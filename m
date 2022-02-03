Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6D2C433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 21:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355351AbiBCVmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355407AbiBCVki (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 16:40:38 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29223C061753
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 13:40:33 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id j25so6893865wrb.2
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 13:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pI9ghd36MDsbv1Hq4YR9A3KVEgNU00W0YpjZ51rjAUc=;
        b=MJqta+91zsab4GKk26FzPs//lq2B/iiOm+8BcKQ68Z+cPj1x8CaLL/erw/uh6ZgpYw
         pLe/60YrYqKDioGtKR/Bg9mT7TaQRilgWp7LvcZZrCBPlxaESk0bahmEId6VMUd+PYZr
         FVq7ngRnFL/x2ceruIAlcwyZ+f4h1kduyzifCIO7K8onxkLXxt6guPVghvcn9/vQvoZW
         fbNQxDcuWjs9YkPge1bLGJAH/UOZdoOliQHxOO7xngMrv/nehokcTovhf/tQB2IgKGXr
         jwlC4nLaY7GyxqU3Ti7ELV49ZEor/eQcF6ApNgP4ficImlD72AIqIGNMKefvbOqF6hNK
         3cXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pI9ghd36MDsbv1Hq4YR9A3KVEgNU00W0YpjZ51rjAUc=;
        b=GvIpB9p6mSJcivhiMXszkZdgZCGabHFVyR/e5ff8nIqE8C7Wcy3wBBtzL+AqLKjGCZ
         tYUa+OA5HyONxS1CaMM7B2UzJz80210GL5caq5PAx9HB9HvlJRxyw4vtVcfpr2yoLsJu
         uK0FeDLqZZaGlJk6hIA9EwrWCZqu+F2h7n8fJVtey5zqmY/yelxJ5FEW+IS4xqtVnGfa
         1lbMpr2CuR978nrFz9wt0MLB5xwc6gto4af9THhFMal9vTG5KrqkgoKgvY/ALaPJuypd
         PG6HNb3T1axYE0s66AVBuKcZhjrID/lRau77OCMzJ5FEzQ6MJeVXuWt8CvYD0QJ+jsC/
         GHDw==
X-Gm-Message-State: AOAM533vwwsBhxsRCEEUL2dhb+fCjcX+jZnfz/fmCJ4KzmLuDWU/u9EF
        5zqo5quW3sB4404awi0HhFCUduAWxTU6qw==
X-Google-Smtp-Source: ABdhPJxSMnnzMligWO533lFigRSNNGQDWv9K/2xxsSZDgJjB7dYn5zyuKJxXKmho3pu7hhWlTaxZMw==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr31378074wrw.351.1643924431543;
        Thu, 03 Feb 2022 13:40:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13sm10637wrf.3.2022.02.03.13.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:40:30 -0800 (PST)
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
Subject: [PATCH v9 7/9] progress.c: refactor stop_progress{,_msg}() to use helpers
Date:   Thu,  3 Feb 2022 22:40:17 +0100
Message-Id: <patch-v9-7.9-3406d71b499-20220203T213350Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.939.g42bf83caa3d
In-Reply-To: <cover-v9-0.9-00000000000-20220203T213350Z-avarab@gmail.com>
References: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com> <cover-v9-0.9-00000000000-20220203T213350Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create two new static helpers for the stop_progress() and
stop_progress_msg() functions.

As we'll see in the subsequent commit having those two split up
doesn't make much sense, and results in a bug in how we log to
trace2. This narrow preparatory change makes the diff for that
subsequent change smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.c | 64 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/progress.c b/progress.c
index 6e7daa3f8a2..6cc7f902f5e 100644
--- a/progress.c
+++ b/progress.c
@@ -317,6 +317,36 @@ static void finish_if_sparse(struct progress *progress)
 		display_progress(progress, progress->total);
 }
 
+static void force_last_update(struct progress *progress, const char *msg)
+{
+	char *buf;
+	struct throughput *tp = progress->throughput;
+
+	if (tp) {
+		uint64_t now_ns = progress_getnanotime(progress);
+		unsigned int misecs, rate;
+		misecs = ((now_ns - progress->start_ns) * 4398) >> 32;
+		rate = tp->curr_total / (misecs ? misecs : 1);
+		throughput_string(&tp->display, tp->curr_total, rate);
+	}
+	progress_update = 1;
+	buf = xstrfmt(", %s.\n", msg);
+	display(progress, progress->last_value, buf);
+	free(buf);
+}
+
+static void log_trace2(struct progress *progress)
+{
+	trace2_data_intmax("progress", the_repository, "total_objects",
+			   progress->total);
+
+	if (progress->throughput)
+		trace2_data_intmax("progress", the_repository, "total_bytes",
+				   progress->throughput->curr_total);
+
+	trace2_region_leave("progress", progress->title, the_repository);
+}
+
 void stop_progress(struct progress **p_progress)
 {
 	struct progress *progress;
@@ -327,17 +357,8 @@ void stop_progress(struct progress **p_progress)
 
 	finish_if_sparse(progress);
 
-	if (progress) {
-		trace2_data_intmax("progress", the_repository, "total_objects",
-				   progress->total);
-
-		if (progress->throughput)
-			trace2_data_intmax("progress", the_repository,
-					   "total_bytes",
-					   progress->throughput->curr_total);
-
-		trace2_region_leave("progress", progress->title, the_repository);
-	}
+	if (progress)
+		log_trace2(*p_progress);
 
 	stop_progress_msg(p_progress, _("done"));
 }
@@ -353,23 +374,10 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 	if (!progress)
 		return;
 	*p_progress = NULL;
-	if (progress->last_value != -1) {
-		/* Force the last update */
-		char *buf;
-		struct throughput *tp = progress->throughput;
-
-		if (tp) {
-			uint64_t now_ns = progress_getnanotime(progress);
-			unsigned int misecs, rate;
-			misecs = ((now_ns - progress->start_ns) * 4398) >> 32;
-			rate = tp->curr_total / (misecs ? misecs : 1);
-			throughput_string(&tp->display, tp->curr_total, rate);
-		}
-		progress_update = 1;
-		buf = xstrfmt(", %s.\n", msg);
-		display(progress, progress->last_value, buf);
-		free(buf);
-	}
+
+	if (progress->last_value != -1)
+		force_last_update(progress, msg);
+
 	clear_progress_signal();
 	strbuf_release(&progress->counters_sb);
 	if (progress->throughput)
-- 
2.35.1.939.g42bf83caa3d

