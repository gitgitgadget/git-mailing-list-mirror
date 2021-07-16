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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C36C636CB
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 16:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F1C613F1
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 16:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhGPRAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 13:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhGPRAA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 13:00:00 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D734C061762
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 09:57:04 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id t3so13782328edc.7
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 09:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ibBQEUJ8aGnG702apCA2QELvfPEIe4oKlGo4J3WqiHA=;
        b=DZfKoHMGvTHOcij9VkLNUeu7ZgP3w4BQyT/vRu24KTuHDuJS302cu71SH8vRh6A4QV
         fZn+VVo0QPjn3eMsUPizrHYLazr+PDmWIi9nKtj/p1t/wb8OJPhITyt/Gl2Qx3CKimam
         QB61KMb6Vi9kG0M7tArHmuhw96rILkqrOhpF3L6giXH70sGpYYf9x5Cdp4DEBVGtxaqV
         dJI8VdoMjp9XJgv93kItx3POSc90PnyTcVNYziOMOfCpCTA0hopnF/MiHYzRkerZcduG
         2/1TTy0Pp6lS29wPc7Ms2hpR5+nqJI96BCsVmiavtWKGkp3plCVv+5QWBXTrVH2gY1u1
         Nf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ibBQEUJ8aGnG702apCA2QELvfPEIe4oKlGo4J3WqiHA=;
        b=qu8uxWupm+5iIJV2E5Gy1egZyOtzFzsW8D7hg+BH13lPH8wFJ9YiXSHC/JlpLkUm5s
         IpEuZUwCYQ5X2/7JNBTRsKzJimu8+4vhAUKXX/nc+ggwGsm+S1hbMnoCEmrqOPWKf6iw
         eRS+MpMtzgkd6HU980k/fA7Xif2oJ8swNAggSbfsSjbR7Wk1oybqoBFScG2SC7LhdO8j
         nIMrU4YjRvzCensOOIcxQ2U+EKtcECKXncX/AGOV/iVJTP52jaXcXK2IclZr6Y0DJ65e
         X8mmigr/rZ+18ufWq4Y9zl7+gjMIo43XLQKhrtHcI+Ag+aI3lNpg2J1roq2Bk7bD79oh
         +FfA==
X-Gm-Message-State: AOAM530iWO8u1D04DUmZRflq9wShbqa52dRzPpKeFztZw9lLNXLPGIha
        5ypfYHCAVcrZJlSVc0GNFN58uI96Ev22VQ==
X-Google-Smtp-Source: ABdhPJzabpfuHZe3Trw0OFMfQrlP1cR/MU0u8li7tqPaZYZWA4NAkBoVTr5wck0XiEt4iyFXSz/Bfg==
X-Received: by 2002:a05:6402:1057:: with SMTP id e23mr16206120edu.352.1626454621705;
        Fri, 16 Jul 2021 09:57:01 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d19sm4015407eds.54.2021.07.16.09.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 09:57:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 11/34] fsmonitor-fs-listen-win32: stub in backend for
 Windows
Date:   Fri, 16 Jul 2021 18:55:12 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <5a9bda7220356ebf0689bb6aaa9068520dc6e33b.1625150864.git.gitgitgadget@gmail.com>
 <87v95tbqgh.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2107161747010.59@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <nycvar.QRO.7.76.6.2107161747010.59@tvgsbejvaqbjf.bet>
Message-ID: <87y2a6w61l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 16 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Fri, 2 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>>
>> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
>>
>> > From: Jeff Hostetler <jeffhost@microsoft.com>
>> >
>> > Stub in empty backend for fsmonitor--daemon on Windows.
>> >
>> > Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> > ---
>> >  Makefile                                     | 13 ++++++
>> >  compat/fsmonitor/fsmonitor-fs-listen-win32.c | 21 +++++++++
>> >  compat/fsmonitor/fsmonitor-fs-listen.h       | 49 ++++++++++++++++++++
>> >  config.mak.uname                             |  2 +
>> >  contrib/buildsystems/CMakeLists.txt          |  5 ++
>> >  5 files changed, 90 insertions(+)
>> >  create mode 100644 compat/fsmonitor/fsmonitor-fs-listen-win32.c
>> >  create mode 100644 compat/fsmonitor/fsmonitor-fs-listen.h
>> >
>> > diff --git a/Makefile b/Makefile
>> > index c45caacf2c3..a2a6e1f20f6 100644
>> > --- a/Makefile
>> > +++ b/Makefile
>> > @@ -467,6 +467,11 @@ all::
>> >  # directory, and the JSON compilation database 'compile_commands.json=
' will be
>> >  # created at the root of the repository.
>> >  #
>> > +# If your platform supports a built-in fsmonitor backend, set
>> > +# FSMONITOR_DAEMON_BACKEND to the "<name>" of the corresponding
>> > +# `compat/fsmonitor/fsmonitor-fs-listen-<name>.c` that implements the
>> > +# `fsmonitor_fs_listen__*()` routines.
>> > +#
>> >  # Define DEVELOPER to enable more compiler warnings. Compiler version
>> >  # and family are auto detected, but could be overridden by defining
>> >  # COMPILER_FEATURES (see config.mak.dev). You can still set
>> > @@ -1929,6 +1934,11 @@ ifdef NEED_ACCESS_ROOT_HANDLER
>> >  	COMPAT_OBJS +=3D compat/access.o
>> >  endif
>> >
>> > +ifdef FSMONITOR_DAEMON_BACKEND
>> > +	COMPAT_CFLAGS +=3D -DHAVE_FSMONITOR_DAEMON_BACKEND
>> > +	COMPAT_OBJS +=3D compat/fsmonitor/fsmonitor-fs-listen-$(FSMONITOR_DA=
EMON_BACKEND).o
>> > +endif
>> > +
>> >  ifeq ($(TCLTK_PATH),)
>> >  NO_TCLTK =3D NoThanks
>> >  endif
>> > @@ -2793,6 +2803,9 @@ GIT-BUILD-OPTIONS: FORCE
>> >  	@echo PAGER_ENV=3D\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\'=
 >>$@+
>> >  	@echo DC_SHA1=3D\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$=
@+
>> >  	@echo X=3D\'$(X)\' >>$@+
>> > +ifdef FSMONITOR_DAEMON_BACKEND
>> > +	@echo FSMONITOR_DAEMON_BACKEND=3D\''$(subst ','\'',$(subst ','\'',$(=
FSMONITOR_DAEMON_BACKEND)))'\' >>$@+
>> > +endif
>>
>> Why put this in an ifdef?
>
> Why not? What benefit does this question bring to improving this patch
> series?

I think that when adding code to the Makefile it makes sense to follow
the prevailing pattern, unless there's a good reason to do otherwise,
e.g. on my build:
=09
	$ grep "''" GIT-BUILD-OPTIONS=20
	NO_CURL=3D''
	NO_EXPAT=3D''
	NO_PERL=3D''
	NO_PTHREADS=3D''
	NO_PYTHON=3D''
	NO_UNIX_SOCKETS=3D''
	X=3D''

Why does the FSMONITOR_DAEMON_BACKEND option require a nonexistent line
as opposed to an empty one?
