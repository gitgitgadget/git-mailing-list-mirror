Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEC3C433EF
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 08:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbiFGIss (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 04:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238734AbiFGIse (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 04:48:34 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AB42AE1A
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 01:48:27 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u8so18780605wrm.13
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YwalYp/exXccnaam8ufdYc/qfOctt9ZxxWgW4GxURkY=;
        b=hQ3FLUtMJKNdJCBfToptQoTvlmu0W5Y8v/C6M+hbseoyKBUpP8V97ghvlNDkp9J+kM
         9LmVRu5DaU4QwZqTO9xNK23IoVhlFI6PIKb3UZduKvbnJVZLumP0b6+1VhDD/5gLX7CH
         Mg73BipMp00rQz/4GFcv05oPAC18alB10BCyKHLx7xSx8v8Eu1VXB8FsDwJ9+De7XJKD
         wYWsr94IF1CnvKY8kYMvGreSIdQF0qUk7rmZBqO68R1ByV+cZ3VvZBZcZa9aoiR6o8Ub
         rx7i7Ksgk1PTaazg+suxX1Y8p+K0M0I+oVj0o2XBQ+XtliUFMawXS4O19KH4L7AUsj+k
         x5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YwalYp/exXccnaam8ufdYc/qfOctt9ZxxWgW4GxURkY=;
        b=XEMncybdbH/NgVQEHDJr/03iQaoLQYa7fCnTXsF33dAs8L/16O5oiOo7UNqrOn851q
         VjFuc4+GSeyvNN99O6wGfqMu/v9F++LiUFWujibO+4lwbaWKGy8gsYCjhKZL6V/aCr5n
         dGf5y8kaeGoGeFqD88t8gBngFTjukE8PIJwEW+47lHwowwrKB2QQDDsB0SBDJqP0uJ1x
         0ydRCEKPAX0+PnpLcBV0ATypaEP8RzHu2sORl/EyNiesV7dTT7P9o1PDCqvyuT0kZlbc
         91n72E9Ypw94EZ8WjkMrTqmpH+zj5y87/tpipxZ0JyRKPNNTjSCDXnOFfYO8iTSxhq1S
         7Y5g==
X-Gm-Message-State: AOAM533Vu5+jZoUu4RWQm/G4z7hcEVaamM2jgOfGe3TPQ+ozJrl2c6Qj
        U2+NUWvVCMbVfSbgwpULsBr9HuCTRpKWlw==
X-Google-Smtp-Source: ABdhPJyOQTKfF/L2BBpUhcRm6O1NimlKG+aSLKMpRXgUChosT8PXlBUDvk4zSm8Zbq9kY8EBTJvUvw==
X-Received: by 2002:a5d:64e6:0:b0:218:29d3:ee74 with SMTP id g6-20020a5d64e6000000b0021829d3ee74mr11111153wri.657.1654591705564;
        Tue, 07 Jun 2022 01:48:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h11-20020a5d688b000000b0020e63ab5d78sm17297421wru.26.2022.06.07.01.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 01:48:24 -0700 (PDT)
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
Subject: [PATCH v6 2/2] hook API: fix v2.36.0 regression: hooks should be connected to a TTY
Date:   Tue,  7 Jun 2022 10:48:20 +0200
Message-Id: <patch-v6-2.2-503ef241a52-20220606T170356Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1173.gcad22db6399
In-Reply-To: <cover-v6-0.2-00000000000-20220606T170356Z-avarab@gmail.com>
References: <cover-v5-0.2-00000000000-20220602T131858Z-avarab@gmail.com> <cover-v6-0.2-00000000000-20220606T170356Z-avarab@gmail.com>
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
 t/t1800-hook.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

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
index 26ed5e11bc8..0175a0664da 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -4,6 +4,7 @@ test_description='git-hook command'
 
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 test_expect_success 'git hook usage' '
 	test_expect_code 129 git hook &&
@@ -120,4 +121,34 @@ test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
 	test_cmp expect actual
 '
 
+test_hook_tty() {
+	cat >expect <<-\EOF
+	STDOUT TTY
+	STDERR TTY
+	EOF
+
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+
+	test_commit -C repo A &&
+	test_commit -C repo B &&
+	git -C repo reset --soft HEAD^ &&
+
+	test_hook -C repo pre-commit <<-EOF &&
+	test -t 1 && echo STDOUT TTY >>actual || echo STDOUT NO TTY >>actual &&
+	test -t 2 && echo STDERR TTY >>actual || echo STDERR NO TTY >>actual
+	EOF
+
+	test_terminal git "$@" &&
+	test_cmp expect repo/actual
+}
+
+test_expect_success TTY 'git hook run: stdout and stderr are connected to a TTY' '
+	test_hook_tty -C repo hook run pre-commit
+'
+
+test_expect_success TTY 'git commit: stdout and stderr are connected to a TTY' '
+	test_hook_tty -C repo commit -m"B.new"
+'
+
 test_done
-- 
2.36.1.1173.gcad22db6399

