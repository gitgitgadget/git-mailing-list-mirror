From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 2/6] Gitweb: add support for minifying gitweb.css
Date: Wed, 14 Apr 2010 19:22:18 +0200
Message-ID: <201004141922.20213.jnareb@gmail.com>
References: <4BB430C3.9030000@mailservices.uwaterloo.ca> <201004140030.47222.jnareb@gmail.com> <4BC55558.1060608@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Charles Bailey <charles@hashpling.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Wed Apr 14 19:22:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O26Hm-0003BY-FT
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 19:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756538Ab0DNRVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 13:21:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:2368 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756477Ab0DNRVw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 13:21:52 -0400
Received: by fg-out-1718.google.com with SMTP id 22so123483fge.1
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 10:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=FLS0ISikzbZS1FG8SilnG47sqImi+5FMGhlpYLutBQI=;
        b=vY+vO/ylKta69FdL5cbCLuPrnXygtmLP7XPmZiAk5sVCSShu+PZFze6Uj+xCbzz8J5
         iZlIdYKGW2a0JkoTNLtcWDMER+V4oZER15WbDm1/k+IndClsCiaM73SJTNRY26m5TfhB
         ghxhPcMzvVput3z50grpgLX1E8BvfBRZ6Ucuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=JDVnAbUYqboOnnzP6pD8Z64ARiChUkPU4CCNIP4pgSYYX69Jivs9V6vIf5G8R3Qtnx
         SoTbbY5KfqesOs5n3wozPuK9taXT0WnSN+Spo4kWHwu/NlckxfGwiHP5Ue/Dr81N7Y77
         /6vxKmoJc1hccLsAs6Ox6gkLE5CpBzt5MKMJk=
Received: by 10.86.6.15 with SMTP id 15mr83327fgf.42.1271265710606;
        Wed, 14 Apr 2010 10:21:50 -0700 (PDT)
Received: from [192.168.1.13] (abvr150.neoplus.adsl.tpnet.pl [83.8.215.150])
        by mx.google.com with ESMTPS id 2sm1046445fks.12.2010.04.14.10.21.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Apr 2010 10:21:48 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4BC55558.1060608@mailservices.uwaterloo.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144890>

On Wed, 14 Apr 2010, Mark Rada wrote:
> On 10-04-13 6:30 PM, Jakub Narebski wrote:
>> On Tue, 13 April 2010, Charles Bailey wrote:
>>> On 01/04/2010 06:36, Mark Rada wrote:

[...]
>>>> +gitweb.cgi: gitweb.perl $(GITWEB_JS) $(GITWEB_CSS)
>>>>
>>>
>>> I have a question about this last line of the patch. Are GITWEB_JS and 
>>> GITWEB_CSS supposed to be a source path or a URI?
>>>
>>> The documentation for install (and my previous assumption) was that they 
>>> represented the path on the target web server. I'm used to overriding 
>>> them so that gitweb.cgi can live in my /cgi-bin directory, but the 
>>> static files are served from /gitweb which is readable but not executable.
>>>
>>> After this patch I had to removed $(GITWEB_JS) and $(GITWEB_CSS) from 
>>> the list of dependencies for gitweb.cgi otherwise make failed.
>>>
>>> Have I got the wrong end of the stick?
>> 
>> Thanks a lot for noticing this bug.
>> 
>> 
>> GITWEB_JS and GITWEB_CSS were originally meant to be URI to file with
>> gitweb JavaScript code and default gitweb stylesheet,... but during work
>> on minification of JavaScript code and CSS file it somehow got confused
>> to mean source path.
>> 
>> If I remember correctly the original patch, before adding required
>> support for minified gitweb.js and gitweb.css to git-instaweb script,
>> and before support for CSS minification had
>> 
>>    ifdef JSMIN
>>    gitweb.cgi: gitweb.perl gitweb.min.js
>>    else
>>    gitweb.cgi: gitweb.perl
>>    endif
>> 
>> which should probably be replaced in current situation by
>> 
>>    ifdef JSMIN
>>    gitweb.cgi : gitweb.min.js
>>    endif
>>    ifdef CSSMIN
>>    gitweb.cgi : gitweb.min.css
>>    endif
>> 
>> just adding prerequisites to gitweb.css target in gitweb/Makefile
>> 
>> 
>> I guess that support for adding minifiction support to git-instaweb
>> would need to be more complicated. [...]
> 
> Aw, frig, never thought of using gitweb like that so I made some
> assumptions to make things cleaner looking.
> 
> I think this can be fixed by just using different variable names? Or
> perhaps some nested ifdef's? I'm not sure which will be better.
> 
> I wasn't at the computer today so I'm just getting to it now, I'll try
> to have something when in the next day, going to bed now. Good night.

I think the best solution for prerequisites would be to have multiple 
target-only (without commands) rules, which according to make 
documentation would get concatenated.  This means the following code
in gitweb/Makefile:

    ifdef JSMIN
    gitweb.cgi : gitweb.min.js
    endif
    ifdef CSSMIN
    gitweb.cgi : gitweb.min.css
    endif

in place of

   gitweb.cgi: gitweb.perl $(GITWEB_JS) $(GITWEB_CSS)


For git-instaweb I think that best solution would be to introduce new
variables holding _source_ of gitweb JavaScript code and CSS, e.g.

            -e '/@@GITWEB_CSS@@/r $(GITWEB_CSS)' \

in place of

            -e '/@@GITWEB_CSS@@/r $(GITWEB_CSS_SOURCE)' \

...although GITWEB_CSS might mean something different for Makefile
and git-instaweb than for gitweb/Makefile and gitweb itself.
-- 
Jakub Narebski
Poland
