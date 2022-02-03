Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0189DC433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 21:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355186AbiBCVko (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355412AbiBCVki (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 16:40:38 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314B0C061757
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 13:40:34 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v123so3117002wme.2
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 13:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PYWUjE4UOevYyYTpr7vP5excF6CF1ZbFF51GkfF5dWg=;
        b=WTIztLlg4Mwpjb2UNkHSa0UPU6UUk/XyYnh8ZaaxVTmffUTVsiZy0kFa7ezPNGWUj6
         OCU3U+0OwKvn1D5Wts7cInyKcXZ8qSQwHvCr6DPrt8Z7hGjHWEUdly9HbPLEupG41wN6
         QruviM5dBa25ZAROgMoX3ucPCNyLsL4OKWcdswY8vBTEjT86nbqgzrb0iGQudYEuhW2V
         s+JSf37RcmZ90Zw6nX9D0H6VPH4IpBL+7iiPJzKCGpdQHApi0xvWufIo5AwTgdORaCTP
         PtN74c5eAGTW1fO2MTM9iZlJBYtRHrrrt1kvFR5ZQwm0O0qjjX+YUPR/rTFLfVmaAKOH
         1grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PYWUjE4UOevYyYTpr7vP5excF6CF1ZbFF51GkfF5dWg=;
        b=ykkt2i2fy/DtSgTvQy9S3AH1sBGJT7Okj4hfv9EPs9nbV6Kl0HOV/SGFIDLvA+cZfY
         28+iDSW90Zhbv4GHXkV0AyNqXuYtrVwrvqwHFLYoHko1Nco6LbH5p76JRfAfrqH7iaH7
         Y4cxhM05HBnUNGZc3nQUYppIcVKyR4qJ7Ul2Xq8EWyDmkc3W6O87zxzTxjr/PvQFLqN9
         bl2Bva1Yg/eaf+p6gZMF5s4Dw0vnPBMIxorxidM7kS0j/szOfl4BkGSisflVEL6fAmf0
         te/w81oPtBdKF97sPXy65lYNW55jPElRwknHZdS/Wcca/V+bDm4AEsM2JIEuspT4x7Qp
         vYXw==
X-Gm-Message-State: AOAM5301MQKodK5SP1saO3X3L7QdxbZYovTsXtPFsGYwcpo5aD86SDcL
        yfvPjoOjv9DdZEI62+jPXThb1l7o2lkBZQ==
X-Google-Smtp-Source: ABdhPJwKG+FBhdhb9gxsJ4o1z+jSefnQQQE9wureRe6p6axAe4VrJKw/iP2wwbT/u3iuc9HXIwrwMg==
X-Received: by 2002:a05:600c:600f:: with SMTP id az15mr12115231wmb.27.1643924432575;
        Thu, 03 Feb 2022 13:40:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13sm10637wrf.3.2022.02.03.13.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:40:31 -0800 (PST)
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
Subject: [PATCH v9 8/9] progress API: unify stop_progress{,_msg}(), fix trace2 bug
Date:   Thu,  3 Feb 2022 22:40:18 +0100
Message-Id: <patch-v9-8.9-62a93bb98b0-20220203T213350Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.939.g42bf83caa3d
In-Reply-To: <cover-v9-0.9-00000000000-20220203T213350Z-avarab@gmail.com>
References: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com> <cover-v9-0.9-00000000000-20220203T213350Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug that's been with us ever since 98a13647408 (trace2: log
progress time and throughput, 2020-05-12), when the
stop_progress_msg() API was used we didn't log a "region_leave" for
the "region_enter" we start in "start_progress_delay()".

The only user of the "stop_progress_msg()" function is
"index-pack". Let's add a previously failing test to check that we
have the same number of "region_enter" and "region_leave" events, with
"-v" we'll log progress even in the test environment.

In addition to that we've had a submarine bug here introduced with
9d81ecb52b5 (progress: add sparse mode to force 100% complete message,
2019-03-21). The "start_sparse_progress()" API would only do the right
thing if the progress was ended with "stop_progress()", not
"stop_progress_msg()".

The only user of that API uses "stop_progress()", but let's still fix
that along with the trace2 issue by making "stop_progress()" a trivial
wrapper for "stop_progress_msg()".

We can also drop the "if (progress)" test from
"finish_if_sparse()". It's now a helper for the small
"stop_progress_msg()" function. We'll already have returned from it if
"progress" is "NULL".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.c                  | 21 +++------------------
 progress.h                  |  6 +++++-
 t/t5316-pack-delta-depth.sh |  6 +++++-
 3 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/progress.c b/progress.c
index 6cc7f902f5e..0cdd875d37f 100644
--- a/progress.c
+++ b/progress.c
@@ -311,8 +311,7 @@ struct progress *start_delayed_sparse_progress(const char *title,
 
 static void finish_if_sparse(struct progress *progress)
 {
-	if (progress &&
-	    progress->sparse &&
+	if (progress->sparse &&
 	    progress->last_value != progress->total)
 		display_progress(progress, progress->total);
 }
@@ -347,22 +346,6 @@ static void log_trace2(struct progress *progress)
 	trace2_region_leave("progress", progress->title, the_repository);
 }
 
-void stop_progress(struct progress **p_progress)
-{
-	struct progress *progress;
-
-	if (!p_progress)
-		BUG("don't provide NULL to stop_progress");
-	progress = *p_progress;
-
-	finish_if_sparse(progress);
-
-	if (progress)
-		log_trace2(*p_progress);
-
-	stop_progress_msg(p_progress, _("done"));
-}
-
 void stop_progress_msg(struct progress **p_progress, const char *msg)
 {
 	struct progress *progress;
@@ -375,8 +358,10 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 		return;
 	*p_progress = NULL;
 
+	finish_if_sparse(progress);
 	if (progress->last_value != -1)
 		force_last_update(progress, msg);
+	log_trace2(progress);
 
 	clear_progress_signal();
 	strbuf_release(&progress->counters_sb);
diff --git a/progress.h b/progress.h
index 4f6806904a8..3a945637c81 100644
--- a/progress.h
+++ b/progress.h
@@ -1,5 +1,6 @@
 #ifndef PROGRESS_H
 #define PROGRESS_H
+#include "gettext.h"
 
 struct progress;
 
@@ -19,5 +20,8 @@ struct progress *start_delayed_progress(const char *title, uint64_t total);
 struct progress *start_delayed_sparse_progress(const char *title,
 					       uint64_t total);
 void stop_progress_msg(struct progress **p_progress, const char *msg);
-void stop_progress(struct progress **p_progress);
+static inline void stop_progress(struct progress **p_progress)
+{
+	stop_progress_msg(p_progress, _("done"));
+}
 #endif
diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
index df524f7b6dd..e9045009a11 100755
--- a/t/t5316-pack-delta-depth.sh
+++ b/t/t5316-pack-delta-depth.sh
@@ -64,7 +64,11 @@ test_expect_success 'create series of packs' '
 			echo $cur &&
 			echo "$(git rev-parse :file) file"
 		} | git pack-objects --stdout >tmp &&
-		git index-pack --stdin --fix-thin <tmp || return 1
+		GIT_TRACE2_EVENT=$PWD/trace \
+		git index-pack -v --stdin --fix-thin <tmp || return 1 &&
+		grep -c region_enter.*progress trace >enter &&
+		grep -c region_leave.*progress trace >leave &&
+		test_cmp enter leave &&
 		prev=$cur
 	done
 '
-- 
2.35.1.939.g42bf83caa3d

