Return-Path: <SRS0=sBbF=2V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4BCC2D0C2
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 16:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E09206DB
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 16:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWaUH4nt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfLaQp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Dec 2019 11:45:58 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46340 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLaQp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Dec 2019 11:45:58 -0500
Received: by mail-lj1-f196.google.com with SMTP id m26so34334996ljc.13
        for <git@vger.kernel.org>; Tue, 31 Dec 2019 08:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=G3qhQsk5HG7t6nACmKOJpjapHxpRlEplknpZ6HaOtJs=;
        b=HWaUH4ntPu6GD24M0DeYmVToE0TqtcbFIBrL692X0HZDh3xwhaFZJ8JVCaT1HF+oXD
         o2Z6ZL2ev1yasB4iCTa4UArXS8fVUGaUv3Z6Eh8RR8WswmT9w4PIu6oJeMB64PP10u/X
         onUjXTvu30F1HmuvObpr4Z/LkJVuoNuCSCIJa19iZG8Vlxkyc1UV1c/yCqFucjO+CiHL
         i9XDUlzEkHkjz47m2pJLC6X4fO7URFhGzzeKUWTx/lly7XuwJLOuMgDy+o9dKjGZuDpH
         oBbRQm/vOuqHGnIXBxAARwevVxLINJdyItDSd0E1oDHvOLCqqtSNlbT1nd1Lm3MRuhwq
         TvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=G3qhQsk5HG7t6nACmKOJpjapHxpRlEplknpZ6HaOtJs=;
        b=BwGBkX23BwC3npJbWSIy98vmTuZlWN27ZthWFWt1L/IOFhdVvT0//lecfscXWQxL8G
         nOAaQJBQIf8Dy8a8JEyFnzQ/i6S0fLw7xjBAB1zWrizzujlB7u5Vpna3bpzVVqgaynpp
         Ya8M4d5diA++URxXxjFjz4jicDexV1fUIajC6duTTEoYsRrGa97ROkRFiDRAahLSBWU6
         +lCe0aEuIYMGaJoalot8nQeJjLLabJcmSzjj9BmAmtlhb3pWyZiBZcNd0NKzTkJD+gKf
         XSgKu19JuOBCrNUcxC4ZWMXrzz+n+KpiErw3n3P1yd7j7dDoNLbvDBoh+JwMij2p0qdf
         JSng==
X-Gm-Message-State: APjAAAX3Czl0n1q4nte51CXSunr5wzDr7Ao775nWly5iWIf4GILg8z+e
        RrWN1kWAG0IdO40+UkR1Ep8=
X-Google-Smtp-Source: APXvYqzpmMUTplsDnXO6cSI9Ic9q+oBDYRtt+Hn5rwv72XcOKt2RamjR+n75HnxwEvjHGRgYcFaXFg==
X-Received: by 2002:a2e:81c7:: with SMTP id s7mr43238504ljg.3.1577810755224;
        Tue, 31 Dec 2019 08:45:55 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id o10sm2771328lfn.20.2019.12.31.08.45.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Dec 2019 08:45:54 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        peff@peff.net, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] [RFC] Changed Paths Bloom Filters
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
Date:   Tue, 31 Dec 2019 17:45:51 +0100
Message-ID: <86d0c44f5s.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Hey!=20
>
> The commit graph feature brought in a lot of performance improvements acr=
oss
> multiple commands. However, file based history continues to be a performa=
nce
> pain point, especially in large repositories.=20
>
> Adopting changed path bloom filters has been discussed on the list before,
> and a prototype version was worked on by SZEDER G=C3=A1bor, Jonathan Tan =
and Dr.
> Derrick Stolee [1]. This series is based on Dr. Stolee's approach [2] and
> presents an updated and more polished RFC version of the feature.=20

It is nice to have this picked up for upstream, finally.  The proof of
concept works[1][2] were started more than a year ago.

On the other hand slow and steady adoption of commit-graph serialization
and then extending it (generation numbers, topological sort, incremental
update) feels like a good approach.

> Performance Gains: We tested the performance of 'git log -- <path>' on th=
e git
> repo, the linux repo and some internal large repos, with a variety of pat=
hs
> of varying depths.
>
> On the git and linux repos: We observed a 2x to 5x speed up.
>
> On a large internal repo with files seated 6-10 levels deep in the tree: =
We
> observed 10x to 20x speed ups, with some paths going up to 28 times faste=
r.

Could you provide some more statistics about this internal repository,
such as number of files, number of commits, perhaps also number of all
objects?  Thanks in advance.

I wonder why such large difference in performance 2-5x vs 10-20x.  Is it
about the depth of the file hierarchy?  How would the numbers look for
files seated closer to the root in the same large repository, like 3-5
levels deep in the tree?

> Future Work (not included in the scope of this series):
>
>  1. Supporting multiple path based revision walk

I wonder if it would ever be possible to support globbing, e.g. '*.c'

>  2. Adopting it in git blame logic.

What about 'git log --follow <path>'?

>  3. Interactions with line log git log -L
>
> This series is intended to start the conversation and many of the commit
> messages include specific call outs for suggestions and thoughts.=20
>
> Cheers! Garima Singh
>
> [1] https://lore.kernel.org/git/20181009193445.21908-1-szeder.dev@gmail.c=
om/
> [2] https://lore.kernel.org/git/61559c5b-546e-d61b-d2e1-68de692f5972@gmai=
l.com/
>
> Garima Singh (9):
>   commit-graph: add --changed-paths option to write

This summary is not easy to understand on first glance.  Maybe:

    commit-graph: add --changed-paths option to the write subcommand

or

    commit-graph: add --changed-paths option to 'git commit-graph write'

would be better?

>   commit-graph: write changed paths bloom filters
>   commit-graph: use MAX_NUM_CHUNKS
>   commit-graph: document bloom filter format
>   commit-graph: write changed path bloom filters to commit-graph file.
>   commit-graph: test commit-graph write --changed-paths
>   commit-graph: reuse existing bloom filters during write.
>   revision.c: use bloom filters to speed up path based revision walks
>   commit-graph: add GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS test flag
>
>  Documentation/git-commit-graph.txt            |   5 +
>  .../technical/commit-graph-format.txt         |  17 ++
>  Makefile                                      |   1 +
>  bloom.c                                       | 257 +++++++++++++++++
>  bloom.h                                       |  51 ++++
>  builtin/commit-graph.c                        |   9 +-
>  ci/run-build-and-tests.sh                     |   1 +
>  commit-graph.c                                | 116 +++++++-
>  commit-graph.h                                |   9 +-
>  revision.c                                    |  67 ++++-
>  revision.h                                    |   5 +
>  t/README                                      |   3 +
>  t/helper/test-read-graph.c                    |   4 +
>  t/t4216-log-bloom.sh                          |  77 ++++++
>  t/t5318-commit-graph.sh                       |   2 +
>  t/t5324-split-commit-graph.sh                 |   1 +
>  t/t5325-commit-graph-bloom.sh                 | 258 ++++++++++++++++++
>  17 files changed, 875 insertions(+), 8 deletions(-)
>  create mode 100644 bloom.c
>  create mode 100644 bloom.h
>  create mode 100755 t/t4216-log-bloom.sh
>  create mode 100755 t/t5325-commit-graph-bloom.sh
>
>
> base-commit: b02fd2accad4d48078671adf38fe5b5976d77304
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-497%2Fg=
arimasi514%2FcoreGit-bloomFilters-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-497/garima=
si514/coreGit-bloomFilters-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/497
