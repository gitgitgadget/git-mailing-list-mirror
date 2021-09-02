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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31ECC4320E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A9C26108E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345055AbhIBNNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345187AbhIBNNg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:13:36 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B1EC06122F
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:12:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u26-20020a05600c441a00b002f66b2d8603so1406019wmn.4
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=umhyauEdB2R62gDQ8HSg3xeXESPuOWe9JF+PMQM5mec=;
        b=Q5i6eifVhY7EMZ16wOGMTKyQPjzCPW7OXJy9FL0HXfHKgF70eX/Z7fBxf+iA37s7NR
         NdTSmVSn6qL78BUA0GnNClt/JxzEUIa6GUoUcEvt5FGypGHjrj+4Pe3wn0wlSY9i+GI5
         T8cET6rZg0pINvM3EwiCpXwaZMbphtrhhrl4L6opqbb17ebKdqq7nk3rXWjqvOsL7HbW
         GgMDxIHf+1XLht59RB3fVngpQZmmfZlKKGtOxMSFMr/7BGJWv9N/Q4hckTdV9mK6o1YK
         t46GXCVOpQYU4KKDTGvlTgUDbojHYJan4n7pR4hfFom/+8GTDXv7hiNt3v/P0leL0tdz
         AcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=umhyauEdB2R62gDQ8HSg3xeXESPuOWe9JF+PMQM5mec=;
        b=frnl0dxyRg4pW2aHa6yRkir5q16M6ChdeBI3A/Z+g32IdZSBl3RYfd5QoYyE6pwNrG
         Qy2ExsMGNfvDRFL7i4nuTx1uNrM4GDd2SlLhy9IEVDc2k11a2F5CXaluMvCoPvMB3iCZ
         wSc0WZs3z8Y0LOF2A/U41DR+ax8XGe7/mo+Iy/Usjw/OJQ8J+V5BuM3HcEOSoS32QNax
         5sQXZma6PF+PV3gIy+uf5BnbxjFaPFlPSI42qYUL2oVoPPoBqiOhgFyonTq0SQzS0RzH
         uD5yaiAd+6cJy3nt+gShn+jb6HuPIAuVdzpiYHEw+5EK01vvP2Ei0YfUD0T/hLJxgB7Q
         z4CQ==
X-Gm-Message-State: AOAM531G3Bo11I8ujbeJVqBBzy23dSSarrmbQ3v9qbHYA38/LAFl0do1
        wA+XPq9Nw0NVpNy3N3egI0FDqkk/yG2i+Q==
X-Google-Smtp-Source: ABdhPJw312t8R0i6vH5EkYRuXzOMIAR84yreGVaNpiBgPVP4md50gCOHhIehAHirfMIAtwpN1zGFVg==
X-Received: by 2002:a7b:cb8c:: with SMTP id m12mr3133675wmi.77.1630588326236;
        Thu, 02 Sep 2021 06:12:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:12:05 -0700 (PDT)
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
Subject: [PATCH v5 22/36] hook: support passing stdin to hooks
Date:   Thu,  2 Sep 2021 15:11:22 +0200
Message-Id: <patch-v5-22.36-3ccc654a664-20210902T125110Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com> <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
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
 hook.h                     |  3 +++
 t/t1800-hook.sh            | 18 ++++++++++++++++++
 5 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 097fb9de63b..fa68c1f3912 100644
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
index 76d49e672f4..fae69068201 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -7,7 +7,7 @@
 #include "strvec.h"
 
 #define BUILTIN_HOOK_RUN_USAGE \
-	N_("git hook run [--ignore-missing] <hook-name> [-- <hook-args>]")
+	N_("git hook run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
 
 static const char * const builtin_hook_usage[] = {
 	BUILTIN_HOOK_RUN_USAGE,
@@ -29,6 +29,8 @@ static int run(int argc, const char **argv, const char *prefix)
 	struct option run_options[] = {
 		OPT_BOOL(0, "ignore-missing", &ignore_missing,
 			 N_("exit quietly with a zero exit code if the requested hook cannot be found")),
+		OPT_STRING(0, "to-stdin", &opt.path_to_stdin, N_("path"),
+			   N_("file to read into hooks' stdin")),
 		OPT_END(),
 	};
 	int ret;
diff --git a/hook.c b/hook.c
index 8a923e52c1b..d156b0dc800 100644
--- a/hook.c
+++ b/hook.c
@@ -59,7 +59,13 @@ static int pick_next_hook(struct child_process *cp,
 	if (!run_me)
 		return 0;
 
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
index 3edd937e198..253725e197b 100644
--- a/hook.h
+++ b/hook.h
@@ -23,6 +23,9 @@ struct run_hooks_opt
 
 	/* Path to initial working directory for subprocess */
 	const char *dir;
+
+	/* Path to file which should be piped to stdin for each hook */
+	const char *path_to_stdin;
 };
 
 #define RUN_HOOKS_OPT_INIT { \
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index feb95b8fc8d..6431b19e392 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -130,4 +130,22 @@ test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
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
2.33.0.816.g1ba32acadee

