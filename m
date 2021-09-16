Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851C7C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6850B60F4C
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbhIPKOj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 06:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbhIPKOi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 06:14:38 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FC8C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:13:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v22so10549641edd.11
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ZKLkoGQDWJUSzq6vP6a0Su7D4TGMXMktVgew2+rCzYk=;
        b=ow9z2FK/uJmNNyfr+YjV5cn2tRUAd4XlkGrF9jgz7yt+VworeLoCCvr8J8Ndcsaz9F
         95vwSJNNzw4yKdUZ6GQIRjgsvIxAEHyLN1NT1zxUsYSPvA3AWmVu4xXcAm77LT5/tiAa
         e860m8XoOg6lzYBiyLevJprd6tLuXCfUfmur6gPlz7UUo8aMw280Cd66HwQl+B0d7St7
         hiRRMIsviCZXRtelgbftBSVXH2JolKRn+mkYHez9U83uC72n0a4EoiCL3nsVHkZTp6EU
         YwoEdJZaWBNmoey3MwRq8ekEwwDkCTEY1xcyCfSsAK42g5RP15cIad7AeXMCOaKh+7F6
         VTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ZKLkoGQDWJUSzq6vP6a0Su7D4TGMXMktVgew2+rCzYk=;
        b=HsgXq7YA+YQz4hCpEfFVqsjJJUkjL9TjFl1DUl13oBLBpVGoI/+KcAjNK8msLOIVbi
         BYTR3MVLotE9i9483/klXmiiYNpxiId/i+3kFg+9vgCw+e9eKZia9J+pshjR+VkMV7uY
         9J2ZpFOxRqO8cssHAw8jFemFnI8wstfutK9EFG5rjENRNAtTPHEEwYxBU3gbaLC1R391
         +/AB8VFXPIQXq+BBjdlQR1o3JCyCLyCOawFRPOt0QPr5sa4+CZaMmdMRKLSLezKEQkYk
         MlPW1R3QHDcYXTOosriFwJMRu7JAA9lPiXTDAefEzZyVcyPb5qmohRlL+yTxuDX+mA4l
         1bGg==
X-Gm-Message-State: AOAM533Tg/gk4MbdYXEH/18mt2SV8L4xG8MhrD712i84YUNLcYDyfnE1
        lzOVgLhdia5nrCztZIHUID1LfDtqpTk=
X-Google-Smtp-Source: ABdhPJzI2QlrvWnXJNqDg+yZLEvCCfecgKj9FOoP8MRCQYILiVUDpz54VUGo4OZk39KxHqONEx9CYg==
X-Received: by 2002:a05:6402:c8b:: with SMTP id cm11mr5570315edb.368.1631787196484;
        Thu, 16 Sep 2021 03:13:16 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id lv10sm1005380ejb.66.2021.09.16.03.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 03:13:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Carlo Arenas <carenas@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, felipe.contreras@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH v3] make: add INSTALL_STRIP option variable
Date:   Thu, 16 Sep 2021 11:50:30 +0200
References: <20210902121104.14778-1-bagasdotme@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210902121104.14778-1-bagasdotme@gmail.com>
Message-ID: <87a6kchlqc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 02 2021, Bagas Sanjaya wrote:

> From: Junio C Hamano <gitster@pobox.com>
>
> Add $(INSTALL_STRIP), which allows passing stripping options to
> $(INSTALL).
>
> For this to work, installing executables must be split to installing
> compiled binaries and scripts portions, since $(INSTALL_STRIP) is only
> meaningful to the former.
>
> Users can set this variable depending on their system. For example,
> Linux users can use `-s --strip-program=strip`, while FreeBSD users can
> simply set to `-s` and choose strip program with $STRIPBIN.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>
>  Changes from v3 [1]:
>    - Squash suggestion patch from Junio, which suggests dropping
>      install-stripped target and rename $(INSTALL_OPTS) to
>      $(INSTALL_STRIP).
>    - Describe $(INSTALL_STRIP) usage on the top of Makefile
>
>  Note: In the future, we may add global $(INSTALL_OPTS), which applies
>  to both compiled binaries and scripts. When such happens, we should
>  rename $(INSTALL_STRIP) to $(INSTALL_STRIP_OPTS).

I see this landed on "master" already, but in case you're interested on
follow-ing up:

I think the suggestion in
https://lore.kernel.org/git/xmqqo89cqkt9.fsf@gitster.g/ is to make this
a boolean variable, and in any case I think that makes more sense here,
since....

>  [1]: https://lore.kernel.org/git/xmqqo89cqkt9.fsf@gitster.g/T/#t
>
>  Makefile | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index d1feab008f..ebef4da50c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -465,6 +465,9 @@ all::
>  # the global variable _wpgmptr containing the absolute path of the current
>  # executable (this is the case on Windows).
>  #
> +# INSTALL_STRIP can be set to "-s" to strip binaries during installation,
> +# if your $(INSTALL) command supports the option.
> +#
>  # Define GENERATE_COMPILATION_DATABASE to "yes" to generate JSON compilation
>  # database entries during compilation if your compiler supports it, using the
>  # `-MJ` flag. The JSON entries will be placed in the `compile_commands/`
> @@ -3004,7 +3007,8 @@ mergetools_instdir = $(prefix)/$(mergetoolsdir)
>  endif
>  mergetools_instdir_SQ = $(subst ','\'',$(mergetools_instdir))
>  
> -install_bindir_programs := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)) $(BINDIR_PROGRAMS_NO_X)
> +install_bindir_xprograms := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X))
> +install_bindir_programs := $(install_bindir_xprograms) $(BINDIR_PROGRAMS_NO_X)
>  
>  .PHONY: profile-install profile-fast-install
>  profile-install: profile
> @@ -3013,12 +3017,17 @@ profile-install: profile
>  profile-fast-install: profile-fast
>  	$(MAKE) install
>  
> +INSTALL_STRIP =
> +
>  install: all
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> -	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> +	$(INSTALL) $(INSTALL_STRIP) $(PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> +	$(INSTALL) $(SCRIPTS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
>  	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> -	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
> +	$(INSTALL) $(INSTALL_STRIP) $(install_bindir_xprograms) '$(DESTDIR_SQ)$(bindir_SQ)'
> +	$(INSTALL) $(BINDIR_PROGRAMS_NO_X) '$(DESTDIR_SQ)$(bindir_SQ)'
> +
>  ifdef MSVC
>  	# We DO NOT install the individual foo.o.pdb files because they
>  	# have already been rolled up into the exe's pdb file.
>
> base-commit: 6c40894d2466d4e7fddc047a05116aa9d14712ee

...this really is not an INSTALL_STRIP but (using some combination of
your own naming) a "INSTALL_XPROGRAMS_OPTS" or "INSTALL_XOPTS". I.e. you
can supply arbitrary options to "install" with this, but only for
binaries.

Also doesn't this misbehave under MSVC when combined with *.pdb files?
See dce7d295514 (msvc: support building Git using MS Visual C++,
2019-06-25) and a8b5355d808 (msvc: copy the correct `.pdb` files in the
Makefile target `install`, 2020-09-21) , i.e. the code at the start of
your diff context.

Does stripping the main binary while having a *.pdb file error or MSCV,
or make the *.pdb file useless, or is *.pdb an unconditional equivalent
of INSTALL_STRIP=-s on MSCV that we should disable if this
hopefully-then-boolean INSTALL_STRIP option is enabled?
