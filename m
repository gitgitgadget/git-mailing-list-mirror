Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED785C432BE
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 00:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D50D961050
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 00:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhHAAHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 20:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhHAAHy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 20:07:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650F5C0613D3
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 17:07:46 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d8so16599034wrm.4
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 17:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1411BeLrexVyVgwVyUlDmirQoqI42mbmsOi2NMIJjyM=;
        b=Rv39mXWRwkJ45GpaVnobQ3wmvnIdsu0dW05hE6Mjnfe5Hx2Xk2+UAQqXAYQC26uAj/
         JSzlUMKO9hcLhgziQZ0YLS1A5jiccavvBgcDC2dHAk07btq7wgd3Ql2CQxR28iMAF1yy
         3oK4HqiRBrEpqDiZPmXFUCmGDNOiYG4Og+oVITHysmEMmVdXxeGWez/+25Z3N5ZJpycB
         YAaxxtBv7aXN3NwnQTszbOjiI+N4YutPbkanlyELt1/tZic8apRyJu6R5NWvwbvApzQw
         /PL/W62G5mo5QYUh3ZTPpBJW8ap+6Qk9m9QeBZiDVkcOsKTCL/uvlSbUaKxCMMCKlScA
         sd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1411BeLrexVyVgwVyUlDmirQoqI42mbmsOi2NMIJjyM=;
        b=srFJ1R3mm4n+OgI98bVw9hMLZxJvYbHMWrPUuWawrc4s/a3WQwymebkZXZI+hOWBx8
         KH7bsQMPfimdTsq1xYTi5A7n882/ZsiD7bSCaKfdWU+5//usu4CK2ERWwPcO/8ozBWck
         bCS8B924Ukh6zSYHlaUMNyTcTmjox0IRZ4KiMcE0vTC1cjmny5Iu4DRNRY3fK2L+CKsf
         V5644iMNwOygUIUKvCmA51HnQ4fijn4YPsGe2z6J9CA9dk7ba72TycR52fHDMgbnwgGJ
         qzBlyKKMkJ4s4jE3dn6f7wTTxiuxKgGr1nw5LywWu9TxvAKkPv+ixmVVwIdzi4+W9xIN
         +qAA==
X-Gm-Message-State: AOAM531Grl/DNsSkFBi6pUqbht8qaj8/zx9560xk4ViXBGQpIBTMqhZ7
        yqT8SuVdl3lU5y3z9eXMvEqgVK47nU8=
X-Google-Smtp-Source: ABdhPJyB5KhqYH3LhcdvjW1P3xad8n2l4toRPRIZJwlI+PpOnGtvxyItuzgMVDwdVY6blHfe9vZu5Q==
X-Received: by 2002:adf:ebd2:: with SMTP id v18mr10468449wrn.248.1627776464888;
        Sat, 31 Jul 2021 17:07:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s13sm6102969wmc.47.2021.07.31.17.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 17:07:44 -0700 (PDT)
Message-Id: <35490397590ae4d39ba98c7eb206bfadc22ddf35.1627776462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1055.git.git.1627776461.gitgitgadget@gmail.com>
References: <pull.1055.git.git.1627776461.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 01 Aug 2021 00:07:41 +0000
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

Make multiple documentation updates to bring things up to date as we
change the default merge backend...

Add a section for `ort` within merge-strategies.txt; while it accepts
the same flags as `recursive` (even if it ignores three of them) and is
meant as a drop in replacement, it still makes sense to explicitly cover
it.

Change several locations in the docs that referred to `recursive` as the
default merge backend, and fix a few that said or implied that only
`recursive` had certain abilities (such as rename detection).

Fix up some wording in directory-rename-detection.txt due to some
restructurings performed while optimizing both the ort backend and the
rename detection machinery.

Drop the "is considered generally safe and fast" from the description of
the `resolve` strategy, since that implies the other strategies are not.
While such an implication may have been true in 2005 when written, it
may well be that `ort` is faster today (since it does not need to
recurse into all directories).  Also, since `resolve` was the default
for less than a year while `recursive` has been the default for a decade
and a half, I think `recursive` is more battle-tested than `resolve` is.
Move the description of `resolve` near `octopus` and `ours` while at it
since it is no longer the default merge algorithm and hasn't been for a
very long time.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt                  | 17 ++--
 Documentation/gitfaq.txt                      |  2 +-
 Documentation/merge-options.txt               |  4 +-
 Documentation/merge-strategies.txt            | 98 +++++++++++--------
 .../technical/directory-rename-detection.txt  | 14 +--
 Documentation/user-manual.txt                 |  2 +-
 6 files changed, 78 insertions(+), 59 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 55af6fd24e2..41b68423444 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -340,9 +340,10 @@ See also INCOMPATIBLE OPTIONS below.
 
 -m::
 --merge::
-	Use merging strategies to rebase.  When the recursive (default) merge
-	strategy is used, this allows rebase to be aware of renames on the
-	upstream side.  This is the default.
+	Use merging strategies to rebase.  When either the `ort`
+	(default) or `recursive` merge strategy is used, this allows
+	rebase to be aware of renames on the upstream side.  This is the
+	default.
 +
 Note that a rebase merge works by replaying each commit from the working
 branch on top of the <upstream> branch.  Because of this, when a merge
@@ -355,8 +356,8 @@ See also INCOMPATIBLE OPTIONS below.
 -s <strategy>::
 --strategy=<strategy>::
 	Use the given merge strategy.
-	If there is no `-s` option 'git merge-recursive' is used
-	instead.  This implies --merge.
+	If there is no `-s` option the `ort` strategy is the default.
+	This implies --merge.
 +
 Because 'git rebase' replays each commit from the working branch
 on top of the <upstream> branch using the given strategy, using
@@ -369,7 +370,7 @@ See also INCOMPATIBLE OPTIONS below.
 --strategy-option=<strategy-option>::
 	Pass the <strategy-option> through to the merge strategy.
 	This implies `--merge` and, if no strategy has been
-	specified, `-s recursive`.  Note the reversal of 'ours' and
+	specified, `-s ort`.  Note the reversal of 'ours' and
 	'theirs' as noted above for the `-m` option.
 +
 See also INCOMPATIBLE OPTIONS below.
@@ -530,7 +531,7 @@ The `--rebase-merges` mode is similar in spirit to the deprecated
 where commits can be reordered, inserted and dropped at will.
 +
 It is currently only possible to recreate the merge commits using the
-`recursive` merge strategy; Different merge strategies can be used only via
+`ort` merge strategy; different merge strategies can be used only via
 explicit `exec git merge -s <strategy> [...]` commands.
 +
 See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
@@ -1219,7 +1220,7 @@ successful merge so that the user can edit the message.
 If a `merge` command fails for any reason other than merge conflicts (i.e.
 when the merge operation did not even start), it is rescheduled immediately.
 
-At this time, the `merge` command will *always* use the `recursive`
+At this time, the `merge` command will *always* use the `ort`
 merge strategy for regular merges, and `octopus` for octopus merges,
 with no way to choose a different one. To work around
 this, an `exec` command can be used to call `git merge` explicitly,
diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index afdaeab8503..072bf84fa8a 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -275,7 +275,7 @@ best to always use a regular merge commit.
 
 [[merge-two-revert-one]]
 If I make a change on two branches but revert it on one, why does the merge of those branches include the change?::
-	By default, when Git does a merge, it uses a strategy called the recursive
+	By default, when Git does a merge, it uses a strategy called the ort
 	strategy, which does a fancy three-way merge.  In such a case, when Git
 	performs the merge, it considers exactly three points: the two heads and a
 	third point, called the _merge base_, which is usually the common ancestor of
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index eb0aabd396f..72b53188504 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -112,8 +112,8 @@ With --squash, --commit is not allowed, and will fail.
 	Use the given merge strategy; can be supplied more than
 	once to specify them in the order they should be tried.
 	If there is no `-s` option, a built-in list of strategies
-	is used instead ('git merge-recursive' when merging a single
-	head, 'git merge-octopus' otherwise).
+	is used instead (`ort` when merging a single head,
+	`octopus` otherwise).
 
 -X <option>::
 --strategy-option=<option>::
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 2912de706bf..6caf3fd6486 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -6,28 +6,23 @@ backend 'merge strategies' to be chosen with `-s` option.  Some strategies
 can also take their own options, which can be passed by giving `-X<option>`
 arguments to `git merge` and/or `git pull`.
 
-resolve::
-	This can only resolve two heads (i.e. the current branch
-	and another branch you pulled from) using a 3-way merge
-	algorithm.  It tries to carefully detect criss-cross
-	merge ambiguities and is considered generally safe and
-	fast.
-
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
-	renames, but currently cannot make use of detected
-	copies.  This is the default merge strategy when pulling
-	or merging one branch.
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
+	algorithm, recursive.
 +
-The 'recursive' strategy can take the following options:
+The 'ort' strategy can take the following options:
 
 ours;;
 	This option forces conflicting hunks to be auto-resolved cleanly by
@@ -43,19 +38,6 @@ theirs;;
 	This is the opposite of 'ours'; note that, unlike 'ours', there is
 	no 'theirs' merge strategy to confuse this merge option with.
 
-patience;;
-	With this option, 'merge-recursive' spends a little extra time
-	to avoid mismerges that sometimes occur due to unimportant
-	matching lines (e.g., braces from distinct functions).  Use
-	this when the branches to be merged have diverged wildly.
-	See also linkgit:git-diff[1] `--patience`.
-
-diff-algorithm=[patience|minimal|histogram|myers];;
-	Tells 'merge-recursive' to use a different diff algorithm, which
-	can help avoid mismerges that occur due to unimportant matching
-	lines (such as braces from distinct functions).  See also
-	linkgit:git-diff[1] `--diff-algorithm`.
-
 ignore-space-change;;
 ignore-all-space;;
 ignore-space-at-eol;;
@@ -84,11 +66,6 @@ no-renormalize;;
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
@@ -105,6 +82,45 @@ subtree[=<path>];;
 	is prefixed (or stripped from the beginning) to make the shape of
 	two trees to match.
 
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
+	renames.  It does not make use of detected copies.
++
+The 'recursive' strategy takes the same options as 'ort'.  However,
+there are three additional options that 'ort' ignores (not documented
+above) that are potentially useful with the 'recursive' strategy:
+
+patience;;
+	Deprecated shorthand for diff-algorithm=patience.
+
+diff-algorithm=[patience|minimal|histogram|myers];;
+	Use a different diff algorithm while merging, which can help
+	avoid mismerges that occur due to unimportant matching lines
+	(such as braces from distinct functions).  See also
+	linkgit:git-diff[1] `--diff-algorithm`.  Note that `ort`
+	specifically uses diff-algorithm=histogram, while `recursive`
+	defaults to the `diff.algorithm` config setting.
+
+no-renames;;
+	Turn off rename detection, which can be computationally much
+	more expensive for the `recursive` strategy than for `ort`.
+	This overrides the `merge.renames` configuration variable.  See
+	also linkgit:git-diff[1] `--no-renames`.
+
+resolve::
+	This can only resolve two heads (i.e. the current branch
+	and another branch you pulled from) using a 3-way merge
+	algorithm.  It tries to carefully detect criss-cross
+	merge ambiguities.  It cannot handle renames.
+
 octopus::
 	This resolves cases with more than two heads, but refuses to do
 	a complex merge that needs manual resolution.  It is
@@ -121,13 +137,13 @@ ours::
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
diff --git a/Documentation/technical/directory-rename-detection.txt b/Documentation/technical/directory-rename-detection.txt
index 49b83ef3cc4..029ee2cedc5 100644
--- a/Documentation/technical/directory-rename-detection.txt
+++ b/Documentation/technical/directory-rename-detection.txt
@@ -2,9 +2,9 @@ Directory rename detection
 ==========================
 
 Rename detection logic in diffcore-rename that checks for renames of
-individual files is aggregated and analyzed in merge-recursive for cases
-where combinations of renames indicate that a full directory has been
-renamed.
+individual files is also aggregated there and then analyzed in either
+merge-ort or merge-recursive for cases where combinations of renames
+indicate that a full directory has been renamed.
 
 Scope of abilities
 ------------------
@@ -88,9 +88,11 @@ directory rename detection support in:
     Folks have requested in the past that `git diff` detect directory
     renames and somehow simplify its output.  It is not clear whether this
     would be desirable or how the output should be simplified, so this was
-    simply not implemented.  Further, to implement this, directory rename
-    detection logic would need to move from merge-recursive to
-    diffcore-rename.
+    simply not implemented.  Also, while diffcore-rename has most of the
+    logic for detecting directory renames, some of the logic is still found
+    within merge-ort and merge-recursive.  Fully supporting directory
+    rename detection in diffs would require copying or moving the remaining
+    bits of logic to the diff machinery.
 
   * am
 
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
