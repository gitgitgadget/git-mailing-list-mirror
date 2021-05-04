Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91707C433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 09:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F1596139A
	for <git@archiver.kernel.org>; Tue,  4 May 2021 09:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhEDJ0p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 05:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhEDJ0o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 05:26:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54EAC06174A
        for <git@vger.kernel.org>; Tue,  4 May 2021 02:25:48 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so887406wmh.4
        for <git@vger.kernel.org>; Tue, 04 May 2021 02:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+eOAok5LqpoNecYNkGL2KFLvV9ws6JsQIxC6RHJRsVs=;
        b=moQqXm/Hf8O/wBzOG+Sq+ULaG+xJlokzwoJnF2V/rizXzRucf+2YY6ujetyewAgyGo
         BjwmVMNk+60MgqBQ/7KTZGYQcF6yneQOaAzuIpWbHSvK62s+KJda7U3NI92oI3/SuoY6
         GhDo429dav/dJDnCWF1YhDV+U9u6gOD7ojNB6UCxOgVVYG3tL0jn6LKD/sueNTXqbEjC
         7eZQZmPintv7exJ66F6haZy3zxz1GsruVDYJEHXzP3NRvUCJvmkVtVO28fOdDRLt5p6G
         xnxvH5zDDqazNQOMzC8lqEnSpmAhJo84hv82Z7HGASGP2wKwPYd7/a82s+lKuebdP1Q2
         Qh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+eOAok5LqpoNecYNkGL2KFLvV9ws6JsQIxC6RHJRsVs=;
        b=ANee7+4O1ieufLXa9Er+jEdfx3hWVQHLwqVFDZID9kbnCYtksY8AbbtMhkJ+xOIOZV
         fxq3G7877hDRy1vyRMMbBnjJgNouazBRKjrEeIUCc+a3SDeHcIvxDBRb70PXRvGC0x+0
         6AXojXdMdSowU0JSqo6e+qT/r+IrZX8NaE5j0tUFAIcGUvdXfOlvID0h+0UnYXmQOi7n
         9F2q6o1ssWkBrz+ysQSA4u23J618IToMv4XyH9POWjq3NlV2wkGzCab/D4rpZcRqxTdG
         Jor/ZUuTefSu6YdbvC9JqSk+laNRKqnCdYFMeWquviuM4wOX40T/RA9p9UEEhIdAy6VR
         cvQg==
X-Gm-Message-State: AOAM530EDHNR3+shkCvYWMDoyA/gL3ZPFueq2XZvKH4jyfP/+Tk1XPTF
        xh1vNRHKe9CwO5KinFkPOjSqVND6wa4=
X-Google-Smtp-Source: ABdhPJyoHTFBK3Y8uf3vpcKPdeC/J0uZSukMVoe/ykJIHWkBO2BaWHzbijCGuglCTa4AxfSVIUmNxg==
X-Received: by 2002:a05:600c:35c5:: with SMTP id r5mr16488761wmq.109.1620120347683;
        Tue, 04 May 2021 02:25:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l14sm1969135wmq.4.2021.05.04.02.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 02:25:47 -0700 (PDT)
Message-Id: <a339d1cf9b9ffd6365fca3efda8fb7e10346dda4.1620120345.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.948.git.1620120345.gitgitgadget@gmail.com>
References: <pull.948.git.1620120345.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 May 2021 09:25:44 +0000
Subject: [PATCH 1/2] patience diff: remove unnecessary string comparisons
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

xdl_prepare_env() calls xdl_classify_record() which arranges for the
hashes of non-matching lines to be different so lines can be tested
for equality by comparing just their hashes.

This reduces the time taken to calculate the diff of v2.28.0 to
v2.29.0 by ~3-4%.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xpatience.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index 20699a6f6054..db2d53e89cb0 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -90,7 +90,7 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
 {
 	xrecord_t **records = pass == 1 ?
 		map->env->xdf1.recs : map->env->xdf2.recs;
-	xrecord_t *record = records[line - 1], *other;
+	xrecord_t *record = records[line - 1];
 	/*
 	 * After xdl_prepare_env() (or more precisely, due to
 	 * xdl_classify_record()), the "ha" member of the records (AKA lines)
@@ -104,11 +104,7 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
 	int index = (int)((record->ha << 1) % map->alloc);
 
 	while (map->entries[index].line1) {
-		other = map->env->xdf1.recs[map->entries[index].line1 - 1];
-		if (map->entries[index].hash != record->ha ||
-				!xdl_recmatch(record->ptr, record->size,
-					other->ptr, other->size,
-					map->xpp->flags)) {
+		if (map->entries[index].hash != record->ha) {
 			if (++index >= map->alloc)
 				index = 0;
 			continue;
@@ -253,8 +249,7 @@ static int match(struct hashmap *map, int line1, int line2)
 {
 	xrecord_t *record1 = map->env->xdf1.recs[line1 - 1];
 	xrecord_t *record2 = map->env->xdf2.recs[line2 - 1];
-	return xdl_recmatch(record1->ptr, record1->size,
-		record2->ptr, record2->size, map->xpp->flags);
+	return record1->ha == record2->ha;
 }
 
 static int patience_diff(mmfile_t *file1, mmfile_t *file2,
-- 
gitgitgadget

