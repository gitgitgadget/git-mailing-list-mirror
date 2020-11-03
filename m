Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2598C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A545C2072D
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCjKqvMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgKCQhA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 11:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbgKCQg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 11:36:59 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE802C0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 08:36:58 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id c21so3970364oic.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 08:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A1YES6mjB9qB79UevtRzRl+E6hHCrP7lFWCA5Sgma5E=;
        b=cCjKqvMi4C6uc8XZsezNNpFcp98ow9C8R8jMhwpvuoLF436+ZeIw0gfFv0wnygm+Bh
         nmy27MXzeO9p2V+k+T4QAyOosVwpZ88XU2vzB04nGNnOK/lr26RM6rAd6Rz8T1Y3Ptvh
         zGye9rp88BIQ9IT6iy6oXzoMRSdfaRP/EOLFbp8W6E2CcOjekbicHJ49JZIxF94j6On3
         9XI43/LeMGP4NISVT1y7Hjl+dsI6Uc9hP6r0FDBylPoDLV1hVVx2kLQ5C/mi0ffeEnc+
         qMa81wqSKJdK+nYZUXwSVQtMiLddADDBOc3q0kFuf7GycGkku2+RVUe/dlxIDr5Yhp/z
         tugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A1YES6mjB9qB79UevtRzRl+E6hHCrP7lFWCA5Sgma5E=;
        b=XXKwZqC9JHlCnkab0JMrHzPrsOKaJl9NWYreC0DlF98ghDsvpzrkZ0g3zEoi6UivCj
         VMccmrmCGmGs2Epom/qwPEa0BgSKahO98JJZGLII4TD7ofP7DY7jiInNtnti/736wtWq
         YKXr8p9+YgH/XZYdaXL1akK4Vk6cjlfBsGnuGfpptVjU9qKnnMnb62c8e+bfEX7Xc2fK
         alNPXC8iFRfs3cMaK2yH0IXgl6tvwhFHvPm1MzKlPeb/fzSGaoLNhpFEfKhBc89zYzYJ
         rT833mhxVoRkWZ7kmvxHt/0yo+5Bx9SbpAbYqPKw5fTFzqTXFXhKDlUWwULNlOOP3VLO
         D0Ow==
X-Gm-Message-State: AOAM530wryRL+KATWG7UK9O00T0ZkHgKNYLaCDJeTfn5RyV1YtP0bxCt
        qXFOBS/bxY5XflO7oaDgoT2U0RF27AHkTvcXJM4=
X-Google-Smtp-Source: ABdhPJz/u1iDWEX4WqxTh4h2XccnP0S5mcXT47RyQXXGkhgWgCB4gQhOSigfY6SKGdTJk3s6kzlCri2lS/ktECBpUS8=
X-Received: by 2002:aca:3b0a:: with SMTP id i10mr334744oia.167.1604421418168;
 Tue, 03 Nov 2020 08:36:58 -0800 (PST)
MIME-Version: 1.0
References: <20201102204344.342633-1-newren@gmail.com> <0197d698-e966-f0bb-4d77-0183e93d9bef@gmail.com>
In-Reply-To: <0197d698-e966-f0bb-4d77-0183e93d9bef@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Nov 2020 08:36:47 -0800
Message-ID: <CABPp-BESfpqjrskz-UQikEfk_rV_QpQybo_hStVw=K8jXHYmfA@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] fundamentals of merge-ort implementation
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 3, 2020 at 6:50 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/2/2020 3:43 PM, Elijah Newren wrote:
> > This series depends on a merge of en/strmap (after updating to v3) and
> > en/merge-ort-api-null-impl.
> >
> > As promised, here's the update of the series due to the strmap
> > updates...and two other tiny updates.
>
> Hi Elijah,
>
> I'm sorry that I've been unavailable to read and review your series
> on this topic. I'm very excited about the opportunities here, and I
> wanted to take your topic and merge it with our microsoft/git fork
> so I could test the performance in a Scalar-enabled monorepo. My
> branch is available in my fork [1]
>
> [1] https://github.com/derrickstolee/git/tree/merge-ort-vfs
>
> However, I'm unable to discover how to trigger your ort strategy,
> even for a simple rebase. Perhaps you could supply a recommended
> command for testing?
>
> Thanks,
> -Stolee

If you want to test performance, you shouldn't test this particular
submission, you should test the end result which exists as the 'ort'
branch of my repo.  It actually passes all the tests rather than just
trivial cherry-picks and rebases, and has lots (and lots) of
performance work that hasn't even begun at the point of the
'ort-basics' branch.  (However, it also contains some unrelated memory
cleanup in revision.c, chdir-notify.c, and a number of other places
because I was annoyed that a rebase wouldn't run valgrind-free and
made it harder to spot my memory leaks.  And the day I went hunting
those memory "leaks", I went and grabbed some unrelated memory leaks
too.  If it causes you merge conflicts, let me know and I'll try to
create a branch for you that hash the minimal changes outside of
merge-ort*.[ch] and diffcore*.[ch])

All that said, for testing either branch you just need to first set
pull.twohead=ort in your git config (see
https://lore.kernel.org/git/61217a83bd7ff0ce9016eb4df9ded4fdf29a506c.1604360734.git.gitgitgadget@gmail.com/),
or, if running regression tests, set GIT_TEST_MERGE_ALGORITHM=ort.
