Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68754C48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BDDF61245
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhFQK0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhFQKZj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:39 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146C5C061760
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gb32so794425ejc.2
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w56WOd37/leZn9F3J/DFkDPgkOgsnZPLn249OK3Eluc=;
        b=TyGBR1A6LJ6TOhQO0+hqri/0wFz/LQRkfJl6Ve/xPYjL/ztcP9E+e0K5wtcsUW78I4
         2ME+xXXxyNKLOUWe1YRiJHiOQyZHNHjhJe/ScDKbhdHKo/buDpF758pFQKlSb7PdqgIi
         y4I6SGashMn0YoKYME2SrbiXUrREqeP5rcqY6kF2atItTGt4vdZnhWs1jKQvV1ACWHX+
         I+iFmx24X0qsOUJFsbiNb/96aSUZOyT91xQnIqoCWwH+P27EHgjsW6fydUlEp/huk9Tt
         BdtGBp/M4F135sauYaAqrxc79ndPmGUa73x5vkh4yrqTumddFJ88IpXwj7KdIXDk2Uc8
         So9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w56WOd37/leZn9F3J/DFkDPgkOgsnZPLn249OK3Eluc=;
        b=n72QyFQlhUal/4pUoi7BGqLpUmtawlOA4mg1YBHgVYAIXo2nVAZKe3tzjRCbEeXKQT
         96nktsJY8BMGC3te2JM+X+dBojqUSr3UyCMq3c+/HRkt+sPgtZ/RNecVoc8uzFmg4VYy
         1Uv/QlsRk2av2uLwfuoh6NE83LrmH8vXEqHY01ommQLDRYxL+qk9fwAiyZQrXWXq0zrE
         rwhgCrSGm3QIf5uPhJdtSG3O/76KS2pkzM2ScR7Swjc67jMIxwqCJmsiDLKe8+Scwzjo
         HVjOfEWnTbNHyYzyQcU1mdo9C4AQPWvNvLSBLU1SVls28SIYGgnDnNRNxXuMvc6ecwaF
         psxQ==
X-Gm-Message-State: AOAM531++PAKj3SH3b+pqmHZ8dEeIB4orbiZfKAS8Pf1wsl7OjCbr9rT
        2nnHOXVzyVa/WG6u5kixVPZbG/lkU8jnRw==
X-Google-Smtp-Source: ABdhPJwemHsgdLaZgsk6NDLKQDH0LuUs2JYymLnorzNABclO8chbO66Af7JRcc8b+dip9orzFUjtOA==
X-Received: by 2002:a17:906:488a:: with SMTP id v10mr4350593ejq.383.1623925401482;
        Thu, 17 Jun 2021 03:23:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:21 -0700 (PDT)
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
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 15/27] hook: support passing stdin to hooks
Date:   Thu, 17 Jun 2021 12:22:49 +0200
Message-Id: <patch-15.27-b7c0ee9719-20210617T101217Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
References: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com> <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
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
 builtin/hook.c             |  5 ++++-
 hook.c                     |  9 ++++++++-
 hook.h                     |  2 ++
 t/t1800-hook.sh            | 18 ++++++++++++++++++
 5 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 097fb9de63..fa68c1f391 100644
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
@@ -32,6 +32,11 @@ what those are.
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
index 47e0de7bbc..169a8dd08f 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -8,12 +8,13 @@
 
 static const char * const builtin_hook_usage[] = {
 	N_("git hook <command> [...]"),
-	N_("git hook run <hook-name> [-- <hook-args>]"),
+	N_("git hook run [<args>] <hook-name> [-- <hook-args>]"),
 	NULL
 };
 
 static const char * const builtin_hook_run_usage[] = {
 	N_("git hook run <hook-name> [-- <hook-args>]"),
+	N_("git hook run [--to-stdin=<path>] <hook-name> [-- <hook-args>]"),
 	NULL
 };
 
@@ -29,6 +30,8 @@ static int run(int argc, const char **argv, const char *prefix)
 	struct option run_options[] = {
 		OPT_BOOL(0, "ignore-missing", &ignore_missing,
 			 N_("exit quietly with a zero exit code if the requested hook cannot be found")),
+		OPT_STRING(0, "to-stdin", &opt.path_to_stdin, N_("path"),
+			   N_("file to read into hooks' stdin")),
 		OPT_END(),
 	};
 
diff --git a/hook.c b/hook.c
index cb39404ac8..cab9cced82 100644
--- a/hook.c
+++ b/hook.c
@@ -85,7 +85,14 @@ static int pick_next_hook(struct child_process *cp,
 	struct hook_cb_data *hook_cb = pp_cb;
 	struct hook *run_me = hook_cb->run_me;
 
-	cp->no_stdin = 1;
+
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
index 8bd0fc8d1f..c4ac054ee3 100644
--- a/hook.h
+++ b/hook.h
@@ -45,6 +45,8 @@ struct run_hooks_opt
 	/* Path to initial working directory for subprocess */
 	const char *dir;
 
+	/* Path to file which should be piped to stdin for each hook */
+	const char *path_to_stdin;
 };
 
 #define RUN_HOOKS_OPT_INIT { \
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 542e551628..f3510379e0 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -133,4 +133,22 @@ test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
 	test_cmp expect actual
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
2.32.0.576.g59759b6ca7d

