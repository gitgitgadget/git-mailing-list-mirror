Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D2BC433EF
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 08:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238750AbiFGIsz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 04:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238732AbiFGIse (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 04:48:34 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CD493459
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 01:48:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d14so14124788wra.10
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 01:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XhIuk6gnlWqVLdvh5QrUpIoOKi36wUomTRPEnq0ljGg=;
        b=gnECfBmjXLqCIr4cLHwKP/3w1ffGHJ74cVdfQ2jCCYQYQPZMfICkYftj8zmfhD+ck3
         BIn1MgYmVmobwmuOi3L/4MO8qj4Xlr1/lrpEpWTSz7IyfWGyXTPHrf9vwLzrEatd3CoH
         GrU5TKny6yFz7llzjtt++t2onIaCKjd143hpaUOau2rwOFYdfPXMU0RLz17Wa0wr0uy4
         eprBlJ7vZIOOzaWYEh6ScF+ElUrsDq3EAbUd7+rEMt15Rz7FD0iFB3PrwnZmbmwyGIg5
         R+wNtSBiqLMZ4eJbgnhLFxdxk9Xm8DppxKvFWascgG05SM3w4isutbeWLf+vZyQlJ2gl
         I/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XhIuk6gnlWqVLdvh5QrUpIoOKi36wUomTRPEnq0ljGg=;
        b=wwbXGWzfYospeyPAxlNjPaFKCuJiAAPp4chMFfqCiac3U9wu2p/pwzABh90nI+m8fL
         a3wVEHUZUY0MmxSwnJP3l+fXaitwMTkkitseNexJlTXMLC93wjCb7ryO/upIDHS4RBCA
         FJqypD21FQGPkPLJ/VAn7efIaIr5mLVYXTD6ifKXPToZdFz8NNqfEIxBxudAMUX7XehX
         38VFz6qydaRa6CP0p7P87laGSimqoJkSBmCVGB/D6jhEuTH/ec7zGbvx4V1d8NDgbPYo
         hp/I9vQ57NdSIUHmH/gm28w0tjXLN2ty9A5R48o7VNpQJjl9lS/zwyzxkFDXNhMQoo9t
         ZkKA==
X-Gm-Message-State: AOAM531wKGVWe9qzvDi1RQNd9yYkLSSzO6eVwM2Y6q80RB68VysBzWYg
        5mK2OiDmGs0qN0R/ESfiLsFWzlmHsMISjQ==
X-Google-Smtp-Source: ABdhPJwcV9n7KtBZjcHQhFS0m/0pvBCngKAHNXOXeLQ6wgVc5QfnrEnR0jqVb2VeyOz43dDb9be0Pg==
X-Received: by 2002:adf:cc8c:0:b0:210:b30:fa0 with SMTP id p12-20020adfcc8c000000b002100b300fa0mr26503355wrj.130.1654591702949;
        Tue, 07 Jun 2022 01:48:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h11-20020a5d688b000000b0020e63ab5d78sm17297421wru.26.2022.06.07.01.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 01:48:22 -0700 (PDT)
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
Subject: [PATCH v6 0/2] hook API: connect hooks to the TTY again, fixes a v2.36.0 regression
Date:   Tue,  7 Jun 2022 10:48:18 +0200
Message-Id: <cover-v6-0.2-00000000000-20220606T170356Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1173.gcad22db6399
In-Reply-To: <cover-v5-0.2-00000000000-20220602T131858Z-avarab@gmail.com>
References: <cover-v5-0.2-00000000000-20220602T131858Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a v2.36.0 regression[1]. See [2] for the v5. The
reasons for why a regression needs this relatively large change to
move forward is discussed in past rounds, e.g. around [3]. CI at
https://github.com/avar/git/actions/runs/2448496389

Changes since v5:

 * Make the hook run test more meaningful, we now test with "-t" in
   the hook, instead of redirecting one of STDOUT or STDERR.

 * Add a test for both "git hook run" and "git commit", to showh that
   the "git hook run" command and one "real" user of it agree.

1. https://lore.kernel.org/git/cover-v5-0.2-00000000000-20220602T131858Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (2):
  run-command: add an "ungroup" option to run_process_parallel()
  hook API: fix v2.36.0 regression: hooks should be connected to a TTY

Ævar Arnfjörð Bjarmason (2):
  run-command: add an "ungroup" option to run_process_parallel()
  hook API: fix v2.36.0 regression: hooks should be connected to a TTY

 hook.c                      |  1 +
 run-command.c               | 70 +++++++++++++++++++++++++++----------
 run-command.h               | 30 ++++++++++++----
 t/helper/test-run-command.c | 22 ++++++++++--
 t/t0061-run-command.sh      | 30 ++++++++++++++++
 t/t1800-hook.sh             | 31 ++++++++++++++++
 6 files changed, 155 insertions(+), 29 deletions(-)

Range-diff against v5:
1:  d018b7c4441 = 1:  45248c786d7 run-command: add an "ungroup" option to run_process_parallel()
2:  b0f0dc7492a ! 2:  503ef241a52 hook API: fix v2.36.0 regression: hooks should be connected to a TTY
    @@ t/t1800-hook.sh: test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
      '
      
     +test_hook_tty() {
    -+	local fd="$1" &&
    -+
    -+	cat >expect &&
    ++	cat >expect <<-\EOF
    ++	STDOUT TTY
    ++	STDERR TTY
    ++	EOF
     +
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +
    -+	test_hook -C repo pre-commit <<-EOF &&
    -+	{
    -+		test -t 1 && echo >&$fd STDOUT TTY || echo >&$fd STDOUT NO TTY &&
    -+		test -t 2 && echo >&$fd STDERR TTY || echo >&$fd STDERR NO TTY
    -+	} $fd>actual
    -+	EOF
    -+
     +	test_commit -C repo A &&
     +	test_commit -C repo B &&
     +	git -C repo reset --soft HEAD^ &&
    -+	test_terminal git -C repo commit -m"B.new" &&
    ++
    ++	test_hook -C repo pre-commit <<-EOF &&
    ++	test -t 1 && echo STDOUT TTY >>actual || echo STDOUT NO TTY >>actual &&
    ++	test -t 2 && echo STDERR TTY >>actual || echo STDERR NO TTY >>actual
    ++	EOF
    ++
    ++	test_terminal git "$@" &&
     +	test_cmp expect repo/actual
     +}
     +
    -+test_expect_success TTY 'git hook run: stdout and stderr are connected to a TTY: STDOUT redirect' '
    -+	test_hook_tty 1 <<-\EOF
    -+	STDOUT NO TTY
    -+	STDERR TTY
    -+	EOF
    ++test_expect_success TTY 'git hook run: stdout and stderr are connected to a TTY' '
    ++	test_hook_tty -C repo hook run pre-commit
     +'
     +
    -+test_expect_success TTY 'git hook run: stdout and stderr are connected to a TTY: STDERR redirect' '
    -+	test_hook_tty 2 <<-\EOF
    -+	STDOUT TTY
    -+	STDERR NO TTY
    -+	EOF
    ++test_expect_success TTY 'git commit: stdout and stderr are connected to a TTY' '
    ++	test_hook_tty -C repo commit -m"B.new"
     +'
     +
      test_done
-- 
2.36.1.1173.gcad22db6399

