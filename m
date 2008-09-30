From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/6] gitweb: action in path with use_pathinfo
Date: Wed, 1 Oct 2008 01:24:40 +0200
Message-ID: <200810010124.41455.jnareb@gmail.com>
References: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com> <200809301048.40046.jnareb@gmail.com> <cb7bb73a0809300340t79a497fey4ededd960223fcdd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@ucw.cz>,
	"Lea Wiemann" <lewiemann@gmail.com>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 01:25:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkobN-0004lh-4x
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 01:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbYI3XYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 19:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752892AbYI3XYq
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 19:24:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:31467 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbYI3XYp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 19:24:45 -0400
Received: by ug-out-1314.google.com with SMTP id k3so710293ugf.37
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 16:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=so5Fxpu8ZWEVeVB1dEGxDqHpPYnSB/BE8YhcdClpzQE=;
        b=qwG8B2YTWBy12Skcflbw3hVv3NNg8PmtC8h/8cu2lwikmnoQ7jk9o2N7DvKVkO4qxN
         watI4BV0Hiik6JRxxQqtJvYs5fRkO0FnaghRS1efwIoC8jfrqgocyX+CtehVhM3MjS/v
         leO5KvpQybPYDTWZQwCL94UFuRVukAY/FAyew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xl13AO+2MfaHPfz7Q2PKFVvZce2bkiYcGKUNL9SPsryfR6VWRSGC5AMZ2ei7zmnsZ1
         40qvHJVyC/5WKmwf99Y/T/MeztRnftEwubA3eq8OuiI0x1AO109Eb5OIyQX+9EKa76LH
         xWfkvGJjRCO3xvheQdrW181FG7Lu917z92Zd0=
Received: by 10.210.109.10 with SMTP id h10mr8684141ebc.145.1222817083332;
        Tue, 30 Sep 2008 16:24:43 -0700 (PDT)
Received: from ?192.168.1.11? (abvo173.neoplus.adsl.tpnet.pl [83.8.212.173])
        by mx.google.com with ESMTPS id c22sm2636926ika.1.2008.09.30.16.24.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 16:24:41 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0809300340t79a497fey4ededd960223fcdd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97169>

On Tue, 30 Sep 2008, Giuseppe Bilotta wrote:
> On Tue, Sep 30, 2008 at 10:48 AM, Jakub Narebski <jnareb@gmail.com> wrote:

>> I presume that you would want to replace for example $hash_base
>> everywhere by %input_params{'hash_base'}?
> 
> No. %input_params{'hash_base'} would only be the _input_ hash base.
> $hash_base would be kept if it's supposed to indicate the value of
> hash base that is being manipulated.

Ah, sorry, I misunderstood. Then your idea is the same as one of mine
(except perhaps some details).
 
>> I can think of yet another solution, namely to abstract getting
>> parameters from CGI query string, from path_info, and possibly in the
>> future also from command line options, and use this mechanism in
>> the getting parameters and validation part.
>>
>> The %params hash would be filled from CGI parameters by using simply
>> "%params = $cgi->Vars;", then added to in evaluate_path_info instead
>> of directly modifying global parameters variables.
> 
> So far I agree.

Using "%input_params = %cgi->Vars;" has consequence of using short
parameter names for keys (and also a bit strange syntax for multivalue
options, see CGI(3pm)).

>> The input validation
>> and dispatch part would be modified to use %params (taking care of
>> multivalued parameters as described in CGI(3pm)), like below:

This has the additional advantage of doing gitweb parameter validation
_once_, and not like it is now done for example first in the "input
validation and dispatch" section, and then in evaluate_path_info()
subroutine.

On the other hand $project is checked _already_ in evaluate_path_info(),
because it has to to find where project name ends, so this part would
get duplicated, unless something smart is done.

>>
>>  our $action = $params{'a'} || $params{'action'};
>
> Not too sure about that. The path_info (or whatever)-derived params
> should be converted to use the same name as the CGI params. Or
> conversely, CGI params should be mapped to the corresponding
> full-form.

After thinking about it a little, I agree with above paragraph.

>> That is just for consideration: each approach has its advantages and
>> disadvantages.  Your proposal, as I understand it, is similar to the
>> way described in "Storing options in a hash" subsection of
>> Getopt::Long(3pm) manpage.
> 
> I'll read that, although it probably is.

Perhaps gitweb should have implement something like GetOptions?

>> Or we could just scrap and revert adding href(..., -replay=>1).
>> There is much trouble with getting it right and performing well,
>> and it is less useful than I thought (at least now).
> 
> Dunno, the idea in itself is not bad. We just have to get it right ;)
> 
> In a way, I actually think that -replay=>1 should be the default, I
> suspect it makes sense in most cases.

PITA but useful. Hmmm....

-- 
Jakub Narebski
Poland
