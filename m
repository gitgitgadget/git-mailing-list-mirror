Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CAEC433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 20:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D390F606A5
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 20:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245679AbhDUUrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 16:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245677AbhDUUrO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 16:47:14 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3710BC06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 13:46:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id y204so21508204wmg.2
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 13:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ASsy2hegRysMDqjOqNkp8U0L/p7ZNZM7vrogq2XqlXs=;
        b=Jw5aIb8bGXTIVh5YR0qzbyo9W1Mi8NxqUBmcSiEwKpOSjbYrXmbalB93olpSmQzHE3
         ab9sbyjFgkGFmGbZE/s8SvmSkKsU7iwA8/u2j2Z+sPV1CddeHTkxm6uyL9PmW6bAYs0b
         WACJpqYRKCa8JkDa6HtQ3e4dBnn/yQ1skamepFAlI90EkxqWeKJ7ueXp1giCbgBzycN8
         uvuw7kHVn4QCJvTrDIGw/6g2mUa3C3/AKmWDKo3RZ3mgFbbrE7RZdPK/Ydtr4eZt0rOB
         O4mlEvFaUdMwTs2VSGncZXSO1J51ZizulquRJlFNIJlGv5bHrwM7FFDu3k+C5Xt6L4Y2
         8REQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ASsy2hegRysMDqjOqNkp8U0L/p7ZNZM7vrogq2XqlXs=;
        b=XN1UWThc+fO3ucaXO8nii7PLzA1k4i/M5Y9htf50rv3m+de0xe92kw44TGytkaBpPg
         e+LjiACq16ou+SslUcy2JrGsusK5SBR/ONDWSk346yfP0BuXHY9ilyNJb6zGxciAjnjR
         EC11p7ouZSC7AbLV2Zufi2CfYVhjckAxs2h8E5yB12UtGEvxuPMRUY9Eh6vw0fMvFAvZ
         BYjU5RCqYaJLmzQBbrqqMUDEQ09SecFbGM/4QdleeN2VEK9OI1lcYdFGdW6Ysk09MaT6
         egL/SF61WL6GlOHBuG0prub3x+n1CZHtCAWNDII2tjmZ104Dx3fj8F8ZKDKw56YUtMzZ
         hTag==
X-Gm-Message-State: AOAM533KqljOVctQkV8mSAD++EkxLQxF1MEKduScgWo/fD0aXZ1jsn0f
        tBAwOcdNuFyDx6YUVk3xAWg=
X-Google-Smtp-Source: ABdhPJwELU2K0s4XG66pkTmsBhB4OyIejWR1IrWbn1nTVJ6ccstbaA6/x6UMcGcawEe5NMrbtbhYNg==
X-Received: by 2002:a7b:c394:: with SMTP id s20mr11853407wmj.4.1619037999740;
        Wed, 21 Apr 2021 13:46:39 -0700 (PDT)
Received: from szeder.dev (78-131-14-48.pool.digikabel.hu. [78.131.14.48])
        by smtp.gmail.com with ESMTPSA id x15sm3305373wmi.41.2021.04.21.13.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 13:46:39 -0700 (PDT)
Date:   Wed, 21 Apr 2021 22:46:37 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 3/3] config: allow overriding of global and system
 configuration
Message-ID: <20210421204637.GA2947267@szeder.dev>
References: <cover.1618297711.git.ps@pks.im>
 <cover.1618835148.git.ps@pks.im>
 <7e7506217e4aac82e3a03013d24e6f885383ecd3.1618835148.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e7506217e4aac82e3a03013d24e6f885383ecd3.1618835148.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 02:31:16PM +0200, Patrick Steinhardt wrote:
> In order to have git run in a fully controlled environment without any
> misconfiguration, it may be desirable for users or scripts to override
> global- and system-level configuration files. We already have a way of
> doing this, which is to unset both HOME and XDG_CONFIG_HOME environment
> variables and to set `GIT_CONFIG_NOGLOBAL=true`. This is quite kludgy,
> and unsetting the first two variables likely has an impact on other
> executables spawned by such a script.
> 
> The obvious way to fix this would be to introduce `GIT_CONFIG_NOGLOBAL`
> as an equivalent to `GIT_CONFIG_NOSYSTEM`. But in the past, it has
> turned out that this design is inflexible: we cannot test system-level
> parsing of the git configuration in our test harness because there is no
> way to change its location, so all tests run with `GIT_CONFIG_NOSYSTEM`
> set.
> 
> Instead of doing the same mistake with `GIT_CONFIG_NOGLOBAL`, introduce
> two new variables `GIT_CONFIG_GLOBAL` and `GIT_CONFIG_SYSTEM`:
> 
>     - If unset, git continues to use the usual locations.
> 
>     - If set to a specific path, we skip reading the normal
>       configuration files and instead take the path. By setting the path
>       to `/dev/null`, no configuration will be loaded for the respective
>       level.
> 
> This implements the usecase where we want to execute code in a sanitized
> environment without any potential misconfigurations via `/dev/null`, but
> is more flexible and allows for more usecases than simply adding
> `GIT_CONFIG_NOGLOBAL`.

Something is still not right with this patch series, because:

> +test_expect_success 'write to overridden global and system config' '
> +	cat >expect <<EOF &&
> +[config]
> +	key = value
> +EOF
> +
> +	GIT_CONFIG_GLOBAL=write-to-global git config --global config.key value &&
> +	test_cmp expect write-to-global &&
> +
> +	GIT_CONFIG_SYSTEM=write-to-system git config --system config.key value &&
> +	test_cmp expect write-to-system
> +'

This test fails on Travis CI's Linux32 job:

  expecting success of 1300.184 'write to overridden global and system config': 
  	cat >expect <<EOF &&
  [config]
  	key = value
  EOF
  	GIT_CONFIG_GLOBAL=write-to-global git config --global config.key value &&
  	test_cmp expect write-to-global &&
  	GIT_CONFIG_SYSTEM=write-to-system git config --system config.key value &&
  	test_cmp expect write-to-system
  + cat
  + GIT_CONFIG_GLOBAL=write-to-global git config --global config.key value
  fatal: unable to access '/root/etc/gitconfig': Permission denied
  error: last command exited with $?=128
  not ok 184 - write to overridden global and system config

Yeah, that job has a weird environment with Docker and 'su'
interacting in a way that ultimately builds Git with 'HOME=/root',
which in our build system means that 'sysconfdir=/root/etc'.  To
reproduce at home just run:

  make prefix=/root && cd t && ./t1300-config.sh -V -x -i


