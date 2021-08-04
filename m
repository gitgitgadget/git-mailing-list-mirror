Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2DFC432BE
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8B560F25
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbhHDFiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 01:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbhHDFiS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 01:38:18 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A08C06179B
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 22:38:06 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n12-20020a05600c3b8cb029025a67bbd40aso3105654wms.0
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 22:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yGRI/7DWz4wYUAHxWOXasEQ1e39OsZKdaSNsPJcuiRs=;
        b=lufZKUsJcf+AoPuZLODY9N/JBXFncvEGDE69WWatOKNm8XBWLIDPTJ7uBt5QoZlgYe
         FwgrnKWihDL2s2ULJi5KntdChPdnkIIApt45AynzuEHtK8q2fcdZKDQR1mZ324jdECE6
         o2JhmYFaVVwGJ0EkRf3KFIA6q39WtrWSQfv2mwpCtYpXP3Ac/5ctzxInC4c9JFlEI4+O
         6OyunqYMwGRrjwWjeY71F+cfAypGEKCRXkF/CRg4V2X/5EMGSwPFw5oSCsntKiEj1TSf
         h23VBo92ww9mBOwl2vPvi6CBFoU7FW6GmmzQJv24SvmovcB1/rLVshi3/QXqzbZZCIV4
         IAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yGRI/7DWz4wYUAHxWOXasEQ1e39OsZKdaSNsPJcuiRs=;
        b=eODyBX9HxJmLft/3vB5mjMozeF+ClXbUomqfYKYUwID3USCfFf9DNO3FCstbH3FvOB
         vL1Z0H3JkZaXUy0ifvY/4WY8JujRRF7MMZ7jE9pehOGiX3lIhP1HqUMaHuolFsxjRFcZ
         9ZPLZI4PYHVW3F8/pP9p6QaCXFXYG+UzcpDsk3eZa0yAMvjjFE8s25q5eZywtvL8LjMB
         QrcakpSUIXpbbcsBv1z8Lp2joyZiMPEZ/pWI8YPHkT+VHZSQ/JX/IG7XESJn+Uym7uhq
         sQF3YN1nUMgDOD23LMdaB3p0sUkUoQRmK4TIgwR51lw1I83GsVrZQNU2UbHQE36FQdA3
         CRaQ==
X-Gm-Message-State: AOAM530up+cDATF/dtBSd6S1xrK1vbPy3Vn+y+PXBZz+Gs265zm91zoz
        pttZBHGMPKxUwx7O5X1kPrA+R/DUlwY=
X-Google-Smtp-Source: ABdhPJyMShVsRwIs2T4ptGLRTpEcVb5voSloNDOZEIzsmxM7j5LZKanRUB9HwKA8GSTFhjkbGzVd7Q==
X-Received: by 2002:a05:600c:414e:: with SMTP id h14mr7796514wmm.92.1628055484507;
        Tue, 03 Aug 2021 22:38:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 104sm1108158wrc.4.2021.08.03.22.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 22:38:04 -0700 (PDT)
Message-Id: <845d5bf510c5dea2bf6d96d6bc21f356d00fc562.1628055482.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1011.git.1628055482.gitgitgadget@gmail.com>
References: <pull.1011.git.1628055482.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 05:38:02 +0000
Subject: [PATCH 2/2] Update docs for change of default merge backend
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Make it clear that `ort` is the default merge strategy now rather than
`recursive`, including moving `ort` to the front of the list of merge
strategies.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt       | 28 ++++-----
 Documentation/gitfaq.txt           |  2 +-
 Documentation/merge-options.txt    |  2 +-
 Documentation/merge-strategies.txt | 93 ++++++++++++++++--------------
 Documentation/user-manual.txt      |  2 +-
 5 files changed, 67 insertions(+), 60 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 73d49ec8d91..3f1030df70e 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -352,8 +352,8 @@ See also INCOMPATIBLE OPTIONS below.
 
 -s <strategy>::
 --strategy=<strategy>::
-	Use the given merge strategy, instead of the default
-	`recursive`.  This implies `--merge`.
+	Use the given merge strategy, instead of the default `ort`.
+	This implies `--merge`.
 +
 Because 'git rebase' replays each commit from the working branch
 on top of the <upstream> branch using the given strategy, using
@@ -366,7 +366,7 @@ See also INCOMPATIBLE OPTIONS below.
 --strategy-option=<strategy-option>::
 	Pass the <strategy-option> through to the merge strategy.
 	This implies `--merge` and, if no strategy has been
-	specified, `-s recursive`.  Note the reversal of 'ours' and
+	specified, `-s ort`.  Note the reversal of 'ours' and
 	'theirs' as noted above for the `-m` option.
 +
 See also INCOMPATIBLE OPTIONS below.
@@ -527,7 +527,7 @@ The `--rebase-merges` mode is similar in spirit to the deprecated
 where commits can be reordered, inserted and dropped at will.
 +
 It is currently only possible to recreate the merge commits using the
-`recursive` merge strategy; different merge strategies can be used only via
+`ort` merge strategy; different merge strategies can be used only via
 explicit `exec git merge -s <strategy> [...]` commands.
 +
 See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
@@ -1216,16 +1216,16 @@ successful merge so that the user can edit the message.
 If a `merge` command fails for any reason other than merge conflicts (i.e.
 when the merge operation did not even start), it is rescheduled immediately.
 
-By default, the `merge` command will use the `recursive` merge
-strategy for regular merges, and `octopus` for octopus merges.  One
-can specify a default strategy for all merges using the `--strategy`
-argument when invoking rebase, or can override specific merges in the
-interactive list of commands by using an `exec` command to call `git
-merge` explicitly with a `--strategy` argument.  Note that when
-calling `git merge` explicitly like this, you can make use of the fact
-that the labels are worktree-local refs (the ref `refs/rewritten/onto`
-would correspond to the label `onto`, for example) in order to refer
-to the branches you want to merge.
+By default, the `merge` command will use the `ort` merge strategy for
+regular merges, and `octopus` for octopus merges.  One can specify a
+default strategy for all merges using the `--strategy` argument when
+invoking rebase, or can override specific merges in the interactive
+list of commands by using an `exec` command to call `git merge`
+explicitly with a `--strategy` argument.  Note that when calling `git
+merge` explicitly like this, you can make use of the fact that the
+labels are worktree-local refs (the ref `refs/rewritten/onto` would
+correspond to the label `onto`, for example) in order to refer to the
+branches you want to merge.
 
 Note: the first command (`label onto`) labels the revision onto which
 the commits are rebased; The name `onto` is just a convention, as a nod
diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index afdaeab8503..8c1f2d56751 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -275,7 +275,7 @@ best to always use a regular merge commit.
 
 [[merge-two-revert-one]]
 If I make a change on two branches but revert it on one, why does the merge of those branches include the change?::
-	By default, when Git does a merge, it uses a strategy called the recursive
+	By default, when Git does a merge, it uses a strategy called the `ort`
 	strategy, which does a fancy three-way merge.  In such a case, when Git
 	performs the merge, it considers exactly three points: the two heads and a
 	third point, called the _merge base_, which is usually the common ancestor of
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index f819bd8dd68..72b53188504 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -112,7 +112,7 @@ With --squash, --commit is not allowed, and will fail.
 	Use the given merge strategy; can be supplied more than
 	once to specify them in the order they should be tried.
 	If there is no `-s` option, a built-in list of strategies
-	is used instead (`recursive` when merging a single head,
+	is used instead (`ort` when merging a single head,
 	`octopus` otherwise).
 
 -X <option>::
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 210f0f850b2..34c6c31d8e7 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -6,21 +6,23 @@ backend 'merge strategies' to be chosen with `-s` option.  Some strategies
 can also take their own options, which can be passed by giving `-X<option>`
 arguments to `git merge` and/or `git pull`.
 
-recursive::
-	This can only resolve two heads using a 3-way merge
-	algorithm.  When there is more than one common
-	ancestor that can be used for 3-way merge, it creates a
-	merged tree of the common ancestors and uses that as
-	the reference tree for the 3-way merge.  This has been
-	reported to result in fewer merge conflicts without
-	causing mismerges by tests done on actual merge commits
-	taken from Linux 2.6 kernel development history.
-	Additionally this can detect and handle merges involving
-	renames.  It does not make use of detected copies.  This
-	is the default merge strategy when pulling or merging one
-	branch.
+ort::
+	This is the default merge strategy when pulling or merging one
+	branch.  This strategy can only resolve two heads using a
+	3-way merge algorithm.  When there is more than one common
+	ancestor that can be used for 3-way merge, it creates a merged
+	tree of the common ancestors and uses that as the reference
+	tree for the 3-way merge.  This has been reported to result in
+	fewer merge conflicts without causing mismerges by tests done
+	on actual merge commits taken from Linux 2.6 kernel
+	development history.  Additionally this strategy can detect
+	and handle merges involving renames.  It does not make use of
+	detected copies.  The name for this algorithm is an acronym
+	("Ostensibly Recursive's Twin") and came from the fact that it
+	was written as a replacement for the previous default
+	algorithm, `recursive`.
 +
-The 'recursive' strategy can take the following options:
+The 'ort' strategy can take the following options:
 
 ours;;
 	This option forces conflicting hunks to be auto-resolved cleanly by
@@ -36,16 +38,6 @@ theirs;;
 	This is the opposite of 'ours'; note that, unlike 'ours', there is
 	no 'theirs' merge strategy to confuse this merge option with.
 
-patience;;
-	Deprecated synonym for `diff-algorithm=patience`.
-
-diff-algorithm=[patience|minimal|histogram|myers];;
-	Use a different diff algorithm while merging, which can help
-	avoid mismerges that occur due to unimportant matching lines
-	(such as braces from distinct functions).  See also
-	linkgit:git-diff[1] `--diff-algorithm`.  Defaults to the
-	`diff.algorithm` config setting.
-
 ignore-space-change;;
 ignore-all-space;;
 ignore-space-at-eol;;
@@ -74,11 +66,6 @@ no-renormalize;;
 	Disables the `renormalize` option.  This overrides the
 	`merge.renormalize` configuration variable.
 
-no-renames;;
-	Turn off rename detection. This overrides the `merge.renames`
-	configuration variable.
-	See also linkgit:git-diff[1] `--no-renames`.
-
 find-renames[=<n>];;
 	Turn on rename detection, optionally setting the similarity
 	threshold.  This is the default. This overrides the
@@ -95,19 +82,39 @@ subtree[=<path>];;
 	is prefixed (or stripped from the beginning) to make the shape of
 	two trees to match.
 
-ort::
-	This is meant as a drop-in replacement for the `recursive`
-	algorithm (as reflected in its acronym -- "Ostensibly
-	Recursive's Twin"), and will likely replace it in the future.
-	It fixes corner cases that the `recursive` strategy handles
-	suboptimally, and is significantly faster in large
-	repositories -- especially when many renames are involved.
+recursive::
+	This can only resolve two heads using a 3-way merge
+	algorithm.  When there is more than one common
+	ancestor that can be used for 3-way merge, it creates a
+	merged tree of the common ancestors and uses that as
+	the reference tree for the 3-way merge.  This has been
+	reported to result in fewer merge conflicts without
+	causing mismerges by tests done on actual merge commits
+	taken from Linux 2.6 kernel development history.
+	Additionally this can detect and handle merges involving
+	renames.  It does not make use of detected copies.  This was
+	the default strategy for resolving two heads from Git v0.99.9k
+	until v2.33.0.
 +
-The `ort` strategy takes all the same options as `recursive`.
-However, it ignores three of those options: `no-renames`,
-`patience` and `diff-algorithm`.  It always runs with rename
-detection (it handles it much faster than `recursive` does), and
-it specifically uses `diff-algorithm=histogram`.
+The 'recursive' strategy takes the same options as 'ort'.  However,
+there are three additional options that 'ort' ignores (not documented
+above) that are potentially useful with the 'recursive' strategy:
+
+patience;;
+	Deprecated synonym for `diff-algorithm=patience`.
+
+diff-algorithm=[patience|minimal|histogram|myers];;
+	Use a different diff algorithm while merging, which can help
+	avoid mismerges that occur due to unimportant matching lines
+	(such as braces from distinct functions).  See also
+	linkgit:git-diff[1] `--diff-algorithm`.  Note that `ort`
+	specifically uses `diff-algorithm=histogram`, while `recursive`
+	defaults to the `diff.algorithm` config setting.
+
+no-renames;;
+	Turn off rename detection. This overrides the `merge.renames`
+	configuration variable.
+	See also linkgit:git-diff[1] `--no-renames`.
 
 resolve::
 	This can only resolve two heads (i.e. the current branch
@@ -131,13 +138,13 @@ ours::
 	the 'recursive' merge strategy.
 
 subtree::
-	This is a modified recursive strategy. When merging trees A and
+	This is a modified ort strategy. When merging trees A and
 	B, if B corresponds to a subtree of A, B is first adjusted to
 	match the tree structure of A, instead of reading the trees at
 	the same level. This adjustment is also done to the common
 	ancestor tree.
 
-With the strategies that use 3-way merge (including the default, 'recursive'),
+With the strategies that use 3-way merge (including the default, 'ort'),
 if a change is made on both branches, but later reverted on one of the
 branches, that change will be present in the merged result; some people find
 this behavior confusing.  It occurs because only the heads and the merge base
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 96240598e3f..865074bed4e 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3190,7 +3190,7 @@ that *updated* thing--the old state that you added originally ends up
 not being pointed to by any commit or tree, so it's now a dangling blob
 object.
 
-Similarly, when the "recursive" merge strategy runs, and finds that
+Similarly, when the "ort" merge strategy runs, and finds that
 there are criss-cross merges and thus more than one merge base (which is
 fairly unusual, but it does happen), it will generate one temporary
 midway tree (or possibly even more, if you had lots of criss-crossing
-- 
gitgitgadget
