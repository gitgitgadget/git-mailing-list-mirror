Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69612C432BE
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 11:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BB2B61053
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 11:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbhHTLgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 07:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239196AbhHTLgt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 07:36:49 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7EBC061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 04:36:12 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id j187so8328498pfg.4
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 04:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ebh8P6tZs5MaCaCaIB7M97Zk0w3ezh8TlDwo7BTQw7k=;
        b=hNZLMW83z66h+tOrhADG6r5pE8wZQE+AIELDKjScQzSTS8BzrNSwB1UUc/Kixy9Uwu
         +5yhf2cpBpFfE/hdzbXVvzGDYjQHDqvLNDtBsmYvqpEhvEzuA4ZnpZUxSoARvz6ky7tx
         +cIJMkbwKs346Shej8qqCi0cpt/ntQGhk3LgxoZfcJwX4p0R/GKZeJpY/mrLeCp1cMIf
         E5HTK7VZ3TJi42/2bTln17FWAdV78LZQYEaMAV3Sgz/3yaJNf0JNIM1Y8mN3eniex7ZG
         hT16TrBnFLl2nITdGGzjTM9x2/4s8gDWTmYOOlpWplPVrH/Z9IhI7Ir16+0VVb5OloAC
         9J8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ebh8P6tZs5MaCaCaIB7M97Zk0w3ezh8TlDwo7BTQw7k=;
        b=kFqNt067hr4Ti1M51nr4IqGcLCjbFU0b8qHWKXDfJgraJuKztFTlr+3S/Je/ArQ4B6
         f2Syjgk4vijPvOHFILPL+EN31E2L6srqXvzSi/hjCrJFGeJfu9QWYDXB0CLn93w2SPkE
         PQ19f0UwOMaIqFB/ay4icrHH/VhO0tGFDhQ52qs55XrfANWzGU8XXG07RS6O5JhjWcYc
         SjFxNUV08ppY38T6CxrQZNsj9dFVES/wFDt6Yy9QicDQKiPnn/X+fWeVEiVLW9jrfhBl
         QCem0yloblXBU62zeLqj5hdvIWnDQUiuCihU+xqEB38a9yv86Vl3qN9YHnhF0xbu5FwU
         hCSQ==
X-Gm-Message-State: AOAM532bFInsKAuSZPheuXpA4sZGvdra3xYozJgT6DMJOZD82qIDK3zM
        DLiqwrih3cuHgFcErsjVNFw=
X-Google-Smtp-Source: ABdhPJwKk/Hz5nKYH6Vbyd6ygYYb+2Ojnp3hTdNDEEV/g0zj0sB+C/o59PQFn3KUmJu9BIPRXRIciA==
X-Received: by 2002:a65:6908:: with SMTP id s8mr18418049pgq.263.1629459371611;
        Fri, 20 Aug 2021 04:36:11 -0700 (PDT)
Received: from localhost ([2402:800:63ed:4478:964c:2b9b:388e:4b0])
        by smtp.gmail.com with ESMTPSA id p9sm6615727pfn.97.2021.08.20.04.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 04:36:10 -0700 (PDT)
Date:   Fri, 20 Aug 2021 18:36:07 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] make: add INSTALL_STRIP variable
Message-ID: <YR+Tp2AGeeKyRKoC@danh.dev>
References: <20210820105052.30631-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820105052.30631-1-bagasdotme@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-08-20 17:50:53+0700, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> In some environments (most notably embedded systems and small production
> servers), it is often desirable to have stripped Git binaries due to
> tight disk space constraint.
> 
> Until now stripped Git can be built wih `make strip install`. Add
> INSTALL_STRIP make variable so that they can install stripped Git
> binaries with `make INSTALL_STRIP=yes install`.
> 
> Also document stripping and using INSTALL_STRIP in INSTALL.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Junio suggested me to have INSTALL_STRIP make variable [1] when
>  reviewing the install-strip target patch.
> 
>  [1]:
> https://lore.kernel.org/git/xmqq1r6p1ark.fsf@gitster.g/T/#mc3b8017448bdafedf9250ba407f5de767c20ad67
> 
>  INSTALL  | 8 ++++++++
>  Makefile | 5 +++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/INSTALL b/INSTALL
> index 66389ce059..98e541ee4d 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -58,6 +58,14 @@ suite has to be run using only a single CPU.  In addition, the profile
>  feedback build stage currently generates a lot of additional compiler
>  warnings.
>  
> +You can also strip debug info from built binaries by:
> +
> +	$ make strip
> +
> +or for stripping and installing together:
> +
> +	$ make INSTALL_STRIP=yes install
> +
>  Issues of note:
>  
>   - Ancient versions of GNU Interactive Tools (pre-4.9.2) installed a
> diff --git a/Makefile b/Makefile
> index 9573190f1d..e486f3ab75 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -8,6 +8,8 @@ all::
>  # Define SANE_TOOL_PATH to a colon-separated list of paths to prepend
>  # to PATH if your tools in /usr/bin are broken.
>  #
> +# Define INSTALL_STRIP if you want to install with stripped binaries.
> +#
>  # Define SOCKLEN_T to a suitable type (such as 'size_t') if your
>  # system headers do not define a socklen_t type.
>  #
> @@ -3005,6 +3007,9 @@ profile-fast-install: profile-fast
>  	$(MAKE) install
>  
>  install: all
> +ifdef INSTALL_STRIP
> +	$(MAKE) strip
> +endif

I believe it's better to write like this:

----- 8< ------
ifdef INSTALL_STRIP
install: strip
endif

install: all
	....
---- >8-------

IOW, install depends on strip, not install invoke strip.
I think it would work better for:

	make install strip

>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
>  	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> 
> base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
> -- 
> 2.25.1
> 

-- 
Danh
