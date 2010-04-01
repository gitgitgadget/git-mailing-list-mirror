From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 3/6] Gitweb: add autoconfigure support for minifiers
Date: Fri, 2 Apr 2010 00:40:25 +0200
Message-ID: <201004020040.26177.jnareb@gmail.com>
References: <4BB430D9.1090900@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Fri Apr 02 00:40:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxT49-0005F6-96
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 00:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524Ab0DAWki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 18:40:38 -0400
Received: from mail-qy0-f171.google.com ([209.85.221.171]:59323 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab0DAWkf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 18:40:35 -0400
Received: by qyk1 with SMTP id 1so1636971qyk.15
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 15:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=hTFzb22NMBxthW5P/T6N3pw0CkpzLq7ZXoZWVPPucSY=;
        b=ApaE/6/M3rfTe/RcqTLRI7/mhdp21oNlPtchz72lLGVUDHGKeX8KEZWRNU1+svfdvY
         phR/iE0XtRf5N2E+nbwaLur/SNwSPE6ZKQvGnUQ4raqfLA7ikH8vxDYhaKX3zfPPnIi9
         5XhsUN+JRr3YqGKXxizl/UaVgJPYkQUk3NGeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=UDTMnak27+4bW/yRPr50zaG8SHNRurxLN0d0Xd5py7CAwcTH4QWTLBpI3F6zQ/ZOdm
         /Hgbi0A9+ug5v7HDOR9Uf21/SkcNsX9KWaoXsFJCeDFmf+Da1yCU1VMasBrQ+IcePkYl
         yQKuM2csDcaT6CBBHVyGK7+/Y1JzcoGe8ucZE=
Received: by 10.224.107.209 with SMTP id c17mr365483qap.308.1270161633850;
        Thu, 01 Apr 2010 15:40:33 -0700 (PDT)
Received: from [192.168.1.13] ([72.14.241.38])
        by mx.google.com with ESMTPS id 22sm4455089qyk.6.2010.04.01.15.40.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Apr 2010 15:40:32 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4BB430D9.1090900@mailservices.uwaterloo.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143757>

On Thu, 1 Apr 2010, Mark Rada wrote:

> This will allow users to set a JavaScript/CSS minifier when/if they run
> the autoconfigure script while building git.

This is a good idea, IMHO.

>                                              This is much more 
> convenient than editing Makefile and gitweb/Makefile manually.

Actually recommended way of customizing the build if one doesn't
want to use ./configure script (besides providing values in
command line when invoking make) is not to edit Makefile, but
to add appropriate definitions to [untracked] config.mak file.

> 
> Signed-off-by: Mark Rada <marada@uwaterloo.ca>
> 
> ---
> 
> 	No changes since the previous version.
> 
>  Makefile        |    4 ----
>  configure.ac    |   20 ++++++++++++++++++++
>  gitweb/Makefile |   14 ++------------
>  3 files changed, 22 insertions(+), 16 deletions(-)

Why there is no change to config.mak.in?  I would thought that it
would contain JSMIN=@JSMIN@ etc.

But see also below: perhaps current version is a better version.

> 
> diff --git a/Makefile b/Makefile
> index 450e4df..ef1a232 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -282,10 +282,6 @@ lib = lib
>  # DESTDIR=
>  pathsep = :
>  
> -# JavaScript/CSS minifier invocation that can function as filter
> -JSMIN =
> -CSSMIN =
> -

I think it is a good change anyway, as we unset variables in Makefile
only in "Guard against environment variables" for variables such as
LIB_OBJS.  So even without support for JSMIN/CSSMIN in ./configure it
would be a good change.

>  export prefix bindir sharedir sysconfdir
>  
>  CC = gcc
> diff --git a/configure.ac b/configure.ac
> index 914ae57..bf36c72 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -179,6 +179,26 @@ fi],
>     AC_MSG_NOTICE([Will try -pthread then -lpthread to enable POSIX Threads.])
>  ])
>  
> +# Define option to enable JavaScript minification
> +AC_ARG_ENABLE([jsmin],
> + [AS_HELP_STRING([--enable-jsmin=ARG],
> +   [ARG is the value to pass to make to enable JavaScript minification.])],
> + [
> +   JSMIN=$enableval;
> +   AC_MSG_NOTICE([Setting JSMIN to '$JSMIN' to enable JavaScript minifying])
> +   GIT_CONF_APPEND_LINE(JSMIN=$enableval);
> + ])
> +
> +# Define option to enable CSS minification
> +AC_ARG_ENABLE([cssmin],
> + [AS_HELP_STRING([--enable-cssmin=ARG],
> +   [ARG is the value to pass to make to enable CSS minification.])],
> + [
> +   CSSMIN=$enableval;
> +   AC_MSG_NOTICE([Setting CSSMIN to '$CSSMIN' to enable CSS minifying])
> +   GIT_CONF_APPEND_LINE(CSSMIN=$enableval);
> + ])
> +

Why not follow the code as it was done e.g. for iconv (--without-iconv
and --with-iconv=path); this would require JSMIN=@JSMIN@ in 
config.mak.in (and respectively for CSSMIN).

Alternatively, if you decide on appending to config.mak.autogen (by the
way of config.mak.append) instead of filling config.mak.in, why not use
ready macro GIT_PARSE_WITH_SET_MAKE_VAR?

[...]
> diff --git a/gitweb/Makefile b/gitweb/Makefile
> index fffe700..ffee4bd 100644
> --- a/gitweb/Makefile
> +++ b/gitweb/Makefile
> @@ -14,10 +14,6 @@ prefix ?= $(HOME)
>  bindir ?= $(prefix)/bin
>  RM ?= rm -f
>  
> -# JavaScript/CSS minifier invocation that can function as filter
> -JSMIN ?=
> -CSSMIN ?=
> -

I can understand that this was not needed anyway.

>  # default configuration for gitweb
>  GITWEB_CONFIG = gitweb_config.perl
>  GITWEB_CONFIG_SYSTEM = /etc/gitweb.conf
> @@ -30,18 +26,10 @@ GITWEB_STRICT_EXPORT =
>  GITWEB_BASE_URL =
>  GITWEB_LIST =
>  GITWEB_HOMETEXT = indextext.html
> -ifdef CSSMIN
> -GITWEB_CSS = gitweb.min.css
> -else
>  GITWEB_CSS = gitweb.css
> -endif
>  GITWEB_LOGO = git-logo.png
>  GITWEB_FAVICON = git-favicon.png
> -ifdef JSMIN
> -GITWEB_JS = gitweb.min.js
> -else
>  GITWEB_JS = gitweb.js
> -endif
>  GITWEB_SITE_HEADER =
>  GITWEB_SITE_FOOTER =
>  
> @@ -95,9 +83,11 @@ all:: gitweb.cgi
>  FILES = gitweb.cgi
>  ifdef JSMIN
>  FILES += gitweb.min.js
> +GITWEB_JS = gitweb.min.js
>  endif
>  ifdef CSSMIN
>  FILES += gitweb.min.css
> +GITWEB_CSS = gitweb.min.css
>  endif
>  gitweb.cgi: gitweb.perl $(GITWEB_JS) $(GITWEB_CSS)

O.K., this change means that it is two conditionals less...

-- 
Jakub Narebski
Poland
