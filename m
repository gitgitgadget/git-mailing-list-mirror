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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007E8C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C149D23A02
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732003AbgLIUHi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 15:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbgLIUHc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 15:07:32 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB94C0613D6
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 12:06:52 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id y17so3089233wrr.10
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 12:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V5jL6CvthRDOm7VFkTZI+7ymROBsvC8v5TDlobM54nQ=;
        b=h5v98Vu3EDotimjXWeAY0prT1XAQ1mt8S4r32wQ/3kQf3Yfm4L1ZZN5i7EROo+y5P9
         1uL13xwwd2/dZdt2HuZavM6MoSE/OwoAk3e9vCdKQbtBUP87VIgemayL5D2z8e0Nvda2
         Oj0MO80xiVkGlFzdHSRdKlRlE5vrxIsTcwQCcA+q2EZ3443iPuLiE5cPBQhkHzGtSS/y
         98Rj4HIVeKrIeftuvEMJnxUof5AdBKew6+u1GsTfdgKLrOwQetKr6BeFatz2fk7nTTT9
         /3hLqjTUtYSh9F/mzKm+/jpJH3jajFtR4fkZMYL9uWirc4Llfsx4rGyHSlWlimA5TCOg
         C9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V5jL6CvthRDOm7VFkTZI+7ymROBsvC8v5TDlobM54nQ=;
        b=f/xKLYSxNRfNy7i2dmt067mfGFdg+CLGmFzEr9NlCjnie5A4JtyY3CS1JJpWGyrb/o
         76V1B3ZvCR89VY9zfDaPiOg65ddCpyw6fVP8qvV1iPb+yOAQjOksePjjNa+Cn1TYqD6u
         REm4lGsKM08ElKux3QMtgG1za92YnbygctNElTjMrvqe4kvKysiD1Gy+jf5ilNJ3AAnR
         WZI6ZwyJwXJDa0SEb3u4PEIplOjtiJSWMbWAu+CNVceA5c7pF6SBXY0LdTUJwFbeKJzs
         XUGBqW86olu7ZLtCT5Rg7Y4XgSo91imLiTmKtUa+/UsjaB3+dV/NCOb55gDyhV7SRcKN
         My/A==
X-Gm-Message-State: AOAM532gY5Q5Mwq59v4w1UFE/9VdZ609CuLoCez2Rt6Qqe1PTt2rCtp0
        JMvwskVeIXyRKh1VcB/EzUXJ5wf9a8s=
X-Google-Smtp-Source: ABdhPJy35ktkuW69NT5XaIShnHkF4qRM3Gh2/yFIHBONhOMaOEi/HRDG8cIOwQHw7Pyo/RhsJuBL8A==
X-Received: by 2002:a5d:690d:: with SMTP id t13mr4463259wru.410.1607544410653;
        Wed, 09 Dec 2020 12:06:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c81sm5817065wmd.6.2020.12.09.12.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 12:06:50 -0800 (PST)
Message-Id: <27e66d43c833c2e5b8b612e91b6b513076d7fcb7.1607544408.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.790.v5.git.1607544408.gitgitgadget@gmail.com>
References: <pull.790.v4.git.1605819390.gitgitgadget@gmail.com>
        <pull.790.v5.git.1607544408.gitgitgadget@gmail.com>
From:   "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 20:06:47 +0000
Subject: [PATCH v5 1/2] hooks: lay foundations for passing stdin to hooks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Orgad Shaneh <orgads@gmail.com>,
        Orgad Shaneh <orgads@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

Used in the follow-up commit for enabling stdin for commit-related
hooks.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 builtin/commit.c |  8 ++++----
 builtin/merge.c  |  6 +++---
 commit.c         |  4 ++--
 commit.h         |  3 ++-
 run-command.c    |  6 +++---
 run-command.h    | 17 ++++++++++++-----
 sequencer.c      |  4 ++--
 7 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 505fe60956d..70a7842e224 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -699,7 +699,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
 
-	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
+	if (!no_verify && run_commit_hook(use_editor, index_file, 0, "pre-commit", NULL))
 		return 0;
 
 	if (squash_message) {
@@ -998,7 +998,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (run_commit_hook(use_editor, index_file, "prepare-commit-msg",
+	if (run_commit_hook(use_editor, index_file, 0, "prepare-commit-msg",
 			    git_path_commit_editmsg(), hook_arg1, hook_arg2, NULL))
 		return 0;
 
@@ -1015,7 +1015,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	}
 
 	if (!no_verify &&
-	    run_commit_hook(use_editor, index_file, "commit-msg", git_path_commit_editmsg(), NULL)) {
+	    run_commit_hook(use_editor, index_file, 0, "commit-msg", git_path_commit_editmsg(), NULL)) {
 		return 0;
 	}
 
@@ -1701,7 +1701,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	repo_rerere(the_repository, 0);
 	run_auto_maintenance(quiet);
-	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
+	run_commit_hook(use_editor, get_index_file(), 0, "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
 		commit_post_rewrite(the_repository, current_head, &oid);
 	}
diff --git a/builtin/merge.c b/builtin/merge.c
index 1cff7307153..26e6ae15993 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -836,7 +836,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	struct strbuf msg = STRBUF_INIT;
 	const char *index_file = get_index_file();
 
-	if (!no_verify && run_commit_hook(0 < option_edit, index_file, "pre-merge-commit", NULL))
+	if (!no_verify && run_commit_hook(0 < option_edit, index_file, 0, "pre-merge-commit", NULL))
 		abort_commit(remoteheads, NULL);
 	/*
 	 * Re-read the index as pre-merge-commit hook could have updated it,
@@ -864,7 +864,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
 	write_merge_heads(remoteheads);
 	write_file_buf(git_path_merge_msg(the_repository), msg.buf, msg.len);
-	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
+	if (run_commit_hook(0 < option_edit, get_index_file(), 0, "prepare-commit-msg",
 			    git_path_merge_msg(the_repository), "merge", NULL))
 		abort_commit(remoteheads, NULL);
 	if (0 < option_edit) {
@@ -873,7 +873,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	}
 
 	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
-					  "commit-msg",
+					  0, "commit-msg",
 					  git_path_merge_msg(the_repository), NULL))
 		abort_commit(remoteheads, NULL);
 
diff --git a/commit.c b/commit.c
index fe1fa3dc41f..3f5a50164eb 100644
--- a/commit.c
+++ b/commit.c
@@ -1631,7 +1631,7 @@ size_t ignore_non_trailer(const char *buf, size_t len)
 }
 
 int run_commit_hook(int editor_is_used, const char *index_file,
-		    const char *name, ...)
+		    unsigned flags, const char *name, ...)
 {
 	struct strvec hook_env = STRVEC_INIT;
 	va_list args;
@@ -1646,7 +1646,7 @@ int run_commit_hook(int editor_is_used, const char *index_file,
 		strvec_push(&hook_env, "GIT_EDITOR=:");
 
 	va_start(args, name);
-	ret = run_hook_ve(hook_env.v, name, args);
+	ret = run_hook_ve(hook_env.v, flags, name, args);
 	va_end(args);
 	strvec_clear(&hook_env);
 
diff --git a/commit.h b/commit.h
index 5467786c7be..72215d57fb2 100644
--- a/commit.h
+++ b/commit.h
@@ -352,6 +352,7 @@ int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
 int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused);
 
 LAST_ARG_MUST_BE_NULL
-int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
+int run_commit_hook(int editor_is_used, const char *index_file, unsigned flags,
+		    const char *name, ...);
 
 #endif /* COMMIT_H */
diff --git a/run-command.c b/run-command.c
index ea4d0fb4b15..30d69562f43 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1344,7 +1344,7 @@ const char *find_hook(const char *name)
 	return path.buf;
 }
 
-int run_hook_ve(const char *const *env, const char *name, va_list args)
+int run_hook_ve(const char *const *env, unsigned flags, const char *name, va_list args)
 {
 	struct child_process hook = CHILD_PROCESS_INIT;
 	const char *p;
@@ -1357,7 +1357,7 @@ int run_hook_ve(const char *const *env, const char *name, va_list args)
 	while ((p = va_arg(args, const char *)))
 		strvec_push(&hook.args, p);
 	hook.env = env;
-	hook.no_stdin = 1;
+	hook.no_stdin = !(flags & RUN_HOOK_ALLOW_STDIN);
 	hook.stdout_to_stderr = 1;
 	hook.trace2_hook_name = name;
 
@@ -1370,7 +1370,7 @@ int run_hook_le(const char *const *env, const char *name, ...)
 	int ret;
 
 	va_start(args, name);
-	ret = run_hook_ve(env, name, args);
+	ret = run_hook_ve(env, 0, name, args);
 	va_end(args);
 
 	return ret;
diff --git a/run-command.h b/run-command.h
index 6472b38bde4..e613e5e3f92 100644
--- a/run-command.h
+++ b/run-command.h
@@ -201,22 +201,29 @@ int run_command(struct child_process *);
  */
 const char *find_hook(const char *name);
 
+#define RUN_HOOK_ALLOW_STDIN 1
+
 /**
  * Run a hook.
- * The first argument is a pathname to an index file, or NULL
- * if the hook uses the default index file or no index is needed.
- * The second argument is the name of the hook.
+ * The env argument is an array of environment variables, or NULL
+ * if the hook uses the default environment and doesn't require
+ * additional variables.
+ * The flags argument is an OR'ed collection of feature bits like
+ * RUN_HOOK_ALLOW_STDIN defined above, which enables
+ * stdin for the child process (the default is no_stdin).
+ * The name argument is the name of the hook.
  * The further arguments correspond to the hook arguments.
  * The last argument has to be NULL to terminate the arguments list.
  * If the hook does not exist or is not executable, the return
  * value will be zero.
  * If it is executable, the hook will be executed and the exit
  * status of the hook is returned.
- * On execution, .stdout_to_stderr and .no_stdin will be set.
+ * On execution, .stdout_to_stderr will be set, and .no_stdin will be
+ * set unless RUN_HOOK_ALLOW_STDIN flag is requested.
  */
 LAST_ARG_MUST_BE_NULL
 int run_hook_le(const char *const *env, const char *name, ...);
-int run_hook_ve(const char *const *env, const char *name, va_list args);
+int run_hook_ve(const char *const *env, unsigned flags, const char *name, va_list args);
 
 /*
  * Trigger an auto-gc
diff --git a/sequencer.c b/sequencer.c
index 8909a467700..5f48d32e2fa 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1203,7 +1203,7 @@ static int run_prepare_commit_msg_hook(struct repository *r,
 	} else {
 		arg1 = "message";
 	}
-	if (run_commit_hook(0, r->index_file, "prepare-commit-msg", name,
+	if (run_commit_hook(0, r->index_file, 0, "prepare-commit-msg", name,
 			    arg1, arg2, NULL))
 		ret = error(_("'prepare-commit-msg' hook failed"));
 
@@ -1528,7 +1528,7 @@ static int try_to_commit(struct repository *r,
 		goto out;
 	}
 
-	run_commit_hook(0, r->index_file, "post-commit", NULL);
+	run_commit_hook(0, r->index_file, 0, "post-commit", NULL);
 	if (flags & AMEND_MSG)
 		commit_post_rewrite(r, current_head, oid);
 
-- 
gitgitgadget

