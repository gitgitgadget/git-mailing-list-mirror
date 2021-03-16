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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A2DC43603
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3584B65024
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhCPCOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbhCPCNz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:13:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386F8C061756
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:43 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so550256wmi.3
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MJI73Had1MhMkvOcsw9JObAb7Wp6gbDeCQ7qTuWirUs=;
        b=Ck4IfK3yPVkg9PhSIjW885WGX9mXtpWr8efZKrCAM0G/ta+X/mbSBnObqIz/gZU23B
         +1FRw/17yxP3hhHXng+laV7OWCDbRpHAJJdHDMM/LKpjAb5lT6UODfrKL1LZw2iXSjsI
         6jjLN1CqwM2Yb5fZUcl6TuaJsUEpqcGzGqItXisF8iEze2KXLnCm6ukZOBbchK8dZLL/
         nUaIOklYTyLvARPeuUN5LBCtxQTFPTq/Fp4d5LbneOw2SKJVj5taPFrv9xmj9A9TVXc8
         5xF9O9eW/OwMuBsq/s7Ma2bzONmesaExTXZrRImqbpFUSNLAYNsPd0VfHuS1rp+3lqvk
         fM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MJI73Had1MhMkvOcsw9JObAb7Wp6gbDeCQ7qTuWirUs=;
        b=KWRM7aixO4811QOtc9ErnCjkjT6n5N/tSmPHVdDLxXVFy22gCP5cWoe8bRmEkFdjiG
         JuiuO57e90DHBOqx0SJ/e6djwjMJwV6OhiMt1qpf6+AB/wb5B4IsKvauljmeZbgxMPSv
         UVopqo7JCa+IfgaWLWIYhXGagwRkHvkEBib9BH1VcN7NbfBUCN9IQXjA3r5Oq9joCj83
         g5lrYxxQjTDJ33NhntwcJujFcFQkhhXhabiCTCOKOM/06gjZLmWxTnS9aryHG7qDlyAO
         XXV8SIKyVLfaJLFWQPVtAwYOjLOTWvs/rIHjVPfuhUTTbV+eNxfPq5hjCyD73p+/kfDl
         d6HA==
X-Gm-Message-State: AOAM533t4M/gwKfG3C+iRD7wk4nXZWRH1soDJ5uEeNPd3eTgTI2k1y+W
        RPfaN26Tl6C7Zd45Bk6enn08v0OH5c3dDw==
X-Google-Smtp-Source: ABdhPJzteQMABS63NTyBKXPm7wFbn3IAeOuFpEgriA29IoJTD9s61EA7MRDV/xCb0S7LgUyqdBOhvw==
X-Received: by 2002:a1c:9854:: with SMTP id a81mr2175373wme.19.1615860821542;
        Mon, 15 Mar 2021 19:13:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm21092494wrx.43.2021.03.15.19.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:13:40 -0700 (PDT)
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
Subject: [PATCH v2 12/29] tree-walk.h users: migrate "p->mode &&" pattern
Date:   Tue, 16 Mar 2021 03:12:55 +0100
Message-Id: <20210316021312.13927-13-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
References: <20210308150650.18626-1-avarab@gmail.com>
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
index de8520778d2..2de34c2d485 100644
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
index 4075d13aaab..4375027914c 100644
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
index d9d573df986..802de46228b 100644
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
2.31.0.rc2.211.g1d0b8788b3

