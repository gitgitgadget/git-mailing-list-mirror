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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588FBC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 01:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D5C560EFF
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 01:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhHCBQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 21:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbhHCBQi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 21:16:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AE9C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 18:16:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c9so3177905wri.8
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 18:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6kSMPTcrwo9AyRcFDQzj4q4qR5SuoL3Nucig/Alfxz0=;
        b=aPauJRjiA5vpl+TsQ/uA+S6gQk8+A37gQA4jk6BmgVOL2covCz+YXEHchNhJK0+PdW
         6El9xcEyPSAl5kQoSmPY2Po7zorg9k2o5iHZQH5w3mXspAaQ0GNseSl9V9JQjD00r8eJ
         RzTzXLbk8K6xW+L/zXVwujyl2d/Osy8KjCVrhOivUdAKBQA8I6Lr+eofa1iOzoRybfON
         5LPQmK024C0jmIzRxIR34TpZ/3DtQwqQcZMtQU0QqQcZWE1qtXZMAMpXD8nrWTHvIb9M
         oBfBqgfcP1xsVnUR82/0AIFggLl1gTn8f6xmiCnuuoCsBsFSeX8i6rk48u0nplGw7OHv
         1yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6kSMPTcrwo9AyRcFDQzj4q4qR5SuoL3Nucig/Alfxz0=;
        b=H6csIR26FCsISZsN1BubpDnFWkv/huJfIIV0y6h8TCPaLmKd/myQHFN9w1PGLw5NyA
         NDHEh2+w53fLhnyEZc5hLkjr4mAT49wJbbncYp1VfBpQ4jfwV6IQ3n6vxpgi4n33I9ei
         S83SDF76zDrfLN+GoezbXkzg/ZHO0JnObW5mBCNXkzQ71XHKxSTWSQUPLhX7Uv3p1LNJ
         YV9OYDzEYxbOjEQkrwPfWEC1E+TjB3S/sj7jJhzy3GF3hljZyQ9nkQVtIqEyn3lYC898
         AcToNQQwckzrmT6W0XoYgrV3dBMH/98z0dplFCyluuozkJ8ktejNzF3CmQznzN7CAUA4
         Cp1w==
X-Gm-Message-State: AOAM531vlBNpVmFZkFB8v9t1XLQCLAeAt3ogLman2FYrre91uyyYn+Gd
        pz/Z6dhei+axM5q1XGQ4EnFkocJExoo=
X-Google-Smtp-Source: ABdhPJxuhGNbtmiNbw+4v61NY5aLiJa+f7fcbZn0XGSLSP+2mNlUgiHJtNkfMeDmXeOzI+DyNulisw==
X-Received: by 2002:a05:6000:18c9:: with SMTP id w9mr17668258wrq.38.1627953385354;
        Mon, 02 Aug 2021 18:16:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j2sm13059210wrd.14.2021.08.02.18.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 18:16:24 -0700 (PDT)
Message-Id: <5d2fd55c580abc2057f2e6fe9f7d9c94748bf8de.1627953383.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1010.v2.git.1627953383.gitgitgadget@gmail.com>
References: <pull.1010.git.1627714877.gitgitgadget@gmail.com>
        <pull.1010.v2.git.1627953383.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 01:16:21 +0000
Subject: [PATCH v2 1/2] [GSOC] cherry-pick: fix bug when used with
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
`delete_cherry_pick_head` to `struct replay_opts`, We can decide whether
to delete CHERRY_PICK_HEAD by setting and checking this flag bit.

Then we split print_advice() into two part: Firstly, print_advice()
will only be responsible for outputting content; Secondly, check if
we set the `delete_cherry_pick_head` flag; if set, delete CHERRY_PICK_HEAD.
In this way, the steps of printing advice and deleting CHERRY_PICK_HEAD
are decoupled. Finally, let `git-rebase--preserve-merges.sh` use the
`--delete-cherry-pick-head` option when it executes git cherry-pick, and
set the `delete_cherry_pick_head` flag in get_replay_opts() when we
are using `git rebase --merge`, which can fix this breakage.

It is worth mentioning that now we use advice() to print the content
of GIT_CHERRY_PICK_HELP in print_advice(), each line of output will
start with "hint: ".

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by Hariom Verma <hariom18599@gmail.com>:
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Hepled-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/rebase.c                |  1 +
 builtin/revert.c                |  2 ++
 git-rebase--preserve-merges.sh  |  2 +-
 sequencer.c                     | 28 +++++++++++++---------------
 sequencer.h                     |  1 +
 t/t3507-cherry-pick-conflict.sh | 31 +++++++++++++++++++++----------
 6 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 12f093121d9..08ba437c6a0 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -152,6 +152,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 		oidcpy(&replay.squash_onto, opts->squash_onto);
 		replay.have_squash_onto = 1;
 	}
+	replay.delete_cherry_pick_head = 1;
 
 	return replay;
 }
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
index 014001b8f32..af5678d981a 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -76,12 +76,33 @@ test_expect_success 'advice from failed cherry-pick --no-commit' "
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
 	test_cmp_rev picked CHERRY_PICK_HEAD
 '
 
+test_expect_success 'failed cherry-pick with --delete-cherry-pick-head does not set CHERRY_PICK_HEAD' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick --delete-cherry-pick-head picked &&
+	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
+'
+
 test_expect_success 'successful cherry-pick does not set CHERRY_PICK_HEAD' '
 	pristine_detach initial &&
 	git cherry-pick base &&
@@ -109,16 +130,6 @@ test_expect_success \
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

