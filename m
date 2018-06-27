Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 062FC1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 07:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932646AbeF0HXk (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 03:23:40 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:49706 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932470AbeF0HXi (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 Jun 2018 03:23:38 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5R7JD1i013136;
        Wed, 27 Jun 2018 00:23:22 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ju8sxtfn0-1;
        Wed, 27 Jun 2018 00:23:21 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 87B7D22FD108;
        Wed, 27 Jun 2018 00:23:21 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 7CF192CDE86;
        Wed, 27 Jun 2018 00:23:21 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 1/9] git-rebase.txt: document incompatible options
Date:   Wed, 27 Jun 2018 00:23:11 -0700
Message-Id: <20180627072319.31356-2-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.9.g431b2c36d5
In-Reply-To: <20180627072319.31356-1-newren@gmail.com>
References: <20180625161300.26060-1-newren@gmail.com>
 <20180627072319.31356-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270086
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git rebase has many options that only work with one of its three backends.
It also has a few other pairs of incompatible options.  Document these.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 85 ++++++++++++++++++++++++++++++++----
 1 file changed, 77 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 0e20a66e73..b2d95e3fb9 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -243,11 +243,15 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 --keep-empty::
 	Keep the commits that do not change anything from its
 	parents in the result.
++
+See also INCOMPATIBLE OPTIONS below.
 
 --allow-empty-message::
 	By default, rebasing commits with an empty message will fail.
 	This option overrides that behavior, allowing commits with empty
 	messages to be rebased.
++
+See also INCOMPATIBLE OPTIONS below.
 
 --skip::
 	Restart the rebasing process by skipping the current patch.
@@ -271,6 +275,8 @@ branch on top of the <upstream> branch.  Because of this, when a merge
 conflict happens, the side reported as 'ours' is the so-far rebased
 series, starting with <upstream>, and 'theirs' is the working branch.  In
 other words, the sides are swapped.
++
+See also INCOMPATIBLE OPTIONS below.
 
 -s <strategy>::
 --strategy=<strategy>::
@@ -280,8 +286,10 @@ other words, the sides are swapped.
 +
 Because 'git rebase' replays each commit from the working branch
 on top of the <upstream> branch using the given strategy, using
-the 'ours' strategy simply discards all patches from the <branch>,
+the 'ours' strategy simply empties all patches from the <branch>,
 which makes little sense.
++
+See also INCOMPATIBLE OPTIONS below.
 
 -X <strategy-option>::
 --strategy-option=<strategy-option>::
@@ -289,6 +297,8 @@ which makes little sense.
 	This implies `--merge` and, if no strategy has been
 	specified, `-s recursive`.  Note the reversal of 'ours' and
 	'theirs' as noted above for the `-m` option.
++
+See also INCOMPATIBLE OPTIONS below.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
@@ -324,6 +334,8 @@ which makes little sense.
 	and after each change.  When fewer lines of surrounding
 	context exist they all must match.  By default no context is
 	ever ignored.
++
+See also INCOMPATIBLE OPTIONS below.
 
 -f::
 --force-rebase::
@@ -355,19 +367,22 @@ default is `--no-fork-point`, otherwise the default is `--fork-point`.
 --whitespace=<option>::
 	These flag are passed to the 'git apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
-	Incompatible with the --interactive option.
++
+See also INCOMPATIBLE OPTIONS below.
 
 --committer-date-is-author-date::
 --ignore-date::
 	These flags are passed to 'git am' to easily change the dates
 	of the rebased commits (see linkgit:git-am[1]).
-	Incompatible with the --interactive option.
++
+See also INCOMPATIBLE OPTIONS below.
 
 --signoff::
 	Add a Signed-off-by: trailer to all the rebased commits. Note
 	that if `--interactive` is given then only commits marked to be
-	picked, edited or reworded will have the trailer added. Incompatible
-	with the `--preserve-merges` option.
+	picked, edited or reworded will have the trailer added.
++
+See also INCOMPATIBLE OPTIONS below.
 
 -i::
 --interactive::
@@ -378,6 +393,8 @@ default is `--no-fork-point`, otherwise the default is `--fork-point`.
 The commit list format can be changed by setting the configuration option
 rebase.instructionFormat.  A customized instruction format will automatically
 have the long commit hash prepended to the format.
++
+See also INCOMPATIBLE OPTIONS below.
 
 -r::
 --rebase-merges[=(rebase-cousins|no-rebase-cousins)]::
@@ -404,7 +421,7 @@ It is currently only possible to recreate the merge commits using the
 `recursive` merge strategy; Different merge strategies can be used only via
 explicit `exec git merge -s <strategy> [...]` commands.
 +
-See also REBASING MERGES below.
+See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
 
 -p::
 --preserve-merges::
@@ -415,6 +432,8 @@ See also REBASING MERGES below.
 This uses the `--interactive` machinery internally, but combining it
 with the `--interactive` option explicitly is generally not a good
 idea unless you know what you are doing (see BUGS below).
++
+See also INCOMPATIBLE OPTIONS below.
 
 -x <cmd>::
 --exec <cmd>::
@@ -437,6 +456,8 @@ squash/fixup series.
 +
 This uses the `--interactive` machinery internally, but it can be run
 without an explicit `--interactive`.
++
+See also INCOMPATIBLE OPTIONS below.
 
 --root::
 	Rebase all commits reachable from <branch>, instead of
@@ -447,6 +468,8 @@ without an explicit `--interactive`.
 	When used together with both --onto and --preserve-merges,
 	'all' root commits will be rewritten to have <newbase> as parent
 	instead.
++
+See also INCOMPATIBLE OPTIONS below.
 
 --autosquash::
 --no-autosquash::
@@ -461,11 +484,11 @@ without an explicit `--interactive`.
 	too.  The recommended way to create fixup/squash commits is by using
 	the `--fixup`/`--squash` options of linkgit:git-commit[1].
 +
-This option is only valid when the `--interactive` option is used.
-+
 If the `--autosquash` option is enabled by default using the
 configuration variable `rebase.autoSquash`, this option can be
 used to override and disable this setting.
++
+See also INCOMPATIBLE OPTIONS below.
 
 --autostash::
 --no-autostash::
@@ -487,6 +510,52 @@ recreates the topic branch with fresh commits so it can be remerged
 successfully without needing to "revert the reversion" (see the
 link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for details).
 
+INCOMPATIBLE OPTIONS
+--------------------
+
+git-rebase has many flags that are incompatible with each other,
+predominantly due to the fact that it has three different underlying
+implementations:
+
+ * one based on linkgit:git-am[1] (the default)
+ * one based on git-merge-recursive (merge backend)
+ * one based on linkgit:git-cherry-pick[1] (interactive backend)
+
+Flags only understood by the am backend:
+
+ * --committer-date-is-author-date
+ * --ignore-date
+ * --whitespace
+ * --ignore-whitespace
+ * -C
+
+Flags understood by both merge and interactive backends:
+
+ * --merge
+ * --strategy
+ * --strategy-option
+ * --allow-empty-message
+
+Flags only understood by the interactive backend:
+
+ * --[no-]autosquash
+ * --rebase-merges
+ * --preserve-merges
+ * --interactive
+ * --exec
+ * --keep-empty
+ * --autosquash
+ * --edit-todo
+ * --root when used in combination with --onto
+
+Other incompatible flag pairs:
+
+ * --preserve-merges and --interactive
+ * --preserve-merges and --signoff
+ * --preserve-merges and --rebase-merges
+ * --rebase-merges and --strategy
+ * --rebase-merges and --strategy-option
+
 include::merge-strategies.txt[]
 
 NOTES
-- 
2.18.0.9.g431b2c36d5

