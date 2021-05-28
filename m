Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE10AC4708D
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFABF601FD
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbhE1MOb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbhE1MNh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:13:37 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B385FC061348
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:58 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id z137-20020a1c7e8f0000b02901774f2a7dc4so6684474wmc.0
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uWJhMm5EPfBadxamxZZKdhxIcSwYZaw7Ps6FrbMmv6g=;
        b=gFNCZx/P0JIXNqMetDNVq7yeha8JFxNlxmfxMyxINWeKH2YdV2jm6sUodNgNVXAJOV
         yMbszkD5S+/7Bl0yimnIHk4zm72XvRHdVJOEU41epZYMzy6q5lp2kYuFb4lqdPKohIfE
         sLUgxepiOxkM2BJrSDQYnaUZ4C4UXcnEvtCgOYqhO06O8wf+Ef5UtTIS7Mzfu5DO+Tnf
         GwqSTWbG3Qrek7ARa2QXrUHqnlHC2C2n34goHKtqO76h7GhtjcoPFKCOHDMGKu+lCbtW
         W+YXdsk36eoLLj7+KtBsAQ8dOHIk9eVE2KdWkWKCgb0cYqK9h+2roVjUhCLilfcPtFOI
         1B2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uWJhMm5EPfBadxamxZZKdhxIcSwYZaw7Ps6FrbMmv6g=;
        b=My1/e2XnfgnddFzzsCfPQvtzjISPM0bbme84kIERBD+k3KcHFVHKVnp0Hl6r7fyZrg
         UeCe6fGb023U1qfZxNRJ6XC4sjvFlf5gGM7xZ5dtL2W7KQkoDc6Nt9eHHjo71RpSoqNo
         swSnl5Dl81vcJWOKM7r3Rnc4ddNlW5l84knQIZUCL2cfKFosOmd+YbNrPoSvOTiK2vm5
         qZSbO4fYu21wAgwOyMq4V2EuCnPe62nwz8oXkWx42DkqkgE/LpSrPckbJQGfzpBajgEj
         LwbsHlxaibYPsnnaBNsIFad56Or3ShuJAKB6JcZYFLAypBnOqipcRcSN/OOLzMdeMiYX
         QoqQ==
X-Gm-Message-State: AOAM5320yyAj7wc4eycaWusL99Vw6fdMWZh85S+3uXREyC+xVWO1lo9X
        fjT8UDbTWPTuPL6GCV77X9nSyKwSzziw7w==
X-Google-Smtp-Source: ABdhPJxpKXLCvVlED1wDjHBY8PTjxQV8+WNYwGSbz3aoYW9cVwguxAvM1t55bxr3jegtIa6nBkwCgw==
X-Received: by 2002:a1c:2cc3:: with SMTP id s186mr13506073wms.150.1622203917007;
        Fri, 28 May 2021 05:11:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:11:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 18/31] hook: support passing stdin to hooks
Date:   Fri, 28 May 2021 14:11:20 +0200
Message-Id: <patch-18.31-4745dcfce49-20210528T110515Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.460.g26a014da44c
In-Reply-To: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com> <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

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
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-hook.txt |  7 ++++++-
 builtin/hook.c             |  4 +++-
 hook.c                     |  8 +++++++-
 hook.h                     |  2 ++
 t/t1800-hook.sh            | 18 ++++++++++++++++++
 5 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 1528c860cf1..816b3eda460 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -8,7 +8,7 @@ git-hook - run git hooks
 SYNOPSIS
 --------
 [verse]
-'git hook' run [--ignore-missing] <hook-name> [-- <hook-args>]
+'git hook' run [--to-stdin=<path>] [--ignore-missing] <hook-name> [-- <hook-args>]
 
 DESCRIPTION
 -----------
@@ -30,6 +30,11 @@ run::
 OPTIONS
 -------
 
+--to-stdin::
+	For "run"; Specify a file which will be streamed into the
+	hook's stdin. The hook will receive the entire file from
+	beginning to EOF.
+
 --ignore-missing::
 	Ignore any missing hook by quietly returning zero. Used for
 	tools that want to do a blind one-shot run of a hook that may
diff --git a/builtin/hook.c b/builtin/hook.c
index 275dd5b0ed0..baaef4dce49 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -7,7 +7,7 @@
 #include "strvec.h"
 
 static const char * const builtin_hook_usage[] = {
-	N_("git hook run <hook-name> [-- <hook-args>]"),
+	N_("git hook run [--to-stdin=<path>] <hook-name> [-- <hook-args>]"),
 	NULL
 };
 
@@ -23,6 +23,8 @@ static int run(int argc, const char **argv, const char *prefix)
 	struct option run_options[] = {
 		OPT_BOOL(0, "ignore-missing", &ignore_missing,
 			 N_("exit quietly with a zero exit code if the requested hook cannot be found")),
+		OPT_STRING(0, "to-stdin", &opt.path_to_stdin, N_("path"),
+			   N_("file to read into hooks' stdin")),
 		OPT_END(),
 	};
 
diff --git a/hook.c b/hook.c
index 51337f9798f..daf39f61741 100644
--- a/hook.c
+++ b/hook.c
@@ -58,7 +58,13 @@ static int pick_next_hook(struct child_process *cp,
 	if (!run_me)
 		BUG("did we not return 1 in notify_hook_finished?");
 
-	cp->no_stdin = 1;
+	/* reopen the file for stdin; run_command closes it. */
+	if (hook_cb->options->path_to_stdin) {
+		cp->no_stdin = 0;
+		cp->in = xopen(hook_cb->options->path_to_stdin, O_RDONLY);
+	} else {
+		cp->no_stdin = 1;
+	}
 	cp->env = hook_cb->options->env.v;
 	cp->stdout_to_stderr = 1;
 	cp->trace2_hook_name = hook_cb->hook_name;
diff --git a/hook.h b/hook.h
index 2d7724bbb50..74a8c76a94c 100644
--- a/hook.h
+++ b/hook.h
@@ -28,6 +28,8 @@ struct run_hooks_opt
 	/* Path to initial working directory for subprocess */
 	const char *dir;
 
+	/* Path to file which should be piped to stdin for each hook */
+	const char *path_to_stdin;
 };
 
 #define RUN_HOOKS_OPT_INIT { \
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 9077afa1ed9..9e2dd64275c 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -137,4 +137,22 @@ test_expect_success 'set up a pre-commit hook in core.hooksPath' '
 	EOF
 '
 
+test_expect_success 'stdin to hooks' '
+	write_script .git/hooks/test-hook <<-\EOF &&
+	echo BEGIN stdin
+	cat
+	echo END stdin
+	EOF
+
+	cat >expect <<-EOF &&
+	BEGIN stdin
+	hello
+	END stdin
+	EOF
+
+	echo hello >input &&
+	git hook run --to-stdin=input test-hook 2>actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.32.0.rc1.458.gd885d4f985c

