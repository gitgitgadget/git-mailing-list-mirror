Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED60C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 16:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 916B760235
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 16:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbhJFQtw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhJFQtw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 12:49:52 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D01C061746
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 09:47:59 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x7so11619854edd.6
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 09:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eujSp+EeN6yl+gz16I/kFxYyGE2PZVGswflZBFJTKj0=;
        b=WcEEui/FdCCbg5TzFh6p8HmnmUDpDbtmDzeOvTjct5YlVYC+0A+kdu2WQLzg16ulMf
         sl65rHKfVqg89awbl6yeUQp0g9NivBnnwi+WD6nLulPE8ctbxyXeE7C4c53cFWbjBF7Z
         o5tIp8IdMQQ6ORQeReSAfeJhckCYhL+5R10BexoDc/N5aNuFipcteRwGf74l2V84+gvC
         V4Kj7nnJEtW9h1kDBwR3MtUle5+GTScyoj/fu48hVN2Ugns5XnI/hmdJ8JOFZn0bx9jH
         ylhTPNKPJgkIugsngtbqAKPh8D8CQ2u0vuWKjJYYvADKXcYi+yctb1mjhl/a+RTQRxIS
         TgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eujSp+EeN6yl+gz16I/kFxYyGE2PZVGswflZBFJTKj0=;
        b=YyUZ8eC5B0r1tM3tAq7xN7Ksbv+QUW8GAE4RwlPBBpIxAVurqu7P/LVNPQi/tdOi8o
         UNoSk25Y3UexVrY694roEySn76t/Bmcxiy4tqVqJr0Xq/aw4YlK4FVE9/YTYqRKk/iKt
         tDJMzNiRuhobg0ex0fgvptf8g3BDdKRLOAW+xytUFJAxCBGXrrTx+mgNy4NS16a8OESI
         BlH9jP4bNOc1oHQUAM93mydnAEx8XWeFvMiWPptA/COP5rRI2JdNY/oCPXI0OBiLJACt
         x42445Cffxs5dTHoDRxqpGzR6ZkHlR+wOn9UXNS2w7RuoACU+TK0Yhfii3xn7wClG+dq
         yHFQ==
X-Gm-Message-State: AOAM531KtSDAf7MEsV+tCx3mNtTZZlawwjgsgD82VVpwHiYLUsgTdYbZ
        gvj2T9sgUuVpHsCHK3Pimxuw3F9P8jrHePmVSoU=
X-Google-Smtp-Source: ABdhPJy4+Szrh9D/btjTmLWSzlb/bQKB5N8WWWfqHE0tGzIyNae90XPyOUSuI67ZnY4uxWK194s2A0H3qjMplHb5olA=
X-Received: by 2002:a17:906:c205:: with SMTP id d5mr33692530ejz.74.1633538875688;
 Wed, 06 Oct 2021 09:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com>
In-Reply-To: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 6 Oct 2021 09:47:41 -0700
Message-ID: <CABPp-BHUmLdoxhCndBB2_eA59=4=sNDGx2oFvpU6gFHW4sf2HA@mail.gmail.com>
Subject: Re: [PATCH 0/7] leak tests: fix "test-tool" & other small leaks
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 6, 2021 at 3:02 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Like my just-submitted series to mark existing tests as passing[1]
> under the test mode added in ab/sanitize-leak-ci, this marks more
> tests as passing, but here we need to fix some small memory
> leaks. This goes on top of ab/sanitize-leak-ci.
>
> Like [1] I merged each of these with "seen" and tested them with
> GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue, so they should hopefully not be a
> hassle while cooking. This doesn't inter-depend on any other topic I
> have except ab/sanitize-leak-ci.

Modulo a tiny comment on one of the commit messages, this series looks
good to me.

>
> But with the outstanding topics I've got in this area (+ [2] + [3] +
> [4]) and Elijah's en/removing-untracked-fixes these topics in
> combination will get us to a spot where we can start fixing the big block=
ing memory leaks in the test suite.
>
> I.e. most tests fail because "git log" and "git checkout" leak when
> doing almost anything. I've got patches on top of this which fix both
> of those for 80-90% of cases. After that most failing tests will have
> failures because of things specific to those tests, not just because
> their setup code dies as they use "git checkout" or "git log" to set
> something up.
>
> 1. https://lore.kernel.org/git/cover-00.10-00000000000-20211006T094705Z-a=
varab@gmail.com/
> 2. https://lore.kernel.org/git/cover-0.2-00000000000-20211006T093405Z-ava=
rab@gmail.com
> 3. https://lore.kernel.org/git/cover-v4-0.5-00000000000-20211002T201434Z-=
avarab@gmail.com/
> 4. https://lore.kernel.org/git/cover-v2-0.5-00000000000-20210927T124407Z-=
avarab@gmail.com/#t
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (7):
>   tests: fix a memory leak in test-prio-queue.c
>   tests: fix a memory leak in test-parse-options.c
>   tests: fix a memory leak in test-oidtree.c
>   tests: fix test-oid-array leak, test in SANITIZE=3Dleak
>   ls-files: fix a trivial dir_clear() leak
>   ls-files: add missing string_list_clear()
>   merge: add missing strbuf_release()
>
>  builtin/ls-files.c                 | 14 ++++++--------
>  builtin/merge.c                    |  2 ++
>  t/helper/test-oid-array.c          |  4 ++++
>  t/helper/test-oidtree.c            |  3 +++
>  t/helper/test-parse-options.c      |  7 ++++++-
>  t/helper/test-prio-queue.c         |  2 ++
>  t/t0009-prio-queue.sh              |  2 ++
>  t/t0040-parse-options.sh           |  1 +
>  t/t0064-oid-array.sh               |  2 ++
>  t/t0069-oidtree.sh                 |  1 +
>  t/t3001-ls-files-others-exclude.sh |  5 +++--
>  t/t3005-ls-files-relative.sh       |  1 +
>  t/t3020-ls-files-error-unmatch.sh  |  2 ++
>  t/t3700-add.sh                     |  1 +
>  t/t7104-reset-hard.sh              |  1 +
>  t/t7604-merge-custom-message.sh    |  1 +
>  16 files changed, 38 insertions(+), 11 deletions(-)
>
> --
> 2.33.0.1441.gbbcdb4c3c66
>
