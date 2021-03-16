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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8058C433E6
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC6D65102
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbhCPP7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbhCPP6x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:58:53 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C572C061756
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:53 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso1785598wmi.0
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B1e0auwR7dQ9081R7lapYX5pivO4iWA57pTkN5noa9Y=;
        b=GmO2aP+WH4OR6g8x16udPzFoVe74sOkYXeFqNcLaVxWaXkU9ar0i/ViNI+oYDyGSr9
         /2ibHGnFemEWIQmYrvDMNeFNV3a9jJAyyfnGDHKkNNlItUw8gll+afiy5octCqoCCZdD
         QctSfr7StuRarxESyLj4F4sJydCJMMweh41ZCQ06EgnKpV6rEjjXj4XOxdEioUd0uEK0
         wwlYQRwRX7UJzGsV6+xuvX+g9UpIaAd9O3SwnnzoeZLAd7iYXD7zXRj4ASDi58jBo3fQ
         TRukDn7/9KhD2woYu2fvxMyPoSnzohQU9k/id/A7/MF9yTGe9g2a9mswOVWGr/Imjo1S
         GvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B1e0auwR7dQ9081R7lapYX5pivO4iWA57pTkN5noa9Y=;
        b=sekWp8UakARBucLBXrShNln1Go0H9ZSQRhbMbo0lG9cU3Pq5j5+Vz9WBBZ8ILNQUw3
         fo4HWrPHIrCSqaGr3uF44yfxus41qaa+MwhnTlWORUkLa++FDM29YRVHYTcQ4WQi/lES
         8YLgq53mPWODdCxem+TIwtooqQBCPl2+IBGpAKhLlVhpC818wB6ow97EsA4GZm/1WJpi
         pGItouwlPgrmwwbV8Bxbq6imLQUdSGpXNjj0VfF6avMVf+hnCAbr02IDVO+VMD9/yAnv
         OmjbZzeJ7BCCaIQCNaGzcQ7vFL+iXi8qCVACScsBp2s6DJEt1Xg8LMpmlZVah2Ldf7sO
         Zt7g==
X-Gm-Message-State: AOAM531TzjCq0OKzLp7+03csLvKyeOypCOykuYLx5L2dKtt8F3GD0s2I
        OzSyuVSSbgfgx0V6tUZBO8uuXnc55GQwQg==
X-Google-Smtp-Source: ABdhPJzR6SFDMp1LhaED3MA56/YW3QDZyvjHubwn/raW4MElsq044zTSgFx9hpyHsHrUcT2W6ZmDTw==
X-Received: by 2002:a05:600c:252:: with SMTP id 18mr294164wmj.67.1615910331454;
        Tue, 16 Mar 2021 08:58:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:58:50 -0700 (PDT)
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
Subject: [PATCH v3 15/32] tree-walk.h users: migrate "p->mode &&" pattern
Date:   Tue, 16 Mar 2021 16:58:12 +0100
Message-Id: <20210316155829.31242-16-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code that depends on "p->mode" either being a valid mode or
zero to use a p->object_type comparison to "OBJ_NONE".

The object_type() function in cache.h will not return OBJ_NONE, but
these API users are implicitly relying on the memzero() that happens
in setup_traverse_info().

Since OBJ_NONE is "0" we can also rely on that being zero'd out here,
along with the rest of the structure. I think this is slightly less
clever than "mode not set", and helps to get rid of more uses of
"mode".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-tree.c | 9 +++++----
 merge-ort.c          | 2 +-
 unpack-trees.c       | 4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index de8520778d..2de34c2d48 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -214,7 +214,7 @@ static void unresolved_directory(const struct traverse_info *info,
 	void *buf0, *buf1, *buf2;
 
 	for (p = n; p < n + 3; p++) {
-		if (p->mode && S_ISDIR(p->mode))
+		if (p->object_type == OBJ_TREE)
 			break;
 	}
 	if (n + 3 <= p)
@@ -222,7 +222,7 @@ static void unresolved_directory(const struct traverse_info *info,
 
 	newbase = traverse_path(info, p);
 
-#define ENTRY_OID(e) (((e)->mode && S_ISDIR((e)->mode)) ? &(e)->oid : NULL)
+#define ENTRY_OID(e) (((e)->object_type == OBJ_TREE) ? &(e)->oid : NULL)
 	buf0 = fill_tree_descriptor(r, t + 0, ENTRY_OID(n + 0));
 	buf1 = fill_tree_descriptor(r, t + 1, ENTRY_OID(n + 1));
 	buf2 = fill_tree_descriptor(r, t + 2, ENTRY_OID(n + 2));
@@ -242,7 +242,7 @@ static struct merge_list *link_entry(unsigned stage, const struct traverse_info
 	const char *path;
 	struct merge_list *link;
 
-	if (!n->mode)
+	if (n->object_type == OBJ_NONE)
 		return entry;
 	if (entry)
 		path = entry->path;
@@ -265,7 +265,8 @@ static void unresolved(const struct traverse_info *info, struct name_entry n[3])
 		 * Treat missing entries as directories so that we return
 		 * after unresolved_directory has handled this.
 		 */
-		if (!n[i].mode || S_ISDIR(n[i].mode))
+		if (n[i].object_type == OBJ_NONE ||
+		    n[i].object_type == OBJ_TREE)
 			dirmask |= (1 << i);
 	}
 
diff --git a/merge-ort.c b/merge-ort.c
index 4075d13aaa..4375027914 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -668,7 +668,7 @@ static int collect_merge_info_callback(int n,
 	 * setup_path_info() for tracking.
 	 */
 	p = names;
-	while (!p->mode)
+	while (p->object_type == OBJ_NONE)
 		p++;
 	len = traverse_path_len(info, p->pathlen);
 
diff --git a/unpack-trees.c b/unpack-trees.c
index d9d573df98..802de46228 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -862,7 +862,7 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 	}
 
 	p = names;
-	while (!p->mode)
+	while (p->object_type == OBJ_NONE)
 		p++;
 
 	newinfo = *info;
@@ -1242,7 +1242,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 	const struct name_entry *p = names;
 
 	/* Find first entry with a real name (we could use "mask" too) */
-	while (!p->mode)
+	while (p->object_type == OBJ_NONE)
 		p++;
 
 	if (o->debug_unpack)
-- 
2.31.0.256.gf0ddda3145

