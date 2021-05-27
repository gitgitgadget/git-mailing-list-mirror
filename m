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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1ADC47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BFC6613BE
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbhE0ALF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbhE0AKy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:10:54 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65105C06175F
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:19 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id h11-20020a0ceecb0000b0290211ed54e716so2566747qvs.9
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g4Md1XkQ5N67CgVq854t25haHVEaoZQdKXfMwtnQtVs=;
        b=L/HgEFUjQr5uh+BvYC6YXjTTNtQgMUgiCTONFyTJx/21jIRYA2CHKlwqPDIIl0yYNt
         gsn967pEeIQoBSDgADJRpCKWuQd+dHSz9mveRb9T0pDNkK9TtQbJYZg8frVpvwmga0Wx
         f7NnojXDZediMFy2AqY966rBIKO2K2NpL1Qac/krVJenVLfJCmcwRdy1Ok41nFo/obH3
         oL0JcuQocBr/NdFLnJWmBbDPzEX96e163EifPtHYa0Xl2uhJ/rGXFXGu17qrP3NjzVGb
         FrCGGflVyWwm3+euWoHG9pRA/zcUsGTkXTwg8IFb14InCNEy4aRIrvdJthK4t6UeTXHD
         lLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g4Md1XkQ5N67CgVq854t25haHVEaoZQdKXfMwtnQtVs=;
        b=e3GM5reOYhwdWIyRvz+LGWSgSMI/1PI8CDx+zIIU+2gQapYp2+P7WyLqP5XlVy6hzq
         bWXVFCITvO5HnvxDRy0dZaFjaNYkCox5QWuym51G1w0hDPS1Bn/++7lBoZ3b6H0TGYIk
         LUhuV2HVX7jubeVcIeZwvNSxazKOzmv/OMeVq26JsTtwRKpqvPH7PO13ZorUuD197cIC
         6IDLa3nO+SBiaTJ+vAkv++Zg33Le2FOquDdau+78roCdcdo8ZbtdWJEr5M1aNmhlxhIV
         VAdZsEmfnEE/ZWNqet4drSzmRVEQfLyycF/sat3NoyAkLiQ/ak6F6jIgSgXX3vH6GQ0r
         TcSQ==
X-Gm-Message-State: AOAM5312+yC6NUu+lPsuU1hX9AtaS+eFY2uQgA4lG9YyK5kmHY3crxtd
        WVUtprhL5IjXl6Eg0winSfwoAe32iQ68mWMkl6H+br7Fy37KOevRRdi6Sm/ylUgeTuQ3YeCbOor
        4mMsDIBhLHsPquVsxMrYRXNWrAntXqcThAxYQyKIf9pVdItkVJAbOZ2kCkhE8MmVLzSXu7sEdQA
        ==
X-Google-Smtp-Source: ABdhPJzCSwoOG9rvxkGKjOvCREz6eAl+azuVJCzguJ1WDHnOQn4tZfSkgS2MopGLCZNSbVAqENNwLVrTM1nCk7B6wns=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:efcf:: with SMTP id
 a15mr1040880qvt.55.1622074158505; Wed, 26 May 2021 17:09:18 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:28 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-10-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 09/37] hook: support passing stdin to hooks
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
 hook.c                        |  8 +++++++-
 hook.h                        |  6 +++++-
 t/t1360-config-based-hooks.sh | 24 ++++++++++++++++++++++++
 5 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 8f96c347ea..96a857c682 100644
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
@@ -98,7 +99,7 @@ in the order they should be run, and print the config scope where the relevant
 `hook.<hook-name>.command` was specified, not the `hookcmd` (if applicable).
 This output is human-readable and the format is subject to change over time.
 
-run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] `<hook-name>`::
+run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] [--to-stdin=<path>] `<hook-name>`::
 
 Runs hooks configured for `<hook-name>`, in the same order displayed by `git
 hook list`. Hooks configured this way may be run prepended with `sh -c`, so
@@ -124,6 +125,12 @@ Specify arguments to pass to every hook that is run.
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
index 4673c9091c..0d9c052e84 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -8,7 +8,8 @@
 
 static const char * const builtin_hook_usage[] = {
 	N_("git hook list <hookname>"),
-	N_("git hook run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] <hookname>"),
+	N_("git hook run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...]"
+	   "[--to-stdin=<path>] <hookname>"),
 	NULL
 };
 
@@ -111,6 +112,8 @@ static int run(int argc, const char **argv, const char *prefix)
 			   N_("environment variables for hook to use")),
 		OPT_STRVEC('a', "arg", &opt.args, N_("args"),
 			   N_("argument to pass to hook")),
+		OPT_STRING(0, "to-stdin", &opt.path_to_stdin, N_("path"),
+			   N_("file to read into hooks' stdin")),
 		OPT_END(),
 	};
 
diff --git a/hook.c b/hook.c
index 008167dbe5..a2eda57fb9 100644
--- a/hook.c
+++ b/hook.c
@@ -245,6 +245,7 @@ void run_hooks_opt_init(struct run_hooks_opt *o)
 {
 	strvec_init(&o->env);
 	strvec_init(&o->args);
+	o->path_to_stdin = NULL;
 	o->run_hookdir = configured_hookdir_opt();
 }
 
@@ -280,7 +281,12 @@ static void prepare_hook_cp(const char *hookname, struct hook *hook,
 	if (!hook)
 		return;
 
-	cp->no_stdin = 1;
+	/* reopen the file for stdin; run_command closes it. */
+	if (options->path_to_stdin)
+		cp->in = xopen(options->path_to_stdin, O_RDONLY);
+	else
+		cp->no_stdin = 1;
+
 	cp->env = options->env.v;
 	cp->stdout_to_stderr = 1;
 	cp->trace2_hook_name = hookname;
diff --git a/hook.h b/hook.h
index 5f770b53ed..37147f4c5e 100644
--- a/hook.h
+++ b/hook.h
@@ -52,6 +52,9 @@ struct run_hooks_opt
 	 * to be overridden if the user can override it at the command line.
 	 */
 	enum hookdir_opt run_hookdir;
+
+	/* Path to file which should be piped to stdin for each hook */
+	const char *path_to_stdin;
 };
 
 void run_hooks_opt_init(struct run_hooks_opt *o);
@@ -68,7 +71,8 @@ int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir);
 
 /*
  * Runs all hooks associated to the 'hookname' event in order. Each hook will be
- * passed 'env' and 'args'.
+ * passed 'env' and 'args'. The file at 'stdin_path' will be closed and reopened
+ * for each hook that runs.
  */
 int run_hooks(const char *hookname, struct run_hooks_opt *options);
 
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
index 3dddd41e4f..43917172d7 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -302,4 +302,28 @@ test_expect_success 'hook.runHookDir is tolerant to unknown values' '
 	test_cmp expected actual
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
2.31.1.818.g46aad6cb9e-goog

