From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 2/6] Gitweb: add support for minifying gitweb.css
Date: Thu, 15 Apr 2010 02:25:41 +0200
Message-ID: <201004150225.42101.jnareb@gmail.com>
References: <4BB430C3.9030000@mailservices.uwaterloo.ca> <201004140030.47222.jnareb@gmail.com> <7viq7tmvsb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Charles Bailey <charles@hashpling.org>,
	Mark Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 02:25:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2CtL-0003g5-BK
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 02:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755615Ab0DOAZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 20:25:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:25616 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426Ab0DOAZD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 20:25:03 -0400
Received: by fg-out-1718.google.com with SMTP id 22so298119fge.1
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 17:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=cVy8dxT6853YagA42Uw80HjdZF2Pn6XqrbHOUnvjh7c=;
        b=PAFy3sx509tJkI1PuTjou1kDcPD4SRZU+jeqvq0+R6/ZhT8uay1rYMYPe6+Xpi3EKf
         Nn7RzbyI1PaJ9Blbch8Wiy6OSfuTVdTEy05SI01PDkJa9hUIBFeauyVoQ/gMHQjAtfGC
         kuluCn+eITBBBKHpAoVBIvDr53DASlbQ/cOgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ECgQi038kxp2P0LWSp/1anuxCFAvJAIL2NXljSdTnIu2uPX/mVh7UQjxdRiAyayc1m
         GOeHcAjvh6rJrS1e/cTTOT5Do7BGUJdQGhDYN7RpG0BhsiKiyhDJnvt/OhvWDlPX5dS3
         /G/cB7FhUvM8qfV1tu59dcqlO/rge8NLxb8qk=
Received: by 10.102.165.40 with SMTP id n40mr4783388mue.71.1271291101647;
        Wed, 14 Apr 2010 17:25:01 -0700 (PDT)
Received: from [192.168.1.13] (abvo40.neoplus.adsl.tpnet.pl [83.8.212.40])
        by mx.google.com with ESMTPS id s11sm5141899mue.41.2010.04.14.17.25.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Apr 2010 17:25:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7viq7tmvsb.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144931>

On Thu, 15 Apr 2010, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> On Tue, 13 April 2010, Charles Bailey wrote:
>>> On 01/04/2010 06:36, Mark Rada wrote:
>>>> @@ -84,13 +92,14 @@ endif
>>>>
>>>>   all:: gitweb.cgi
>>>>
>>>> +FILES = gitweb.cgi
>>>>   ifdef JSMIN
>>>> +FILES += gitweb.min.js
>>>> +endif
>>>> +ifdef CSSMIN
>>>> +FILES += gitweb.min.css
>>>> +endif
>>>> +gitweb.cgi: gitweb.perl $(GITWEB_JS) $(GITWEB_CSS)
>>
>> GITWEB_JS and GITWEB_CSS were originally meant to be URI to file with
>> gitweb JavaScript code and default gitweb stylesheet,... but during work
>> on minification of JavaScript code and CSS file it somehow got confused
>> to mean source path.
> 
> I am not touching instaweb part, but this would fix the build/clean side
> of the things, no?

Close, see below.

> 
> -->8 --
> gitweb: simplify gitweb.min.* generation and clean-up rules
> 
> GITWEB_CSS and GITWEB_JS are meant to be "what URI should the installed
> cgi script use to refer to the stylesheet and JavaScript", never "this is
> the name of the file we are building".
> 
> Lose incorrect assignment to them.

Actually the assignment was intended to provide correct *default* values
for GITWEB_CSS and GITWEB_JS, so that if e.g. JSMIN is defined gitweb,
in absence of build time configuration, would link gitweb.min.js instead
of gitweb.js.

> 
> While we are at it, lose FILES that is used only for "clean" target in a
> misguided way.  "make clean" should try to remove all the potential build
> artifacts regardless of a minor configuration change.  Instead of trying
> to remove only the build product "make clean" would have created if it
> were run without "clean", explicitly list the three potential build
> products for removal.

Good.

> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  gitweb/Makefile |   15 ++++-----------
>  1 files changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/gitweb/Makefile b/gitweb/Makefile
> index ffee4bd..1787633 100644
> --- a/gitweb/Makefile
> +++ b/gitweb/Makefile
> @@ -80,16 +80,7 @@ endif
>  
>  all:: gitweb.cgi
>  
> -FILES = gitweb.cgi
> -ifdef JSMIN
> -FILES += gitweb.min.js
> -GITWEB_JS = gitweb.min.js
> -endif
> -ifdef CSSMIN
> -FILES += gitweb.min.css
> -GITWEB_CSS = gitweb.min.css
> -endif

I wonder about removing assigmnet to GITWEB_JS and GITWEB_CSS.  Without
it "make gitweb" (in top dir) would create gitweb/gitweb.cgi and 
gitweb/gitweb.min.js etc.... but generated gitweb/gitweb.cgi would
refer to gitweb.js, not gitweb.min.js.  Unless of course one provides
values for GITWEB_JS during build time.

> -gitweb.cgi: gitweb.perl $(GITWEB_JS) $(GITWEB_CSS)
> +gitweb.cgi: gitweb.perl
>  
>  gitweb.cgi:
>  	$(QUIET_GEN)$(RM) $@ $@+ && \
> @@ -118,16 +109,18 @@ gitweb.cgi:
>  	mv $@+ $@
>  
>  ifdef JSMIN
> +all:: gitweb.min.js
>  gitweb.min.js: gitweb.js
>  	$(QUIET_GEN)$(JSMIN) <$<>$@
>  endif # JSMIN
>  
>  ifdef CSSMIN
> +all:: gitweb.min.css
>  gitweb.min.css: gitweb.css
>  	$(QUIET_GEN)$(CSSMIN) <$>$@
>  endif

That makes gitweb.cgi not depend on gitweb.min.js, not gitweb.min.css.
It might be right... and I think the rightness or wrongness might be
tied with values of GITWEB>JS and GITWEB_CSS.

>  
>  clean:
> -	$(RM) $(FILES)
> +	$(RM) gitweb.cgi gitweb.min.css gitweb.min.js
>  
>  .PHONY: all clean .FORCE-GIT-VERSION-FILE
> 

-- 
Jakub Narebski
Poland
