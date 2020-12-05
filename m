Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A513C4361B
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE5922DFB
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbgLEBrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731109AbgLEBrr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:47:47 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF66C08E85F
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:46:33 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a13so9306733ybj.3
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=47/DYeNU6D8st82KWpNBYJdvhFv5Im0BXbxBiJhbb6M=;
        b=mI0TrZ65mMaQYaw37y8b/kYi7yUCPQapoppj81KFFSddBbylpNNIWe/wSnDLhuulFl
         7liRSobSBc8NlpJ4d2GBbxHQdtZXNfdRaUcmKqc+rBBBj513M8S4hu6xqRCjXmUq5ZPG
         eQb+QKGCre3s2/s+6L1CTzEDMLOGa611546z2QMD34diyu+rZr8g5/IbKohYsHdvtzSB
         e6WDs5tuzq6t8uziEs70gng2WlfEAmhouJ524XsR9PGJfBwCAGIzVcHgafYdfVyy1TxK
         ej66tHmtAL2e7IQIfaeTKOx0Dwn54cuaHiu10bI5CMrng74SdlO+w4RUIWdzySwKI1ej
         HTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=47/DYeNU6D8st82KWpNBYJdvhFv5Im0BXbxBiJhbb6M=;
        b=nQqjZWT9gNx47sLy9GgazjfF5P0BSHI+UFLikhoLgb1l76XfpnU0WTpHAhCfeOa/MN
         j14B0pheAuxEr99Qr5ewpKKRbxwfAKkQKnQ60bmKx898yFkKZE7QGbeXe+kP9cTlrQ9t
         9uvPUKzcfKYskKecZczhDEPVfS9zlyQefP3mikFO30aspKklXjhBIZuSPbvnpt3VodU/
         PFZYETMKN2g0191jx/5z+nw9guPWdoquIr3KSYOr8tM6KEs0QyiPCdTUkj7ndEIeEeVn
         uaMRcymE9NYrk+itskqtHLUDkjqS5SOz8rPb4y+VuWqTvvnw7lb1SynBLDpJ41oOwHvd
         Hm5w==
X-Gm-Message-State: AOAM530gRNlZO3AvdGu2vyfPaHevW7keio84KfSxMPcz2hL9tIUytni6
        PI5spD/uuEHEv8qSKZKvZhHHYZA8/W2teRGRtFA5RCBxdgX7Gb7AGkm6Kuh/DStbDYPXdjgitI3
        Y0AcXWAUpvUehKlOa1bO7a2kt4dDN+MzlFPBCPfSIHLd6eAzy4smYYVo8CeASMw7pKUunZ6MH9Q
        ==
X-Google-Smtp-Source: ABdhPJx0qpDUL31l4Ii15yKAOHkrXccqZNxF5/qFrd5cPTcgHJQj9XRPI3lHITVEQLJd2cpb7ZsSdBTQf+JguLprSFw=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a25:b11e:: with SMTP id
 g30mr10173535ybj.71.1607132793166; Fri, 04 Dec 2020 17:46:33 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:46:00 -0800
In-Reply-To: <20201205014607.1464119-1-emilyshaffer@google.com>
Message-Id: <20201205014607.1464119-11-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014607.1464119-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 10/17] hook: support passing stdin to hooks
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
index 26f7050387..e45831e01d 100644
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
index a7a4abdcac..c7fdf556fe 100644
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
index 94a25c7cd0..5184dcaa5a 100644
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

