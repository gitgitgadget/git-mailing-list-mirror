Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912B6C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 12:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1432070A
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 12:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZLfmCWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgCZMXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 08:23:19 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55020 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgCZMXT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 08:23:19 -0400
Received: by mail-pj1-f68.google.com with SMTP id np9so2386754pjb.4
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 05:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AcHy6QuT11K4zkdONQSQLIAXUAS7zE/6RIfSdfKJMOg=;
        b=fZLfmCWDzHKWnhArrrLIiu2N7+vMgDeZcIDKRFgDyfsJrXjCa+EcTl8ud9Djmkl72p
         PXyaoz5fjrhL0jZVtMhpArKp6nWT4u8CQ4oi6/prob8jPF35oChcSwZJ0MQ1OcsN9/QX
         AqmTTVVMbuU+o//UysafaH7e4YXau+qDK7vpE844cn2kkyJodaVRMfq9b1bdZaeM/gZG
         nORJZ3YAPAgZoHl2vj77ykvZ3HWKwL27v9RQZe6ZsjYSJX8tXMFy+B2Y7TUdo8BG6Mb1
         izKFrDH9uF37emt2XfDCI2pReEL10U0lNXpQ9QRN5k9jxz2Q5km9rGGfibLhmXPICFnR
         XcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AcHy6QuT11K4zkdONQSQLIAXUAS7zE/6RIfSdfKJMOg=;
        b=cDTgoiS+I0AznxIQveC+zAjnay/MPMLrXn45Pf3bNKDk00EOdnlPR7SBiUe0QiqCq/
         Bo/ozZDuq2ZFSV3YgQTDj7GCXoo8GkIqgLYn9G1+AgESEIEIiEcaUXxPP2B+pbZUvOJo
         tU6vOe4d563JPFoiCyof4b9I/SC4TCntxgu50ZBaSxGHk2fCQffx5Tz3ZcHyeyNnE4Xi
         5G0VZ2sV0QGbVuFEF1aWn2XjjHn9Ntd+9jwJF4PwupQvJ6+17tvp5o4Fx88w47p1kbwq
         uF3MkMRYEd9OiKVgH1i/Lcwx3FEx6iTRUpZ705b0RrdjO9/H9k/P/D5pE3L6+aTlfY29
         Me+w==
X-Gm-Message-State: ANhLgQ3rS3aQmz2h/sicgGBoihpbm5+chL3Wu4GiunsjQxztKoVfNO7T
        eDo3MR/8fGM5WbzZP+UnASJawMcgr1o=
X-Google-Smtp-Source: ADFU+vs+b+M9h0gDmenLIR3w+qFqXc2SIloip79b2ucuocT2S/DqGp3/s0SpkjQzfGWjXj0z7y6fIw==
X-Received: by 2002:a17:902:b682:: with SMTP id c2mr8102041pls.36.1585225397229;
        Thu, 26 Mar 2020 05:23:17 -0700 (PDT)
Received: from localhost ([2402:800:6375:f121:1d2a:e7e0:840f:1f18])
        by smtp.gmail.com with ESMTPSA id 8sm1598179pfv.65.2020.03.26.05.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 05:23:16 -0700 (PDT)
Date:   Thu, 26 Mar 2020 19:23:14 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] configure: respect --without-<package> flags
Message-ID: <20200326122314.GA19102@danh.dev>
References: <cover.1584516715.git.congdanhqx@gmail.com>
 <cover.1584589859.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1584589859.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-03-19 10:58:54+0700, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> Current git's configure script allow --without-<package>,
> it rightfully set NO_<PACKAGE> in the beginning of the configure script,
> but overwrite them with autodetect later.
> 
> Respect them now.

Hi Junio,

Can I get your opinion on this serie?

I didn't see it in cooking list.
I guess it was lost because of 2.26.

> 
> Change from v1:
> - Simply check if NO_<PACKAGE> is empty or not instead of explicitly
>   check for YesPlease
> - --without-openssl will ignore libcrypto all-together and fallback
>   into DC_SHA1
> 
> Đoàn Trần Công Danh (3):
>   configure: respect --without-curl flag
>   configure: respect --without-expat flag
>   configure: respect --without-openssl flag
> 
>  configure.ac | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> Interdiff against v1:
> diff --git a/configure.ac b/configure.ac
> index 20a11e1f32..807bb8bc5a 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -542,17 +542,18 @@ AC_MSG_NOTICE([CHECKS for libraries])
>  
>  GIT_STASH_FLAGS($OPENSSLDIR)
>  
> +if test -z "$NO_OPENSSL"; then
>  AC_CHECK_LIB([crypto], [SHA1_Init],
>  [NEEDS_SSL_WITH_CRYPTO=],
> -[
> -if "x$NO_OPENSSL" = xYesPlease; then
> -	AC_MSG_ERROR([Disabled OpenSSL is required for SHA1])
> +[AC_CHECK_LIB([ssl], [SHA1_Init],
> + [NEEDS_SSL_WITH_CRYPTO=YesPlease NO_OPENSSL=],
> + [NEEDS_SSL_WITH_CRYPTO=          NO_OPENSSL=YesPlease])])
>  else
> -	AC_CHECK_LIB([ssl], [SHA1_Init],
> -	[NEEDS_SSL_WITH_CRYPTO=YesPlease NO_OPENSSL=],
> -	[NEEDS_SSL_WITH_CRYPTO=          NO_OPENSSL=YesPlease])
> +	# Fallback to DC SHA1
> +	NEEDS_SSL_WITH_CRYPTO=
> +	DC_SHA1=YesPlease
> +	GIT_CONF_SUBST([DC_SHA1])
>  fi
> -])
>  
>  GIT_UNSTASH_FLAGS($OPENSSLDIR)
>  
> @@ -598,17 +599,19 @@ fi
>  # git-http-push are not built, and you cannot use http:// and https://
>  # transports.
>  
> -# Respect --without-curl
> -if test "x$NO_CURL" != "xYesPlease"; then
> -
>  GIT_STASH_FLAGS($CURLDIR)
>  
> +# Respect --without-curl
> +if test -z "$NO_CURL"; then
>  AC_CHECK_LIB([curl], [curl_global_init],
>  [NO_CURL=],
>  [NO_CURL=YesPlease])
> +fi
>  
>  GIT_UNSTASH_FLAGS($CURLDIR)
>  
> +GIT_CONF_SUBST([NO_CURL])
> +
>  if test -z "$NO_CURL"; then
>  
>  AC_CHECK_PROG([CURL_CONFIG], [curl-config],
> @@ -629,27 +632,22 @@ fi
>  
>  fi
>  
> -fi
> -
> -GIT_CONF_SUBST([NO_CURL])
>  
>  #
>  # Define NO_EXPAT if you do not have expat installed.  git-http-push is
>  # not built, and you cannot push using http:// and https:// transports.
>  
> -# Respect --without-expat
> -if test "x$NO_EXPAT" != xYesPlease; then
> -
>  GIT_STASH_FLAGS($EXPATDIR)
>  
> +# Respect --without-expat
> +if test -z "$NO_EXPAT"; then
>  AC_CHECK_LIB([expat], [XML_ParserCreate],
>  [NO_EXPAT=],
>  [NO_EXPAT=YesPlease])
> +fi
>  
>  GIT_UNSTASH_FLAGS($EXPATDIR)
>  
> -fi
> -
>  GIT_CONF_SUBST([NO_EXPAT])
>  
>  #
> -- 
> 2.26.0.rc2.234.g969ad452ca
> 

-- 
Danh
