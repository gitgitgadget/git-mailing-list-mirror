Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EFAC35249
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 23:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC3420661
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 23:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkYGaw4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgBAXcj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Feb 2020 18:32:39 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38909 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgBAXcj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Feb 2020 18:32:39 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so10916250ljh.5
        for <git@vger.kernel.org>; Sat, 01 Feb 2020 15:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=n0ImSmMTtdc5xJq+I/breyB9bXUzHQEFJ5lwjbHaGHo=;
        b=ZkYGaw4P+E0ZgN6aVUt5wMSTGDElK1EkWeEbrApwtJjHxGAS/h8JfZKCTLl1QwOTUP
         adjk3Fjc3ep6EjBEKTrx0ec2uZet5u1wq+aMcfmsJuUPZvorYzHIFJkQeGLnVihJqDQT
         Nf/iNFlykzRWclbFoMkVZYpqRuPvvUf3cUdRrwQmzVrC2qL4w63vAfcNLmwpnBBmBVSi
         z2396xaQlyozJRDMET+5n7fZMgn/6BURENkGRMtKaDgM9GipwxlOxy8qJQUNXgPkbuZ8
         ptih1MZ+yURm/zg7Ov5zj7v5Yx0zHbSRcssrwQPlZFrCgLb0CMlU0sxwBUMmMQPxZoD3
         bgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=n0ImSmMTtdc5xJq+I/breyB9bXUzHQEFJ5lwjbHaGHo=;
        b=ENdmtG+L9OUkb/uFFp7+SEaT/9IxibkQ6TpakCbIcVG2xI8FOVvULr2Yj27/gHQlOU
         yv6ehhbYbls3okmr5GX5lii78UA/I3yf7iFy88uyWBLZWq2YSYoPlYBmKgJiivC1ZwyN
         XrupghlrF0Jknka1/bdt8C+JSDiC9pnLTnWXo9eyh2eoou/ExTKzIrEdmGj06FF5D+3C
         wEj6AKQG2V5DJ7qFz2EfmQzsyUaplPtnSEcEGDdglg9OCuyFXg8b2xR+AnN/YBKkqhea
         xH0qL0Wy5dfppMR3+temGJk+UCqIhnT9QeZRTdOMWAHI1grYdXw2/ZOmoxhtVRv65S4O
         +1dA==
X-Gm-Message-State: APjAAAVBg0AdvKMumzGCslbbjZof+0X1+1ca7nku20RmH2tAEuSAd3b+
        AAvyin4l0QXXOz/921oMzUo=
X-Google-Smtp-Source: APXvYqxlc0Qi0s+J8tzksO+bFjB1+HsysgRtWX7TFr7IGursKi43NN7kICp2kUOCg3n2UoLrQlA1Ww==
X-Received: by 2002:a05:651c:1183:: with SMTP id w3mr10108732ljo.232.1580599955716;
        Sat, 01 Feb 2020 15:32:35 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id y14sm7151920ljk.46.2020.02.01.15.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Feb 2020 15:32:34 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        peff@peff.net, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] [RFC] Changed Paths Bloom Filters
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <20200121234055.GN181522@google.com>
Date:   Sun, 02 Feb 2020 00:32:30 +0100
In-Reply-To: <20200121234055.GN181522@google.com> (Emily Shaffer's message of
        "Tue, 21 Jan 2020 15:40:55 -0800")
Message-ID: <86blqhsx2p.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

[...]
> Speaking of making sure I understand the change right, I will also
> summarize my own understanding in the hopes that I can be corrected and
> others can learn too ;)
>
>  - The general idea is that we can write down a hint at the tree level
>    saying "something I own did change this commit"; when we look for an
>    object later, we can skip the commit where it looks like that path
>    didn't change.

Or, to be more exact, we write hint about all the files and directories
changed in the commit at the commit level.

Say, for example, that changed files are 'README' and 'subdir/file'.
We store hint that 'README', 'subdir/file' and 'subdir' paths have
changes in them.

>  - The change is in two pieces: first, to generate the hints per tree
>    (which happens during commit-graph); second, to use those hints to
>    optimize a rev walk (which happens in revision.c patch 8)

Right.

>  - When we calculate the hints during commit-graph, we check the diff of
>    each tree compared to its recent ancestor to see if there was a
>    change;

s/recent ancestor/first parent/

Right, though commits without any changes with respect to first-parent
(or null tree in case of root i.e. parentless commit) should be rare.

>           if so we calculate a hash for each path and use that as a key
>    for a map from hash to path.

Yes, and no.  Here we enter the details how Bloom filter is constructed.
We don't store paths in Bloom filter -- it would take too much space.

The hashmap is used as an implementation of mathematical set, a
temporary structure used during Bloom filter construction.  We could
have used string_list, but then we could waste time trying to add
intermediate directories multiple times (for example if 'foo/bar' and
'foo/baz' files changed, we need to add 'foo' path only once to Bloom
filter).

You can think of Bloom filter as a compact (and probabilistic, see
below) representation of set of changed paths.

>                                After we look through everything changed
>    in the diff, we can add it to a cumulative bloom filter list (one
>    filter per commit) so we have a handy in-memory idea of which paths
>    changed in each commit.

Yes.

>  - When it's time to do the rev walk, we ask for the bloom filter for
>    each commit and check if that commit's map contains the path to the
>    object we're worried about; if so, then it's OK to unpack the tree
>    and check if the path we are interested in actually did get changed
>    during that commit.

From the point of view of rev walk, we ask for the Bloom filter for each
commit walked, and check if the (sub)set of changed paths includes given
path.

Bloom filter can answer "no" -- then we can skip the commit simplifying
history, or it can answer "maybe" -- then we need to check if file was
actually changed unpacking the trees (there is around 1% probability
that Bloom filter will say "maybe" if the path is not actually changed).


From the point of view of Bloom filter, if the path was actually changed
the filter will always answer "maybe".  If the path was not changed,
then in most cases the filter will answer "no" but there is 1% of chance
that it will answer "maybe".


I hope that helps,
--
Jakub Nar=C4=99bski
