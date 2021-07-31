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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C35EC4320E
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 07:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F9936109D
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 07:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhGaHBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 03:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhGaHBa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 03:01:30 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E36C06175F
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 00:01:23 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so5103002wms.2
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 00:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FWZ4z4g9kzwziR5o7EonYSoQUHreWUVGGuwnR3VUYS0=;
        b=b4nekgaDBptRT12+0dq/egItBGt9zYFngTbGfB3uKKqrQQYPTY7KtLhhbfnJoJT02g
         YlAeqzLVwB5bCBcvuhkqFx6PeMdvgKSjz9zKFpKozfRwMRP+iBe771CZuVdp7wk9sKIs
         cNKwbtDOH9hxeJ1iLvQ47UjS+n5R18W6iOW7McLcw5IVatosUi69svGs2RMDcXQzF5nE
         4svOJ+DrVoR4wrcixX5i1qsGLdsmVlxXNAd/n+v/+7HGz8LY6HbeN3cEGs2+1F/ySfmi
         PaAqrLQtY0Ho2Kt8NArHrWUrt51BM53CKHMtAEA6Jo6fOl8ISI9zT9v+7RfyejP+6dbg
         OnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FWZ4z4g9kzwziR5o7EonYSoQUHreWUVGGuwnR3VUYS0=;
        b=Fc0TGP+YAg97WB9D4GaMuFdiu10RHOap1uI//PYagG9He1WVps7BNtJ1MudzEm6vKR
         eCWfqLTXIiftA7PuovLm16UVrWLFZGUCwHCUyloqjdKG8tXecOywkUnai4XL0bL6J65K
         U9cSLs0Y2FRPLgMq+2seSDZerrQhq5c3Jy/jQWQ7ExUa9f9fk0Guf+s1NlEvUlXeon3M
         i21i6r1H/aOPBjkNJqbnyNicSHdxwT/GXIFAC3DnmlZ95m45kwEzBsTvmbeZMnU33hRf
         VfeVR1KYU+ypvNsTIGSy4qKKDMM4IqNCc6NCHD6L2r+97t7cKYViMAoUEAR7mBLtncYn
         4U/A==
X-Gm-Message-State: AOAM530TDF0DGfaIf/5y9SoVm7UWuM6oL3nBAFVbHoeP+eVKwm6G2v97
        1rWbyCU6bZvOGx6v4KWLxMdXocxM1ng=
X-Google-Smtp-Source: ABdhPJyFO6AKOPm2o44ipsVwge8dt0kUhFmmRUOrcVltPkB3+unCTG+d+t1PQhcmlK4NXLwPwyBZOw==
X-Received: by 2002:a05:600c:5114:: with SMTP id o20mr6725454wms.176.1627714881605;
        Sat, 31 Jul 2021 00:01:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1sm3955869wrz.61.2021.07.31.00.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 00:01:21 -0700 (PDT)
Message-Id: <0d0a55bd9c4094450749fa20a30d0d11203768d6.1627714878.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1010.git.1627714877.gitgitgadget@gmail.com>
References: <pull.1010.git.1627714877.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 31 Jul 2021 07:01:16 +0000
Subject: [PATCH 1/2] [GSOC] cherry-pick: fix bug when used with
 GIT_CHERRY_PICK_HELP
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

GIT_CHERRY_PICK_HELP is an environment variable, as the
implementation detail of some porcelain in git to help realize
the rebasing steps. E.g. `git rebase -p` set GIT_CHERRY_PICK_HELP
value in `git-rebase--preserve-merges.sh`, `git rebase --merge` set
GIT_CHERRY_PICK_HELP value in run_specific_rebase(). But If we set
the value of GIT_CHERRY_PICK_HELP when using `git cherry-pick`,
CHERRY_PICK_HEAD will be deleted, then we will get an error when we
try to use `git cherry-pick --continue` or other cherr-pick command.

Introduce new "hidden" option `--delete-cherry-pick-head` for git
cherry-pick which indicates that CHERRY_PICK_HEAD will be deleted when
conflict occurs, which provided for some porcelain commands of git like
`git-rebase--preserve-merges.sh`. After `git rebase -p` completely
abolished, this option should be removed. At the same time, add the flag
`delete_cherry_pick_head` to `struct rebase_options` and
`struct replay_opts`, We can decide whether to delete CHERRY_PICK_HEAD
by setting, passing, and checking this flag bit.

Then we split print_advice() into two part: Firstly, print_advice()
will only be responsible for outputting content; Secondly, check if
we set the `delete_cherry_pick_head` flag; if set, delete CHERRY_PICK_HEAD.
In this way, the steps of printing advice and deleting CHERRY_PICK_HEAD
are decoupled. Finally, let `git-rebase--preserve-merges.sh` use the
`--delete-cherry-pick-head` option when it executes git cherry-pick, and
set the `delete_cherry_pick_head` flag in run_specific_rebase() when we
are using `git rebase --merge`, which can fix this breakage.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by Hariom Verma <hariom18599@gmail.com>:
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Hepled-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/rebase.c                |  3 +++
 builtin/revert.c                |  2 ++
 git-rebase--preserve-merges.sh  |  2 +-
 sequencer.c                     | 28 +++++++++++++---------------
 sequencer.h                     |  1 +
 t/t3507-cherry-pick-conflict.sh | 25 +++++++++++++++----------
 6 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 12f093121d9..5983f37d531 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -84,6 +84,7 @@ struct rebase_options {
 		REBASE_FORCE = 1<<3,
 		REBASE_INTERACTIVE_EXPLICIT = 1<<4,
 	} flags;
+	int delete_cherry_pick_head;
 	struct strvec git_am_opts;
 	const char *action;
 	int signoff;
@@ -152,6 +153,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 		oidcpy(&replay.squash_onto, opts->squash_onto);
 		replay.have_squash_onto = 1;
 	}
+	replay.delete_cherry_pick_head = opts->delete_cherry_pick_head;
 
 	return replay;
 }
@@ -948,6 +950,7 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 	if (opts->type == REBASE_MERGE) {
 		/* Run sequencer-based rebase */
 		setenv("GIT_CHERRY_PICK_HELP", resolvemsg, 1);
+		opts->delete_cherry_pick_head = 1;
 		if (!(opts->flags & REBASE_INTERACTIVE_EXPLICIT)) {
 			setenv("GIT_SEQUENCE_EDITOR", ":", 1);
 			opts->autosquash = 0;
diff --git a/builtin/revert.c b/builtin/revert.c
index 237f2f18d4c..15a4b6fe4ee 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -127,6 +127,8 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 			OPT_BOOL(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
 			OPT_BOOL(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
 			OPT_BOOL(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
+			OPT_BOOL_F(0, "delete-cherry-pick-head", &opts->delete_cherry_pick_head,
+				   N_("delete CHERRY_PICK_HEAD when conflict occurs"), PARSE_OPT_HIDDEN),
 			OPT_END(),
 		};
 		options = parse_options_concat(options, cp_extra);
diff --git a/git-rebase--preserve-merges.sh b/git-rebase--preserve-merges.sh
index b9c71d2a71b..eaa8f9de2c5 100644
--- a/git-rebase--preserve-merges.sh
+++ b/git-rebase--preserve-merges.sh
@@ -444,7 +444,7 @@ pick_one_preserving_merges () {
 			output eval git cherry-pick $allow_rerere_autoupdate \
 				$allow_empty_message \
 				${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
-				"$strategy_args" "$@" ||
+				"$strategy_args" --delete-cherry-pick-head "$@" ||
 				die_with_patch $sha1 "$(eval_gettext "Could not pick \$sha1")"
 			;;
 		esac
diff --git a/sequencer.c b/sequencer.c
index 0bec01cf38e..83cf6a5da3c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -397,24 +397,13 @@ static void free_message(struct commit *commit, struct commit_message *msg)
 	unuse_commit_buffer(commit, msg->message);
 }
 
-static void print_advice(struct repository *r, int show_hint,
-			 struct replay_opts *opts)
+static void print_advice(struct replay_opts *opts, int show_hint)
 {
 	char *msg = getenv("GIT_CHERRY_PICK_HELP");
 
 	if (msg) {
-		fprintf(stderr, "%s\n", msg);
-		/*
-		 * A conflict has occurred but the porcelain
-		 * (typically rebase --interactive) wants to take care
-		 * of the commit itself so remove CHERRY_PICK_HEAD
-		 */
-		refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
-				NULL, 0);
-		return;
-	}
-
-	if (show_hint) {
+		advise("%s\n", msg);
+	} else if (show_hint) {
 		if (opts->no_commit)
 			advise(_("after resolving the conflicts, mark the corrected paths\n"
 				 "with 'git add <paths>' or 'git rm <paths>'"));
@@ -2265,7 +2254,16 @@ static int do_pick_commit(struct repository *r,
 		      ? _("could not revert %s... %s")
 		      : _("could not apply %s... %s"),
 		      short_commit_name(commit), msg.subject);
-		print_advice(r, res == 1, opts);
+		print_advice(opts, res == 1);
+		if (opts->delete_cherry_pick_head) {
+			/*
+			 * A conflict has occurred but the porcelain
+			 * (typically rebase --interactive) wants to take care
+			 * of the commit itself so remove CHERRY_PICK_HEAD
+			 */
+			refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
+					NULL, 0);
+		}
 		repo_rerere(r, opts->allow_rerere_auto);
 		goto leave;
 	}
diff --git a/sequencer.h b/sequencer.h
index d57d8ea23d7..76fb4af56fd 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -49,6 +49,7 @@ struct replay_opts {
 	int reschedule_failed_exec;
 	int committer_date_is_author_date;
 	int ignore_date;
+	int delete_cherry_pick_head;
 
 	int mainline;
 
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 014001b8f32..f17621d1915 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -76,6 +76,21 @@ test_expect_success 'advice from failed cherry-pick --no-commit' "
 	test_cmp expected actual
 "
 
+test_expect_success 'advice from failed cherry-pick with GIT_CHERRY_PICK_HELP' "
+	pristine_detach initial &&
+	(
+		picked=\$(git rev-parse --short picked) &&
+		cat <<-EOF >expected &&
+		error: could not apply \$picked... picked
+		hint: and then do something else
+		EOF
+		GIT_CHERRY_PICK_HELP='and then do something else' &&
+		export GIT_CHERRY_PICK_HELP &&
+		test_must_fail git cherry-pick picked 2>actual &&
+		test_cmp expected actual
+	)
+"
+
 test_expect_success 'failed cherry-pick sets CHERRY_PICK_HEAD' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick picked &&
@@ -109,16 +124,6 @@ test_expect_success \
 	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
 '
 
-test_expect_success 'GIT_CHERRY_PICK_HELP suppresses CHERRY_PICK_HEAD' '
-	pristine_detach initial &&
-	(
-		GIT_CHERRY_PICK_HELP="and then do something else" &&
-		export GIT_CHERRY_PICK_HELP &&
-		test_must_fail git cherry-pick picked
-	) &&
-	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
-'
-
 test_expect_success 'git reset clears CHERRY_PICK_HEAD' '
 	pristine_detach initial &&
 
-- 
gitgitgadget

