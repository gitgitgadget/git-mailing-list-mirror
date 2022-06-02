Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD94AC43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 14:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbiFBOIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 10:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbiFBOIG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 10:08:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DBA24E017
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 07:08:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k16so6624937wrg.7
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 07:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Dcz9zgLfq/HGW4BSRWkNt0Qw3TRvaz6YQLvKz2u8pA=;
        b=O9O41a5iffJDqPEtGLHi7+M/HZP+WJQvWm0uxHalA/yEGp871+seAYEs3uiX/pUdaQ
         7tG9VkQHWm0/oddrX2WUtnnkES+UY/PqMqJh4J7sDWK8IO37wZKDVaRu6Sb0WBhGre62
         OzjsDAl+/b8BJBI6c9+UvT/Il5RQbtvZ7EKvingH1492Fczoo97D0g1jaS1J47d7ciRX
         FMHTdNd2eI8WN0rBRuNZjHW74ZKxH50nNiAIyUH7bQ4+Xf6fTKnMFq9axVkzVTFUKY3X
         C5rQDM6rELaNcMph1QJb5+svMbsCj1rcp0bo3oC7Pn1aizq0awOKBHQRLPPLWUerlZkF
         ImFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Dcz9zgLfq/HGW4BSRWkNt0Qw3TRvaz6YQLvKz2u8pA=;
        b=628kdfhnOOlexIrXPqqgIkLj7imZDC8wp8EaOc0DUEvjjS9YLQot1xXRBtG6/KC53A
         BYGpMvTfLflcW6BKP5W+hnCYxgYQ7xRexe6aS3a9SoHRJ/DkVG0KytOMUwG4n1R5aRh2
         h8E2KGmdeE2ujbfVl25JkzR/gyeFgUogjjJr6319dGJ81sfF5Hiy3ahRvTEb+ZlMmu9R
         xuM9Tb6yuzZ4huN32IG9vLBOakFRntHIb8Y6pIBP7GjokzeU3FT4o8NCdLicJMgrUjMP
         fpoF+zrgGLeSYNJDx9mqmmsLj1XOH9dIhpkkU55U1Q9Ex1f5OMXEj2tn5SIjRE1bCLRB
         Vz2Q==
X-Gm-Message-State: AOAM530xJTJN65P4O/nLSqhmmrufVTBVj1y+yK/Ey1lyn62KokLDUMwC
        DX6AxTDkaYorDd4KVAY6WIr01yWe9Q2XvQ==
X-Google-Smtp-Source: ABdhPJxsnoloIWXaS+LN4pfaLSxVQ0pzLsliivCP2m18jd336YUHzbvz2ykxq+dh04VlSTPeCf3qDA==
X-Received: by 2002:a5d:6daf:0:b0:20f:f1e7:c720 with SMTP id u15-20020a5d6daf000000b0020ff1e7c720mr3844582wrs.584.1654178883406;
        Thu, 02 Jun 2022 07:08:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c4fd200b0039744bd664esm9271514wmq.13.2022.06.02.07.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 07:08:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 2/2] hook API: fix v2.36.0 regression: hooks should be connected to a TTY
Date:   Thu,  2 Jun 2022 16:07:57 +0200
Message-Id: <patch-v5-2.2-b0f0dc7492a-20220602T131858Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1103.gb3ecdfb3e6a
In-Reply-To: <cover-v5-0.2-00000000000-20220602T131858Z-avarab@gmail.com>
References: <cover-v4-0.2-00000000000-20220531T173005Z-avarab@gmail.com> <cover-v5-0.2-00000000000-20220602T131858Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression reported[1] against f443246b9f2 (commit: convert
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

1. https://lore.kernel.org/git/CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com/

Reported-by: Anthony Sottile <asottile@umich.edu>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 hook.c          |  1 +
 t/t1800-hook.sh | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/hook.c b/hook.c
index 1d51be3b77a..7451205657a 100644
--- a/hook.c
+++ b/hook.c
@@ -144,6 +144,7 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
 		cb_data.hook_path = abs_path.buf;
 	}
 
+	run_processes_parallel_ungroup = 1;
 	run_processes_parallel_tr2(jobs,
 				   pick_next_hook,
 				   notify_start_failure,
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 26ed5e11bc8..0b8370d1573 100755
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
2.36.1.1103.gb3ecdfb3e6a

