Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147C4C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F12C361452
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhFNKjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:39:04 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:44866 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbhFNKhD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:37:03 -0400
Received: by mail-wr1-f44.google.com with SMTP id f2so13966929wri.11
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hs61v+o9NuN8dXH1/E/hJ7rrZ9IiRob9QFRiR5JubfQ=;
        b=S0Jcq387mQn3ptIhQBLmuUvnpmzZDHHsbfXHKMnv0X6I/hgWMhZBD3M/f1XDSMQdIv
         cIL/olxPq2kaoVd20gTL02SGPzRjbIn94/b2+h5miCRCyMEBjt8cmFKTcPfMstfiWtGe
         /R0m8mggat6/C6Irk340WWdTDI0db0WSXyapko5BduUj006BYCOFkvEPfqAc1oNw9Y0U
         wp1mUdbYmSC9WqvM6tnuQiGDlGuG0+NzezSHF3TIhD3vo9FZo9N7kidAbghbj7xPH/Hh
         1z8qXK7jAHKJP/Ib6E1+qRbeaLSAq1OP4UXFQbHkKtDxXruB3AyHUJmoEQvyceytjYeW
         KMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hs61v+o9NuN8dXH1/E/hJ7rrZ9IiRob9QFRiR5JubfQ=;
        b=pCHhk0TxCkejaq6qq/Win1UwN5DLhcOh98VZGw73yMGEBve8U2JH/d7itLm3BgMwUr
         ktcW1ce3nXcPI4YzC8z3xr+vDmM0knuzWF7MREuM9udj6ipTeuIw4+ahT7Rl+qSnUOq+
         6kE/lf+DK6K7jcOwQWUBpIg84Xo5ymeLJr08IO0MWHcFWQqp43daindQrb0Fci7FiOXG
         UYb+HJBzoAZnUU60xBx3SEFBXFUuLVj6yrY+Gfm4o7ry7KePUfQyACLhbgFPBNWL4yxj
         DWw3nOgsu1acf5GhEGvmOted2HkTpA+GxMogwoHqYyjxM5kJyJAYzCFVLufDbF2+e7t8
         CfYA==
X-Gm-Message-State: AOAM532PXTimJ57xFMygZrHtpAPp7YZWQs7txQlCesDV8tJtJX229hUR
        e/gWZVH7FH8prigvX50jDGAYyYrNtyh5Wg==
X-Google-Smtp-Source: ABdhPJwPV2DfVYzJsJaMgLW+HAoAy8fb0fz9+jjhw/FHUVCmA1MyGZ3pKE3KpcezODqP2bi3hdgxdQ==
X-Received: by 2002:adf:fe8c:: with SMTP id l12mr18085823wrr.26.1623666838700;
        Mon, 14 Jun 2021 03:33:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:33:58 -0700 (PDT)
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
Subject: [PATCH v2 17/30] hook: support passing stdin to hooks
Date:   Mon, 14 Jun 2021 12:33:06 +0200
Message-Id: <patch-17.30-c4f60db606d-20210614T101920Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com> <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
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
index 714dfd08cd8..1a6b708137e 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -133,4 +133,22 @@ test_expect_success 'set up a pre-commit hook in core.hooksPath' '
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
2.32.0.rc3.434.gd8aed1f08a7

