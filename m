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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C66C48BE5
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97B3F611C1
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhFWRvg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhFWRvR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:51:17 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE255C061198
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m18so3601825wrv.2
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5OKH/i3dTvmI+x3R6+WrMbtVpxjw5d8f5ggfGKosnHg=;
        b=tp0j1PQbOLM+S/i5w+opeVjCkkOhjoqYuru/O2gr7mtoAELNfrYef4jlIM5DzjpQCn
         J6BPd/yWwe/zURQbqkGpLjHRloWLFpKaXkMFdaehfJwSpVMrcrGLZ51htakruQkV/ltC
         1hQuH9oGPEUPGm54yUnI1hzXW34fCm+f81jRUtCpjLxX8UOoPl7bWgul/zG0xWvYT5M4
         u6M0Lu5DVt804GcaHcGFwrHEHLvRG2/Pwk6AVtguA0CCmP6o18n+9aQYm8sZm/a0rtMQ
         FiD8QSxtgH4O7TegXDHVIOUkZ7EZpD/UR+f9/hLn7ztUpuBzKhCXCHO+nul1j4z8d6iF
         v1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5OKH/i3dTvmI+x3R6+WrMbtVpxjw5d8f5ggfGKosnHg=;
        b=gBRmPUThNAwTjqoBjq2BX6ANeG8LN5V0b19uPeAGsVTkKxqIyjXaIfz8uQSbSsRQzD
         6UCXZoSrqxzP++kAQZi/ruTY+0gxhrZjNdhZ88flNSYpQM4qFKJbmXoCdIg9X7zXpVuf
         FfAATvYYKGGfbevUtOuXQ/X7nkr5MLfY9F/Ffppl0Nik+yRJVBCQQJDqI9s5NQwvvj9/
         T9g8KFkHHiSY3xtMoEhWdvCIzugkyABVmKtPqtwcWx0Zpn/Kx51MadXaJVwCzPAw0GQz
         4/lkMcsIfFd0Bzr6dxBN+IIAbT1C2Wj4TQR0Da2dAO8UZuBX1mpVxZtDVq9sdlwFDWtH
         ihJA==
X-Gm-Message-State: AOAM531FZRAfwHo05iZ05fCrMgCzL62gvFm1ONEyceTxeZexQzKwNP2O
        C+BfNe06AofAGs22w5gQ+q/mtKXw++pUVA==
X-Google-Smtp-Source: ABdhPJxRifaXT3Wcd1heyqEh4ytchOt0qE8ik/1lYxGVp1b/hNx1mwMR5/XPWrZ59sf/8vDBpouQHg==
X-Received: by 2002:adf:cd02:: with SMTP id w2mr1480696wrm.258.1624470527109;
        Wed, 23 Jun 2021 10:48:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 25/25] progress: assert counting upwards in display()
Date:   Wed, 23 Jun 2021 19:48:25 +0200
Message-Id: <patch-25.25-099e9c019a9-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: SZEDER Gábor <szeder.dev@gmail.com>

We had to fix a buggy progress line recently, where the progress
counter counted backwards, see 8e118e8490 (pack-objects: update
"nr_seen" progress based on pack-reused count, 2021-04-11).

Let's add a BUG(...) assertion that makes use of the "last_update"
value to make sure this doesn't happen again, i.e.  trigger a BUG()
when the counter passed to display_progress() is smaller than the
previous value.

Note that we allow subsequent display_progress() calls with the same
counter value, because:

  - Strictly speaking, it's not wrong to do so.

  - Forbidding it might make the code calling display_progress() more
    complex; I suspect that would be the case with e.g. the "Updating
    index flags" progress line in 'unpack-trees.c', where the counter
    is increased in recursive function calls.

  - We would need to special case the internal display() call in
    stop_progress_msg(), because it uses the same counter value as the
    last display_progress() call, which would trigger this BUG().

't0500-progress-display.sh' countains a few tests that check how
shortened progress lines are covered up, and one of them ('progress
shortens - crazy caller') shortens the progress line by counting
backwards.  From now on that test would trigger this BUG(), so remove
it; the other test cases cover shortening progress lines sufficiently.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

WARNING: I belive this is subtly buggy, see the discussion in the
cover letter. It needs more fixes of the progress.c API usage in
various places before being ready.

 progress.c                  |  2 ++
 t/t0500-progress-display.sh | 36 ++++++++++++------------------------
 2 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/progress.c b/progress.c
index 40043bf6601..7b59006c7c4 100644
--- a/progress.c
+++ b/progress.c
@@ -40,6 +40,8 @@ static void display(struct progress *progress, uint64_t n,
 	const char *tp;
 	int show_update = 0;
 
+	if (progress->last_update != -1 && n < progress->last_update)
+		BUG("counting backwards with display_progress()");
 	progress->last_update = n;
 
 	if (progress->delay && (!progress_update || --progress->delay))
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 3f00e52ce46..de59a757f86 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -211,30 +211,6 @@ EOF
 	test_cmp expect out
 '
 
-# Progress counter goes backwards, this should not happen in practice.
-test_expect_success 'progress shortens - crazy caller' '
-	cat >expect <<-\EOF &&
-	Working hard:  10% (100/1000)<CR>
-	Working hard:  20% (200/1000)<CR>
-	Working hard:   0% (1/1000)  <CR>
-	Working hard: 100% (1000/1000)<CR>
-	Working hard: 100% (1000/1000), done.
-	EOF
-
-	cat >in <<-\EOF &&
-	start 1000
-	progress 100
-	progress 200
-	progress 1
-	progress 1000
-	stop
-	EOF
-	test-tool progress <in 2>stderr &&
-
-	show_cr <stderr >out &&
-	test_cmp expect out
-'
-
 test_expect_success 'progress display with throughput' '
 	cat >expect <<-\EOF &&
 	Working hard: 0, stalled.<CR>
@@ -451,4 +427,16 @@ test_expect_success 'BUG: display_progress() does not reach declared "total"' '
 	grep "BUG:.*total progress does not match" stderr
 '
 
+test_expect_success 'BUG: display_progres() counting backwards' '
+	cat >in <<-\EOF &&
+	start 3
+	progress 1
+	progress 2
+	progress 1
+	EOF
+
+	test_must_fail test-tool progress <in 2>stderr &&
+	grep "BUG:.*counting backwards" stderr
+'
+
 test_done
-- 
2.32.0.599.g3967b4fa4ac

