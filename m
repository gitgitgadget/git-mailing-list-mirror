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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E815C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 22:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E93E6140E
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 22:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbhGAWvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 18:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbhGAWvV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 18:51:21 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A49C061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 15:48:49 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id v20so13038856eji.10
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 15:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=rgTGHdzd/wEl//45r3cN/lj5pEAanq8pWNCXvsOLKOg=;
        b=O5e7IXpcvqYZ3qiGYk1IEKrdvjqYjkMFUOFNQM7DvdDt5Yw6sXbN7s9FkDXMXNmdZ1
         jQn80kn4JHmNZALqIZA0iAmYevHYa86gp6o7gRMyJT0FWWP+ts3frysNCLtofw+3RnNt
         IlIleKSL/S+MYGWtdrcJKJR8nsrVP4xBqqRUYGZjQ+u2NxfeJlS6thlQJ/370Z2WNT34
         hMUMcKVku+QWE+6ws3mIlzWc1xZ2wZkZrA07gD5amsMNVOTFPCex24ARZq8HtM4nKgVK
         197UIz3snG1M38N/bDN86ugzzT48f5+qzV4MwjChpWvJZLrKdR+Y/gn0WG9M+VwsqvYb
         rE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=rgTGHdzd/wEl//45r3cN/lj5pEAanq8pWNCXvsOLKOg=;
        b=GWxeZDWYtNwm2519Kj+IJlDqDBtE7N2dGXQRZmtegUAtZNyxZk4bWxNQVoz+73IfgJ
         M7MeAXDanvKlckfBHc3DZQyqMHe8t9Vu56uRXGu6gdbKodrTwbUSJ8GLhDP0Pji2IXIO
         +W4J31M5hi0I3+Lkfkr5rz4ywMrYtaTbOvUMIlLYYUdDAoMb1lyvpvgChdlV0dxsql54
         zc5UuepsNnC70zj+9EjfObmBTO2pHo6ZFy+o+BeADHHd5cH53Db7KiW6n5+RjUYcvvXY
         HF+3eQQWCftou6S9Rc9lRyjTjxFKSJiiPmvJLufQ8LvsPrYa0EmW4V62sEusRyjpcp3O
         LjLQ==
X-Gm-Message-State: AOAM531KqJmC2OIelnnFJ1d9OcwNqmuq4OZwXif5RoY5mbQYtrj+n1Vf
        NI24xr5puwsDTalYGLJlYr856H84vcvcRQ==
X-Google-Smtp-Source: ABdhPJx8UBcK5t/Fg7OPxdtiTgb09QoQAMayEgGHb8E70hzFCt9LLYlQ1lRTNHcIGF0paA3hAl41ig==
X-Received: by 2002:a17:906:538c:: with SMTP id g12mr2169813ejo.245.1625179727908;
        Thu, 01 Jul 2021 15:48:47 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id o27sm396537eja.14.2021.07.01.15.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 15:48:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 11/34] fsmonitor-fs-listen-win32: stub in backend for
 Windows
Date:   Fri, 02 Jul 2021 00:45:45 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <5a9bda7220356ebf0689bb6aaa9068520dc6e33b.1625150864.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <5a9bda7220356ebf0689bb6aaa9068520dc6e33b.1625150864.git.gitgitgadget@gmail.com>
Message-ID: <87v95tbqgh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Stub in empty backend for fsmonitor--daemon on Windows.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  Makefile                                     | 13 ++++++
>  compat/fsmonitor/fsmonitor-fs-listen-win32.c | 21 +++++++++
>  compat/fsmonitor/fsmonitor-fs-listen.h       | 49 ++++++++++++++++++++
>  config.mak.uname                             |  2 +
>  contrib/buildsystems/CMakeLists.txt          |  5 ++
>  5 files changed, 90 insertions(+)
>  create mode 100644 compat/fsmonitor/fsmonitor-fs-listen-win32.c
>  create mode 100644 compat/fsmonitor/fsmonitor-fs-listen.h
>
> diff --git a/Makefile b/Makefile
> index c45caacf2c3..a2a6e1f20f6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -467,6 +467,11 @@ all::
>  # directory, and the JSON compilation database 'compile_commands.json' will be
>  # created at the root of the repository.
>  #
> +# If your platform supports a built-in fsmonitor backend, set
> +# FSMONITOR_DAEMON_BACKEND to the "<name>" of the corresponding
> +# `compat/fsmonitor/fsmonitor-fs-listen-<name>.c` that implements the
> +# `fsmonitor_fs_listen__*()` routines.
> +#
>  # Define DEVELOPER to enable more compiler warnings. Compiler version
>  # and family are auto detected, but could be overridden by defining
>  # COMPILER_FEATURES (see config.mak.dev). You can still set
> @@ -1929,6 +1934,11 @@ ifdef NEED_ACCESS_ROOT_HANDLER
>  	COMPAT_OBJS += compat/access.o
>  endif
>  
> +ifdef FSMONITOR_DAEMON_BACKEND
> +	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
> +	COMPAT_OBJS += compat/fsmonitor/fsmonitor-fs-listen-$(FSMONITOR_DAEMON_BACKEND).o
> +endif
> +
>  ifeq ($(TCLTK_PATH),)
>  NO_TCLTK = NoThanks
>  endif
> @@ -2793,6 +2803,9 @@ GIT-BUILD-OPTIONS: FORCE
>  	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
>  	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
>  	@echo X=\'$(X)\' >>$@+
> +ifdef FSMONITOR_DAEMON_BACKEND
> +	@echo FSMONITOR_DAEMON_BACKEND=\''$(subst ','\'',$(subst ','\'',$(FSMONITOR_DAEMON_BACKEND)))'\' >>$@+
> +endif

Why put this in an ifdef?

In 342e9ef2d9e (Introduce a performance testing framework, 2012-02-17)
we started doing that for some perf/test options (which b.t.w., I don't
really see the reason for, maybe it's some subtlety in how test-lib.sh
picks those up).

But for all the other compile-time stuff we don't ifdef it, we just
define it, and then you get an empty value or not.

This would AFAICT be the first build-time-for-the-C-program option we
ifdef for writing a line to GIT-BUILD-OPTIONS.
