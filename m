From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: simplify gitweb.min.* generation and clean-up rules
Date: Thu, 15 Apr 2010 08:11:53 +0200
Message-ID: <201004150811.55627.jnareb@gmail.com>
References: <4BC689FF.9080308@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Thu Apr 15 08:11:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2IIj-00075u-C0
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 08:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755114Ab0DOGL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 02:11:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:53160 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837Ab0DOGL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 02:11:26 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2609323fgg.1
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 23:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=TOcQA6ajdjk9XeJSz6GUEuoj71HwUoEoNXA424trTTc=;
        b=Z18/iuJnkus6BL59t5Zo/cjRFMlyzHXZFzbZiFndQAoZRBxAyqMVaelWkq8Om8RKHl
         DBfYfZZn5RNPD10hiMvkJYAKDOnlF3Bmhjkh0Obl+g5zH55bAuAAA2zV9WLL4FkJ5d2u
         IQyXedEEF95vZOhYtodT/5dFcdeD9nuQ0K1Jg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=SRA4kYsAnmy/p0FKDRWj4bAt8gmFI4zGK8kMZhTPYPmIBB4LIAgQ+4SfJYxcRfufZN
         +kYo6k7sfjv5vqKYwoYWSSIB49+LrDIkRcxfNWfxK/pBQd1wJOr/Zk15Z6QIUcqh1YF5
         EEKHW3hWU1J0eASK0gNsSBTp+RR8XflE++VPc=
Received: by 10.86.221.34 with SMTP id t34mr2760000fgg.36.1271311884858;
        Wed, 14 Apr 2010 23:11:24 -0700 (PDT)
Received: from [192.168.1.13] (abvo40.neoplus.adsl.tpnet.pl [83.8.212.40])
        by mx.google.com with ESMTPS id d8sm1550719fga.26.2010.04.14.23.11.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Apr 2010 23:11:24 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4BC689FF.9080308@mailservices.uwaterloo.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144951>

Mark Rada wrote:

> GITWEB_CSS and GITWEB_JS are meant to be "what URI should the installed
> cgi script use to refer to the stylesheet and JavaScript", never "this
> is the name of the file we are building".
> 
> Lose incorrect assignment to them.
> 
> While we are at it, lose FILES that is used only for "clean" target in a
> misguided way.  "make clean" should try to remove all the potential
> build artifacts regardless of a minor configuration change.  Instead of
> trying to remove only the build product "make clean" would have created
> if it were run without "clean", explicitly list the three potential build
> products for removal.
> 
> In addition, this patch tries to make sure that the scripts are
> regenerated whenever the replacement variables are modified.  For a good
> measure, if you used different JSMIN/CSSMIN since the last time you
> produced minified version of these files, they are regenerated.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Tested-by: Mark Rada <marada@uwaterloo.ca>
> 
> 
> ---
> 
> I gave this a test run:
> 	With just jsmin enabled
> 	With just cssmin enabled
> 	With neither enabled
> 	With both enabled
> 	Overriding GITWEB_JS
> 	Overriding GITWEB_JS and jsmin enabled

Thank you very much.
 
> Instaweb will still generate what it needs to the first time around,
> but if you change GITWEB_JS or the JSMIN (or css equivalents) then you
> have to regenerate gitweb first manually before instaweb. I'm not sure
> if it would be best to swallow up instaweb into this same patch or to
> fix it separately (also, I still don't quite understand how this patch
> works).

Instaweb would need to check if gitweb was run with its GITWEB_JS and
with curent JSMIN... and this should be I think a separate patch.

>  config.mak.in   |    2 +
>  gitweb/Makefile |   75 ++++++++++++++++++++++++++++---------------------------
>  2 files changed, 40 insertions(+), 37 deletions(-)
> 
> diff --git a/config.mak.in b/config.mak.in
> index 6008ac9..bb828fe 100644
> --- a/config.mak.in
> +++ b/config.mak.in
> @@ -57,3 +57,5 @@ FREAD_READS_DIRECTORIES=@FREAD_READS_DIRECTORIES@
>  SNPRINTF_RETURNS_BOGUS=@SNPRINTF_RETURNS_BOGUS@
>  NO_PTHREADS=@NO_PTHREADS@
>  PTHREAD_LIBS=@PTHREAD_LIBS@
> +GITWEB_JS=/home/ferrous/gitweb.js
> +

I think that you have committed this by accident...

-- 
Jakub Narebski
Poland
