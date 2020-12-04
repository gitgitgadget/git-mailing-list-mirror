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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB40CC193FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A6BE22CF6
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387999AbgLDUuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387781AbgLDUuM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:50:12 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E96BC094242
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 12:48:34 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id s8so6569084wrw.10
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 12:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K29zBB+AFMmeMA/iUOnzryDPtPH0Jw7ZArcsBIzNtsY=;
        b=qQ7x2IcwR4XUxqyQgRNj/0WQRLuQMtQXHj9qGc0VwdWylwdn3NNLnuAf+ClfClIpGT
         CHLGfAfO7V8+lOtMDZhQQ6TfsLPxsLFAboQT7LidhaxUxMbHz6ScTjUecyF1aMxsir9Z
         lDMIz1wbAUYk7o4N56ZZtZotkgSLA0UUKHAskrWE6ueUtuGu3X+XX1J9mbohkotZSWHp
         WjrlLA+KDqY+UrOLVgJIVvJz1QL2gqHWWTh34ZkEYQk9WVS8eAzYq5GIp3T7P086+im1
         Wi13NDxivmhuV/ftuaYzZFf9Te0kJhf9SHqumt4uWCPjhIA2LGWc0KZ1TMN7QRln25d9
         8BiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K29zBB+AFMmeMA/iUOnzryDPtPH0Jw7ZArcsBIzNtsY=;
        b=Al4dUggFqEDOsC1/Q7zsZlVbbH/w7kEHfkHhnR2qH47fklJxbA3pqXpjEXOTqXUVSm
         5udMSAR4v2rBtL3BjNT6isA+hDbMgQuiFiZ19OMvZR8Yh8rUvnSFIkP4d/6oT/1BABQZ
         EEY4silIfxnjnGRc6qFgDsWS6GXJ2kmgq9YrcGEtFPKImVrQJLafNgNiJtbknl5PGe+O
         /qDmrh7Z2zlLCRhWni0/40P0dZBRqITUFqk1RdJXC8J23VUp5tTg5IEvXYbP3wot0GQZ
         7Sn2W+Kr54ner4RhUcA7J0fUhj7/ox3pCZmm7JAaEvKjqPAYW9B7HaVYiohPEMBuYDxV
         B/HA==
X-Gm-Message-State: AOAM532xC5drXgRCpJ5tgmm0W/VO+Y6Zxi4yhR4P0swllIgM/tvL4Sez
        NKrYjXgokp5y2pEfWKI0WeZhdCxCZgo=
X-Google-Smtp-Source: ABdhPJzH25DmPZo/JtnChSb+eVK9an79u3bn1UY1pgMR2hNk5IbK4HGsRhXToicvzYYwJb5PlzgBRA==
X-Received: by 2002:a5d:4f10:: with SMTP id c16mr6836099wru.39.1607114912985;
        Fri, 04 Dec 2020 12:48:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y130sm4690822wmc.22.2020.12.04.12.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 12:48:32 -0800 (PST)
Message-Id: <fbeb527d671e55c9264b52146e7d43522cfa7261.1607114891.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
        <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 20:48:10 +0000
Subject: [PATCH v2 20/20] merge-ort: free data structures in merge_finalize()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index faebee8e7e..5d13932dd9 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -182,6 +182,16 @@ struct conflict_info {
 	assert((ci) && !(mi)->clean);        \
 } while (0)
 
+static void free_strmap_strings(struct strmap *map)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	strmap_for_each_entry(map, &iter, entry) {
+		free((char*)entry->key);
+	}
+}
+
 static int err(struct merge_options *opt, const char *err, ...)
 {
 	va_list params;
@@ -1126,7 +1136,27 @@ void merge_switch_to_result(struct merge_options *opt,
 void merge_finalize(struct merge_options *opt,
 		    struct merge_result *result)
 {
-	die("Not yet implemented");
+	struct merge_options_internal *opti = result->priv;
+
+	assert(opt->priv == NULL);
+
+	/*
+	 * We marked opti->paths with strdup_strings = 0, so that we
+	 * wouldn't have to make another copy of the fullpath created by
+	 * make_traverse_path from setup_path_info().  But, now that we've
+	 * used it and have no other references to these strings, it is time
+	 * to deallocate them.
+	 */
+	free_strmap_strings(&opti->paths);
+	strmap_clear(&opti->paths, 1);
+
+	/*
+	 * All keys and values in opti->conflicted are a subset of those in
+	 * opti->paths.  We don't want to deallocate anything twice, so we
+	 * don't free the keys and we pass 0 for free_values.
+	 */
+	strmap_clear(&opti->conflicted, 0);
+	FREE_AND_NULL(opti);
 }
 
 static void merge_start(struct merge_options *opt, struct merge_result *result)
-- 
gitgitgadget
