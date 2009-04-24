From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: filter escapes from longer commit titles that break firefox
Date: Fri, 24 Apr 2009 19:53:35 +0200
Message-ID: <200904241953.37187.jnareb@gmail.com>
References: <1239985473-666-1-git-send-email-paul.gortmaker@windriver.com> <m3r5znpt5g.fsf@localhost.localdomain> <49EC78AB.6020009@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 19:55:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxPcO-0007gX-EZ
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 19:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760054AbZDXRxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 13:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760835AbZDXRxp
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 13:53:45 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:21307 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756028AbZDXRxo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 13:53:44 -0400
Received: by fk-out-0910.google.com with SMTP id 18so552762fkq.5
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 10:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=RWirYGCk+u3GlX12RlgIUG6/upvFAQZzDBDu2bQckT0=;
        b=f072gTMK6XQymu1sE+NZTt9R2j+jr6mVGpoUy/O1OWGsiwf+zaFcehbfGDsE56qKAU
         C8jEtdgiGkJPBOjuxXcvHwwfktUD1XbP7GgzkYC+Dwhm9+emJ/AAOFwAo7w0O6AXfLvV
         gOCG6qJBeCl4ZrRWvD90oOk8ZanCEgPR90znQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=d0tmUPG/WqGU8lGz8L2jg1WAIS6x9FWrYPXkWxIrxM+vHy2EIvPsoLf9JsYpWqIhR7
         p/EeNzJV2KIlfeFm+irTyjJUj9E96AmUNYReXqmqSP4VDailSMGHC1atyL5Ut49h4MYT
         2JeeCN5K5BOTci8I6SjK2FVMgtE6b7IWOFxjw=
Received: by 10.103.108.18 with SMTP id k18mr1025249mum.40.1240595621958;
        Fri, 24 Apr 2009 10:53:41 -0700 (PDT)
Received: from ?192.168.1.13? (abrz154.neoplus.adsl.tpnet.pl [83.8.119.154])
        by mx.google.com with ESMTPS id 23sm3843708mun.34.2009.04.24.10.53.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Apr 2009 10:53:40 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <49EC78AB.6020009@windriver.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117475>

On Mon, 20 April 2009, Paul Gortmaker wrote:
> Jakub Narebski wrote:
>> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
>>
>>   
>>> If there is a commit that ends in ^X and is longer in length than
>>> what will fit in title_short, then it doesn't get fed through
>>> esc_html() and so the ^X will appear as-is in the page source.
>>>
>>> When Firefox comes across this, it will fail to display the page,
>>> and only display a couple lines of error messages that read like:
>>>
>>>    XML Parsing Error: not well-formed
>>>    Location: http://git ....
>>>
>>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

>> But I do not think that the solution presented here is good solution
>> for this problem.  chop_and_escape_str is meant as _output_ filter,
>> because it generates (can generate) fragment of HTML.  It is not a
>> good solution to use it for shortening in intermediate representation
>> of %co{'title'}.
>>
>> And I think that issue might be a bug elsewhere in gitweb if we have
>> text output which is not passed through esc_html... or bug in CGI.pm
>> if the error is in not escaping of -title _attribute_ (attribute
>> escaping has slightly different rules than escaping HTML, and should
>> be done automatically by CGI.pm).
>>
>>
>> So thanks for noticing the issue, but NAK on the solution.
> 
> Fair enough -- I wasn't familiar with the code in there, and there 
> wasn't really any indication that it was for output only.  I can easily 
> believe that there is a better place for it -- I just didn't see where 
> any global esc_html filtering was taking place...

The name chop_and_escape_str for this subroutine is not a very good
name; it rather should follow format_* as a naming convention for this
subroutine.

What more important is: can you find out in more detail _where_
an error (unescaped control character) occurs: is it tag contents or
'title' attribute for some tag, what tag is it (name and class), in
what view or views this bug is present, and in which part this occur?
Without those details it would b much harder to diagnose this bug...
-- 
Jakub Narebski
Poland
