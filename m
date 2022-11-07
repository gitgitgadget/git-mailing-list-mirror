Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EA7C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 14:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiKGOdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 09:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiKGOdV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 09:33:21 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F6F20377
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 06:31:26 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z18so17836606edb.9
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 06:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pBo5KMWWZLlPnEPA4VK5uy0qV/fbvspoXBk/K+tSYe8=;
        b=E4LN3/x5tECzuTYtga7xIAf/yrFHzOnfLZwCWFieezZwEZcOikMxh/Dku5iZ3Q5Lc0
         YHEkL1UG1CEs8fIvEkENLkKVZccgvgzphWddtUqEGptcWswHXNPwJK5fC5NyY87cC3TW
         bhCVUT43ZLGrEW6OpqpNcuxzP+NkPUzNIhzXV1QNkcnQ5Z7IbJguup7wFDuc1vMqJ0yo
         mB7EIHEaNGZGeRH0CCN87FH093EJ+o1OECEV/zaXP5kQQuTW54Xede3cFQdxHibp8qEp
         /gVfjVpaeb1JnxykSJxMwq3QfkWhVxTCXkn9sFkMKB4wvThitKDOyTG4fH1Iw2TSCVBT
         Cjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBo5KMWWZLlPnEPA4VK5uy0qV/fbvspoXBk/K+tSYe8=;
        b=s2EsLwpow3LLNYfSYlNBPR8/HpgitqWm1qbCKQilj7SojMZebWUt3WHgVfAEJ7y0XA
         vFhVXcSlkncFgg7Ndj3Kn62yIHOJubkiyWSwGWpppZ/7NO0pG/cd6Vt+yyE6yUf55POn
         yfNBJWEMi4T01K3FAwU2r7sNc2T4gNEqdYeKFThq/5qNjOxKybAGP51s257RiPJRqe/I
         xcToc3cuQWK2wAhZnCmxM7UzL8/an5u8oKoIcLXLWqWX8HmIGXMhgUa7NzYYtLLUn/g6
         UlPhliypK5S6CsKSE1DUxtG9bCW71hENf/ra/tmhNB8Kb0cGjlu+GBkiG+Ujv7GV91Pb
         dENQ==
X-Gm-Message-State: ACrzQf3fUO5E2byMfFnNdO9icakKpp2DtmOaDsMTI+SkgjV13vlI9lFf
        y9RNbEtfHSPDebQuQqoIbws=
X-Google-Smtp-Source: AMsMyM4MRWYLbVxl8hUjuSqfEXdqh3F59RknhRbL09ZhsLGB+nZQd90FgxY64j71wiOPah928wx0LQ==
X-Received: by 2002:a05:6402:249b:b0:460:cb11:27d4 with SMTP id q27-20020a056402249b00b00460cb1127d4mr50684063eda.410.1667831484575;
        Mon, 07 Nov 2022 06:31:24 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id et19-20020a170907295300b0078df26efb7dsm3459090ejc.107.2022.11.07.06.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 06:31:24 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1os39n-0007Na-1U;
        Mon, 07 Nov 2022 15:31:23 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <junio@pobox.com>
Subject: ab/config-multi-and-nonbool (was: What's cooking in git.git (Nov
 2022, #01; Thu, 3))
Date:   Mon, 07 Nov 2022 15:28:14 +0100
References: <Y2RldUHTwNzmez73@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2RldUHTwNzmez73@nand.local>
Message-ID: <221107.86leomx2dg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 03 2022, Taylor Blau wrote:

> * ab/config-multi-and-nonbool (2022-11-02) 9 commits
>  - for-each-repo: with bad config, don't conflate <path> and <cmd>
>  - config API: add "string" version of *_value_multi(), fix segfaults
>  - config API users: test for *_get_value_multi() segfaults
>  - for-each-repo: error on bad --config
>  - config API: have *_multi() return an "int" and take a "dest"
>  - versioncmp.c: refactor config reading next commit
>  - config tests: add "NULL" tests for *_get_value_multi()
>  - config tests: cover blind spots in git_die_config() tests
>  - for-each-repo tests: test bad --config keys
>
>  A mixed bag of config API updates.
>
>  Expecting a reroll.
>  cf. <221026.86pmeebcj9.gmgdl@evledraar.gmail.com>
>  source: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>

The "mixed bag" part of this comes from Junio's v1 summary[1], which I
think I addressed by narrowing the scope in the v2[2].

Per [3] it looks like you were going to try to find time to take a
second look, *gentle poke* :)

1. https://lore.kernel.org/git/xmqqy1szef49.fsf@gitster.g/
2. https://lore.kernel.org/git/cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com/
3. https://lore.kernel.org/git/Y2G+qczur9eLVtk5@nand.local/
