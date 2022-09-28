Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81529C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 17:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbiI1Rna (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 13:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbiI1Rn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 13:43:28 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70510E5FAC
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 10:43:27 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id n18-20020a056a000d5200b0053e16046751so7739363pfv.7
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 10:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=VFFgD1tzJbb5s0AJcN9YeV1ec8EFSupiakoo3Kjycyo=;
        b=tYLUf+pExcJBjF0oBlqSsabjSuzX0skPY6coPNnhYeFkyhBN1ZdlZU/K26cfq3viUs
         WioMsm0wXb2Irbg4TQyaFwSfl49GYI9ucyuOVgNt9vfb2+fK5ltTC80X+tRqL/Gu+lKE
         KxD4UACF7RkRd7CQC1uL4NFx6Wt/BONYS6YQswxjbYAq/ykfL5sg3Rpy/2HOaqPCxHdp
         u7RC4hxQR0P6DtvHTe+6nBKeGC2vjQBi8+eGHpLdWzI0JPGieBoFdDu+dU4K+pxYv5vc
         fb5R02xlr5Wf1haidslDKeo+pw4Q3BZvv/DwJypv/DV7x9Pc1rX/x+PtBy3oknrVpiss
         fQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=VFFgD1tzJbb5s0AJcN9YeV1ec8EFSupiakoo3Kjycyo=;
        b=UkFMaDDGmA+/BZDGpdyO5jNPWPll2G6QreTjCRWXEFdXD+wgbVdEoklCkggtNm9NAA
         LG+Uv2hW4/au+QXTm9uC4W/zQepxvhJorDAyv4ewHhrXIrvNo7NnqjW2pR98Vgubr3ST
         dDK2nP1Njk/IxkHgRP8aI01DJB+YGWYGeXNzUZchrTf5EZWBQ4uPotNkvVyGkxbwjL3+
         4EtgRbpb9L0CoUyBnqWrRbmoueTiniaUyMxdZlS9FHyxNYpQm/mz8F+vLHI71n4wq5uB
         gxnSZjGu2zaA1jX/KBJ7L7l2lib7QOlgtq15KkTiRHvpKB+0gSUROA12ot/62tdv8OKG
         CBDw==
X-Gm-Message-State: ACrzQf2GmmqCbZX85igA6n02X5rQJiLgMk3UmJyPwZTv9l/1PYymbYV/
        z7hYYfEyxNaJ4s0Eb9GULZa1UMLgM+tfvA==
X-Google-Smtp-Source: AMsMyM6mkrZLgHTMWnvRqAMvqR1S+Sgu++JIL+a3MB1VVfCTGGdQMy9adPquQ7L/hjlouT3MftSOlNqqId4pRQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:1ce:b0:178:80f1:c4c7 with SMTP id
 e14-20020a17090301ce00b0017880f1c4c7mr909001plh.27.1664387006877; Wed, 28 Sep
 2022 10:43:26 -0700 (PDT)
Date:   Wed, 28 Sep 2022 10:43:18 -0700
In-Reply-To: <7f6412eb8ce0c47a7645b89fab171a212353f8b2.1664316642.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1664316642.git.jonathantanmy@google.com> <7f6412eb8ce0c47a7645b89fab171a212353f8b2.1664316642.git.jonathantanmy@google.com>
Message-ID: <kl6l8rm3mm2x.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 2/2] promisor-remote: die upon failing fetch
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No real comments on the code - I'm not familiar enough with it, but it
seems really simple anyway.

Jonathan Tan <jonathantanmy@google.com> writes:

> When this batch prefetch fails, these commands fall back to the
> sequential fetches. But at $DAYJOB we have noticed that this results in
> a bad user experience: a command would take unexpectedly long to finish
> if the batch prefetch would fail for some intermittent reason, but all
> subsequent fetches would work. It would be a better user experience for
> such a command would just fail.

I'm not certain that this fail-fast approach is always a better user
experience:

- I could imagine that for a small-enough set of objects (say, a very
  restrictive set of sparse specifications), one-by-one fetching would be
  good enough.
- Even if one-by-one fetching isn't fast, I'd imagine that each
  individual fetch is more likely to succeed than a batch prefetch, and
  as a user, I would prefer to ^C an operation that takes longer than I
  expected than to have retry the repeatedly.

Here are some other arguments that you didn't mention, but I find more
convincing:

- Running prefetch in a non-interactive process (e.g. running a job in
  CI) and the user would prefer to fail fast than to have the job run
  longer than expected, e.g. they could script retries manually
  (although, maybe we should do that ourselves).

- Fetching might be subject to a quota, which will be exhausted by
  one-by-one fetching.

As such, it _might_ make sense to make this behavior configurable, since
we may sometimes want it and sometimes not.
