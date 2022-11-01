Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04288FA3740
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 02:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKACOE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 22:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKACOC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 22:14:02 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB90CCC3
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 19:14:01 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id e62so155173ybh.12
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 19:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLuOEJt4LuXlSdJ9KSLNFvEOdpi1SAJ4//RiHpkm+3c=;
        b=B6otJ0PGPk2sMgTnE31cDr1DQqjhvakN7woVW9N7FFPdyCkWon+ze22kCgaLgIbRIf
         QmBDEVfiZ/eSEvwk7e0g4BihR7mPQ8PTmHUwTY67mw3RI5HIgyUgPOARA4SDWN2ff9VV
         +m+N7XPFaNDQql7ndmQxK/81apRqaqtT5gYnBUNSolkp3g3mIQYi8cn+eLpZUQ3UMyqe
         bZf7uZkg4FeTvOBj4to0XW9YYKsEGH9J7DITN/9OZSz9UgwrS2/tkh+BjAG23gX5tyUB
         b3GZB7aDIfdgGWHnRQ7qhk12k8r0F8KQlWf3PVTAULtWSkMCYEwoy46RZdlLhZh/mdTd
         idxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLuOEJt4LuXlSdJ9KSLNFvEOdpi1SAJ4//RiHpkm+3c=;
        b=yOCL/yjzYd+Gqs8mcud/tde1qf9igp4SeCeS6qavMDv8wJWVPOtqXg4ZExA5Wm2hw6
         2y5zxtZnbVEuKpG4fHYmKof3NpP6TTHBQiIAp7uLIrDTtXq/WA14M7f/jgNs/SSP+WJq
         bebAA9vw1Ja8BOtVonQUpz0iJg2k1AtaDdy0TQNt5iVYhuDnEWpwqsJ/IP7rouTq7ezT
         hVmwMbEG6lpStSjPw0q7ZpnHMshInj2IR4GktzCpwoxY3w1cFdO4FVrRxMWaMQ9cklpa
         l46Z5ms7K7VMW6/xclD0ME6PjEcSQeaaOaX0Me4Pj5HETo11v+2n5BNpDnCZq801mj4u
         k94Q==
X-Gm-Message-State: ACrzQf0G35fQb4Varpdolwi7TTe8S0E9i/mfJShUEfGk1H9TE/RjyA57
        i8mQfPLdP49LAHwwMU8LgU83T6f0E2qvmJDyGRI=
X-Google-Smtp-Source: AMsMyM5hFLscBxazviwovxzl6bNelB0YYh24nN/skUbaUlPFXpcCdiHQ/SzFM0kNZd4MHxdfopDTpFKBfWhpu+XWPT0=
X-Received: by 2002:a05:6902:110d:b0:6ae:3411:71f7 with SMTP id
 o13-20020a056902110d00b006ae341171f7mr15774446ybu.300.1667268841101; Mon, 31
 Oct 2022 19:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1398.git.1667189512579.gitgitgadget@gmail.com> <Y2B3j3sFcd/mJoHx@nand.local>
In-Reply-To: <Y2B3j3sFcd/mJoHx@nand.local>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 1 Nov 2022 10:13:50 +0800
Message-ID: <CAOLTT8RZEsJcNquSU0FQMZvhA++eZAkzMq9um9YkkruCJc3aiA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] diff: introduce scope option
To:     Taylor Blau <me@ttaylorr.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=881=E6=97=A5=
=E5=91=A8=E4=BA=8C 09:34=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Oct 31, 2022 at 04:11:52AM +0000, ZheNing Hu via GitGitGadget wro=
te:
> >  t/t4070-diff-sparse-checkout-scope.sh | 469 ++++++++++++++++++++++++++
>
> It looks like this test is non-executable, leading to the following
> error:
>
>     ~/s/git [nand] (zh/diff--scope) $ make test
>         SUBDIR templates
>     make -C t/ all
>     make[1]: Entering directory '/home/ttaylorr/src/git/t'
>     rm -f -r 'test-results'
>     non-executable tests: t4070-diff-sparse-checkout-scope.sh
>     make[1]: *** [Makefile:120: test-lint-executable] Error 1
>     make[1]: *** Waiting for unfinished jobs....
>     make[1]: Leaving directory '/home/ttaylorr/src/git/t'
>     make: *** [Makefile:3083: test] Error 2
>

Thanks for pointing out that I had overlooked this problem.

> Thanks,
> Taylor

ZheNing Hu
