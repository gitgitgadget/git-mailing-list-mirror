Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23130C54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 12:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjALMz5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 07:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjALMzi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 07:55:38 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2074ECA8
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:55:36 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id g10so13127688wmo.1
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31tuFpNq7eVLdV/O0mDNyKZE5qgZnSzPGxNRo80/t6Y=;
        b=LJstrtCzi5PTRfyn0xX2Fvppn1KinAe4l8Xo2wNsuqPHAu5mVuPzWkokrNHi9AS2Wb
         dMJPHEJ6fqKZHUWe2+hXFLx4VtFk7gex6HRnRrgKKPA41GqyEAr88P0A1NMiRXf+Egi0
         rzUA3B3OT0G4lqljaLc6YinPj3w0rn4wrG7U9gy6z2qaBsdAaTEauGws4xpggIXvKWO8
         WE+5R5YBxuf/QNtw4m/VILZveJqvL0C2XoEAiJQD3bCRBko+27HJ1cQ5LSYlV87wyGBZ
         JJJyL0dp5LP92dfRWq7M6WeeL0tz9c0151HgHucnym/ABwnOkZ5FQ1wmpAh1AgY/ts7F
         KFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31tuFpNq7eVLdV/O0mDNyKZE5qgZnSzPGxNRo80/t6Y=;
        b=3kiiUBVuWAcinYEAxvWP7zsH6uDXuhknlQ29gHjhiAcbs9t3Rs0TgMZi9TriTtWOdY
         UmUkV5tTA9roer7JHh7or75cS6gXW4tb2Yh9rJ+GwLWuzY12QF7cMr2dahGK5H2UxaUa
         e0fgwaKErF7ZWe/JROSb1IBBla157dWijihbb9ncRR3o9RYaE3j3NmWFxMMFPNc4Hjjv
         gVgL5WifF5W0GyJDqqMXYYKC/GYfolWlB8QiIxW9hxrfBt9L32EAe6b/yGKCgPzsWEcB
         rMGbJ3QTDigIwwQw8bxXZuy9zmRqHBAbfgCrxLGugnkvBaIvJqN2aPSyMXj1AJYtw0du
         x2qA==
X-Gm-Message-State: AFqh2krez9lWz4zRvlL3bRt3JtCND10LuPU/ADQgOtNFt5Ql4d2JUVSi
        3Yc0fXBOdDLkqPjdozWpGCUQxgOsT437uA==
X-Google-Smtp-Source: AMrXdXt4OJW+opJr2EGjKQ9wDdygENFHz5KUMI6jSKGMeclQi7d2cFQsLv70AvFVvgcvyC5ea/GXoQ==
X-Received: by 2002:a05:600c:48a8:b0:3cf:7197:e68a with SMTP id j40-20020a05600c48a800b003cf7197e68amr56290113wmp.18.1673528135046;
        Thu, 12 Jan 2023 04:55:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c154c00b003d9fba3c7a4sm8462473wmg.16.2023.01.12.04.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:55:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/6] read-cache.c: refactor set_new_index_sparsity() for subsequent commit
Date:   Thu, 12 Jan 2023 13:55:26 +0100
Message-Id: <patch-v2-4.6-a75977bd37b-20230112T124842Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1205.g2ca064edc27
In-Reply-To: <cover-v2-0.6-00000000000-20230112T124842Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20230112T124842Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor code added to set_new_index_sparsity() in [1] to eliminate
indentation resulting from putting the body of his function within the
"if" block. Let's instead return early if we have no
istate->repo. This trivial change makes the subsequent commit's diff
smaller.

1. 491df5f679f (read-cache: set sparsity when index is new, 2022-05-10)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 read-cache.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index cf87ad70970..25925c8c002 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2300,12 +2300,12 @@ static void set_new_index_sparsity(struct index_state *istate)
 	 * If the index's repo exists, mark it sparse according to
 	 * repo settings.
 	 */
-	if (istate->repo) {
-		prepare_repo_settings(istate->repo);
-		if (!istate->repo->settings.command_requires_full_index &&
-		    is_sparse_index_allowed(istate, 0))
-			istate->sparse_index = 1;
-	}
+	if (!istate->repo)
+		return;
+	prepare_repo_settings(istate->repo);
+	if (!istate->repo->settings.command_requires_full_index &&
+	    is_sparse_index_allowed(istate, 0))
+		istate->sparse_index = 1;
 }
 
 /* remember to discard_cache() before reading a different cache! */
-- 
2.39.0.1205.g2ca064edc27

