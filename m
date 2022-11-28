Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE17C433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 14:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiK1OKj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 09:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiK1OKT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 09:10:19 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10AA1084
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:10:14 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b21so10240458plc.9
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYzX5I6rIXKYxYK9hhceUWgq+/nrljfdmEc4WBAJG5U=;
        b=MGpY1Vx6nD+jR206gHvK29FAkyJd25vimQqZSQEmN0zWowc+4/7MMlGIdZdigNxnfd
         jklt0Svb97kQEdkEDN7NCM/4M/dsdkkleoKglQE9wyKDCLexwEH88JAUZMih33etVW1p
         6yHAtFdlrtqNGm+TN13JeVZotDi2biey/3H1ftV0uP/FLyrfPLaKAQ/KyuEr47Kzdghs
         SDrkkIIvAn4FowP4NVFFjqho4PH3paSXxN0QmRbYhkhljcpCrrWU8xNBtQ+KNMTwbvaF
         aga+STsDhPoAGWs6SPfB4PuZmfVRarAqLG9bry6TMsKwTnOmfjEI3OVD2xH2WQo5/Zyg
         7ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYzX5I6rIXKYxYK9hhceUWgq+/nrljfdmEc4WBAJG5U=;
        b=Zthlr4AdqDKN8ZfixJIrdMx4EZP5Uhu3QIvjJWc5cX4Y4qw6P/drAv6zWMyFDUCDEa
         dqWj1BJFylBuTytiG2siz1VvlGCtet58bZhyOwQoBlL14o1VqNlYU14TjozHQ9/gSs+D
         FEgeBdIsYgnk8OE/rSCKCrOmCP85SXuuxVG3jL4yJK07p4Gxz+Ki1d4B2gvdyXBDHGSX
         9zhcCzJ0wcMR4+7vWnfR05hVZ35ROkBnBj6MsN66Cjvwp4Vp+D1ABiRB8A8MJtrCh7eA
         7jXcB0/s4ixYYjaaxqfYIl+hF1Du2MFHMU2yzcDRwLj0Rv1Tgk/pfHAuXsbL+L+yjAB8
         Xo6A==
X-Gm-Message-State: ANoB5pk3QlahPSB5LImlqJAdByyFvCGzdiREU3XFLmr7eHawsNTAdZCa
        Hbw5NBbZ7lpUrkBRalyslOI=
X-Google-Smtp-Source: AA0mqf6i6HbLXlEcgQQEVslg0XJi0wSk7KBqfiWNA9Mio6bzvQCFdUabt3L97qGQNsL5uOKyrOgY8Q==
X-Received: by 2002:a17:90a:de90:b0:219:44f2:8618 with SMTP id n16-20020a17090ade9000b0021944f28618mr1614555pjv.79.1669644614275;
        Mon, 28 Nov 2022 06:10:14 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.57])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b0017f64ab80e5sm8842819plg.179.2022.11.28.06.10.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2022 06:10:13 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v5 4/4] pack-bitmap.c: trace bitmap ignore logs when midx-bitmap is found
Date:   Mon, 28 Nov 2022 22:09:53 +0800
Message-Id: <28306b7e8d560f48d3546527c1f60f5126eeb8a1.1669644101.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.385.g28306b7e8d5
In-Reply-To: <cover.1669644101.git.dyroneteng@gmail.com>
References: <cover.1669644101.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

When we find a midx bitmap, we do not bother checking for pack
bitmaps, since we can use only one. But since we will warn of unused
bitmaps via trace2, let's continue looking for pack bitmaps when
tracing is enabled.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 3b6c2f804a..d2a42abf28 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -524,8 +524,6 @@ static int open_pack_bitmap(struct repository *r,
 	struct packed_git *p;
 	int ret = -1;
 
-	assert(!bitmap_git->map);
-
 	for (p = get_all_packs(r); p; p = p->next) {
 		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
 			ret = 0;
@@ -559,11 +557,20 @@ static int open_midx_bitmap(struct repository *r,
 static int open_bitmap(struct repository *r,
 		       struct bitmap_index *bitmap_git)
 {
+	int found;
+
 	assert(!bitmap_git->map);
 
-	if (!open_midx_bitmap(r, bitmap_git))
-		return 0;
-	return open_pack_bitmap(r, bitmap_git);
+	found = !open_midx_bitmap(r, bitmap_git);
+
+	/*
+	 * these will all be skipped if we opened a midx bitmap; but run it
+	 * anyway if tracing is enabled to report the duplicates
+	 */
+	if (!found || trace2_is_enabled())
+		found |= !open_pack_bitmap(r, bitmap_git);
+
+	return found ? 0 : -1;
 }
 
 struct bitmap_index *prepare_bitmap_git(struct repository *r)
-- 
2.38.1.385.g28306b7e8d5

