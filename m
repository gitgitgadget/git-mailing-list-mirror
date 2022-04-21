Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2CCC433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 12:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384227AbiDUM2l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 08:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384137AbiDUM2c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 08:28:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B0F2F39E
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 05:25:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u3so6481552wrg.3
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 05:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=905cJlFlPtOpan3ejilU/X+EUQOlmr6HjccKRgl86Uc=;
        b=pqGIrICVPZjpWJQGV0ksvzfDZKiOAPcz+JbA6iizuHEEjovPH580sKAySOz7bKUfwG
         1jSyMT4O9qX8swpOWeDl2wP1vYnFtRA8EMH07sy5JkO+y5sVA0Voi6ZS3kbWp+7UpcUr
         TlccjenFRjMwU+a/KaDF89+t81rLv9Vx8a5K5wtwZSpG+xpiUH9RF2wiDVb+sk72Lq3q
         dQ/t+2FweH9kkduUC64l8y0X5e9HnJp8cg5JfyUutFXooTO9OUZf8T8Fh5mIwFlAPJiR
         /1sBsiClT4Ebqg1IlM8YNpOUhE7yxpDxtPF27QGFUVRfpvTTLd8zJvSDn3MDOTlEiaUM
         /mEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=905cJlFlPtOpan3ejilU/X+EUQOlmr6HjccKRgl86Uc=;
        b=giD+CS3vy5lQtGJmUe1A0pYujkkQhOSVZSaiQmYWCLfTiKkDcAO1BYv3mMYovvZE4G
         e42MdIycFgZyzDgbdVJMfF1H6NNh0Xy0MMvr7yyEXO6XCVutmNyUeBy7B5FMdKnsNAMJ
         GCKdgexecpwsuwirekLso1SzZHviKR2rPxbrx0Lqlceops2dRHXgmg8gbdlMjiYpj0BV
         wWNzpZ7W5bRf6H7+lYXGDLXOOkjRLJ92T6t2lYo3p+PMO2ZzDQ5a/mYyGW//82LgmP6X
         E8KamfkoF5dwdEjrATKkX8XGbBTmhAVaRN/uyN7XiaobXRrficoj3HiV3gryv9/bd9qC
         9T4w==
X-Gm-Message-State: AOAM533vAHhWBFfxSl48H3sZReA0t/5x2iEpe1HAbAVMj67srKp9Qnaq
        lTCxWklQpTmR+Fqemqxjq1lxiQ5GWlPU2Q==
X-Google-Smtp-Source: ABdhPJxAkFdUopEsjmcxQWUm6X/ZS2ovbOuYKmgyGUuT9AGdTZYJChTb3ARsmj7chjdjqqG9CFB7ug==
X-Received: by 2002:a05:6000:1849:b0:20a:aa03:c6d0 with SMTP id c9-20020a056000184900b0020aaa03c6d0mr9139465wri.381.1650543940101;
        Thu, 21 Apr 2022 05:25:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c2c4700b0038eb7d8df69sm1920168wmg.11.2022.04.21.05.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 05:25:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/6] hook API: fix v2.36.0 regression: hooks should be connected to a TTY
Date:   Thu, 21 Apr 2022 14:25:31 +0200
Message-Id: <patch-6.6-de3664f6d2b-20220421T122108Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.893.g80a51c675f6
In-Reply-To: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com> <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression reported[1] in f443246b9f2 (commit: convert
{pre-commit,prepare-commit-msg} hook to hook.h, 2021-12-22): Due to
using the run_process_parallel() API in the earlier 96e7225b310 (hook:
add 'run' subcommand, 2021-12-22) we'd capture the hook's stderr and
stdout, and thus lose the connection to the TTY in the case of
e.g. the "pre-commit" hook.

As a preceding commit notes GNU parallel's similar --ungroup option
also has it emit output faster. While we're unlikely to have hooks
that emit truly massive amounts of output (or where the performance
thereof matters) it's still informative to measure the overhead. In a
similar "seq" test we're now ~30% faster:

	$ cat .git/hooks/seq-hook; git hyperfine -L rev origin/master,HEAD~0 -s 'make CFLAGS=-O3' './git hook run seq-hook'
	#!/bin/sh

	seq 100000000
	Benchmark 1: ./git hook run seq-hook' in 'origin/master
	  Time (mean ± σ):     787.1 ms ±  13.6 ms    [User: 701.6 ms, System: 534.4 ms]
	  Range (min … max):   773.2 ms … 806.3 ms    10 runs

	Benchmark 2: ./git hook run seq-hook' in 'HEAD~0
	  Time (mean ± σ):     603.4 ms ±   1.6 ms    [User: 573.1 ms, System: 30.3 ms]
	  Range (min … max):   601.0 ms … 606.2 ms    10 runs

	Summary
	  './git hook run seq-hook' in 'HEAD~0' ran
	    1.30 ± 0.02 times faster than './git hook run seq-hook' in 'origin/master'

In the preceding commit we removed the "no_stdin=1" and
"stdout_to_stderr=1" assignments. This change brings them back as with
".ungroup=1" the run_process_parallel() function doesn't provide them
for us implicitly.

As an aside omitting the stdout_to_stderr=1 here would have all tests
pass, except those that test "git hook run" itself in
t1800-hook.sh. But our tests passing is the result of another test
blind spot, as was the case with the regression being fixed here. The
"stdout_to_stderr=1" for hooks is long-standing behavior, see
e.g. 1d9e8b56fe3 (Split back out update_hook handling in receive-pack,
2007-03-10) and other follow-up commits (running "git log" with
"--reverse -p -Gstdout_to_stderr" is a good start).

1. https://lore.kernel.org/git/CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com/

Reported-by: Anthony Sottile <asottile@umich.edu>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 hook.c          |  8 +++++++-
 t/t1800-hook.sh | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/hook.c b/hook.c
index 68ee4030551..f5eef1d561b 100644
--- a/hook.c
+++ b/hook.c
@@ -53,7 +53,9 @@ static int pick_next_hook(struct child_process *cp,
 	if (!hook_path)
 		return 0;
 
+	cp->no_stdin = 1;
 	strvec_pushv(&cp->env_array, hook_cb->options->env.v);
+	cp->stdout_to_stderr = 1;
 	cp->trace2_hook_name = hook_cb->hook_name;
 	cp->dir = hook_cb->options->dir;
 
@@ -119,16 +121,20 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
 		.options = options,
 	};
 	const char *const hook_path = find_hook(hook_name);
-	int jobs = 1;
+	const int jobs = 1;
 	int ret = 0;
 	struct run_process_parallel_opts run_opts = {
 		.tr2_category = "hook",
 		.tr2_label = hook_name,
+		.ungroup = jobs == 1,
 	};
 
 	if (!options)
 		BUG("a struct run_hooks_opt must be provided to run_hooks");
 
+	if (jobs != 1 || !run_opts.ungroup)
+		BUG("TODO: think about & document order & interleaving of parallel hook output");
+
 	if (options->invoked_hook)
 		*options->invoked_hook = 0;
 
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 1e4adc3d53e..f22754deccc 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -4,6 +4,7 @@ test_description='git-hook command'
 
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 test_expect_success 'git hook usage' '
 	test_expect_code 129 git hook &&
@@ -120,4 +121,40 @@ test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
 	test_cmp expect actual
 '
 
+test_hook_tty() {
+	local fd="$1" &&
+
+	cat >expect &&
+
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+
+	test_hook -C repo pre-commit <<-EOF &&
+	{
+		test -t 1 && echo >&$fd STDOUT TTY || echo >&$fd STDOUT NO TTY &&
+		test -t 2 && echo >&$fd STDERR TTY || echo >&$fd STDERR NO TTY
+	} $fd>actual
+	EOF
+
+	test_commit -C repo A &&
+	test_commit -C repo B &&
+	git -C repo reset --soft HEAD^ &&
+	test_terminal git -C repo commit -m"B.new" &&
+	test_cmp expect repo/actual
+}
+
+test_expect_success TTY 'git hook run: stdout and stderr are connected to a TTY: STDOUT redirect' '
+	test_hook_tty 1 <<-\EOF
+	STDOUT NO TTY
+	STDERR TTY
+	EOF
+'
+
+test_expect_success TTY 'git hook run: stdout and stderr are connected to a TTY: STDERR redirect' '
+	test_hook_tty 2 <<-\EOF
+	STDOUT TTY
+	STDERR NO TTY
+	EOF
+'
+
 test_done
-- 
2.36.0.893.g80a51c675f6

