Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA25C77B7A
	for <git@archiver.kernel.org>; Tue, 16 May 2023 04:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjEPEnF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 00:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjEPEnC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 00:43:02 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ADE2697
        for <git@vger.kernel.org>; Mon, 15 May 2023 21:43:01 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2ac8091351eso142830451fa.2
        for <git@vger.kernel.org>; Mon, 15 May 2023 21:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684212180; x=1686804180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiZaOdAQM6YIrtiIdyEz9Q/OsnTDLz0ZVYLIWlwdq8w=;
        b=EwgLf+csNLyeKExL73NMTc3MA7rSfqROpqqMQxwXKXf6XQvnX8ZptZ+ajabQQD4nWw
         +dLEqLNZaMIISePLImhQ0kbudeVn6Ixw8TAntGm66KWqiEz0fdMq2MGNaRdCXHmye8Za
         t9XCeDPXmrXtmYiEncYt9OQLcz4xmlfy8eFriP4QQNbgD/6021bZaSwGX6l8GmK7Edi/
         7xL/nVxfClLkkTBF0niH9cvo44FDjsEkdooHjUrTO0/PLSyUgP9a5U9/wE2j19dA1SAz
         Tl7rA5ZI83dCGsQ/Q2Bb0ynj88gtBRcEGhxI3xrovQBF3yZ25NK3Tyvt4bWe60x6F/h3
         tnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684212180; x=1686804180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiZaOdAQM6YIrtiIdyEz9Q/OsnTDLz0ZVYLIWlwdq8w=;
        b=EQ7BFxddfGBYDMhXPBBVBErSZa7vWJ82oNP5cuSVIQWzGbnXlbJG+TMb/4oIb1pzHI
         COgd5Qoj3BNJEc0Tbs2anUaoRGXaRunE0f+uE5MUus/OE096MxH+RoW3r6T7sR2dbf7Z
         pUHAqWlbZFC3OBv04jn/uP5Vx91bvjps/q0eQ/hJEeUs16yZ28Hf1auaydsoMYd7+hhd
         aP0x0Lvh2JVBZPErqHJ2DP5SaYUXN8QLaZ93JZ/pxG0JggNeqmmN1q7Ldb7w5JTULoTT
         XTAH6srN3De4//gMz4K9JyCNeANd+NdFizP9uxsheQzEn/RyEH0/T/m6TtP/LyCAcC1s
         gj4g==
X-Gm-Message-State: AC+VfDwYwJllpWh3Q0rbsXM381IrxENuThUUcrjMA957dX5UtD/pJzN6
        NPNF1tQSBSg27Q466/Y1qD4GaSygKRZze5dFoVI=
X-Google-Smtp-Source: ACHHUZ5MbkE5/sxTpbR4kVqWCEFnsH6h/S7ghWFrRBu/p7xmW26z2R6aMa0uY6XN+rSBCPjsytFVmP4XKJb5y4aZEdQ=
X-Received: by 2002:ac2:4344:0:b0:4ed:c5a4:28dc with SMTP id
 o4-20020ac24344000000b004edc5a428dcmr6027450lfl.38.1684212179608; Mon, 15 May
 2023 21:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230407072415.1360068-1-christian.couder@gmail.com> <20230509175347.1714141-1-christian.couder@gmail.com>
In-Reply-To: <20230509175347.1714141-1-christian.couder@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 May 2023 21:42:47 -0700
Message-ID: <CABPp-BFz688Hz3FMjO9TwxicnS6S76f2zbsBMMK5JtYju5iBbA@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] Introduce new `git replay` command
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 9, 2023 at 10:54=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
[...]
> Now the changes between v1 and v2 are:
>
> * The patch series has been rebased on top of current master, so that
>   conflicts with master are resolved. This required replacing calls to
>   functions like get_oid() with repo_get_oid(), as well as changing
>   some `#include "*.h"` to use different header files. This
>   unfortunately makes the range-diff between v1 and v2 a bit more
>   difficult to read than we would like.
>
> * Patch 1/15 is a new patch. It has been introduced to rework t6429,
>   so that this test script doesn't break when conflict output is
>   removed later in the series. This allowed us to remove the old 9/14
>   patch ("replay: very coarse worktree updating").
>
> * The old 9/14 patch ("replay: very coarse worktree updating") was
>   removed. This is to make sure that the new command can be used on
>   bare repos. This enables us to focus first on making sure the new
>   command a good plumbing command that works well on bare repos.
>
> * The old 12/14 patch ("replay: introduce guess_new_base()") was
>   removed. This is also to focus first on making sure the new command
>   is a good plumbing command.
>
> * The old 13/14 patch ("replay: add different modes") has been split
>   into 2 patches: patch 13/15 ("replay: add --advance or 'cherry-pick'
>   mode") and patch 14/15 ("replay: add --contained to rebase contained
>   branches").
>
> * Patch 12/15 ("replay: disallow revision specific options and
>   pathspecs") is a new patch that disallow using revision specific
>   options that would be allowed and eaten by setup_revisions(). Even
>   if it would be very nice to have some of these options in the
>   future, not all these options make sense for the new command, and it
>   might require improving the setup_revisions() mechanism (as well as
>   adding tests and doc) to cleanly allow those we want, but that is
>   outside the scope of this first patch series.
>
>   While at it, this patch also disallow pathspecs too.
>
>   It would be nice to have them in the future,

Other than these 10 words and the code comment they represent, all the
changes made in v2 look good to me...

>   but for now it is not necessary and
>   would require work (at least for tests and doc) that can be done
>   later.
>
> * Patches 11/15 to 15/15 include a number of new tests to check that
>   the command works well on bare repos, and in case of 11/15 to check
>   that exit code in case of conflict is 1.
>
> * Patch 11/15, in which the doc for the `git replay` command is
>   introduced, now says that the new command is experimental.

..especially this one.  Thanks for including this!

> * Note that a segfault that was found by Derrick Stolee in the v1 is
>   fixed by 000c4ceca7 (merge-ort: fix calling merge_finalize() with no
>   intermediate merge, 2023-04-22) merged to master by 3927312601
>   (Merge branch 'en/ort-finalize-after-0-merges-fix', 2023-05-02).
