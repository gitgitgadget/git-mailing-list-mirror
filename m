Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2266C43219
	for <git@archiver.kernel.org>; Wed, 18 May 2022 20:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242346AbiERUGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 16:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242306AbiERUFu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 16:05:50 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1592375E9
        for <git@vger.kernel.org>; Wed, 18 May 2022 13:05:38 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so3797842wmj.1
        for <git@vger.kernel.org>; Wed, 18 May 2022 13:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qstmnqVssfnKoI8gpTKL61nuXl96/A+PoHUHtWKmtqI=;
        b=DiCMfqoyE9+2CNfyLEIRlfF955ddyN5WBHWy2uV1EqLqXmxqb07v8KSu3BHcfJM3lc
         WIsuQWp5WBEaRiOfBUZcxExyD8MOm+/tF7zm9OtVU2Z+i3hCHny+2oC3SkJfKGg9U9sO
         8n6gS+Nyzx6RtlHZ30/qNyZVLRVXubzaL5etQeOc2vuV+PfANIetEHYwCOePp9ef7LjI
         GdnHJnnc4nM6uU+V+NnBBDg70WOM2YuIH3qvSAnS72M0IJAL4GL/4J++GGH4C0fLSPT2
         k2rmL6rrxuc1WMUUYBZbvBEdNU7D3fLwLBc1XlUG1FmAMWyVoc/1IfL2NTIEKwLt4z+1
         4ZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qstmnqVssfnKoI8gpTKL61nuXl96/A+PoHUHtWKmtqI=;
        b=HdQ/XkGwq4DmjWKp/wb3FXyEDb0wQjsHfFbnKH9SbbGpMGEvjz3wJLeG1MQnydfL8w
         ycKMsKGhcu0r4otAyrBbiHSFyW3Z+Dt2H/UDXCFUcJiit8dKKBsh36mEj6bXKM03zQZ2
         u1H+sAwmgvQs+KobudS+oq/0thO+u6ZK5n+s8TkLiHaORgy0cAiOmrU+iVwnkHsXX58r
         U1dSNqeXMaxCMyoEE6hO6WxMVxA+cnkCc9caeuAI/3Qu/P4eeawdV2TyUgG8G/+stbMo
         y8fv9KQpdNwa4Km9yz3bRQ0zIUNqjJT9EANtO2bJ4Gv+kiiHFJR2OoT/vVQJsQ37ShT1
         qYZQ==
X-Gm-Message-State: AOAM532saCzLJ0SPRl8ALI9KEYKuU0BFKvNw+d84oawvfrUgfjloZvn4
        4xFjiRdfHuBWyQVnhspAGyAie0QeicUSig==
X-Google-Smtp-Source: ABdhPJzIkRVRaJmq/YPZNUR1QkEghc1AY2M02eA1PdEK5Zia0JiztJxJLmOEDYNqQM/3R2i6WycoSA==
X-Received: by 2002:a05:600c:288:b0:394:31f9:68f with SMTP id 8-20020a05600c028800b0039431f9068fmr1349631wmk.57.1652904336587;
        Wed, 18 May 2022 13:05:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f18-20020adfb612000000b0020d00174eabsm2674441wre.94.2022.05.18.13.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:05:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 8/8] hook API: fix v2.36.0 regression: hooks should be connected to a TTY
Date:   Wed, 18 May 2022 22:05:24 +0200
Message-Id: <patch-v2-8.8-238155fcb9d-20220518T195858Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.952.g0ae626f6cd7
In-Reply-To: <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
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

In the preceding commit we removed the "stdout_to_stderr=1" assignment
as being redundant. This change brings it back as with ".ungroup=1"
the run_process_parallel() function doesn't provide them for us
implicitly.

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
 hook.c          |  5 +++++
 t/t1800-hook.sh | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/hook.c b/hook.c
index dc498ef5c39..5f31b60384a 100644
--- a/hook.c
+++ b/hook.c
@@ -54,6 +54,7 @@ static int pick_next_hook(struct child_process *cp,
 		return 0;
 
 	strvec_pushv(&cp->env_array, hook_cb->options->env.v);
+	cp->stdout_to_stderr = 1; /* because of .ungroup = 1 */
 	cp->trace2_hook_name = hook_cb->hook_name;
 	cp->dir = hook_cb->options->dir;
 
@@ -126,6 +127,7 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
 		.tr2_label = hook_name,
 
 		.jobs = jobs,
+		.ungroup = jobs == 1,
 
 		.get_next_task = pick_next_hook,
 		.start_failure = notify_start_failure,
@@ -136,6 +138,9 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
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
2.36.1.952.g0ae626f6cd7

