Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8F8C433EF
	for <git@archiver.kernel.org>; Tue, 31 May 2022 17:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346593AbiEaRdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 13:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346608AbiEaRdU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 13:33:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8392980AE
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:33:11 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n185so411659wmn.4
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZuEGVYzDCvW+2yEZPSfQTm0iUghJC5e0dxYbNUGeVt4=;
        b=Bn2oDlKv1g3yMkBhm8z6QDUKCrm1O+2njEo66o8pwIvUXeHo4OmaslUow7OKHBTgJh
         ALa/RRdG8h07bNwfDXl8qw2ruA8klpe5y3AnLU7YsSxogQs7iNTDaz9i3PDofPrUpDIn
         lRldIBPmbzd65eqUrv7ff4AH0WXo5LsbSDnenT5lQqjA2Q7w+TKt0HpCuOUD/8D2AyPK
         kt8kVaZob79HXNwvjCI+07hEaUtelFxrgHg9GnIMVfC1hLv+ZZ5SpmGm0NYud18Dr1J2
         9NDVhciW6b95CVW3fcm4/w8D1NlNFxuIIC89scRDt5BnY49hBW7L7pivO2XfLG6xpNPZ
         4eSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZuEGVYzDCvW+2yEZPSfQTm0iUghJC5e0dxYbNUGeVt4=;
        b=erOyxHMhq/vtptNl5htvNzAdG8LaU5Q2w24khZ22+d6ZnfGEsLLNcReDmULoYmmcyc
         ZXsTji73CvjU/11Grza3smmMpG364Nr7cOUdPy+P0eW0dEAhQiOC4S80q+kej09JoA1n
         PKHQUBjWG2nMidRkuVrB4kW9u8vW1+rxxAVf+eEZ84QrYuXA//ZuVTA0mvb17S7wUr6O
         gL1LLYEWs0Ld/H1OPMnBhx1Cv/Xw/cyMFOjcxhtzQVrkCQY0FRiW+2MESZCqpK457N7l
         SJ4qxcdyMykrIDtewE/Dtu5+QK5EAbqLB2MiGf6GRPjBvJeBxoxzSOkH34dGr7nKuMi9
         +VfA==
X-Gm-Message-State: AOAM531uqwsa7Bp7HMuwRc1+sXjbL9SxdBjQtZPnNai4LxWFF0p7sHhn
        wQu1zjVYEhMT65f+biA4n87wnhOTxaVTTQ==
X-Google-Smtp-Source: ABdhPJxfIzyUX57OPc/Hsj/YgGDLyVyQyvlubWt5MhHKnezMiWfBm0Q7AdOLv8g3GGqYekdhqCbMTw==
X-Received: by 2002:a1c:f405:0:b0:397:56ec:b8fb with SMTP id z5-20020a1cf405000000b0039756ecb8fbmr24218845wma.99.1654018389980;
        Tue, 31 May 2022 10:33:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c215500b003973e8a227dsm2637941wml.46.2022.05.31.10.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 10:33:08 -0700 (PDT)
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
Subject: [PATCH v4 2/2] hook API: fix v2.36.0 regression: hooks should be connected to a TTY
Date:   Tue, 31 May 2022 19:32:59 +0200
Message-Id: <patch-v4-2.2-8ab09f28729-20220531T173005Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1103.g036c05811b0
In-Reply-To: <cover-v4-0.2-00000000000-20220531T173005Z-avarab@gmail.com>
References: <cover-v3-0.2-00000000000-20220527T090618Z-avarab@gmail.com> <cover-v4-0.2-00000000000-20220531T173005Z-avarab@gmail.com>
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
2.36.1.1103.g036c05811b0

