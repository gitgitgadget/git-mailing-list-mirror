Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 030081F453
	for <e@80x24.org>; Tue, 30 Apr 2019 14:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfD3O0D (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 10:26:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46742 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbfD3O0D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 10:26:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id r7so1538378wrr.13
        for <git@vger.kernel.org>; Tue, 30 Apr 2019 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DtZS2Y9NlWvG81Bax4XDwt65qqMiL/RM+ydF2QlEMaM=;
        b=a51afVcVGbHTj5SZzAqEW3EcTb4YHbhCiy6StfIwbZG70BjsJFIHLdjaCxjuSffYGO
         +FJOxQVvccz4n7XpLkB290OhwAtUpZVaCGXC2O3S0SHmbpMrh4ii2aH5iIgHVma1hVxY
         rz4wKuu07x3tBb1QRZVRqc2i41CMspqSxs1AlsQDcO8ZIXcv3qxkMJKlXHDwVJY49Enr
         0wORCIwL8w0UMJudUK96F+Ey3bx1cREh/yLl0zOUWuH0SSddW+4gLTgMSqovBXrRwjt9
         o2Ep1lvALkD3BZcKwehBDt0YSpKhkspfoQjy+lXWmOpu4sTrhXMd30w9cwKF0oh+Wx2Q
         Iv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DtZS2Y9NlWvG81Bax4XDwt65qqMiL/RM+ydF2QlEMaM=;
        b=Rh4F7vGltEEcQHAFMcB5aMFONkYUNNewwc4Ov3Iakz/ho/p1/qAftrrB9gjfd0m1Dt
         OnhyecTWqcA2v0xSGPTXKBVBC2bhB3R/f65bGzbgQVdZRGaQGhDrfrk0uhDS+p6L1MKZ
         vY2fUBQf0s+Kob64GZoxJ0VL0zZEOVl2kiLbzn8ao4xX34N7OLWKVhdntALdafvtOQxp
         E+pEanFKHye5nXaUgxJUHLmu7ARsdKVYU3kBwaCA4xcDV0tANdRgT7wXDRZ/B7iHlSi2
         O54Yw8FVM1cvx5KPih9XiAMZPPA9GzBa43Xt67TjOIk0qRtYAtG3TLlVgTbgB0srngZa
         V3LA==
X-Gm-Message-State: APjAAAVJck9PaNp/HED72LcDRiOKF5b7V3vdszdwRrqHfeysRypLxxFP
        3gqG+0uUt3RnbAAG73H6yzRKv8Gc
X-Google-Smtp-Source: APXvYqw+yPzNOcDu8tq6SN/j1iYflBe7qptc870BNmTpTf2ySum77yHtVix0cD/9Yf2KxpQAAuB+BA==
X-Received: by 2002:a5d:430f:: with SMTP id h15mr17518955wrq.132.1556634361653;
        Tue, 30 Apr 2019 07:26:01 -0700 (PDT)
Received: from localhost.localdomain (x4dbd75f4.dyn.telefonica.de. [77.189.117.244])
        by smtp.gmail.com with ESMTPSA id v25sm29157660wrv.7.2019.04.30.07.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Apr 2019 07:26:00 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] rebase: fix garbled progress display with '-x'
Date:   Tue, 30 Apr 2019 16:25:56 +0200
Message-Id: <20190430142556.20921-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.1181.g24122a4251
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running a command with the 'exec' instruction during an
interactive rebase session, or for a range of commits using 'git
rebase -x', the output can be a bit garbled when the name of the
command is short enough:

  $ git rebase -x true HEAD~5
  Executing: true
  Executing: true
  Executing: true
  Executing: true
  Executing: true)
  Successfully rebased and updated refs/heads/master.

Note the ')' at the end of the last line.  It gets more garbled as the
range of commits increases:

  $ git rebase -x true HEAD~50
  Executing: true)
  [ repeated 3 more times ]
  Executing: true0)
  [ repeated 44 more times ]
  Executing: true00)
  Successfully rebased and updated refs/heads/master.

Those extra numbers and ')' are remnants of the previously displayed
"Rebasing (N/M)" progress lines that are usually completely
overwritten by the "Executing: <cmd>" lines, unless 'cmd' is short and
the "N/M" part is long.

Make sure that the previously displayed "Rebasing (N/M)" line is
completely covered up by printing a terminal width worth of space
characters.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

This issue has already been present in the scripted rebase as well.

As far as I could tell, if any other rebase instruction prints a
message, then that tends to be so long (including abbreviated commit
OIDs and whatnot) that they practically always overwrite that
"Rebasing (N/M)" progress line (well, except, perhaps, when rebasing
billions of commits at a time?).

 sequencer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 546f281898..c2e4baa90e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3631,6 +3631,12 @@ static int pick_commits(struct repository *r,
 			int saved = *end_of_arg;
 			struct stat st;
 
+			if (!opts->verbose)
+				/*
+				 * Fully cover the previous "Rebasing (n/m)"
+				 * progress line.
+				 */
+				fprintf(stderr, "%*s\r", term_columns(), "");
 			*end_of_arg = '\0';
 			res = do_exec(r, arg);
 			*end_of_arg = saved;
-- 
2.21.0.1181.g24122a4251

