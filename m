Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C022C433DF
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 16:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1B932067B
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 16:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FF41UKEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgFGQWi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 12:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgFGQWh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 12:22:37 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2536CC08C5C3
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 09:22:37 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bg4so5694012plb.3
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Z2UjOOT/Ep20ka3R0dJj4N61oBZ/CaKvPv6YBNAvChs=;
        b=FF41UKEnh6uX92AT7vHvQFSBExrSnGezVsm+qR+Jxgd1CzAN3x55O9KybxJKuXps/Q
         PeFn1yVTq4DvZ/xf6bNBnsusxFb0/badYFLl+dCMrsUYa3CJhCLRtC40Q9t5/L3RTKDB
         8QEio/NRP45F75qUOdLsksd+RzzRVASOGoEnskiYk6P6IMrOW+SmIC8YGLO1u9QLUodV
         TlBD5CfwdmOxSUk0RiVLZWaNCmbBALhjRycxhNzrEtrthdR77Qw26V1JFG+srI2Xiubj
         RxWRMthojhvwE8M3LDznxBClhjeUNGZruuaODv8dQDvKxxXEVuXbfNBx+XwMtv/kEgtr
         OnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Z2UjOOT/Ep20ka3R0dJj4N61oBZ/CaKvPv6YBNAvChs=;
        b=pslBJ3xdRAkEYtK2rSm7G1bAgSSuJJYY+yZZntESLZrg9VsGdA2dhi4kojPxijpU/+
         XXByDB0HMPtxeiP+EdVYl1jLWwdpdxQ7EA2xQ0TY3zDB8vfv5xY6jMM3K6E8CUSc8Z88
         2SD+JeRXdno/cfNP72xafRN3lXDB6d5q0Tc9oIHKafhGDN0BTlDjgFi6xCe9Tpc46I1k
         8KsiqWXNjJvPF2aVGDBPOQ4Y0tKxcJSvD7wxXQbPW9zA8zFgKu7T847yHeBISPkc6p5P
         goxnUuvxHEU3LimU44tPSmHIemiDWf+xRj36MnbK/wIqwEInNXHd33iNH4ZqNwSLzi2D
         fZVA==
X-Gm-Message-State: AOAM5331AtBIjHU2ZIJcRp/xo8mnpmRsEkeqX8boKhy1TFWnkTLhHTQK
        Wb8GxqnHQZuRPoCTh+Ns0YI=
X-Google-Smtp-Source: ABdhPJwZ6a+u7t4lAvCF1EC8hWrOJVnZbbb80Osy5iaEH/+AXLLoX7X/y9MPrdUwzUo+3M1wINKCfQ==
X-Received: by 2002:a17:90a:744f:: with SMTP id o15mr13497137pjk.54.1591546956418;
        Sun, 07 Jun 2020 09:22:36 -0700 (PDT)
Received: from ?IPv6:2601:8c0:37f:6012:8c4b:deea:298c:b06f? ([2601:8c0:37f:6012:8c4b:deea:298c:b06f])
        by smtp.gmail.com with ESMTPSA id k101sm13895573pjb.26.2020.06.07.09.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 09:22:35 -0700 (PDT)
To:     git-ml <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
From:   Antonio Russo <antonio.e.russo@gmail.com>
Subject: [PATCH 0/3] Ignore merge bases graph simplification
Message-ID: <456a1271-4f17-5503-5d13-d0c97115e2fd@gmail.com>
Date:   Sun, 7 Jun 2020 10:22:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is a second attempt at providing a way to simplify the
graphical representation of forked branches that are merged back in.
Currently, when many branches are forked off the same commit, a
"mountain" of the tails of the merge that connect to the merge base
accumulate, making visual inspection of the --graph output challenging:

% git log --graph --oneline 20514004dd -n20

> * 20514004dd Start the post 2.27 cycle
> *   54041832d7 Merge branch 'en/fast-import-looser-date'
> |\
> | * d42a2fb72f fast-import: add new --date-format=raw-permissive format
> * |   a0ba2bbbdd Merge branch 'mt/zsh-completion-optim'
> |\ \
> | * | a44a0a9fc4 completion: use native ZSH array pattern matching
> * | |   e34df9a6e5 Merge branch 'la/diff-relative-config'
> |\ \ \
> | * | | c28ded83fc diff: add config option relative
> * | | |   de82fb45db Merge branch 'rs/checkout-b-track-error'
> |\ \ \ \
> | * | | | bb2198fb91 checkout: improve error messages for -b with extra argument
> | * | | | 16ab794b82 checkout: add tests for -b and --track
> * | | | |   202a2b8e71 Merge branch 'lo/sparse-universal-zero-init'
> |\ \ \ \ \
> | * | | | | 1c96642326 sparse: allow '{ 0 }' to be used without warnings
> | | |_|_|/
> | |/| | |
> * | | | |   1ab0dfde2c Merge branch 'cb/t5608-cleanup'
> |\ \ \ \ \
> | * | | | | d63ae31962 t5608: avoid say() and use "skip_all" instead for consistency
> | |/ / / /
> * | | | |   70a1e331b0 Merge branch 'jx/pkt-line-doc-count-fix'
> |\ \ \ \ \
> | * | | | | 2c31a7aa44 doc: fix wrong 4-byte length of pkt-line message
> | |/ / / /
> * | | | |   51b4708811 Merge branch 'jn/experimental-opts-into-proto-v2'
> |\ \ \ \ \
> | * | | | | 3697caf4b9 config: let feature.experimental imply protocol.version=2
> * | | | | |   7a8fec908a Merge branch 'bk/p4-prepare-p4-only-fix'
> |\ \ \ \ \ \
> | * | | | | | 2dfdd705ff git-p4.py: fix --prepare-p4-only error with multiple commits

This patch adds a new "--ignore-merge-bases' parameter that, roughly,
hides all of the information about the merge base:

% git log --graph --oneline 20514004dd --ignore-merge-bases -n20

> * 20514004dd Start the post 2.27 cycle
> *   54041832d7 Merge branch 'en/fast-import-looser-date'
> |\
> | * d42a2fb72f fast-import: add new --date-format=raw-permissive format
> *   a0ba2bbbdd Merge branch 'mt/zsh-completion-optim'
> |\
> | * a44a0a9fc4 completion: use native ZSH array pattern matching
> *   e34df9a6e5 Merge branch 'la/diff-relative-config'
> |\
> | * c28ded83fc diff: add config option relative
> *   de82fb45db Merge branch 'rs/checkout-b-track-error'
> |\
> | * bb2198fb91 checkout: improve error messages for -b with extra argument
> | * 16ab794b82 checkout: add tests for -b and --track
> *   202a2b8e71 Merge branch 'lo/sparse-universal-zero-init'
> |\
> | * 1c96642326 sparse: allow '{ 0 }' to be used without warnings
> *   1ab0dfde2c Merge branch 'cb/t5608-cleanup'
> |\
> | * d63ae31962 t5608: avoid say() and use "skip_all" instead for consistency
> *   70a1e331b0 Merge branch 'jx/pkt-line-doc-count-fix'
> |\
> | * 2c31a7aa44 doc: fix wrong 4-byte length of pkt-line message
> *   51b4708811 Merge branch 'jn/experimental-opts-into-proto-v2'
> |\
> | * 3697caf4b9 config: let feature.experimental imply protocol.version=2
> *   7a8fec908a Merge branch 'bk/p4-prepare-p4-only-fix'
> |\
> | * 2dfdd705ff git-p4.py: fix --prepare-p4-only error with multiple commits

The significant changes since the last round of discussion are:

1. A streaming version of the algorithm has been implemented.  No longer
is revs->limited, with all of its very serious drawbacks, required.

2. The commit->parents commit_list is no longer modified (amputated).
Instead, a "principle child" is identified during a (heavily modified)
indegree walk.

3. Per D. Stolee's suggestion, the output of child->parent edges are
suppressed during graph emission (in particular, in
graph_is_interesting).

4. No commit flags are used. All per-commit ancillary data is stored
in a commit slab.

I discarded J. Sixt's suggestion to change the format of the --boundary
output.  While I like the proposed format, I think the change is
orthogonal to this (already large) change.

There are several outstanding issues that I would appreciate help with:

1. I have developed some terminology to think about the concepts used
here.  They are definitely not conventional, and probably should be
changed.  I would appreciate feedback:

 - A "skeleton walk" is the streaming version of a left-first
   DFS-generated spanning tree.  This is achieved using a carefully
   generation-limited traversal of the commit graph.  *Edges* are
   stored in a skel_walk_list structure.  This traversal should be
   linear in the number of edges (but I'll admit I haven't actually
   done this proof).

 - The "guide commits" are all of the commits in revs->commits.

 - A "component" (and this is particularly bad terminology) is the
   collection of commits reachable from a guide commit, but not from
   an earlier ("higher priority") guide commit.

   This approach avoids any ambiguity in the output of
   --ignore-merge-bases as to what commits are included at the merge
   point, by always drawing any edge between components.  Notice that
   the definition of a component means that no edges go from higher-
   priority to lower-priority components (instead, those commits are
   absorbed into the higher-priority component).

 - The "principle child" of a commit c is the first child in the
   leftmost-first DFS that references c.  It is always in the same
   component as c, and it is the only commit in that component whose
   edge is drawn connecting to c.

Presumably, all of these terms should be documented (with visuals)
somewhere.  If there is serious interest in this patch, I'm happy to do
this, but I'm loathe to waste time doing this until I start hearing some
sort of positive feedback on what has become a significant time sink.

2. The meat of the changes are monolithically collected into patch 2/3.
It does not make sense in my mind to implement functions that are not
used anywhere, and then make first use them in another commit.  But, I
can split this up into the skeleton walk implementation and the graph
display, if wanted.

3. A skel_walk_info structure is allocated at parameter parse time, and
currently is never freed.  While this is certainly a memory leak, it is
not clear to me if there is a benefit to performing the cleanup, besides
getting clean valgrind output (and masking more serious memory leaks). I
I didn't try to read everything in Documentation, but, besides an
abundance of commits fixing memory leaks, I could not find a specific
policy regarding freeing memory before program termination.

4. The implementation for revs->limited and !revs->limited is
frustratingly similar, but I cannot see any particular elegant way to
deduplicate the code.  The existing code also seems to suffer similarly.

Is there movement forward on eliminating the whole rev->limited
code-path?  This is obviously out of scope for this patch set, but
maintaining two code-paths was a hassle for this one action, and I can
imagine that it is much worse when multiplied by all of git's features.

5. Similarly, the skel_walk is very similar to the existing indegree
walk.  But again, avoiding duplicated code leads to uncomfortable

> if (skel) {
>         ...
> }

blocks.  It also confuses gcc, which has trouble realizing that
variables were initialized in previous `if (skel)` blocks.  I'm then
forced to resort to underhanded tricks: blanket initializing of
variables that should have been optimized out if !skel.

Duplicating the entire function leads to cleaner and negligibly faster
code.  Frustratingly, but unsurprisingly, the meticulous careful
skeleton walk that I've implemented is slightly slower than the
existing indegree walk, so it's a bad candidate to replace the old code.

Any thoughts?

The entire patch set is also available at [1], which includes a few
debugging assertions enabled, and the excision of the unused
free_skel_info method (see 3, above) which otherwise breaks
-Wunused-function.  It passes the full battery of tests there (as well
as locally for me).

Best,
Antonio Russo

[1] <https://github.com/aerusso/git/tree/mrs/imb-skel>
