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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AFDC43381
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E64A601FE
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhCUACV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhCUABk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:40 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AE5C061762
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:40 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id o16so12867294wrn.0
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bzhAk7HLL18ahxJavY+1axicfmQOL1UzRBQ9gOrev9g=;
        b=oG5jd8WAHTKpN+0rZullxUWugNx0IA49mla7nf5d4sB9uD37shD8SQ2q8NphTbizwF
         23u5tf14XB5GDmnMaNBRpPfgLu7oOwK4CAlFO5Q4VQsk+nytpMBpWuvya0Si9NsRwR6M
         LnlyC6ULs1pzz0mh6gL0i2h/jOssnfjFQJyqDN8XQwbig21XUuqnPvqIV/ZqI2bZ0u3t
         9WQ81UptXNgaGBiag7SvmcupOnBqQKyWoGQhMlD5RreqWTZ6UJbhfZDoKbXYTeGy6h2L
         n9RRhcKjAjGwsp5zc40SwCUl5+IhGCs39/Fp38DtP8DhBHFBw0UFLEJrWS0mdwL47laf
         29Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bzhAk7HLL18ahxJavY+1axicfmQOL1UzRBQ9gOrev9g=;
        b=c+Sj3YKZAw6l2r29S7JHBz+tndYW9pU/fUlcF/uW1PiUqYcBGQ6oApLx/ePAKPWgAL
         fT/31t0oWZGNBvGYDaMRl84af2vgpP2V5eYARJuq+QOu7xGpo08cvw5gXgejZltAXcKR
         MRcvgkeSW9pAF+3qDTI3OEQWXmAqg4yTdjhfMLC28na1VEqJU7u2qtQuByrwGyKk7u9I
         o7m3Trz16n7/qdiltv/L052YEOtJ+cMNZc8YvpnNZzKLQx27v56b9pKq4JgnP9fnbz8P
         EB8rVUBfTodcInbnk6FJzFb3PkSQ+5H0PJXIyhfcCirNqu/YWFElXVOlkPQMWRpv/jZm
         Ot5g==
X-Gm-Message-State: AOAM531tYhfGmrnLjBy913jkxPK4X3597KhDbtRrFIwKbWpCweBmGksD
        8JKI/Rf3CM7ASID67N6jDrfNiuk5KWNr1Q==
X-Google-Smtp-Source: ABdhPJx64wBra84//tkDX5V4HSgfUb/LLLiEApUJcg1dMxeSb3/AJj+WXp2dIyjhqKqNkT/sZtvVeQ==
X-Received: by 2002:adf:e60a:: with SMTP id p10mr11250745wrm.291.1616284895526;
        Sat, 20 Mar 2021 17:01:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:34 -0700 (PDT)
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
Subject: [PATCH v4 12/29] tree-walk.h users: migrate "p->mode &&" pattern
Date:   Sun, 21 Mar 2021 01:00:45 +0100
Message-Id: <1c2f65cb674c538eb01152a6a26c64899cef1743.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
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
index 68eaa8f294f..052231efdb2 100644
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
index ea1ce7894ba..e6cb505fcb0 100644
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
2.31.0.286.gc175f2cb894

