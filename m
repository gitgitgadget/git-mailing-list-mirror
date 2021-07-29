Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16EBC432BE
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 12:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7E4E60F02
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 12:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbhG2M16 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 08:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237018AbhG2M1y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 08:27:54 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EE1C0613C1
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 05:27:49 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m12so1915597wru.12
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 05:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6zeMuY93CrD1/Jm0dVrIiq57WY2Od4AkbzSpMT19rzk=;
        b=iu6r2mGlWCDs4jRN75kHPRP4Xy2yMiaQHaFTa00iSXikVfonunQHybbX8l0iC8pV44
         sgHvnXcjpWKUrtp1oqr4zpLUiEffip6J3+4vQ5rI05GNYiQ7OdTdrtx/eVApyMGucL6e
         DSHgaMtDKhUTUHPm2ksUoZTEfd2o7nKYeu3GmxxmlEla7w2KllnS7s9cXVQjnhKBwdgs
         zZxsQ2Jny90uGB22f7gLT+vJSfZ05/IS81oKcswJqkBWgj5dE83Bb4FqBtY1J4AQRlhx
         QOkX3gAEjuiKRCnQUWAP0NBmT5Yu9TNVSNYiszgfJvchwdo8NMc2qe29+K/3EoTnDiOn
         mLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6zeMuY93CrD1/Jm0dVrIiq57WY2Od4AkbzSpMT19rzk=;
        b=cm2pra/fF8wQE/fSxpgZmU3MEgCZTAtRq3jiecg9bwI5akqwOzg08e0HO76yCswRVn
         WdvFcHqSVdmicknuQlYBiL4G+hyLnRfwNzFQLphvYMg/eHI6vnRRU+h+UDMHeLaaiEUs
         nOxRBAD2Mhngk+JxFvDVdZ9tWmW2rwYwCRBykjBf/pBlTUUlDbXYBZyN2K4N2hgSUi0y
         hPXPxU7km0oybnVdO3e5OeYEOJ4c7e98NZ0L5+jKRauqJaBL7b4QJ4viYEkx/u6HKGq2
         fi42taA/9f04ysEJFVfv7RAjyFS70l8uOZ5Uah4URynfEfgezwl70eB+kYPWI8xAMw5T
         AuLA==
X-Gm-Message-State: AOAM531yVRLpD/TSszNIZL2IjEFWOuZVwpjWJIpZKMYFBuAJ5EVArBds
        WDsAdPT+2abMipevbd5YQtRL8pClZBE=
X-Google-Smtp-Source: ABdhPJxiGYZNV5KY6cRDpNfTWOV4jbKkXcb6TWXFCobI82aeGP7TeVtXNsAqCq5zuZCVA2j3sFGTZA==
X-Received: by 2002:adf:e550:: with SMTP id z16mr4828820wrm.250.1627561668509;
        Thu, 29 Jul 2021 05:27:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x21sm5439056wmi.46.2021.07.29.05.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 05:27:48 -0700 (PDT)
Message-Id: <5c5ec310b9230ee19bde4b3c8733b359d5218b32.1627561665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1007.git.1627561665.gitgitgadget@gmail.com>
References: <pull.1007.git.1627561665.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Jul 2021 12:27:43 +0000
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
value in git-rebase--preserve-merges.sh. But If we set the value
of GIT_CHERRY_PICK_HELP when using `git cherry-pick`, CHERRY_PICK_HEAD
will be deleted, then we will get an error when we try to use
`git cherry-pick --continue` or other cherr-pick command.

Introduce new "hidden" option --rebase-preserve-merges-mode for git
cherry-pick which indicates that git cherry-pick is currently called by
git-rebase--preserve-merges.sh. After `git rebase -p` completely
abolished, this option should be removed.

And then we split print_advice() into two part:
check_need_delete_cherry_pick_head() check if we set
GIT_CHERRY_PICK_HELP, if set, delete CHERRY_PICK_HEAD and return
GIT_CHERRY_PICK_HELP's value, if not set, return NULL; The parameters
of print_advice() have changed, which now accept a
`struct replay_opts *opt` and a `const char *help_msgs`. We can pass
the value of GIT_CHERRY_PICK_HELP into print_advice(), and output it.
In this way, the steps of printing advice and checking
GIT_CHERRY_PICK_HELP are decoupled.

Finally, avoid deleting CHERRY_PICK_HEAD when we are truly
cherry-picking, which can fix this breakage.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by Hariom Verma <hariom18599@gmail.com>:
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Hepled-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/revert.c                |  2 ++
 git-rebase--preserve-merges.sh  |  2 +-
 sequencer.c                     | 36 ++++++++++++++++++++-------------
 sequencer.h                     |  1 +
 t/t3507-cherry-pick-conflict.sh | 27 ++++++++++++++++---------
 5 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 237f2f18d4c..6165bb10143 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -127,6 +127,8 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 			OPT_BOOL(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
 			OPT_BOOL(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
 			OPT_BOOL(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
+			OPT_BOOL_F(0, "rebase-preserve-merges-mode", &opts->rebase_preserve_merges_mode,
+				   N_("use for git-rebase--preserve-merges backend"), PARSE_OPT_HIDDEN),
 			OPT_END(),
 		};
 		options = parse_options_concat(options, cp_extra);
diff --git a/git-rebase--preserve-merges.sh b/git-rebase--preserve-merges.sh
index b9c71d2a71b..ca97d9b6539 100644
--- a/git-rebase--preserve-merges.sh
+++ b/git-rebase--preserve-merges.sh
@@ -444,7 +444,7 @@ pick_one_preserving_merges () {
 			output eval git cherry-pick $allow_rerere_autoupdate \
 				$allow_empty_message \
 				${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
-				"$strategy_args" "$@" ||
+				"$strategy_args" --rebase-preserve-merges-mode "$@" ||
 				die_with_patch $sha1 "$(eval_gettext "Could not pick \$sha1")"
 			;;
 		esac
diff --git a/sequencer.c b/sequencer.c
index 0bec01cf38e..ceaf73a34df 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -397,13 +397,11 @@ static void free_message(struct commit *commit, struct commit_message *msg)
 	unuse_commit_buffer(commit, msg->message);
 }
 
-static void print_advice(struct repository *r, int show_hint,
-			 struct replay_opts *opts)
+static char *check_need_delete_cherry_pick_head(struct repository *r)
 {
 	char *msg = getenv("GIT_CHERRY_PICK_HELP");
 
 	if (msg) {
-		fprintf(stderr, "%s\n", msg);
 		/*
 		 * A conflict has occurred but the porcelain
 		 * (typically rebase --interactive) wants to take care
@@ -411,18 +409,22 @@ static void print_advice(struct repository *r, int show_hint,
 		 */
 		refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
 				NULL, 0);
-		return;
+		return msg;
 	}
+	return NULL;
+}
 
-	if (show_hint) {
-		if (opts->no_commit)
-			advise(_("after resolving the conflicts, mark the corrected paths\n"
-				 "with 'git add <paths>' or 'git rm <paths>'"));
-		else
-			advise(_("after resolving the conflicts, mark the corrected paths\n"
-				 "with 'git add <paths>' or 'git rm <paths>'\n"
-				 "and commit the result with 'git commit'"));
-	}
+static void print_advice(struct replay_opts *opts, const char *help_msgs)
+{
+	if (help_msgs)
+		advise("%s\n", help_msgs);
+	else if (opts->no_commit)
+		advise(_("after resolving the conflicts, mark the corrected paths\n"
+			 "with 'git add <paths>' or 'git rm <paths>'"));
+	else
+		advise(_("after resolving the conflicts, mark the corrected paths\n"
+			 "with 'git add <paths>' or 'git rm <paths>'\n"
+			 "and commit the result with 'git commit'"));
 }
 
 static int write_message(const void *buf, size_t len, const char *filename,
@@ -2261,11 +2263,17 @@ static int do_pick_commit(struct repository *r,
 		res = -1;
 
 	if (res) {
+		const char *help_msgs = NULL;
+
 		error(command == TODO_REVERT
 		      ? _("could not revert %s... %s")
 		      : _("could not apply %s... %s"),
 		      short_commit_name(commit), msg.subject);
-		print_advice(r, res == 1, opts);
+		if (((opts->action == REPLAY_PICK &&
+		      !opts->rebase_preserve_merges_mode) ||
+		      (help_msgs = check_need_delete_cherry_pick_head(r))) &&
+		      res == 1)
+			print_advice(opts, help_msgs);
 		repo_rerere(r, opts->allow_rerere_auto);
 		goto leave;
 	}
diff --git a/sequencer.h b/sequencer.h
index d57d8ea23d7..5a40b6d8bdc 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -49,6 +49,7 @@ struct replay_opts {
 	int reschedule_failed_exec;
 	int committer_date_is_author_date;
 	int ignore_date;
+	int rebase_preserve_merges_mode;
 
 	int mainline;
 
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 014001b8f32..6f8035399d9 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -76,6 +76,23 @@ test_expect_success 'advice from failed cherry-pick --no-commit' "
 	test_cmp expected actual
 "
 
+test_expect_success 'advice from failed cherry-pick with GIT_CHERRY_PICK_HELP' "
+	pristine_detach initial &&
+	(
+		picked=\$(git rev-parse --short picked) &&
+		cat <<-EOF >expected &&
+		error: could not apply \$picked... picked
+		hint: after resolving the conflicts, mark the corrected paths
+		hint: with 'git add <paths>' or 'git rm <paths>'
+		hint: and commit the result with 'git commit'
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
@@ -109,16 +126,6 @@ test_expect_success \
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

