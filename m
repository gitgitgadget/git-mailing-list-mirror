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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB6DC43460
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7532961937
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhCUACd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhCUABs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:48 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1474AC061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:48 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x13so12843685wrs.9
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dgK2r6GAAW9Y+/RBNsBVlKA6hCMcQ2qa7kZ51ZcgCh4=;
        b=oJAUPLG4ySaKZMIflBOGtyzkFHRVx+C5TVPqQ6cUQRx9mags6umuiP59N9ogxZvNr1
         tawPr4tu2gt2WfuPNnbhWo/JYQ+EkY3jBSb85gxueyCTgDZI/yQe4wWdovse2WZfYDip
         53iiCmdeE6vUovY9fXocmOGts/5Y7XHYdo0o58C+8b4tEtWjuZw8LDBsnWHeWXne9r0J
         uqrKcjJGM9OjQv+GBTO3mat6AatUiXXmLmUev/js4AYdO97P7QaG+eCD5c3ESs8nms9U
         PsSlUAV6azFFxau7fBkjUJuNgUvI0aNZqOziaZGzGhJ/MpRc3oxkv2urrl2XLbNxTwfI
         WWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dgK2r6GAAW9Y+/RBNsBVlKA6hCMcQ2qa7kZ51ZcgCh4=;
        b=qa1+K6YNIQiKb3pumro47zHtmS+XA3t13+WvXw3bSkB8DnzirhSU5v9AOtv7m7jSXQ
         VgIaPUE7eSBHIogcKFZp6xi0elvvnV+yhSOj2t83TOu9fP1Tn01AppLXQJedJPlRd8sU
         dH5cX1JlTqnIRVVH7Ysbcx+vk54mRmcz0ZascGaRqtLzD5b0/e+wkVk/vbW+tjpWjupi
         Y0LOg2vCm5QuZvenPgl/vUxRA+PwbC0WYruZzuUt/IwLRA6Rz6FMd9bCgBhSF+hFs3p/
         q6EtqyX3Ga8N8d+zu+29Z891NNmnN3RGv7VKxKgqW0sbGxTqsvuKTOHkhHsU5/Hiujwv
         Dfmg==
X-Gm-Message-State: AOAM5338qC6Wy2DuX2O7IFfUTzueU11Yelf2O6ZLA9XzctPX00HWThNr
        ActV6ar3dVTJqaRIRBqE06+uMoJNLLN2Uw==
X-Google-Smtp-Source: ABdhPJyA2l67KrLkQS5MfqU8TCFy6fujVIGEO0bjmgBt/3WyyL0xhYqCFsfp4rAH/lf0PmcHOGjMiw==
X-Received: by 2002:adf:8b45:: with SMTP id v5mr11103819wra.398.1616284906616;
        Sat, 20 Mar 2021 17:01:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:46 -0700 (PDT)
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
Subject: [PATCH v4 26/29] tree-walk.h API: add get_tree_entry_all()
Date:   Sun, 21 Mar 2021 01:00:59 +0100
Message-Id: <95eec961be8b49e4f2f68ee92f24e95fe6edc04d.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
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
index 070510d6a88..b489a876392 100644
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
index f4473276c9f..a90dbf87af4 100644
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
index a4c54871747..55ef88ef2e5 100644
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
2.31.0.286.gc175f2cb894

