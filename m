Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066CEC433EF
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 17:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiCZRQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Mar 2022 13:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiCZRQO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Mar 2022 13:16:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA4435AA8
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 10:14:37 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u16so14683046wru.4
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 10:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tokKn3kJoQhtfoKIy68C85T1SUOGLJ/PBvKnvlsBPwI=;
        b=l/EGxKk+4ycBOWboDEU5zp+tP750RRUGV97g4EcJpbqOJ06cIFlaJTIvDrP2Ne9iG+
         g/hzzWGx0pnzf0CfU5LdLW9eqbdmtfb23GMIY4q6XvyB6Zn2nZw/w4kD96peJb4XJkcC
         cFzicTWDS11MJyejkkvmRmHup2/GO+t8eBnIQeIv+2OGiALJXgl73qZUcBvov7eFG2aA
         47yPLNu8cpMmfJPOC83ytfQoa+ARUbD4DuxAF/nOP7eed8//duhCwAydiZZw6gYfBr2L
         JyiAj0n80dI22O5BcoSn0iQOe5RhPN5Jg1BsOAF91cvFMvgo8eCBCAiqsDULWFjaj43B
         Lfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tokKn3kJoQhtfoKIy68C85T1SUOGLJ/PBvKnvlsBPwI=;
        b=3tcGMF2XzGTatljIzYyHEE2kcQLw96MclutsWXOotm3j7i7RVjW/j/rLMv5MZp80f6
         8kAbt7/xMMHLgvJt7ADrSGvSJOBb+zqBwiPYd2JFz7F6/lLmiRrKv/2aoJO6579Rpb0M
         9T92mVCZm+s34gVCBS2cC23MN463N4eHST+oFxhI0NgpxuEZQSiyJTHF5uZYx3odGDN/
         e5VxDcBjZOSU8p0bN97ZsTGmniNafxW6RsXmeqviRodJ2qtMgFx3//Gqjbn0mPD5P9G1
         PEI5ZuULStFqdM4OAzIskDEs0ev7goWrQlqkQsPWvzO1WcGLDdFdHrR7fda7Yyf+DDDp
         Kc0A==
X-Gm-Message-State: AOAM532zJVcsM0WBc8q7H2FKg6Qkqbf75q+POIufI7QQVMevbMPFoxvx
        iyV2bPwQDNeABJphSc6Ca5O4ppbfrZOMFg==
X-Google-Smtp-Source: ABdhPJxj7qeHrvmBw/yPlZlWfuxm5mk/Cy8vcn7eAtN3sUeJLeDRHsXp1P0uFJRVOimajuoGu6ayBQ==
X-Received: by 2002:adf:f4c7:0:b0:203:fb33:332f with SMTP id h7-20020adff4c7000000b00203fb33332fmr13821389wrp.280.1648314875306;
        Sat, 26 Mar 2022 10:14:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c4f1300b0038cb924c3d7sm7805913wmq.45.2022.03.26.10.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 10:14:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/7] alloc.[ch]: remove alloc_report() function
Date:   Sat, 26 Mar 2022 18:14:18 +0100
Message-Id: <patch-v3-6.7-b60a4c24a28-20220326T171200Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1535.gf8d72b9da1e
In-Reply-To: <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com> <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The alloc_report() function has been orphaned since its introduction
in 855419f764a (Add specialized object allocator, 2006-06-19), it
appears to have been used for demonstration purposes in that commit
message.

These might be handy to manually use in a debugger, but keeping them
and the "count" member of "alloc_state" just for that doesn't seem
worth it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 alloc.c | 21 ---------------------
 alloc.h |  1 -
 2 files changed, 22 deletions(-)

diff --git a/alloc.c b/alloc.c
index 957a0af3626..27f697e4c87 100644
--- a/alloc.c
+++ b/alloc.c
@@ -27,7 +27,6 @@ union any_object {
 };
 
 struct alloc_state {
-	int count; /* total number of nodes allocated */
 	int nr;    /* number of nodes left in current allocation */
 	void *p;   /* first free node in current allocation */
 
@@ -63,7 +62,6 @@ static inline void *alloc_node(struct alloc_state *s, size_t node_size)
 		s->slabs[s->slab_nr++] = s->p;
 	}
 	s->nr--;
-	s->count++;
 	ret = s->p;
 	s->p = (char *)s->p + node_size;
 	memset(ret, 0, node_size);
@@ -122,22 +120,3 @@ void *alloc_commit_node(struct repository *r)
 	init_commit_node(c);
 	return c;
 }
-
-static void report(const char *name, unsigned int count, size_t size)
-{
-	fprintf(stderr, "%10s: %8u (%"PRIuMAX" kB)\n",
-			name, count, (uintmax_t) size);
-}
-
-#define REPORT(name, type)	\
-    report(#name, r->parsed_objects->name##_state->count, \
-		  r->parsed_objects->name##_state->count * sizeof(type) >> 10)
-
-void alloc_report(struct repository *r)
-{
-	REPORT(blob, struct blob);
-	REPORT(tree, struct tree);
-	REPORT(commit, struct commit);
-	REPORT(tag, struct tag);
-	REPORT(object, union any_object);
-}
diff --git a/alloc.h b/alloc.h
index 371d388b552..3f4a0ad310a 100644
--- a/alloc.h
+++ b/alloc.h
@@ -13,7 +13,6 @@ void init_commit_node(struct commit *c);
 void *alloc_commit_node(struct repository *r);
 void *alloc_tag_node(struct repository *r);
 void *alloc_object_node(struct repository *r);
-void alloc_report(struct repository *r);
 
 struct alloc_state *allocate_alloc_state(void);
 void clear_alloc_state(struct alloc_state *s);
-- 
2.35.1.1535.gf8d72b9da1e

