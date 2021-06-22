Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1464C49EA4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 16:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86829610C7
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 16:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhFVQM5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 12:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhFVQMy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 12:12:54 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70282C061756
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 09:10:36 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id k1-20020a0568200161b029024bef8a628bso178473ood.7
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 09:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0Wv4xJmZATXPNUCfURfipYW+CnqkEET/MYcoC5fsI80=;
        b=Wbe4Bum4QWnLWIfRkdQTRrQWBcusqD7OLH2WPCNfcdmAHdAvauKpxOiTHdxH8L0nLZ
         AIAASY1VYoOtNvdRq4cfi2GBa3VrLLW/O18dEfA2rrMj0yKlkgsYUY7aiW4RfFM1T58o
         bEGQwXGI96tgyeVaemAuWI0YGBPPgSBh2srLERCEPPTcRle6xj+Ix1WaXwUg3Iyxp1hQ
         dnLI5gjiwqi0x79xc3FSeBAltKKTkkGD6bf09/YV2NWcK7G0x0wbNXcgyzQRIy8z4Isv
         zdK0YGUzFhFTcYZokIcfalbk1MOpVv3JezVhCZjTQGno6Jb1JOoCTjpcKt/hNhVJV+i8
         pKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Wv4xJmZATXPNUCfURfipYW+CnqkEET/MYcoC5fsI80=;
        b=iZZ3yunVya96dNSoNLxXpVcSTBRtEufzGJzqpkuzAjGKSacyGflqgJsb26sAxlU5nA
         v8CJpq7Rt/yQVfPs3W3wndWGUr6aCVMtS/zQjkBu5GS/6mC0m5x0OePTji8rk2iEDCgl
         ptAn4G0ARdNfiUIEHymvae5fzaF8KKq7jZ0qWMlUwfjhAH3b60KhZNCm3gp2DmSO+YPZ
         zgXTG3+TJNb9VOHRtQa3cUHt7ky5HPOI5MhsoLEhqrEsdpsA6yscH2nsEaGct6AZFfMu
         x3/zqkWJviIQiGGwCLzuk/c9Elb1pVUQNz9d5uMywAeKJ1nuoxVKYm0dXLyq1qBD5j3J
         zUpQ==
X-Gm-Message-State: AOAM532lKqg9bztf5BUGpmkP8TGHyqGEeUJvjxSQiU7fBjLaAmX+2Qqa
        t7AHBfNEyURO38dWt/uJm0k=
X-Google-Smtp-Source: ABdhPJzGd89SFbp6HhfayF+NFt9FKFsLoGblKzKZHXjcmkICVsnJm5+ov9ceOucz/Gt5PDUTlUZm7g==
X-Received: by 2002:a4a:8802:: with SMTP id d2mr3943563ooi.28.1624378235724;
        Tue, 22 Jun 2021 09:10:35 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:2110:dbed:f0f7:d6e3? ([2600:1700:e72:80a0:2110:dbed:f0f7:d6e3])
        by smtp.gmail.com with ESMTPSA id b20sm2777976otq.41.2021.06.22.09.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 09:10:35 -0700 (PDT)
Subject: Re: [PATCH v3 0/5] Optimization batch 13: partial clone optimizations
 for merge-ort
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
References: <pull.969.v2.git.1623796907.gitgitgadget@gmail.com>
 <pull.969.v3.git.1624349082.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3a397e04-88a1-1205-a465-75dc2fd7e93d@gmail.com>
Date:   Tue, 22 Jun 2021 12:10:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <pull.969.v3.git.1624349082.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/22/2021 4:04 AM, Elijah Newren via GitGitGadget wrote:
> This series optimizes blob downloading in merges for partial clones. It can
> apply on master. It's independent of ort-perf-batch-12.

As promised, I completed a performance evaluation of this series as well
as ort-perf-batch-12 (and all earlier batches) against our microsoft/git
fork and running in one of our large monorepos that has over 2 million
files at HEAD. Here are my findings.

In my comparisons, I compare the recursive merge strategy with renames
disabled against the ORT strategy (which always has renames enabled). When
I enabled renames for the recursive merge I saw the partial clone logic
kick in and start downloading many files in every case, so I dropped that
from consideration.


Experiment #1: Large RI/FI merges
---------------------------------

Most of the merge commits in this repo's history are merges of several
long-lived branches as code is merged across organizational boundaries. I
focused on the merge commits in the first-parent history, which mean these
are the merges that brought the latest changes from several areas into the
canonical version of the software.

These merges are all automated merges created by libgit2's implementation
of the recursive merge strategy. Since they are created on the server,
these will not have any merge conflicts.

They are still interesting because the sheer number of files that change
can be large. This is a pain point for the recursive merge because many
index entries need to update with the merge. For ORT, some of the updates
are simple because only one side changed a certain subtree (the
organizational boundaries also correspond to the directory structure in
many cases).

Across these merges I tested, ORT was _always_ faster and was consistent
with the recursive strategy. Even more interesting was the fact that the
recursive strategy had very slow outliers while the ORT strategy was much
more consistent:

     Recursive     ORT
-----------------------
MAX     34.97s    4.74s
P90     30.04s    4.50s
P75     15.35s    3.74s
P50      7.22s    3.39s
P10      3.61s    3.08s

(I'm not testing ORT with the sparse-index yet. A significant portion of
this 3 second lower bound is due to reading and writing the index file
with 2 million entries. I _am_ using sparse-checkout with only the files
at root, which minimizes the time required to update the working directory
with any changed files.)

For these merges, ORT is a clear win.


Experiment #2: User-created merges
----------------------------------

To find merges that might be created by actual user cases, I ran
'git rev-list --grep="^Merge branch"' to get merges that had default
messages from 'git merge' runs. (The merges from Experiment #1 had other
automated names that did not appear in this search.)

Here, the differences are less striking, but still valuable:

     Recursive     ORT
-----------------------
MAX     10.61s   6.27s
P75      8.81s   3.92s
P50      4.32s   3.21s
P10      3.53s   2.95s

The ORT strategy had more variance in these examples, though still not as
much as the recursive strategy. Here the variance is due to conflicting
files needing content merges, which usually were automatically resolved.

This version of the experiment provided interesting observations in a few
cases:

1. One case had the recursive merge strategy result in a root tree that
   disagreed with what the user committed, but the ORT strategy _did_ the
   correct resolution. Likely, this is due to the rename detection and
   resolution. The user probably had to manually resolve the merge to
   match their expected renames since we turn off merge.renames in their
   config.

2. I watched for the partial clone logic to kick in and download blobs.
   Some of these were inevitable: we need the blobs to resolve edit/edit
   conflicts. Most cases none were downloaded at all, so this series is
   working as advertised. There _was_ a case where the inexact rename
   detection requested a large list of files (~2900 in three batches) but
   _then_ said "inexact rename detection was skipped due to too many
   files". This is a case that would be nice to resolve in this series. I
   will try to find exactly where in the code this is being triggered and
   report back.

3. As I mentioned, I was using sparse-checkout to limit the size of the
   working directory. In one case of a conflict that could not be
   automatically resolved, the ORT strategy output this error:

   error: could not open '<X>': No such file or directory

   It seems we are looking for a file on disk without considering if it
   might have the SKIP_WORKTREE bit on in the index. I don't think this is
   an issue for this series, but might require a follow-up on top of the
   other ORT work.


Conclusions
-----------

I continue to be excited about the ORT strategy and will likely be
focusing on it in a month or so to integrate it with the sparse-index. I
think we would be interested in making the ORT strategy a new default for
Scalar, but we might really want it to respect merge.renames=false if only
so we can deploy the settings in stages (first, change the strategy, then
enable renames as an independent step) so we can isolate concerns.


Thanks!
-Stolee
