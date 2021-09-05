Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1344C433F5
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 07:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97CEE60F92
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 07:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbhIEH7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 03:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbhIEH7E (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 03:59:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99276C061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 00:58:01 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r7so4976960edd.6
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 00:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=DLVWV/wBaZi1hVNIEwVEFQE0MFr29PEj/WC0OG92wdw=;
        b=dT4wx2zxtCJjJ5BaXY907CSoGTa4hJF1Oc3+bBaeYaLUXvAARrXMNaDMtqjVCuL1Et
         rxJKMhyefoAm3NtvZnudddkFVLP8dqPqPRgb07ZzGu9qQb6URGZ6Xsyff65PG/doNMX1
         iCZSm59Ojn4qHsZ19kLTgs0sGYhOGkn7rlxb7NAD4PQGJySGldL9esnOBbeiyTGk6ghw
         ugQBqNvmrVZhK6XCWUZJBHywvn7Jj1Wy2Fi5kj1Cmehy2UEsDa8rAk1AMb8Xor146rnA
         keutyepHrVmzN5YU0rDI4YGcUHy+DV5IrbHSux7Ne5it+nHh1LlVnDYGYahiVmpGH8b9
         7xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=DLVWV/wBaZi1hVNIEwVEFQE0MFr29PEj/WC0OG92wdw=;
        b=GcLccgmylr4ZtBRCgLXAQqZRdrOOLSgCKkSaXVUGLeJmiVdQq2nT5fGRoxwKCNTAob
         g0RopQjGwpxB9AtivOn4pPkW6LhtcYT4oOqK+/Aq1bX3ebFgrud4CbURtt5DWb8cfJ8M
         7I9drh3ayyvqpeVpydtR8yyr7lRA7ZstcqltzBsvrDKP7BXebcqirSb6HAsJK496uqqL
         OWVoEPqWGuRktyNbAjtaRWvxKQYPbQ94KzMKBEyUknW2qBtw2+6+3nMObNYY7DkyoU8/
         O+5b6pWSTfTCgTqKoN1KKoZh2yjB7xbjWXYz/E+phO8JXXMYMTySNc5znQL9+SJ/A6nF
         orgg==
X-Gm-Message-State: AOAM531tjuW/ELW+kBi383+VSdlmeCRKFsuVzqH9KyR0TSSyr1BgR+8U
        bQ3cKEj5ApIUeXjNqhlfWBOlbqtV+k3/NQ==
X-Google-Smtp-Source: ABdhPJxL82lUZQoRmqz5zeJmZe4wsrFTnAu1Zg6yY5rJMOABY7Ul2Yhy3SSvl1fmhwg9cePJJdopfA==
X-Received: by 2002:a50:cc08:: with SMTP id m8mr7801992edi.60.1630828680140;
        Sun, 05 Sep 2021 00:58:00 -0700 (PDT)
Received: from evledraar (2a02-a45a-de66-1-2cbc-c868-da6a-49d1.fixed6.kpn.net. [2a02:a45a:de66:1:2cbc:c868:da6a:49d1])
        by smtp.gmail.com with ESMTPSA id k22sm1995963eje.89.2021.09.05.00.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 00:57:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, phillip.wood@dunelm.org.uk,
        sunshine@sunshineco.com
Subject: Re: [PATCH v3 0/3] support pedantic in developer mode
Date:   Sun, 05 Sep 2021 09:54:00 +0200
References: <20210901091941.34886-1-carenas@gmail.com>
 <20210903170232.57646-1-carenas@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210903170232.57646-1-carenas@gmail.com>
Message-ID: <87o897pi7x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 03 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> This series enables pedantic mode for building when DEVELOPER=3D1 is
> used and as an alternative to only enabling it in one CI job, that
> was merged to "seen" as part of cb/ci-build-pedantic.
>
> The second patch is really an independent prerequisite to ensure
> that it doesn't break the build for Windows and is the minimal change
> possible.
>
> Additional changes needed for the git-for-windows/git fork main to be
> posted independently.
>
> It merges and builds successfully all the way to "seen" IF the known
> problem reported earlier[1] and expected as part of a reroll of=20
> jh/builtin-fsmonitor is merged first.
>
> [1] https://lore.kernel.org/git/20210809063004.73736-3-carenas@gmail.com/
>
> Carlo Marcelo Arenas Bel=C3=B3n (2):
>   win32: allow building with pedantic mode enabled
>   developer: enable pedantic by default
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
>   gettext: remove optional non-standard parens in N_() definition

This whole series looks good to me, thanks for picking up my patch as
the 1/3. The only comment I have on it (doesn't need a re-roll) is that
I found the first paragraph in 2/3 slightly confusing, i.e.:
=20=20=20=20
    In preparation to building with pedantic mode enabled, change a couple
    of places where the current mingw gcc compiler provided with the SDK
    reports issues.

With "the SDK" we're talking about the Win32 SDK, which is implicit from
the subject line. I'd find something like this less confusing:

    In preparation for building with DEVOPTS=3Dpedantic enabled
    everywhere, change a couple of places where we'd get Win32 breakes
    under the GCC version provided wit hthe current MinGW version.

Or something. I'm not sure if this /only/ impacts Win32, or just that
compiler version. Some of the diffstat is win32-only, but nod nedmalloc,
but I see there's some parallel discussion about whether that's in
effect win32-specific.

Anyway, that's all a tiny nit. In general I like the change. I also
checked that an existing DEVOPTS=3Dpedantic wouldn't accidentally enable
DEVOPTS=3Dno-pedantic (i.e. that it wasn't a glob), but it doesn't, since
that's not how $(filter) works.
