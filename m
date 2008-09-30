From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/6] gitweb: action in path with use_pathinfo
Date: Tue, 30 Sep 2008 23:00:45 +0200
Message-ID: <200809302300.46786.jnareb@gmail.com>
References: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com> <200809301322.58280.jnareb@gmail.com> <cb7bb73a0809300553o7496f4c1me14ddf55b31fe4a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@ucw.cz>,
	"Lea Wiemann" <lewiemann@gmail.com>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 23:02:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkmMC-00075n-Sg
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 23:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbYI3VA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 17:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753174AbYI3VA6
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 17:00:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:19183 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbYI3VA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 17:00:57 -0400
Received: by nf-out-0910.google.com with SMTP id d3so110655nfc.21
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 14:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=aRwDY4v1pGGTlHlS2Jf9wrMALAsz7VShVT1Ux2xjcds=;
        b=cvuHHlTCiJrnQwN/P0bztbyYES7RH38fWekfQJv/LCPV5+Hgutr7o34EGJClY7bxI5
         m68UnakdcMT1+TwKY+mLUj/SdvnDnTEXcG+IsFgsgAz8/UPN/vL9VIRtauu6d8YXiL9y
         nm4rVY2PBH9RnTE9HHprB5vqFfUVwZihE5D1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VCEHlUgbhg8St8ZDz5F52ISRpsn241N3egSRK+2ejzRr7p4hV4mGWj5MxesA0lzmEC
         8GKjLLEa40DbVxTj0/aU+SyVpsmdjDGIrEL8fDXD9tZ1KEXcVbRRMlvXd8wh08iAEW2T
         e0MpTOIEnMJtz2Q91FutlnCBimzbeIj9eMuyk=
Received: by 10.210.23.3 with SMTP id 3mr8496672ebw.188.1222808455387;
        Tue, 30 Sep 2008 14:00:55 -0700 (PDT)
Received: from ?192.168.1.11? (abvo173.neoplus.adsl.tpnet.pl [83.8.212.173])
        by mx.google.com with ESMTPS id 20sm3641890eyk.4.2008.09.30.14.00.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 14:00:53 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0809300553o7496f4c1me14ddf55b31fe4a6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97162>

On Tue, 30 September 2008, Giuseppe Bilotta wrote:
> On Tue, Sep 30, 2008 at 1:22 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Tue, 30 Sep 2008, Giuseppe "Oblomov" Bilotta wrote:
>>> On Tue, Sep 30, 2008 at 10:48 AM, Jakub Narebski <jnareb@gmail.com> wrote:

>>>> Or we could just scrap and revert adding href(..., -replay=>1).
>>>> There is much trouble with getting it right and performing well,
>>>> and it is less useful than I thought (at least now).
>>>
>>> Dunno, the idea in itself is not bad. We just have to get it right ;)
>>
>> It is not easy to get it right, especially that there are multivalued
>> parameters like @extra_options, see e.g. commit 7863c612
> 
> So we just let values be arrays. Or isn't this enough?

I don't think it would be that simple.


Let me elaborate a bit about complications and difficulties
within href() code.

First there are two names of parameters: the short name like 'a',
or 'h', or 'f' which is used in links to make them short (and
which is a bit historical legacy), and the long names like 'action',
'hash' or 'file_name' which are used for readability; then there are
also variables which hold values of parameters, like $action,
$hash and $file_name (which were source of long names for parameters).
href() has to provide translation between those two (well, three)
names; long names are used as names of "named parameters" to href(),
while short names are used when generating URL; %mapping provides
mapping between those two.

Second, href() must distinguish between gitweb options/parameters
like 'file_name'=>$file_name and extra options like '-full'=>1
or '-replay'=>1; additionally we want to have options output in
some definite order, with more important options first.  This
is provided by %mapping (to filter out) and @mapping (to sort).

Third, there are various sources of values of parameters, and
parameters used.  There are parameters specified explicitly in
href() call, and there are also implicit parameters: 'project'
parameter is implicitly added as it is needed in almost all
gitweb links (you can override it and generate projectless link by
using 'project'=>undef), and for '-replay'=>1 all parameters from
current URL are added.  Parameters specified explicitly have preference
over implicit or '-replay' ones.  

Now for '-replay' parameters might come from CGI query string, from
path_info part of URL, and perhaps in the future also from command
line.  To avoid duplicated code and other problems we should either
get parameters from variables (like in your code, but which doesn't
cover @extra_options well, but it could; or using "long name" to
variable ref mapping), or have some place where we save parameters
as we extract it from CGI query string, from path_info part of URL,
and in the future probably also from command line options/parameters.

Fourth, there is a little matter of _some_ parameters be multivalued;
currently it is only @extra_options / 'opt', but this may change in
the future, while _most_ are ordinary scalar values.  Printing arrayref
isn't something we want to do...


That is third and fourth which caused problems in the past with
href(..., -replay=>1)...

-- 
Jakub Narebski
Poland
