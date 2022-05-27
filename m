Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EF0C433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 09:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236582AbiE0JOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 05:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240330AbiE0JOn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 05:14:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E7D765C
        for <git@vger.kernel.org>; Fri, 27 May 2022 02:14:42 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id p10so5046387wrg.12
        for <git@vger.kernel.org>; Fri, 27 May 2022 02:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Q9e6ev7o1pJ/UQNVNfhrnOPRFA0uQrwThUg1exfw5I=;
        b=dfq5s39ascwShoc1xArPPg7J5yK70Vx5dPI/cnpK2URyf7XGoXSCtXdilKvvQaMm4r
         ziEtmETe6uyTMoGAPNCdgF4vetBWv3fxLXcDmPe5GPtadLc9cZsxjhUsvSzE1DsRWzGx
         ZoqHP2YDAeJNdQ+L5RQkiwaJYW49mi8oyXPt+kyLySsI5hPOl+OdzGy0p0F6p0ekp92d
         Nz5CPb77ig9qgsdqV8KaGnIZ4Q1BQCnv/K1YqGiJHbpcESbW4oies1mVvFMiBnbDAPNa
         +rYUSNTQPJoAMBbAyi3R1dfk5ubkt0BmySFFctudUYQ2Iy6CrFA5e8Uz2tkSLT1VRz9b
         Ia0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Q9e6ev7o1pJ/UQNVNfhrnOPRFA0uQrwThUg1exfw5I=;
        b=MHdHeSLFJ+WWKKfruAqxOmeNaKlWnBu6WqJhhugQViVqncjmlyI6gw21bwsQZr0/Lp
         d/s4iXmGBmyKvmjbb4XI9zyXBTEbRfSq3+wcNbs6POLQDmaxvigWY5foTaMKbn8WSAHj
         NtvVoIFwHWDIXp7KnuvGsM/Fy6LB9d+L/P460TgdNf8WTCufNyr2rJnjOcKla1M879qu
         tQ6WoFxfYZxdi/fvm/L/qnLge2q2DKuWAxdoAN7UkPzA85dI/p5l3vywFbOzFGWHNbrL
         8roEVDo2IR8MiezdUjIwgaDp0woSeWecUQjbnC0VeG3XPLCULlou0/xgYrcxB86hjJZH
         ixHA==
X-Gm-Message-State: AOAM533K8h/Y7iUjoLr/OAbH8BkCBlzeejke47znfQ+UU/qr+ogswVBV
        fRuSlzRP5CeXgt4O10nUbBb+jWL00sW7yg==
X-Google-Smtp-Source: ABdhPJxskISLKbKnmLPV8lpQ0MPEQ6UoqeW0jA/+kPaqG1eaulM/QdkeZ/JZuWkI/uVrtVX/4YPweQ==
X-Received: by 2002:a5d:414c:0:b0:210:1611:8f6 with SMTP id c12-20020a5d414c000000b00210161108f6mr2437993wrq.611.1653642880338;
        Fri, 27 May 2022 02:14:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11-20020a05600c3acb00b003942a244ecbsm1551466wms.16.2022.05.27.02.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 02:14:39 -0700 (PDT)
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
Subject: [PATCH v3 2/2] hook API: fix v2.36.0 regression: hooks should be connected to a TTY
Date:   Fri, 27 May 2022 11:14:31 +0200
Message-Id: <patch-v3-2.2-ec27e3906e1-20220527T090618Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1046.g586767a6996
In-Reply-To: <cover-v3-0.2-00000000000-20220527T090618Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com> <cover-v3-0.2-00000000000-20220527T090618Z-avarab@gmail.com>
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
2.36.1.1046.g586767a6996

