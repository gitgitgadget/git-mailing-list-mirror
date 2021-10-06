Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9967C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 16:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A26DD6112D
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 16:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhJFQf4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhJFQfz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 12:35:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3603DC061753
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 09:34:03 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id f9so12355337edx.4
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 09:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/XLOREUbitOSTFEk2hez9UCeLuJRyHkF+axFM0Gt8+0=;
        b=b2RcayokJ8eamUR5262GML5wMfuzhmUN23MQDKcU6ejv5/VlnC9ziKGKcRq6Nd+y1X
         fYQ3LgVoSub5pwA5+BFyvH0JSw+iouVm6zZ3Maf8EYrmNg4EuDVNOsrG43nYcUw0tzzq
         3TJEoN8hvCtWy6TBMmb5PUHJXn33n2Y57hPFek9dF0vV1QTOlaxgpzNfCt+gmwkZrgT+
         mGAvLcHKyeUATSSo1L/OpyefxiBZv9S1NkZCoEDQvyiOMGnlK1+lSU0uqnPFNJSz5yFw
         X71AFN1Nneng+cAFNmz8fpup8BLQRzbCqsj4cgr+d91qkTkwDjyukKlwylCHKF+ZeMxh
         6QSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/XLOREUbitOSTFEk2hez9UCeLuJRyHkF+axFM0Gt8+0=;
        b=ZlQSyI2EXREX9dtBvQ9bJYvp/Dr7aJfrfO1kUHIhbZieikS44c2nTfFAf5AatGhcpc
         CkMTs5vwE6QrcegSfLzNc1dGaCDgec9kgmgDc9dL8NRN1GFRzcGEYpypHG3t3jx1d1DX
         dE6BsgQnG804VOmSo8C1aAeyfjcSOSfMWSu28jZ+fkdzz78yOMZqE57O0E8DxMoYItom
         5X81We2kZvV6yR/FgXO+99OfOiQCKmoidhDJOq9Pv+qemT5/+fc1fgiAoMODk9VVtjeO
         zbo6xasZFcd2bVkiTnL/8OGVGJpIaKn3zJ+lmA7CslvD+m1kCCQheqpr4r92w5vUZwl0
         Oc7Q==
X-Gm-Message-State: AOAM532hH2Ab460zdkHlPfnNWORPGW/bepbkf+5lJzvjyanSR2rH5ulR
        U3bJ9nqa/Ofc6DaT3oRyqYPx9ZGHjxuKEDY0aQaP2C1EBSu32w==
X-Google-Smtp-Source: ABdhPJzKzVqhBpXi08qM50q7VUBTx+qbLHdVdnMjUXylDuRPHVqV04gIKqi4Zsx8DvdBbgM1jnPCmlnO2NOh+yTmZs0=
X-Received: by 2002:a05:6402:1848:: with SMTP id v8mr32996336edy.0.1633538041238;
 Wed, 06 Oct 2021 09:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.2-00000000000-20211006T093405Z-avarab@gmail.com>
In-Reply-To: <cover-0.2-00000000000-20211006T093405Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 6 Oct 2021 09:33:50 -0700
Message-ID: <CABPp-BGsJOtffyLqk85Z65chJkPr+PsZieK=eX57ccKawdVAVQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] dir & unpak-trees: memory-leak fixes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 6, 2021 at 2:40 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> These couple of patches fix some remaining memory leaks in
> unpack-trees.c, which mostly happen via a lack of calls to dir_clear()
> fixed in 2/2.

There is no added dir_clear() in 2/2 (the equivalent patch in the
previous series you took that patch from did have one, so I think this
was just an incomplete edit-or-commenting-after-rebasing case).  More
comments on that patch.  The idea for 2/2 is probably good, but should
probably be accompanied with another tweak, and the commit message and
cover letter about it need some updating.

Patch 1/2 is a clear memory leak fix.

> This goes on top of ab/sanitize-leak-ci (but not
> en/removing-untracked-fixes). In 1/2 I mark a test as passing under
> SANITIZE=3Dleak, which assumes that an environment variable added by
> ab/sanitize-leak-ci is understood. Without ab/sanitize-leak-ci it'll
> be silently ignored.
>
> Elijah has parallel work in fixing leaks in dir.c, but without his
> ab/sanitize-leak-ci that test will also pass, it's not one of the ones
> that needed something like his leak fixes to {dir,unpack-trees}.c to
> pass.
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
>   unpack-trees: don't leak memory in verify_clean_subdirectory()
>   built-ins & lib: plug memory leaks with unpack_trees_options_release()
>
>  archive.c                   | 11 ++++++++---
>  builtin/am.c                | 17 ++++++++++++-----
>  builtin/checkout.c          |  9 +++++++--
>  builtin/clone.c             |  1 +
>  builtin/commit.c            |  6 +++++-
>  builtin/merge.c             |  6 ++++--
>  builtin/read-tree.c         | 14 ++++++++++----
>  builtin/reset.c             | 13 +++++++++----
>  builtin/stash.c             | 14 ++++++++++----
>  diff-lib.c                  |  5 ++++-
>  sequencer.c                 |  2 ++
>  t/t1001-read-tree-m-2way.sh |  2 ++
>  unpack-trees.c              |  3 ++-
>  13 files changed, 76 insertions(+), 27 deletions(-)
>
> --
> 2.33.0.1441.gbbcdb4c3c66
