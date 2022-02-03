Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053B5C4332F
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 21:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355387AbiBCVmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355391AbiBCVki (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 16:40:38 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9D8C06174A
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 13:40:32 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id f80-20020a1c1f53000000b0035399b8bedcso7829599wmf.0
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 13:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Op9YF+9+OfnrsPN3KXmysjV7ltAH6TWBKYkETUIM3/A=;
        b=NFgJdE5kO6y8vbO3os9F5nCMno3tDbQ+htLrG501H8nTbjt1DPa8uw/psXVcpvj2wk
         S7YAnyahmeDeIGb/8iWQPx1GfoXJWpRF6Rw7kISk3bkHwJnjHTYumL2wnJ5gB+BDQhle
         S0LAqeJ929Hrr6dPFMYQ8NWs1YjyV+DtYZP/QaD1Z/wsFMuULkc3WKad00CZGHFv1oPc
         lxbhiJWZAf2cKDcfRWWEHhnjXkN44n/qyxfCHqIO1EpS41KHaU3H1BsGqTrLe2AyQyfl
         efqNGjzFEVPGdhvQ6fIGNBY2SMLn2qbCYN7txdizc8ocJJ7x2/VKCsdqzwIGVL3o03aE
         dsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Op9YF+9+OfnrsPN3KXmysjV7ltAH6TWBKYkETUIM3/A=;
        b=GKN6PVbXQaIJSRP1TJBdtnLKOGD8f85OJPVgnt3nGiug36250vn3VrcLKal4gq8Pp0
         m7IAUoE+bJ8435M6vwZQMC35JphG03UqM/8IVRc1wlEEfj3M8+kv8GSeMZpBi1+35KTj
         uHhRpm6aG5Jym2aAnf5WCsQ4hdldWD5wNTTHyeqQGRTj+AwV2q907PvOyF+Gki5LjfkU
         84bwzxlr7zIdNR3AuRpvNoUIKXUvYmbZL1qCPhYrsSCNCSBbHdxwtsI0JnSRfqhTH5zH
         K4h3mIdffuVsj+eSHoASgMIC5GLUz9TmmjlQBhIY4iQRBIeEl5ETa6ejhamqV4EjDMqj
         IFEw==
X-Gm-Message-State: AOAM532hcUqvhMWmoxif8mSgNMYMWkfzoMpxNScwh14VyCtp8Zhg2wIE
        HdtIDIaqWLfpy3zWQAUaflr8C/s1O7ixog==
X-Google-Smtp-Source: ABdhPJzVz0OcMGtpkXr3qsecQX6Y0XICpEQnyNcRzIFK9IA/LsMY3zJnGIPP39n4G8/CS02J6V/BAQ==
X-Received: by 2002:a05:600c:4ca8:: with SMTP id g40mr12210089wmp.55.1643924430626;
        Thu, 03 Feb 2022 13:40:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13sm10637wrf.3.2022.02.03.13.40.29
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
Subject: [PATCH v9 6/9] progress.c: use dereferenced "progress" variable, not "(*p_progress)"
Date:   Thu,  3 Feb 2022 22:40:16 +0100
Message-Id: <patch-v9-6.9-ab24cb78d73-20220203T213350Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.939.g42bf83caa3d
In-Reply-To: <cover-v9-0.9-00000000000-20220203T213350Z-avarab@gmail.com>
References: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com> <cover-v9-0.9-00000000000-20220203T213350Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 98a13647408 (trace2: log progress time and throughput,
2020-05-12) stop_progress() dereferences a "struct progress **"
parameter in several places. Extract a dereferenced variable to reduce
clutter and make it clearer who needs to write to this parameter.

Now instead of using "*p_progress" several times in stop_progress() we
check it once for NULL and then use a dereferenced "progress" variable
thereafter. This uses the same pattern as the adjacent
stop_progress_msg() function, see ac900fddb7f (progress: don't
dereference before checking for NULL, 2020-08-10).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/progress.c b/progress.c
index 680c6a8bf93..6e7daa3f8a2 100644
--- a/progress.c
+++ b/progress.c
@@ -319,21 +319,24 @@ static void finish_if_sparse(struct progress *progress)
 
 void stop_progress(struct progress **p_progress)
 {
+	struct progress *progress;
+
 	if (!p_progress)
 		BUG("don't provide NULL to stop_progress");
+	progress = *p_progress;
 
-	finish_if_sparse(*p_progress);
+	finish_if_sparse(progress);
 
-	if (*p_progress) {
+	if (progress) {
 		trace2_data_intmax("progress", the_repository, "total_objects",
-				   (*p_progress)->total);
+				   progress->total);
 
-		if ((*p_progress)->throughput)
+		if (progress->throughput)
 			trace2_data_intmax("progress", the_repository,
 					   "total_bytes",
-					   (*p_progress)->throughput->curr_total);
+					   progress->throughput->curr_total);
 
-		trace2_region_leave("progress", (*p_progress)->title, the_repository);
+		trace2_region_leave("progress", progress->title, the_repository);
 	}
 
 	stop_progress_msg(p_progress, _("done"));
-- 
2.35.1.939.g42bf83caa3d

