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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E723C48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26CEF61003
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhFWRvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhFWRvM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:51:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96851C0611C6
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n23so2212263wms.2
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=koojd2KDRGVk6oc9qwVRPJ2qgo48BnXYozwIv0A9zq8=;
        b=e57A0ID98yPsz2LTl/pBCGddXnLNXPJwE1D6WNaYqkSUpP3BqjOFEbdoas+R8S44GU
         6TAQ372uorlAPey02JpQJkiMiYzm0uX7hB/iUcPlIrcpgXoLnmFlzaljRxg66s3mRDqZ
         OD8GaezoIacnNJTohod+MMby3osKZEi936FFMJTQ52eJW8z15rAJ07XjV++adjQHeTVz
         5pfGxVN4jTXE/JHP+K+GvsA1MycY5BhJwsV/lx347W//6JLy38b2n6I9u/jXvhphcDuS
         GsRnBY0foXGIutLhyLKj0Y8bzh+/InPwC1PFvNzz/ybUQXRnxpAWGby31DGT5qaLhec1
         mOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=koojd2KDRGVk6oc9qwVRPJ2qgo48BnXYozwIv0A9zq8=;
        b=tpxG/1plIjQ9F5fQFC3gOv0BHGH5BJN15QNf6j9inHj605H9/9bBluSU1hlft+Do7U
         4KpYWX6ZkyKtTPscvvHlfhv7d/S/EwJ0/KEksK5v+OGTaerxYWHl4xL1ZQx5AG1cfnat
         Xw4tor20OyCpy2KpCK7MSH82JKmP1agvOxbwCtZKm8/pVbcqq/oNaaQ5ZNEuu7Da3M82
         fFKi4kCd0T+R9BtFKHtscYSE6GgXxc53fl5eqaVsM28FWsf9btIoT8DUxFkx1fqhzfcG
         DOSvbVxexjIpE9ZP/tmm6s9FmQEqSxqBnbeho4W4U/urhXxBLTKoIWkopfwBMJh/Jo/2
         heVw==
X-Gm-Message-State: AOAM533ddyCdvJaThMnSrWywqCWzL9pGeg+r/oL+GW5bQLGj/6PdEMPO
        84UYy1ELBREx82pmVvKjLfgkoEKX49f9/Q==
X-Google-Smtp-Source: ABdhPJwTR3T2mBrb+dd4QRGDDrLwhKDU8V2BEDjSNooMEMeSbosm54862CvPBGsU+Gw5HrvpNBODVg==
X-Received: by 2002:a7b:c2a2:: with SMTP id c2mr1028873wmk.89.1624470525029;
        Wed, 23 Jun 2021 10:48:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 22/25] progress.c: add a stop_progress_early() function
Date:   Wed, 23 Jun 2021 19:48:22 +0200
Message-Id: <patch-22.25-e7f8314867d-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In cases where we error out during processing or otherwise miss
initial "total" estimate we'll still want to show a "done" message and
end our trace2 region, but it won't be true that our total ==
last_update at the end.

So let's add a "last_update" and this stop_progress_early() function
to handle that edge case, this will be used in a subsequent commit.

We could also use a total=0 in such cases, but that would make the
progress output worse for the common non-erroring case. Let's instead
note that we didn't reach the total count, and snap the progress bar
to "100%, done" at the end.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.c | 20 ++++++++++++++++++++
 progress.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/progress.c b/progress.c
index 35847d3a7f2..c1cb01ba975 100644
--- a/progress.c
+++ b/progress.c
@@ -40,6 +40,8 @@ static void display(struct progress *progress, uint64_t n,
 	const char *tp;
 	int show_update = 0;
 
+	progress->last_update = n;
+
 	if (progress->delay && (!progress_update || --progress->delay))
 		return;
 
@@ -413,3 +415,21 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 	free(progress->throughput);
 	free(progress);
 }
+
+void stop_progress_early(struct progress **p_progress)
+{
+	struct progress *progress;
+	struct strbuf sb = STRBUF_INIT;
+
+	if (!p_progress)
+		BUG("don't provide NULL to stop_progress_early");
+	progress = *p_progress;
+	if (!progress)
+		return;
+
+	strbuf_addf(&sb, _(", done at %"PRIuMAX" items, expected %"PRIuMAX"."),
+		    progress->total, progress->last_update);
+	progress->total = progress->last_update;
+	stop_progress_msg(p_progress, sb.buf);
+	strbuf_release(&sb);
+}
diff --git a/progress.h b/progress.h
index ba38447d104..5c5d027d1a0 100644
--- a/progress.h
+++ b/progress.h
@@ -23,6 +23,7 @@ struct progress {
 	struct strbuf status;
 	size_t status_len_utf8;
 
+	uint64_t last_update;
 	uint64_t last_value;
 	uint64_t total;
 	unsigned last_percent;
@@ -56,5 +57,6 @@ struct progress *start_delayed_sparse_progress(const char *title,
 					       uint64_t total);
 void stop_progress(struct progress **progress);
 void stop_progress_msg(struct progress **progress, const char *msg);
+void stop_progress_early(struct progress **p_progress);
 
 #endif
-- 
2.32.0.599.g3967b4fa4ac

