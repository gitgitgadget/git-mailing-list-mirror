Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8151EC433E6
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 23:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A2164F6A
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 23:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbhCOXoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 19:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhCOXoE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 19:44:04 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4819FC061756
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 16:44:04 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so401885wml.2
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 16:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IedyVXvepslcJcxAu1Ehwt/3yJwg7LW3tTzo1nSXfwc=;
        b=kVPpm4AdrPo0lF/neUwLH4rH7avmLEiVQLMSW2p6Wgk0X6vVvKmZUlISAlOzf7BGz2
         vFbVVacV3LgRrOsKXY9Ayjd4pOXNSJtvU+OZM+KeBQWR7zjAIey6gfR5YmkE7k+wqmnz
         czYHwOIu+UBVB4rS2Pa8t0Sez+Hz6W4ol5mXvdCdWtlE8yQI3vCxiyOOFN/pQuhOE5+m
         tmKygnl396UNYHDUvp6N+qClr04YbvUPByPKR9NBj2cbYKTSIKCHvhiJWwaAVNmVW/jf
         3r4xu6IE2QNoD/iE4xul9UDUsa73JO8ECgKy+jxLfrVA4hsToHGDDuKCQwKgfS1KyC0M
         t2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IedyVXvepslcJcxAu1Ehwt/3yJwg7LW3tTzo1nSXfwc=;
        b=UHVaDSgQqnH3Z679vTSD1zekT0SgeDIKTJx7LrDI2oQGTXxxw/X5MMNmyXa9hTgQBU
         oiWaO7dyQ8FGjZfPQDghBTiQle7xcNaqdv5b8ishkJe5cup/mx8YZJ29QtKbAVSwI0V9
         QjA2hhn0W22O3k1mm7DFIhXrirznA7/TaV61JDRVeULNMJLw/5rMO9XrXhUHwuKYg3D2
         FTj3RT8OSFSjhrFrG2gsQqELHSkeQWV1tVNguzM6Kf+nXclbRgz7FwWVgx6qJN0vAzTu
         m1g4cFhU769J9tZBcWGnNlOUJzYyYdXUrMUsALfg//FyGKmQ2fQnKczchKG5eIH/REdY
         2beQ==
X-Gm-Message-State: AOAM533oo0I5wyX63bGXmjUqZjy08iPcNDGus5bzAB8/WaXM3RJMlqeD
        f9arSK6Sr5w1bzR/HlWSVb4a4Z76Ntfq0A==
X-Google-Smtp-Source: ABdhPJzAPiHmRl+WdfhCDlbU+7ALHCyt/HQj/r+tGLU/mqOFpXtxJlduHDN3aXusoo4/h/HO/CZOpA==
X-Received: by 2002:a05:600c:2197:: with SMTP id e23mr1828783wme.39.1615851842834;
        Mon, 15 Mar 2021 16:44:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z7sm20417268wrt.70.2021.03.15.16.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 16:44:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/9] ls-files: don't needlessly pass around stage variable
Date:   Tue, 16 Mar 2021 00:43:38 +0100
Message-Id: <20210315234344.28427-4-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that read_tree() has been moved to ls-files.c we can get rid of
the stage != 1 case that'll never happen.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-files.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a4458622813..74d572a3e4a 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -470,21 +470,12 @@ static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base
 }
 
 
-static int read_tree(struct repository *r, struct tree *tree, int stage,
+static int read_tree(struct repository *r, struct tree *tree,
 		     struct pathspec *match, struct index_state *istate)
 {
 	read_tree_fn_t fn = NULL;
 	int i, err;
 
-	/*
-	 * Currently the only existing callers of this function all
-	 * call it with stage=1 and after making sure there is nothing
-	 * at that stage; we could always use read_one_entry_quick().
-	 *
-	 * But when we decide to straighten out git-read-tree not to
-	 * use unpack_trees() in some cases, this will probably start
-	 * to matter.
-	 */
 
 	/*
 	 * See if we have cache entry at the stage.  If so,
@@ -493,13 +484,13 @@ static int read_tree(struct repository *r, struct tree *tree, int stage,
 	 */
 	for (i = 0; !fn && i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
-		if (ce_stage(ce) == stage)
+		if (ce_stage(ce) == 1)
 			fn = read_one_entry;
 	}
 
 	if (!fn)
 		fn = read_one_entry_quick;
-	err = read_tree_recursive(r, tree, "", 0, stage, match, fn, istate);
+	err = read_tree_recursive(r, tree, "", 0, 1, match, fn, istate);
 	if (fn == read_one_entry || err)
 		return err;
 
@@ -549,7 +540,7 @@ void overlay_tree_on_index(struct index_state *istate,
 			       PATHSPEC_PREFER_CWD, prefix, matchbuf);
 	} else
 		memset(&pathspec, 0, sizeof(pathspec));
-	if (read_tree(the_repository, tree, 1, &pathspec, istate))
+	if (read_tree(the_repository, tree, &pathspec, istate))
 		die("unable to read tree entries %s", tree_name);
 
 	for (i = 0; i < istate->cache_nr; i++) {
-- 
2.31.0.rc2.211.g1d0b8788b3

