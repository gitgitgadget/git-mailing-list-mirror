Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 202A51FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 15:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932678AbeARPf4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 10:35:56 -0500
Received: from mout.gmx.net ([212.227.15.18]:53610 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932640AbeARPfv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 10:35:51 -0500
Received: from [10.122.129.233] ([46.142.197.184]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXr3H-1eI8NX10pb-00WplJ; Thu, 18
 Jan 2018 16:35:48 +0100
Date:   Thu, 18 Jan 2018 16:35:48 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 5/8] rebase: introduce the --recreate-merges option
In-Reply-To: <cover.1516225925.git.johannes.schindelin@gmx.de>
Message-ID: <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:nkvre9mMA/MdyaT0yNwfGUsgiLDCcEphjfAcS4WjSfYc8msnFdM
 nyK1CgxkWvvrn+0vu8jsVqc5OQ+bJiw5WuJU41v3xFLlRb0yNbjtssmGDjKEWcyFiGWDym0
 kSJsYhSyGYMyUBEVYhaIBZAvDMNz/TBaHQtxDk7bmwCav48rPyWMq7OOOmiMQ5yYPAxxMy9
 l0/V/4GvY4nmGnn2N9k3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j2CADChV7/E=:hnp765T5P+CPoOR8dfRF7j
 3B9vLCzu20TTf4riwbdSuuKLSe4ij/EfcoV2PWGknQ0a/BOpSQls0HgXQEnIwBL7jKWLB2k5B
 3fxkAhy/p4ZKbMQOtugqpGpS6uHvEKy8hJ/Z7hxa4ML6/pdNrNLKZ5YPLlrjwximC+Mcumbpj
 oxl4/gY4yQ4sOEZYmfCbdMpfWvkWEF+DzV6tvBEOIWYceXsYv2wXmDolovxF/mzICeTorM1pK
 B1uckkZdZrac0DoqYhTPwh/tikOndWm/u6/y0g54uFhWqGMAKoRW3ShNMStLpxd5AkZZmRUTQ
 Ow3r7KYzuTFgiZPMH12wGuCMLdWf+1heYe0LRH8DnMbQU5jR85V2LKP6chhxjKD3rWEqST2OE
 xbhv7hB3SZVJa3bbGp5KWum69Lo6ldBcI0viomaYHUwwAmiq/ArWtY1YgiWB/d0whl2W6Zg0p
 wrGUiIF1snjEgegD1oF4CXw0jnkDH4fy0jdhpNWTd4h0XxPD4hjmsaUhvUFC+dX3IiYx4sQSE
 HrCaxEhRaZVmk1aFMtydV2PDrlH1O3HU+WC/uAE+T80tkEVHP3rUtFk49NnQaJbwKME+/gMue
 NigtrTNGr2Wd+76uSVi314MrO1NrzZi3MsvCsJcHDqx+NbS6MZPTRP2Kg4Uy/Xv3Bvh0+9/vw
 WzCkRHiPEfsxJe6yMJs9cBH8V34DHps/mqC5d5AbeThun5PTeTjVmteJer1uq5cJXma5aOUwC
 Sz4f5Hxx/3ckVt+ic68xL8tBY8HpHIsj85yC5SxIENkJRxDXbK8svEEDgGlicsNXBPug1jEVk
 nnV4qh1gLLxUrnZdelbVz/NucxGUjps5mVWDMLHY3pIMIGt1Pg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once upon a time, this here developer thought: wouldn't it be nice if,
say, Git for Windows' patches on top of core Git could be represented as
a thicket of branches, and be rebased on top of core Git in order to
maintain a cherry-pick'able set of patch series?

The original attempt at an answer was: git rebase --preserve-merges.

However, that experiment was never intended as an interactive option,
and it only piggy-backed on git rebase --interactive because that
command's implementation looked already very, very familiar: it was
designed by the same person who designed --preserve-merges: yours truly.

Some time later, some other developer (I am looking at you, Andreas!
;-)) decided that it would be a good idea to allow --preserve-merges to
be combined with --interactive (with caveats!) and the Git maintainer
(well, the interim Git maintainer during Junio's absence, that is)
agreed, and that is when the glamor of the --preserve-merges design
started to fall apart rather quickly and unglamorously.

The reason? In --preserve-merges mode, the parents of a merge commit (or
for that matter, of *any* commit) were not stated explicitly, but were
*implied* by the commit name passed to the `pick` command.

This made it impossible, for example, to reorder commits. Not to mention
to flatten the branch topology or, deity forbid, to split topic branches
into two.

Alas, these shortcomings also prevented that mode (whose original
purpose was to serve Git for Windows' needs, with the additional hope
that it may be useful to others, too) from serving Git for Windows'
needs.

Five years later, when it became really untenable to have one unwieldy,
big hodge-podge patch series of partly related, partly unrelated patches
in Git for Windows that was rebased onto core Git's tags from time to
time (earning the undeserved wrath of the developer of the ill-fated
git-remote-hg series that first obsoleted Git for Windows' competing
approach, only to be abandoned without maintainer later) was really
untenable, the "Git garden shears" were born [*1*/*2*]: a script,
piggy-backing on top of the interactive rebase, that would first
determine the branch topology of the patches to be rebased, create a
pseudo todo list for further editing, transform the result into a real
todo list (making heavy use of the `exec` command to "implement" the
missing todo list commands) and finally recreate the patch series on
top of the new base commit.

That was in 2013. And it took about three weeks to come up with the
design and implement it as an out-of-tree script. Needless to say, the
implementation needed quite a few years to stabilize, all the while the
design itself proved itself sound.

With this patch, the goodness of the Git garden shears comes to `git
rebase -i` itself. Passing the `--recreate-merges` option will generate
a todo list that can be understood readily, and where it is obvious
how to reorder commits. New branches can be introduced by inserting
`label` commands and calling `merge - <label> <oneline>`. And once this
mode has become stable and universally accepted, we can deprecate the
design mistake that was `--preserve-merges`.

Link *1*:
https://github.com/msysgit/msysgit/blob/master/share/msysGit/shears.sh
Link *2*:
https://github.com/git-for-windows/build-extra/blob/master/shears.sh

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-rebase.txt           |   8 +-
 contrib/completion/git-completion.bash |   2 +-
 git-rebase--interactive.sh             |   1 +
 git-rebase.sh                          |   6 ++
 t/t3430-rebase-recreate-merges.sh      | 146 +++++++++++++++++++++++++++++++++
 5 files changed, 161 insertions(+), 2 deletions(-)
 create mode 100755 t/t3430-rebase-recreate-merges.sh

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 8a861c1e0d6..1d061373288 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -368,6 +368,11 @@ The commit list format can be changed by setting the configuration option
 rebase.instructionFormat.  A customized instruction format will automatically
 have the long commit hash prepended to the format.
 
+--recreate-merges::
+	Recreate merge commits instead of flattening the history by replaying
+	merges. Merge conflict resolutions or manual amendments to merge
+	commits are not preserved.
+
 -p::
 --preserve-merges::
 	Recreate merge commits instead of flattening the history by replaying
@@ -770,7 +775,8 @@ BUGS
 The todo list presented by `--preserve-merges --interactive` does not
 represent the topology of the revision graph.  Editing commits and
 rewording their commit messages should work fine, but attempts to
-reorder commits tend to produce counterintuitive results.
+reorder commits tend to produce counterintuitive results. Use
+--recreate-merges for a more faithful representation.
 
 For example, an attempt to rearrange
 ------------
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3683c772c55..6893c3adabc 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2008,7 +2008,7 @@ _git_rebase ()
 	--*)
 		__gitcomp "
 			--onto --merge --strategy --interactive
-			--preserve-merges --stat --no-stat
+			--recreate-merges --preserve-merges --stat --no-stat
 			--committer-date-is-author-date --ignore-date
 			--ignore-whitespace --whitespace=
 			--autosquash --no-autosquash
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5bf1ea3781f..3459ec5a018 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -900,6 +900,7 @@ fi
 if test t != "$preserve_merges"
 then
 	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
+		${recreate_merges:+--recreate-merges} \
 		$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
 	die "$(gettext "Could not generate todo list")"
 else
diff --git a/git-rebase.sh b/git-rebase.sh
index fd72a35c65b..d69bc7d0e0d 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -17,6 +17,7 @@ q,quiet!           be quiet. implies --no-stat
 autostash          automatically stash/stash pop before and after
 fork-point         use 'merge-base --fork-point' to refine upstream
 onto=!             rebase onto given branch instead of upstream
+recreate-merges!   try to recreate merges instead of skipping them
 p,preserve-merges! try to recreate merges instead of ignoring them
 s,strategy=!       use the given merge strategy
 no-ff!             cherry-pick all commits, even if unchanged
@@ -86,6 +87,7 @@ type=
 state_dir=
 # One of {'', continue, skip, abort}, as parsed from command line
 action=
+recreate_merges=
 preserve_merges=
 autosquash=
 keep_empty=
@@ -262,6 +264,10 @@ do
 	--keep-empty)
 		keep_empty=yes
 		;;
+	--recreate-merges)
+		recreate_merges=t
+		test -z "$interactive_rebase" && interactive_rebase=implied
+		;;
 	--preserve-merges)
 		preserve_merges=t
 		test -z "$interactive_rebase" && interactive_rebase=implied
diff --git a/t/t3430-rebase-recreate-merges.sh b/t/t3430-rebase-recreate-merges.sh
new file mode 100755
index 00000000000..46ae52f88b3
--- /dev/null
+++ b/t/t3430-rebase-recreate-merges.sh
@@ -0,0 +1,146 @@
+#!/bin/sh
+#
+# Copyright (c) 2017 Johannes E. Schindelin
+#
+
+test_description='git rebase -i --recreate-merges
+
+This test runs git rebase "interactively", retaining the branch structure by
+recreating merge commits.
+
+Initial setup:
+
+    -- B --                   (first)
+   /       \
+ A - C - D - E - H            (master)
+       \       /
+         F - G                (second)
+'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+test_expect_success 'setup' '
+	write_script replace-editor.sh <<-\EOF &&
+	mv "$1" "$(git rev-parse --git-path ORIGINAL-TODO)"
+	cp script-from-scratch "$1"
+	EOF
+
+	test_commit A &&
+	git checkout -b first &&
+	test_commit B &&
+	git checkout master &&
+	test_commit C &&
+	test_commit D &&
+	git merge --no-commit B &&
+	test_tick &&
+	git commit -m E &&
+	git tag -m E E &&
+	git checkout -b second C &&
+	test_commit F &&
+	test_commit G &&
+	git checkout master &&
+	git merge --no-commit G &&
+	test_tick &&
+	git commit -m H &&
+	git tag -m H H
+'
+
+cat >script-from-scratch <<\EOF
+label onto
+
+# onebranch
+pick G
+pick D
+label onebranch
+
+# second
+bud
+pick B
+label second
+
+bud
+merge H second
+merge - onebranch Merge the topic branch 'onebranch'
+EOF
+
+test_cmp_graph () {
+	cat >expect &&
+	git log --graph --boundary --format=%s "$@" >output &&
+	sed "s/ *$//" <output >output.trimmed &&
+	test_cmp expect output.trimmed
+}
+
+test_expect_success 'create completely different structure' '
+	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
+	test_tick &&
+	git rebase -i --recreate-merges A &&
+	test_cmp_graph <<-\EOF
+	*   Merge the topic branch '\''onebranch'\''
+	|\
+	| * D
+	| * G
+	* |   H
+	|\ \
+	| |/
+	|/|
+	| * B
+	|/
+	* A
+	EOF
+'
+
+test_expect_success 'generate correct todo list' '
+	cat >expect <<-\EOF &&
+	label onto
+
+	bud
+	pick d9df450 B
+	label E
+
+	bud
+	pick 5dee784 C
+	label branch-point
+	pick ca2c861 F
+	pick 088b00a G
+	label H
+
+	reset branch-point C
+	pick 12bd07b D
+	merge 2051b56 E E
+	merge 233d48a H H
+
+	EOF
+
+	grep -v "^#" <.git/ORIGINAL-TODO >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'with a branch tip that was cherry-picked already' '
+	git checkout -b already-upstream master &&
+	base="$(git rev-parse --verify HEAD)" &&
+
+	test_commit A1 &&
+	test_commit A2 &&
+	git reset --hard $base &&
+	test_commit B1 &&
+	test_tick &&
+	git merge -m "Merge branch A" A2 &&
+
+	git checkout -b upstream-with-a2 $base &&
+	test_tick &&
+	git cherry-pick A2 &&
+
+	git checkout already-upstream &&
+	test_tick &&
+	git rebase -i --recreate-merges upstream-with-a2 &&
+	test_cmp_graph upstream-with-a2.. <<-\EOF
+	*   Merge branch A
+	|\
+	| * A1
+	* | B1
+	|/
+	o A2
+	EOF
+'
+
+test_done
-- 
2.15.1.windows.2.1430.ga56c4f9e2a9


