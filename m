Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA5BC43381
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B587722AED
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgLVADv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgLVADt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:03:49 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF10C0611CC
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:44 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id j24so9340605qvg.8
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hqBG27AjgoiYQ8SVuvV/IoKUFszFAUAXY6rgXEtHHxY=;
        b=DFR8SSpn4LyDLhPk6hrLum+hDl3dAbg0ohOZTYuKrtQQQTabpukPL1uoRtXTtjLu3m
         Yj/pNH9qiPoE0EoieRyIrSOdQ2aEu1wtj9SAfOI4S7rOt57mdK1/qmD5sn+OF6eiatq5
         7hc5SEejVNOSYOZPB0zA354+qfeLc/oGLleZHdI3/eW45J8nRqJ1RE/JZjaiSZgZCKs+
         6fi/usPHgFaVg34O6BdMqSBsQtT4AeNc7tsR5dNf8mZxWdhdbQSL9vPaKFpHRCk5TC/c
         TaHGa08QxRq2sdSUVVXp0A/tQ2+mon8FZxasEzW1CUXPa3gcck8yVbu58iukPgLoeqba
         h8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hqBG27AjgoiYQ8SVuvV/IoKUFszFAUAXY6rgXEtHHxY=;
        b=kw5o7qLcqyTAhljR/NNm+cyTN5Y6GotIVLIgAC6EhFCRcTVRWyNNwIfG6ZqWwfteD7
         VX4NeKZR82EKKnsbH8oFKfMToMecuMbVUjeOTEMnLEbk9miVtagx/K5UsnnWD5tN2NFB
         q0ZexvTBkLTEwPgGqvuQjInZUb+2jnZTuRINHsMR7SYg10NBdMZJJbY4e5ua7LdjORsP
         nb2rcOCfdy2/EPjIHE8G7689awBq2xEhaslZNhsOZpHr782Xt4Rr1KG+eYgLG2cIcYtK
         cI6B+MKPqweZ88fWIfn/vtPk+6HwcNlnnD6Q7GIrm45thIhXNgGutMAmdh5aLX7PISnp
         uX4g==
X-Gm-Message-State: AOAM531ut+qH5nL83LXj93bqaDDCzk48Fx06HdtxBHzyemJ7CqNQFaOs
        Du3/PjlTubT1qeNma0Vdd0iY26/160BS6+Kg2KdUX80zaWQTCeREGakUYeSRPI5wR2luHkWKWAK
        ngbz2VzDnfPT40rayUdWQvDvq9AY52Talla+dQ6wDtJoqoFHiiEr7vawW6eY6iL6vX68zzQMeAg
        ==
X-Google-Smtp-Source: ABdhPJzTlW/r12a1SenaeSMiydoaavVRaIzlngsrUR4XPt+tLpKOExIFCmxvnkS4zBJ3dFDW9Zzcm3e3zcoMWjIkUJ4=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:ad4:45a9:: with SMTP id
 y9mr19540991qvu.15.1608595363847; Mon, 21 Dec 2020 16:02:43 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:02:13 -0800
In-Reply-To: <20201222000220.1491091-1-emilyshaffer@google.com>
Message-Id: <20201222000220.1491091-11-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000220.1491091-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v7 10/17] hook: support passing stdin to hooks
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some hooks (such as post-rewrite) need to take input via stdin.
Previously, callers provided stdin to hooks by setting
run-command.h:child_process.in, which takes a FD. Callers would open the
file in question themselves before calling run-command(). However, since
we will now need to seek to the front of the file and read it again for
every hook which runs, hook.h:run_command() takes a path and handles FD
management itself. Since this file is opened for read only, it should
not prevent later parallel execution support.

On the frontend, this is supported by asking for a file path, rather
than by reading stdin. Reading directly from stdin would involve caching
the entire stdin (to memory or to disk) and reading it back from the
beginning to each hook. We'd want to support cases like insufficient
memory or storage for the file. While this may prove useful later, for
now the path of least resistance is to just ask the user to make this
interim file themselves.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-hook.txt    | 11 +++++++++--
 builtin/hook.c                |  5 ++++-
 hook.c                        |  7 ++++++-
 hook.h                        |  9 +++++++--
 t/t1360-config-based-hooks.sh | 24 ++++++++++++++++++++++++
 5 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 18a817d832..cce30a80d0 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -9,7 +9,8 @@ SYNOPSIS
 --------
 [verse]
 'git hook' list <hook-name>
-'git hook' run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] <hook-name>
+'git hook' run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] [--to-stdin=<path>]
+	<hook-name>
 
 DESCRIPTION
 -----------
@@ -65,7 +66,7 @@ in the order they should be run, and print the config scope where the relevant
 `hook.<hook-name>.command` was specified, not the `hookcmd` (if applicable).
 This output is human-readable and the format is subject to change over time.
 
-run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] `<hook-name>`::
+run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] [--to-stdin=<path>] `<hook-name>`::
 
 Runs hooks configured for `<hook-name>`, in the same order displayed by `git
 hook list`. Hooks configured this way are run prepended with `sh -c`, so paths
@@ -91,6 +92,12 @@ Specify arguments to pass to every hook that is run.
 +
 Specify environment variables to set for every hook that is run.
 
+--to-stdin::
+	Only valid for `run`.
++
+Specify a file which will be streamed into stdin for every hook that is run.
+Each hook will receive the entire file from beginning to EOF.
+
 CONFIGURATION
 -------------
 include::config/hook.txt[]
diff --git a/builtin/hook.c b/builtin/hook.c
index 07ba00e07a..be104f2938 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -9,7 +9,8 @@
 
 static const char * const builtin_hook_usage[] = {
 	N_("git hook list <hookname>"),
-	N_("git hook run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] <hookname>"),
+	N_("git hook run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...]"
+	   "[--to-stdin=<path>] <hookname>"),
 	NULL
 };
 
@@ -97,6 +98,8 @@ static int run(int argc, const char **argv, const char *prefix)
 			   N_("environment variables for hook to use")),
 		OPT_STRVEC('a', "arg", &opt.args, N_("args"),
 			   N_("argument to pass to hook")),
+		OPT_STRING(0, "to-stdin", &opt.path_to_stdin, N_("path"),
+			   N_("file to read into hooks' stdin")),
 		OPT_END(),
 	};
 
diff --git a/hook.c b/hook.c
index fbb69706d8..ce5c443206 100644
--- a/hook.c
+++ b/hook.c
@@ -263,8 +263,13 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options)
 		struct child_process hook_proc = CHILD_PROCESS_INIT;
 		struct hook *hook = list_entry(pos, struct hook, list);
 
+		/* reopen the file for stdin; run_command closes it. */
+		if (options->path_to_stdin)
+			hook_proc.in = xopen(options->path_to_stdin, O_RDONLY);
+		else
+			hook_proc.no_stdin = 1;
+
 		hook_proc.env = options->env.v;
-		hook_proc.no_stdin = 1;
 		hook_proc.stdout_to_stderr = 1;
 		hook_proc.trace2_hook_name = hook->command.buf;
 		hook_proc.use_shell = 1;
diff --git a/hook.h b/hook.h
index 762b6fadad..e22a6db832 100644
--- a/hook.h
+++ b/hook.h
@@ -51,11 +51,15 @@ struct run_hooks_opt
 	 * to be overridden if the user can override it at the command line.
 	 */
 	enum hookdir_opt run_hookdir;
+
+	/* Path to file which should be piped to stdin for each hook */
+	const char *path_to_stdin;
 };
 
 #define RUN_HOOKS_OPT_INIT  {   		\
-	.env = STRVEC_INIT, 				\
+	.env = STRVEC_INIT, 			\
 	.args = STRVEC_INIT, 			\
+	.path_to_stdin = NULL,			\
 	.run_hookdir = configured_hookdir_opt()	\
 }
 
@@ -73,7 +77,8 @@ int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir);
 
 /*
  * Runs all hooks associated to the 'hookname' event in order. Each hook will be
- * passed 'env' and 'args'.
+ * passed 'env' and 'args'. The file at 'stdin_path' will be closed and reopened
+ * for each hook that runs.
  */
 int run_hooks(const char *hookname, struct run_hooks_opt *options);
 
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
index 5b3003d59b..c672269ee4 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -229,4 +229,28 @@ test_expect_success 'out-of-repo runs excluded' '
 	nongit test_must_fail git hook run pre-commit
 '
 
+test_expect_success 'stdin to multiple hooks' '
+	git config --add hook.test.command "xargs -P1 -I% echo a%" &&
+	git config --add hook.test.command "xargs -P1 -I% echo b%" &&
+	test_when_finished "test_unconfig hook.test.command" &&
+
+	cat >input <<-EOF &&
+	1
+	2
+	3
+	EOF
+
+	cat >expected <<-EOF &&
+	a1
+	a2
+	a3
+	b1
+	b2
+	b3
+	EOF
+
+	git hook run --to-stdin=input test 2>actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.28.0.rc0.142.g3c755180ce-goog

