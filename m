Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD57C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 15:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbhL1PWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 10:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhL1PWB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 10:22:01 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122DBC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:22:01 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y22so75175451edq.2
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=j7tNuyrlGv8YVNdyQGleIqsYa99aJiSaHeocqaEvcrw=;
        b=IrNGwYRtVEviXxG9NrzTYKKz8VMjc/PLh0IRERdUoDifNZv6wRwuYGxj+27MoiDtDn
         p+s3v3Fl3kte0K9J1RK7Jmu3lLNHdUpCJAQ0yLibnQbJUPborymbDQUJHimlw8Ycwd+K
         n5XbBjV8WFAkqvJafSbXEwkiKrAfwYZkBILZoq/d9mlvMWQ5NPcWZscQLL1ZocsD0SEN
         JdT+PAp6PfCiEGBAE4fSjxVUOZ4YuasYsnwC4rOha0E36mK1WoBTODNjpOe+0Dau3hew
         XdPIoIkulPNSl1h85R6PORW+/hVkLOBT5o5110Aqdyb+C4uS5yGdIBKLNpOT8Fu9jcAS
         UqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=j7tNuyrlGv8YVNdyQGleIqsYa99aJiSaHeocqaEvcrw=;
        b=gXMMeP+GYPHXWzPTTEvKa605EJfbZHjPm2bgZbZ0xKuYDs1SqWBsCjFnbsLDPuchEh
         djPn41PHuvwO5vlkA3g0SqIY/ISh6WWdUC8hMJeB6Hyjb2Wl4D5iG9IzUTZP2DWklM2k
         pJ772dA3EZVf0pwCArZesF/M9BjiN/yf2p1j0FX43GlrNt9BYwDdmpWuRARGFZyWdnmE
         cfaAYPlnUrMdji94lk9+dcA5N9WOhBb/DOaN5b3tFUXLUR4zcShYjuRHMRGL9XjVie50
         H5VGlPWdrCaLRgOQRA9qTqQf1l6Mf9qfzfkpmVG3HEQMjY0BQptP6rZG8vdCy6tDPfsF
         UlHQ==
X-Gm-Message-State: AOAM530oX4Sz2t8/uZjWCPu4i3x675TBVIwKAwGj9b6BCv3n3hzBjncV
        2B1U873+QFsBSwqAc61dy9gcyJ7+876jLoz8
X-Google-Smtp-Source: ABdhPJy3faBCqqioieAqNaBMVudDj5qxqaZqRr92kPlCCd20tb8wK4jkmbfBwkm+13fsyjLQSvhKuA==
X-Received: by 2002:a17:907:7b87:: with SMTP id ne7mr17121074ejc.573.1640704919535;
        Tue, 28 Dec 2021 07:21:59 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id hr5sm6168309ejc.5.2021.12.28.07.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 07:21:59 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n2EIY-000EsD-Bc;
        Tue, 28 Dec 2021 16:21:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Johannes Altmanninger <aclopte@gmail.com>
Subject: ab/only-single-progress-at-once (was: What's cooking in git.git
 (Dec 2021, #06; Mon, 27))
Date:   Tue, 28 Dec 2021 16:20:29 +0100
References: <xmqq7dbpvb0q.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq7dbpvb0q.fsf@gitster.g>
Message-ID: <211228.86czlgiwkp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 27 2021, Junio C Hamano wrote:

> * ab/only-single-progress-at-once (2021-11-03) 8 commits
>  - progress.c: add & assert a "global_progress" variable
>  - various *.c: use isatty(0|2), not isatty(STDIN_FILENO|STDERR_FILENO)
>  - pack-bitmap-write.c: don't return without stop_progress()
>  - progress.c: add temporary variable from progress struct
>  - progress.c tests: test some invalid usage
>  - progress.c tests: make start/stop commands on stdin
>  - progress.c test helper: add missing braces
>  - leak tests: fix a memory leaks in "test-progress" helper
>
>  Further tweaks on progress API.
>
>  Needs review.
>  The last three rounds has seen little reaction, even though earlier
>  round saw a lot of responses. The latest round needs a serious
>  review or at least Acks from past commentors.
>  source: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com>

The slimmed-down v7 got a review from Johannes Altmanninger, and I've
just submitted a v8 now to address the points brought up there:

https://lore.kernel.org/git/cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com/
