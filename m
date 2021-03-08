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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1B6C43332
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE82465231
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhCHPHs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbhCHPHU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:20 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B0FC06175F
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:20 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id f12so11801728wrx.8
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dqZJb5VcTCxvRphJVHXc26pgXJGj04zKVMdc5+0NWkM=;
        b=XXIccVwieny1zZfZHFV/So+5mqPHEia7e5CGsRGzCzNXagK5SDxHBuTuYfKPyZuwSh
         Lm1MxLaE7qqIIZiso0IqcTS9hnhPwg5ZTvO8caN8X/wKBfrlgiftyIQ6koSYceTUvH3u
         IKSnlYnf4a7/yBsB99wvKbHQ9S8VFflJ3E90+GTywKj9/C+13DHUOH+dRYE6GoJYKbTv
         eJu8SpP6y++owtXDyLvGaNsFjlezASY2mWshmCrxcqA+Tx34prV8GKjSFg1uwT0rjZlx
         RnkVkGZXrja4w0U9u0czjeb4bGOzm5vDimk4OAOKTW81Gkv0NsMFH8ywcLJDBCaxQct+
         sSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dqZJb5VcTCxvRphJVHXc26pgXJGj04zKVMdc5+0NWkM=;
        b=fYNE4awlioVP3lenuM6MqaixZ9kXKD8IFJs6VtDMh/e9OeEfBQwsAssebPs2hT9O5k
         FC47MMyRLTovp3MNFH/Klf8SwJRBn8+t/gIp98roJ3B7eYb9yi2em/vpTxlpjrihq+HT
         CsNs6DuBuFmd1Z7vfWSlibCMzEdtMw2mTMiUSqULfK96AnmtRYXrp91x6mDegcDYTWYE
         /WcWIMR4V68vYjmjveFoeJHTup41Rqqoh6ej6PA+ZfuB68g1yRQF4OYDwvbU4N+EbUBW
         Ux2xba19YWttzg4y8+vR8Fx/+Y7/c2sf8bDndXRsNj0okDnSl3GgS5ZE50fT5wjRbMzr
         NuOg==
X-Gm-Message-State: AOAM532GeWUIHqDNBZksayEX/s6uQq3w491F6jJzdLnwLbb8MqmkJsIb
        5kBL3fs7b9U8twmxhuBQeaaob7cDtueUxA==
X-Google-Smtp-Source: ABdhPJz5XHVvTGH9U11GUihUdR9tPi9p2LKtNR/hNxzksxDWtnYki6O1i0mMOtZvpgNzxqmhNVLoyA==
X-Received: by 2002:adf:ee4f:: with SMTP id w15mr23418505wro.199.1615216038559;
        Mon, 08 Mar 2021 07:07:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:18 -0800 (PST)
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
Subject: [PATCH 12/30] tree-walk.h users: migrate "p->mode &&" pattern
Date:   Mon,  8 Mar 2021 16:06:32 +0100
Message-Id: <20210308150650.18626-13-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code that dpends on "p->mode" either being a valid mode or zero
to use a p->object_type comparison to "OBJ_NONE".

The object_type() function in cache.h will not return OBJ_NONE, but in
this these API users are implicitly relying on the memzero() that
happens in setup_traverse_info().

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
index 802f7771d75..92105135522 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -859,7 +859,7 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 	}
 
 	p = names;
-	while (!p->mode)
+	while (p->object_type == OBJ_NONE)
 		p++;
 
 	newinfo = *info;
@@ -1239,7 +1239,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 	const struct name_entry *p = names;
 
 	/* Find first entry with a real name (we could use "mask" too) */
-	while (!p->mode)
+	while (p->object_type == OBJ_NONE)
 		p++;
 
 	if (o->debug_unpack)
-- 
2.31.0.rc0.126.g04f22c5b82

