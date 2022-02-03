Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548F3C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 21:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355312AbiBCVme (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355342AbiBCVki (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 16:40:38 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9A5C061744
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 13:40:31 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so2093611wml.5
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 13:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gefqGwflQ7jbsXijpDGGG2GnaQZuNBfUSlTXS2fGJpM=;
        b=dJvB8g0Pv1NDlz0La+qKedxzSGHkBxQ25kybMpBZdoKBHFumhsmq7XRT+aC2NTtJlf
         gfKsjBwbKuDXIQathEfid2dvUUir7TzZNldlkJdQgAGppFSEjyjVj9YtTTcI3ItmlpAQ
         C7MYk2f6XjCc5Zk1xEgM44hbpfOzxu5/LFmjKqHF9JffhVZrP3/S3rA/cD6XIaYI29lG
         gdhBUkiuk0hwcq2uAdr5+8J1L5rEa7pX1D0lMyAH8e3t6Bg5nrSzmxLBf6Xlq/VYLXs9
         H0bmQhq5nLKeKLJ8ChiOnQmVaoLaimLbs6FkfP1Vv3Kja7WC7MUV2JJZjHXV4rgz/oQQ
         QwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gefqGwflQ7jbsXijpDGGG2GnaQZuNBfUSlTXS2fGJpM=;
        b=dc5a9Gj7Rz5yOHYQAZFfNjeQkfQK9RQoJ9xionlo/Ye5u44y5IgYQ1h7IxsYKO0xyx
         /1C4/MQRCCBX+D1DlF05khkiBdt1Q40MaTz8eCryCPy9APfFtI5Mkm7/YaEWmPf1XiU4
         PXQHiVSOqyEnm0o5e5rSElLsyz3ZF9JG4cjPoA369r03TazeRdD+DagamdqexX06eixh
         8nc8FjTQGkkzJhZ9NUnDE4/p1MfY4TyZK6fO+Bdn/GRgVsMbvlwXcd0NezqtHTYK9+0E
         /w4qQAWQ4lzDH+BYaaAON8g5CgoKzcL7YJHMFalntO/RxUDqRInEbdEuKgmRNxyT4tV8
         wCuA==
X-Gm-Message-State: AOAM531qr08kVcD+iP5WWHljTE5F2a3hM7j00ebZs5iX7/tn0Tly4X+c
        6vI0kLsxbgJ9+gaBqCogdxoWXNi7WV2cKw==
X-Google-Smtp-Source: ABdhPJxIZ+unsmPw44vIZygDawb5udJq9Q5IFzz6G+nI7pCWwk3GIoTUx2Zj8CY7eCjPoBpaCvpS3A==
X-Received: by 2002:a05:600c:1914:: with SMTP id j20mr5162500wmq.51.1643924429567;
        Thu, 03 Feb 2022 13:40:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13sm10637wrf.3.2022.02.03.13.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:40:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 5/9] progress.h: format and be consistent with progress.c naming
Date:   Thu,  3 Feb 2022 22:40:15 +0100
Message-Id: <patch-v9-5.9-4ab4eb3a20a-20220203T213350Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.939.g42bf83caa3d
In-Reply-To: <cover-v9-0.9-00000000000-20220203T213350Z-avarab@gmail.com>
References: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com> <cover-v9-0.9-00000000000-20220203T213350Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix an inconsistency introduced in dc6a0757c4f (make struct progress
an opaque type, 2007-10-30) and rename the "progress" parameters to
stop_progress{,_msg}() to "p_progress". Now these match the
corresponding parameters in the *.c code.

While we're at it let's move the definition of the former below the
latter, a subsequent change will start defining stop_progress() in
terms of stop_progress_msg(). Let's also remove the excess whitespace
at the end of the file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/progress.h b/progress.h
index f1913acf73f..4f6806904a8 100644
--- a/progress.h
+++ b/progress.h
@@ -18,7 +18,6 @@ struct progress *start_sparse_progress(const char *title, uint64_t total);
 struct progress *start_delayed_progress(const char *title, uint64_t total);
 struct progress *start_delayed_sparse_progress(const char *title,
 					       uint64_t total);
-void stop_progress(struct progress **progress);
-void stop_progress_msg(struct progress **progress, const char *msg);
-
+void stop_progress_msg(struct progress **p_progress, const char *msg);
+void stop_progress(struct progress **p_progress);
 #endif
-- 
2.35.1.939.g42bf83caa3d

