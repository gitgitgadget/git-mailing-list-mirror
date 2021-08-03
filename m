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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997E1C4320E
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C0E60BD3
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240231AbhHCTkD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240228AbhHCTjw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:52 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF06DC0617BC
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h13so13026859wrp.1
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1u8+Szhb8RDp/4I1F53C70kQTLq03qQLbPQPfcada8o=;
        b=JdlMB+9P87pApXzJ4kMoXTKXLKUJQFSOel26YJLQDOYl05l3/DGcH/T0bc5tagyDY/
         Vsn6NNouGNYp9vmo1IOc6MYvCUpPQoXEIWbEwxyYxHM2bJ/MNGAsPEwcTxs7d8niz9g9
         UX6dQSDbzQRV9+IGgZOafXTFetcXm3Z5pizRP357eAJk+qah+8cUEQ7oLiVc6fcSBlGu
         HBUi03SIFpQlOv7x9GXYyNEGcWZAsOL7AvDrMCic8RVB2MJ/IAwxdnqg1Kij4l4UpDuY
         wVTxTzhkCN+11AebU6Z+sjbDsW8Gh5R34H42DA5Oey6Awz8CnalG6Gao58tGgiQshjne
         OgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1u8+Szhb8RDp/4I1F53C70kQTLq03qQLbPQPfcada8o=;
        b=QLeTc7puIHzBYPLkhX0WXiJN2tr/F8nFpvTLOwIhTNeeLEOwId+8dQSTye+5TuqACj
         9S6GBVRVfyfDwrknI/XfOtafajxGFUsQZnhwumxeiSmtaag0B5s4xes6KhsOhAfd/sCs
         RbyufPIJcaYn70I5a30kxjLDFIT4OhM6FgT/wAN0NpYVowDnF/IIbwDfEHbOx4alnvLM
         mTGk36HAbFk2QUqD1V19W3682A1QM1AEkeKQCsqWSeGboxRwopSf8Ds287f+m8iGVXcb
         imC+8aUjuRoymr9UMSOSK+5UQVqFXK+M3Abl8Mnhq85aCiG5LqUXEjiFMMaOhiLdtsF5
         AE4g==
X-Gm-Message-State: AOAM530NxM704q93/bEmqIxVjpwT6ZZFHQ04n8vjLkzx7Uk4RLbdzyZa
        +z+4/ANjMmqfVMTV1VchmE1y98wf7LL5zQ==
X-Google-Smtp-Source: ABdhPJzZlsdtEt+2nVMjEs4c0uJ1eMvJzmIQAGoJnSCj0qgmjETU6Mbn581aeC8wHktt+YIsT11Fqw==
X-Received: by 2002:a5d:58c1:: with SMTP id o1mr25025468wrf.6.1628019572151;
        Tue, 03 Aug 2021 12:39:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:31 -0700 (PDT)
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
Subject: [PATCH v4 22/36] hook: support passing stdin to hooks
Date:   Tue,  3 Aug 2021 21:38:48 +0200
Message-Id: <patch-v4-22.36-639e59e9ed0-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com> <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
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
index f33db9953c7..27dce6a2f0e 100644
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
index 5ecf79c8397..63c9a60921f 100644
--- a/hook.c
+++ b/hook.c
@@ -88,7 +88,13 @@ static int pick_next_hook(struct child_process *cp,
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
index 53ea3a9649e..cd6a68a3b50 100644
--- a/hook.h
+++ b/hook.h
@@ -36,6 +36,9 @@ struct run_hooks_opt
 
 	/* Path to initial working directory for subprocess */
 	const char *dir;
+
+	/* Path to file which should be piped to stdin for each hook */
+	const char *path_to_stdin;
 };
 
 #define RUN_HOOKS_OPT_INIT { \
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 49df5a2cdfb..217db848b3f 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -135,4 +135,22 @@ test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
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
2.33.0.rc0.595.ge31e012651d

