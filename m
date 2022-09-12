Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A14ECAAD5
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 15:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiILPgC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 11:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiILPfs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 11:35:48 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609922B633
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 08:35:46 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u22so8933156plq.12
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 08:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=fJGoLVLZd8jzgDM60+fUmAj9Un4+9Yr6WpsjjHH6EOg=;
        b=eNszKe9YvGULTRgONwxKybOb4FzpXPWhknO1IvYZN7i/ILWhpWem7ybProFHZ0Aazo
         Bvu0wkmJbWgLbMTmHPe9+JW/QQWwCk3ws3gT0QfZpkWMOvOKJHM3mk1/XIGkiGaJpeuv
         0UNWj5CVKy5HEPj3TXALIQrt9fAXkO+zCrAbv76cxt2XY6GEcqLJ7H88qkoUrOuyIAVl
         vSaduw4qe/aAf8CCW0RhFCPWALxHbteYxw+oEVhFz8rAApHLtLq1zehDJ3xD16/CXnEV
         wbXN8GLJ4izh5QmPVgleEDiK7WHjGdK32lwp5Lsp6DmG3YqEHLCMtSVOyDQr+Fri7xEx
         5QLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=fJGoLVLZd8jzgDM60+fUmAj9Un4+9Yr6WpsjjHH6EOg=;
        b=7xCagCv5HKHCA2F00Xy0wK+JhEIBHjrl/GUOq6FqoUFnPV8cKucZqe3x2LaQbFgiJd
         w2QPZQCwu6hcHZ7T/PgeVSw+p7cTkL6Zu+MVHZX78OfW494KfPEvmeyBRUpJRgR/Guiu
         1+tursKplFEV8oBm/5b8+qdH9SsE34s7wP6gJ+v763vxHhifB/GBvN7sBVO1CvrFng34
         B5kJJ5NoxYN9X7B/P38Bs5CFVDxIVot97AsR7U9zdqSzsYUiSQvTwdFwRtCFDac91oqh
         m6rvoalOY7MeOPl6d9d2HOhW7cpF64uIyVgPB4u0FisDY6V4XkLu3sZGBujUd0Z0Ucuk
         dUkg==
X-Gm-Message-State: ACgBeo1WnfZ7CpXagxMeu/bIeYuTcSvoSf8ZgnNgK6nlzHXnaMUefMNn
        V+/MRFJpSb+ybNJYe5jIORs=
X-Google-Smtp-Source: AA6agR5Kqds5FIPKLVquT5zQIRyDwGn6+ofmu3K2+2JalXSF3k6FSdx9yBVOdbSeDQFUZ5yzAdl2qQ==
X-Received: by 2002:a17:90b:4c10:b0:202:e9e9:6350 with SMTP id na16-20020a17090b4c1000b00202e9e96350mr1388316pjb.193.1662996945222;
        Mon, 12 Sep 2022 08:35:45 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090a760c00b001fb35e4044bsm5363011pjk.40.2022.09.12.08.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 08:35:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v5 0/4] fsmonitor: option to allow fsmonitor to run
 against network-mounted repos
References: <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
        <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com>
Date:   Mon, 12 Sep 2022 08:35:44 -0700
In-Reply-To: <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com> (Eric
        DeCosta via GitGitGadget's message of "Sat, 10 Sep 2022 20:00:27
        +0000")
Message-ID: <xmqqa674hagf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Eric DeCosta (4):
>   fsmonitor: refactor filesystem checks to common interface
>   fsmonitor: relocate socket file if .git directory is remote
>   fsmonitor: avoid socket location check if using hook
>   fsmonitor: deal with synthetic firmlinks on macOS
>
>  Makefile                                 |   2 +
>  builtin/fsmonitor--daemon.c              |   8 ++
>  compat/fsmonitor/fsm-ipc-darwin.c        |  46 ++++++++
>  compat/fsmonitor/fsm-ipc-win32.c         |   4 +
>  compat/fsmonitor/fsm-listen-darwin.c     |   6 +-
>  compat/fsmonitor/fsm-path-utils-darwin.c | 131 +++++++++++++++++++++++
>  compat/fsmonitor/fsm-path-utils-win32.c  | 106 ++++++++++++++++++
>  compat/fsmonitor/fsm-settings-darwin.c   |  70 ++++--------
>  compat/fsmonitor/fsm-settings-win32.c    | 106 +-----------------
>  contrib/buildsystems/CMakeLists.txt      |   4 +
>  fsmonitor--daemon.h                      |   6 ++
>  fsmonitor-ipc.c                          |   2 -
>  fsmonitor-path-utils.h                   |  49 +++++++++
>  fsmonitor-settings.c                     |  58 +++++++++-
>  fsmonitor-settings.h                     |   2 +-
>  15 files changed, 441 insertions(+), 159 deletions(-)
>  create mode 100644 compat/fsmonitor/fsm-ipc-darwin.c
>  create mode 100644 compat/fsmonitor/fsm-ipc-win32.c
>  create mode 100644 compat/fsmonitor/fsm-path-utils-darwin.c
>  create mode 100644 compat/fsmonitor/fsm-path-utils-win32.c
>  create mode 100644 fsmonitor-path-utils.h
>
>
> base-commit: be1a02a17ede4082a86dfbfee0f54f345e8b43ac

Another curious thing I need your help on.

The cover letter says that this work is a follow-up to extend the
previous work for Windows, and I would have expected these patches
to build on 85dc0da6 (fsmonitor: option to allow fsmonitor to run
against network-mounted repos, 2022-08-11), which is not yet in
be1a02a1 (The seventeenth batch, 2022-09-01).

What is going on?

Thanks.

