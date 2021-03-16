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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1D8C43381
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA691650FF
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238309AbhCPQAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238279AbhCPP7F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:59:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C75AC06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:59:05 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l12so10749317wry.2
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ihb+3rn+3oaRK01exj2s3LbU08etq3Y9pyDTOVeTwcw=;
        b=brJAK6w5s37IUcbOoU20a/HHbvbV4LxHIhmzQkyOljJEf+BuAJ4S5jX/+dwJGmimcn
         Z85F8KKLWLTobW4ZA5BQYwTNax8Nn3Jyo4Ewl7toRb37/Lg98GQ9ZtXoqrC6JY1QsN+H
         sCfI4b06P09iZPW8/nfUd7NTc/+MesMyfnnR1rT7Imh+DeBpasttXknPGdalYvzCYLlm
         eVM4xQD21gHNF8Q29/vaHP/5w8BP+sg/2LEwsBWMvFYhwU+Z2gq5K0CWT3+nP+G1N09R
         07LhngbfuRND8aF8ZhQPGeHxCCoYt15xV9vPKf1JyQl2IogtJquBvFASwvf1mwscyT9M
         4smg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ihb+3rn+3oaRK01exj2s3LbU08etq3Y9pyDTOVeTwcw=;
        b=hVH7zKbz4qNX+holGNxorW7BToyyZQZirkunQR10eKFiODFPaD73KdMCIXyTGx7hz6
         2dNBleI2fbzG51LiJbWDURPIsFpr3h8FBaygJ4RU94xSkulD3XwPbvhzy9v0qLsHhBIP
         AzR08tQ0+OgX8AKbRQsI0akGnBN5H0O1DoqwDGiHgREq6NO/wJ/Md748oskqwVIceSR7
         cTqM0/0GMQWevsasZMOOKZdReGJhSEUXyvxDsbkmWdCx3M1AygtRZ2o0LotXoB4brFh3
         OvYpjTeLtX0LbBsjuSPms9J4LnqbOy3KAErkvo8p23NEpVOna8UGKIiYAyabS41dlIWN
         yXTw==
X-Gm-Message-State: AOAM533bv+2cWk2dRkyoJYoUpweHSkuHM30ohhhaPUPIzIJm7QkQJa6q
        x6DUJMmeDW1Jemp3xoaAm6R9t9Ounz7/PQ==
X-Google-Smtp-Source: ABdhPJz9+/baeAaegqfjwTVa9KoH+wxx/3X1Yyrtp1GDdCVzwX53JJD0RmCEZCzdKs6RhAXOfnw66A==
X-Received: by 2002:adf:a3c2:: with SMTP id m2mr5695305wrb.195.1615910343697;
        Tue, 16 Mar 2021 08:59:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:59:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 29/32] tree-walk.h API: add get_tree_entry_all()
Date:   Tue, 16 Mar 2021 16:58:26 +0100
Message-Id: <20210316155829.31242-30-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a get_tree_entry_all() function and use it in the one caller who
cares about both the mode and the object type. Refactor it accordingly
to make it clear which parts care about the mode, and which about the
object_type.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/update-index.c | 6 ++++--
 tree-walk.c            | 9 +--------
 tree-walk.h            | 4 ++++
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 070510d6a8..b489a87639 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -599,16 +599,18 @@ static struct cache_entry *read_one_ent(const char *which,
 					struct object_id *ent, const char *path,
 					int namelen, int stage)
 {
+	enum object_type object_type;
 	unsigned short mode;
 	struct object_id oid;
 	struct cache_entry *ce;
 
-	if (get_tree_entry_mode(the_repository, ent, path, &oid, &mode)) {
+	if (get_tree_entry_all(the_repository, ent, path, &oid,
+			       &mode, &object_type)) {
 		if (which)
 			error("%s: not in %s branch.", path, which);
 		return NULL;
 	}
-	if (mode == S_IFDIR) {
+	if (object_type == OBJ_TREE) {
 		if (which)
 			error("%s: not a blob in %s branch.", path, which);
 		return NULL;
diff --git a/tree-walk.c b/tree-walk.c
index f4473276c9..a90dbf87af 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -559,13 +559,6 @@ struct dir_state {
 	struct object_id oid;
 };
 
-static int get_tree_entry_all(struct repository *r,
-			      const struct object_id *tree_oid,
-			      const char *name,
-			      struct object_id *oid,
-			      unsigned short *mode,
-			      enum object_type *object_type);
-
 static int find_tree_entry(struct repository *r, struct tree_desc *t,
 			   const char *name, struct object_id *result,
 			   unsigned short *mode,
@@ -605,7 +598,7 @@ static int find_tree_entry(struct repository *r, struct tree_desc *t,
 	return -1;
 }
 
-static int get_tree_entry_all(struct repository *r,
+int get_tree_entry_all(struct repository *r,
 		       const struct object_id *tree_oid,
 		       const char *name,
 		       struct object_id *oid,
diff --git a/tree-walk.h b/tree-walk.h
index a4c5487174..55ef88ef2e 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -195,6 +195,7 @@ struct traverse_info {
  *
  * get_tree_entry_mode(): unsigned int mode
  * get_tree_entry_type(): enum object_type
+ * get_tree_entry_all(): unsigned int mode, enum object_type
  */
 int get_tree_entry_mode(struct repository *, const struct object_id *, const char *,
 			struct object_id *,
@@ -202,6 +203,9 @@ int get_tree_entry_mode(struct repository *, const struct object_id *, const cha
 int get_tree_entry_type(struct repository *, const struct object_id *, const char *,
 			struct object_id *,
 			enum object_type *);
+int get_tree_entry_all(struct repository *, const struct object_id *, const char *,
+		       struct object_id *,
+		       unsigned short *, enum object_type *);
 
 /**
  * Generate the full pathname of a tree entry based from the root of the
-- 
2.31.0.256.gf0ddda3145

