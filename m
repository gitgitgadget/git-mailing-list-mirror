Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DC3C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 13:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC73661416
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 13:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhGANd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 09:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhGANdz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 09:33:55 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA31C061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 06:31:23 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w13so8536136edc.0
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 06:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=1cU71769iOXQfpDgavfEdkAqNtzGmY2OSklUCIOgGvM=;
        b=qWUzrKeyxRYjR2JQxQLK8MPXQjnaEtwHzkTps1aMQZ8tS4JPTLqjwej+rVaJEfmQGc
         xVn2lQ4ldEPOl5Lvs9V+jeAd26iQMcxxqlAgtC/BXAnKRDHnmuaMVlWUjUcbWfGMqdC4
         vg+rt19YnxPSbPiPtswyXbdFaKDdhnMzmVxGzGlG2yqNM8w5y3bVp8xtAe4cRHX2mtF6
         Y7qHLYZTvchDxCTYM4C92BnrzzqQ0EGa3oVxdqXofaouiekYATYtkejl1vanxM7KVGdA
         RJFI9uowonSavOsS05BvRa6qBdPFi2TQ8gE1BLGo06Jjr57FUOS52V/DVNIxsMkVBcqz
         Yzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=1cU71769iOXQfpDgavfEdkAqNtzGmY2OSklUCIOgGvM=;
        b=iak/beLNz4n6dT0ZeYFRpmIitkaa4kgv96sNekH2exhbcIuhxbZ/F1QP/GSevG49fk
         LqhvjYqX8quq3BI/HscXe/xxUNxpztGuK5nPt+E1u51xK8XwCxl0BPzkrn+mH0XfvOW8
         qw5BFI/xHQrJuWBZouldK3Q1DN2a+HBcO0w9uVA2SQ8xzDeDylFPrqRU/k3t9Jvcky0d
         wLqMDhADeWzUafhJOht4zXm5LEdj1htfTjkzB+wOy8/QvIvNAOOh0EXfQtZnF8Nb8JqU
         Q97pZthLOAE2ZqAFZ3O2VJKDgdXs1bKIqO+mmMXOl1UJ2GxRwcd4yQTG4n2fT1BxLpPr
         /DfA==
X-Gm-Message-State: AOAM531CsBki0oWcDjtGPIlW/75Narr02VK+nLWJfasiDVjJglcgaXGz
        CtFidF64POd4iyPtSKJeFuGU8vUz4qFw3g==
X-Google-Smtp-Source: ABdhPJxlLV2QC1DcrzpjJxxefzeCUcH9ayLR/1s7x4iC1L7LShYwW6cw5MOIoOevm56DgHkv6aa0eQ==
X-Received: by 2002:a05:6402:1d55:: with SMTP id dz21mr52690290edb.338.1625146281961;
        Thu, 01 Jul 2021 06:31:21 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id jl10sm10875277ejc.56.2021.07.01.06.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 06:31:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/7] Optimization batch 14: trivial directory resolution
Date:   Thu, 01 Jul 2021 15:21:14 +0200
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <pull.988.git.1625111177.gitgitgadget@gmail.com>
Message-ID: <87wnqacg9i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, Elijah Newren via GitGitGadget wrote:

> This series depends textually on ort-perf-batch-12, but is semantically
> independent. (It is both semantically and textually independent of
> ort-perf-batch-13.)

For others following along, that ort-perf-batch-12 is at
https://lore.kernel.org/git/pull.962.v4.git.1623168703.gitgitgadget@gmail.c=
om/#t
& currently marked as 'will merge to next' in what's cooking.

> Most of my previous series dramatically accelerated cases with lots of
> renames, while providing comparatively minor benefits for cases with few =
or
> no renames. This series is the opposite; it provides huge benefits when
> there are few or no renames, and comparatively smaller (though still quite
> decent) benefits for cases with many uncached renames.

Sounds good, one thing I haven't seen at a glance is how these
performance numbers compare to the merge-recursive backend. Are we in a
state of reaching parity with it, or pulling ahead?

> [...]
> For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
> performance work; instrument with trace2_region_* calls", 2020-10-28), the
> changes in just this series improves the performance as follows:
>
>                      Before Series           After Series
> no-renames:        5.235 s =C2=B1  0.042 s   204.2  ms =C2=B1  3.0  ms
> mega-renames:      9.419 s =C2=B1  0.107 s     1.076 s =C2=B1  0.015 s
> just-one-mega:   480.1  ms =C2=B1  3.9  ms   364.1  ms =C2=B1  7.0  ms
>
>
> As a reminder, before any merge-ort/diffcore-rename performance work, the
> performance results we started with were:
>
> no-renames-am:      6.940 s =C2=B1  0.485 s
> no-renames:        18.912 s =C2=B1  0.174 s
> mega-renames:    5964.031 s =C2=B1 10.459 s
> just-one-mega:    149.583 s =C2=B1  0.751 s

I haven't given any of this a detailed look, just a note/question that
(depending on the answer to the "v.s. merge-recursive above") we may
want to consider bumping the default for the diff.renamelimit at some
point along with any major optimizations.

<random musings follow, the tl;dr is above this line :)>

As an aside that we have diff.renamelimit is one of the most "dangerous"
landmines/fork-in-eye/shotgun-to-foot edge cases we have in using diff
as plumbing IMO.

E.g. I somewhat recently had to deal with some 3rd party Go-language
lint plugin that can be configured to enforce lints "as of a commit".
I.e. it does a diff from that commit, sees in any introduced "issues"
are "new", and complains accordingly. The idea is that it allows you to
enforce lints on "only new code", say ignoring the return value of
os.Write(), without insisting that all existing code must be
whitelisted/fixed first.

The problem being two-fold, one that the thing will get slower over time
as we grow history (can't be avoided), but the more subtle one that at
some point we'll bump into the diff.renamelimit, and whatever unlucky
sob does so will find that the lint is now complaining about ALL THE
THINGS, since "old" code is now ending up as "new" to a na=C3=AFve diff
parser relying on not bumping into the diff.renamelimit.

Arguably bumping the diff.renamelimit would make that sort of problem
worse for plumbing consumers, since they'd have more rope with which to
hang themselves, maybe it's better to step on that landmine early.

Sorry about the digression somewhat pointless but perhaps amusing
digression in the last 4 paragraphs :)

P.S.: I ended up dealing with the Go plugin by not using the "diff"
      feature, but just a one-off giant whitelist of all existing
      instances of stuff it would complain about.
