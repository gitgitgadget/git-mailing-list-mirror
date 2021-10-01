Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5954EC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 15:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3375161242
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 15:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354626AbhJAPNZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 11:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355049AbhJAPNP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 11:13:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6986C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 08:11:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s17so35191332edd.8
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 08:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=nN/65UxM1Wu9GKAWjN1BQKO9g08zLsl7UVwzWwGN+TI=;
        b=joHTLnKQ3RDxXV4XRWaju6A1cQDGDl3CnZF85ZibCaUPVeN9fSR6xEqDlAwFII50PZ
         URYT5H1M/MJx/0oSzjRSxry9Js96GSn2UF+b47htmzyAIQweCZTu9K87gY2Va2tkaSKd
         OWejsjSdAeEEbpZiz0FYrcRuIlyGQr+JVWVZGW29xsX6vceOV/EpgApRKPZeiaMcSGYP
         wBoA0RiBIT9eUVFUNn2zu3uRjxu0WVwzdrewh4EpCcT7NccWgbhqjUh7xMKaBreWho61
         0BUeVMFCMRsjp+krIpGie5SNLSlhfnLQAa+FzTVLZoFOfxhrHPTWsM5fYO5bd6ofVl67
         SSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=nN/65UxM1Wu9GKAWjN1BQKO9g08zLsl7UVwzWwGN+TI=;
        b=CQBLZvzFn7GpYb9k2Hn+EKXOv3tf62CIptvVQYat0HpD+dsPFW9gCFSnKe7/QlnExS
         VdKWEEWPgDnG+4mRJUaoaSeBoaEV5V7PZKZanbodiyjl5TRyeFDUM5CrqVM23kGKViKj
         iP2UUN3AG2fxgeNNqQpaAPmMzgKoTtj8lgnp5jL4sd4QGlFrajIqhFCHs28o9rWrvq8o
         CJE8KmYn3PJDzlktV7wma3IhBJpgWm5Jb4hRB31ZBuIdXwm4d/hYy9RwDEwa/Gba1r77
         mzIBSnfp2NSDa0l/hw7bgG7PwBUhOFSCDzxyNM7FdMj9rUuz7LoXH/zTiR25KoECdedO
         Xcpw==
X-Gm-Message-State: AOAM533D0WwQcPw5gHpokM1bPJToYjGhG3+Oh4VqPZT83zxxqs7gShe/
        fbL+MkeROrxHbYg7jmz4xrk=
X-Google-Smtp-Source: ABdhPJxF+eEBxE+RvMhV0cLj5bl27VlzMhX+vwhRoEohP9SOy2mfGgzBi9g/RAVHO7oYDTkUMhETmg==
X-Received: by 2002:a17:906:1197:: with SMTP id n23mr6969491eja.407.1633101088635;
        Fri, 01 Oct 2021 08:11:28 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d3sm3120623ejb.35.2021.10.01.08.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 08:11:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: ab/config-based-hooks-1
Date:   Fri, 01 Oct 2021 17:07:34 +0200
References: <xmqqh7e18soj.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqh7e18soj.fsf@gitster.g>
Message-ID: <871r54rd9c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 30 2021, Junio C Hamano wrote:

> * ab/config-based-hooks-1 (2021-09-27) 8 commits
>  - hook-list.h: add a generated list of hooks, like config-list.h
>  - hook.c users: use "hook_exists()" instead of "find_hook()"
>  - hook.c: add a hook_exists() wrapper and use it in bugreport.c
>  - hook.[ch]: move find_hook() from run-command.c to hook.c
>  - Makefile: remove an out-of-date comment
>  - Makefile: don't perform "mv $@+ $@" dance for $(GENERATED_H)
>  - Makefile: stop hardcoding {command,config}-list.h
>  - Makefile: mark "check" target as .PHONY
>
>  Mostly preliminary clean-up in the hook API.

I think this has gotten some thorough review from Ren=C3=A9 & Phillip at th=
is
point[1][2]. I think th consensus on the v2 is to just keep the "sed"
invocation I have as-is.

As you know the greater configurable hook topic is pending on this
moving forward, so starting to get at least some of it merged down
before 2.34 would be great. I was hoping we'd have a release with at
least the simpler hooks running via the new hook library (and perhaps
the --stdin cases too).

1. https://lore.kernel.org/git/0e07cee4-079a-af12-880f-d4a99300df28@web.de/
2. https://lore.kernel.org/git/6e7d5945-d64f-9511-9668-b453c20c086c@gmail.c=
om/
