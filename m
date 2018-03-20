Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1D081F42D
	for <e@80x24.org>; Tue, 20 Mar 2018 11:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeCTLLV (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 07:11:21 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:16306 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752628AbeCTLLO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 07:11:14 -0400
Received: from lindisfarne.localdomain ([92.22.3.164])
        by smtp.talktalk.net with SMTP
        id yFAYeoeajwheayFAeepoFm; Tue, 20 Mar 2018 11:11:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521544273;
        bh=9KdnT1fS+gV+uFbF7p1OOvXyIh238ZPqSIg66To4nwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=JrGF+FIJJVqWe/Cqw2f3GB0GTvJylJn7+RcGywy+v/Usx/lb0n7naX5VvjXs3KtQ+
         BAMlst60BZj5eo9hHT9GFFHFUX+mp0fV371uh99+vhC9OMErWJHnZdD4R9qjENXYgi
         DtXDTIdR4eCNB73xdEyJG1jxs/PDac27pezdmsZ4=
X-Originating-IP: [92.22.3.164]
X-Spam: 0
X-OAuthority: v=2.3 cv=ZJr5Z0zb c=1 sm=1 tr=0 a=8UrjQVoXl1ilnsKy4/PEMg==:117
 a=8UrjQVoXl1ilnsKy4/PEMg==:17 a=evINK-nbAAAA:8 a=sW59P6hv9-_NujOGvUMA:9
 a=ojwu8X5-_Dw5Cm9R:21 a=qukdew2zJGDNADtD:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 1/3] rebase: extend --signoff support
Date:   Tue, 20 Mar 2018 11:10:55 +0000
Message-Id: <20180320111057.23862-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320111057.23862-1-phillip.wood@talktalk.net>
References: <20180314111127.14217-1-phillip.wood@talktalk.net>
 <20180320111057.23862-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfHWM/4lw08k95qFtYbD/oZEfLYw4Zj29+70rehODscj0eLpvuRq4J1tgc3nr9myqQASoqaB8S+YAJK/94NBu3RURAdBf4YP+5dkQnsJ2xwLhI/rtrwQ0
 Gmr5YkFv1TUZdRcZ8VHSNb7JCtHavrtmrw4/0NqlIk0hkzdBHkkJf4zemvheEehdQRDx5boEBtWLi7YxajX7dbwWerQdol2JlPVjLFxLNFx6yVIXuovQH3LB
 T0LjIZLOic4AVfCOgOMtGM+LRHTHtu4LSvypBllF4odX7W4z/9RuOhg4OkaFisoc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Allow --signoff to be used with --interactive and --merge. In
interactive mode only commits marked to be picked, edited or reworded
will be signed off.

The main motivation for this patch was to allow one to run 'git rebase
--exec "make check" --signoff' which is useful when preparing a patch
series for publication and is more convenient than doing the signoff
with another --exec command.

This change also allows --root without --onto to work with --signoff
as well (--root with --onto was already supported).

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    changes since v1:
     - added support for --signoff with --interactive and --merge
     - split out the --preserve-merges test into the next commit
     - updated the documentation for --signoff
     - reworded commit message to reflect above changes

 Documentation/git-rebase.txt |  7 ++++---
 git-rebase--interactive.sh   |  6 +++---
 git-rebase--merge.sh         |  2 +-
 git-rebase.sh                | 20 +++++++++++++++++++-
 sequencer.c                  |  8 +++++++-
 t/t3428-rebase-signoff.sh    | 38 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 3277ca1432..dd852068b1 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -364,9 +364,10 @@ default is `--no-fork-point`, otherwise the default is `--fork-point`.
 	Incompatible with the --interactive option.
 
 --signoff::
-	This flag is passed to 'git am' to sign off all the rebased
-	commits (see linkgit:git-am[1]). Incompatible with the
-	--interactive option.
+	Add a Signed-off-by: trailer to all the rebased commits. Note
+	that if `--interactive` is given then only commits marked to be
+	picked, edited or reworded will have the trailer added. Incompatible
+	with the `--preserve-merges` option.
 
 -i::
 --interactive::
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 331c8dfeac..104de328ee 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -285,7 +285,7 @@ pick_one () {
 		pick_one_preserving_merges "$@" && return
 	output eval git cherry-pick $allow_rerere_autoupdate $allow_empty_message \
 			${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
-			"$strategy_args" $empty_args $ff "$@"
+			$signoff "$strategy_args" $empty_args $ff "$@"
 
 	# If cherry-pick dies it leaves the to-be-picked commit unrecorded. Reschedule
 	# previous task so this commit is not lost.
@@ -527,10 +527,10 @@ do_pick () {
 		# resolve before manually running git commit --amend then git
 		# rebase --continue.
 		git commit --allow-empty --allow-empty-message --amend \
-			   --no-post-rewrite -n -q -C $sha1 &&
+			   --no-post-rewrite -n -q -C $sha1 $signoff &&
 			pick_one -n $sha1 &&
 			git commit --allow-empty --allow-empty-message \
-				   --amend --no-post-rewrite -n -q -C $sha1 \
+				   --amend --no-post-rewrite -n -q -C $sha1 $signoff \
 				   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
 				   die_with_patch $sha1 "$(eval_gettext "Could not apply \$sha1... \$rest")"
 	else
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index ceb715453c..368b63671d 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -28,7 +28,7 @@ continue_merge () {
 	if ! git diff-index --quiet --ignore-submodules HEAD --
 	then
 		if ! git commit ${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message \
-			--no-verify -C "$cmt"
+			$signoff --no-verify -C "$cmt"
 		then
 			echo "Commit failed, please do not call \"git commit\""
 			echo "directly, but instead do one of the following: "
diff --git a/git-rebase.sh b/git-rebase.sh
index a1f6e5de6a..5d854657a7 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -92,6 +92,7 @@ preserve_merges=
 autosquash=
 keep_empty=
 allow_empty_message=
+signoff=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
 case "$(git config --bool commit.gpgsign)" in
 true)	gpg_sign_opt=-S ;;
@@ -121,6 +122,10 @@ read_basic_state () {
 		allow_rerere_autoupdate="$(cat "$state_dir"/allow_rerere_autoupdate)"
 	test -f "$state_dir"/gpg_sign_opt &&
 		gpg_sign_opt="$(cat "$state_dir"/gpg_sign_opt)"
+	test -f "$state_dir"/signoff && {
+		signoff="$(cat "$state_dir"/signoff)"
+		force_rebase=t
+	}
 }
 
 write_basic_state () {
@@ -135,6 +140,7 @@ write_basic_state () {
 	test -n "$allow_rerere_autoupdate" && echo "$allow_rerere_autoupdate" > \
 		"$state_dir"/allow_rerere_autoupdate
 	test -n "$gpg_sign_opt" && echo "$gpg_sign_opt" > "$state_dir"/gpg_sign_opt
+	test -n "$signoff" && echo "$signoff" >"$state_dir"/signoff
 }
 
 output () {
@@ -331,7 +337,13 @@ do
 	--ignore-whitespace)
 		git_am_opt="$git_am_opt $1"
 		;;
-	--committer-date-is-author-date|--ignore-date|--signoff|--no-signoff)
+	--signoff)
+		signoff=--signoff
+		;;
+	--no-signoff)
+		signoff=
+		;;
+	--committer-date-is-author-date|--ignore-date)
 		git_am_opt="$git_am_opt $1"
 		force_rebase=t
 		;;
@@ -465,6 +477,12 @@ then
 	git_format_patch_opt="$git_format_patch_opt --progress"
 fi
 
+if test -n "$signoff"
+then
+	git_am_opt="$git_am_opt $signoff"
+	force_rebase=t
+fi
+
 if test -z "$rebase_root"
 then
 	case "$#" in
diff --git a/sequencer.c b/sequencer.c
index 091bd6bda5..68683edfc1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -127,6 +127,7 @@ static GIT_PATH_FUNC(rebase_path_rewritten_pending,
 static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
 static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
 static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
+static GIT_PATH_FUNC(rebase_path_signoff, "rebase-merge/signoff")
 static GIT_PATH_FUNC(rebase_path_head_name, "rebase-merge/head-name")
 static GIT_PATH_FUNC(rebase_path_onto, "rebase-merge/onto")
 static GIT_PATH_FUNC(rebase_path_autostash, "rebase-merge/autostash")
@@ -1605,7 +1606,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		}
 	}
 
-	if (opts->signoff)
+	if (opts->signoff && !is_fixup(command))
 		append_signoff(&msgbuf, 0, 0);
 
 	if (is_rebase_i(opts) && write_author_script(msg.message) < 0)
@@ -2044,6 +2045,11 @@ static int read_populate_opts(struct replay_opts *opts)
 		if (file_exists(rebase_path_verbose()))
 			opts->verbose = 1;
 
+		if (file_exists(rebase_path_signoff())) {
+			opts->allow_ff = 0;
+			opts->signoff = 1;
+		}
+
 		read_strategy_opts(opts, &buf);
 		strbuf_release(&buf);
 
diff --git a/t/t3428-rebase-signoff.sh b/t/t3428-rebase-signoff.sh
index 2afb564701..f6993b7e14 100755
--- a/t/t3428-rebase-signoff.sh
+++ b/t/t3428-rebase-signoff.sh
@@ -12,6 +12,13 @@ cat >file <<EOF
 a
 EOF
 
+# Expected commit message for initial commit after rebase --signoff
+cat >expected-initial-signed <<EOF
+Initial empty commit
+
+Signed-off-by: $(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/")
+EOF
+
 # Expected commit message after rebase --signoff
 cat >expected-signed <<EOF
 first
@@ -43,4 +50,35 @@ test_expect_success 'rebase --no-signoff does not add a sign-off line' '
 	test_cmp expected-unsigned actual
 '
 
+test_expect_success 'rebase --exec --signoff adds a sign-off line' '
+	test_when_finished "rm exec" &&
+	git commit --amend -m "first" &&
+	git rebase --exec "touch exec" --signoff HEAD^ &&
+	test_path_is_file exec &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	test_cmp expected-signed actual
+'
+
+test_expect_success 'rebase --root --signoff adds a sign-off line' '
+	git commit --amend -m "first" &&
+	git rebase --root --keep-empty --signoff &&
+	git cat-file commit HEAD^ | sed -e "1,/^\$/d" >actual &&
+	test_cmp expected-initial-signed actual &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	test_cmp expected-signed actual
+'
+
+test_expect_success 'rebase -i --signoff fails' '
+	git commit --amend -m "first" &&
+	git rebase -i --signoff HEAD^ &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	test_cmp expected-signed actual
+'
+
+test_expect_success 'rebase -m --signoff fails' '
+	git commit --amend -m "first" &&
+	git rebase -m --signoff HEAD^ &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	test_cmp expected-signed actual
+'
 test_done
-- 
2.16.2

