Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095AAC433E0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 13:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D99412070B
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 13:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qM0Fsp5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgFENAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgFENAl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 09:00:41 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB0FC08C5C3
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 06:00:40 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l10so9651253wrr.10
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 06:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=PuFVyAZuk3CYUvpSCADXvcZQsAuDiMmt2d4mjw1LE7Q=;
        b=qM0Fsp5z3+Xuq28jaNBjzdH4TLf0gvldYHQ0d/bFjXXiUyHGr9cOfUPsNBaSIZsSUR
         E9Chddt6wPHYa16viO+qzpvYIorbdbrDHEVwrYVb7xiIS1DE1LSnO20nZhLdmt0+ZFPH
         d/gM7Avpy5CWEYDVRk5wYckDmvZkhb5df8Qk6KT24cUK1tg7pSnUCZzZ5RwPZijj3Z1e
         mVaRevavKHOFj+m+X2MdpBlX3gZWNPFXKrW/txozYnnZteUBsXKspWFdZxa+kghMMzbf
         PmBdvJGcu67VvTXHxHn9JTqcOOB/JbVtWAxAZ8m7PGBTYQnbCVfSaZf4bFP/61m6fsYN
         /toA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=PuFVyAZuk3CYUvpSCADXvcZQsAuDiMmt2d4mjw1LE7Q=;
        b=DNlvGh949P8iNyhaXf+ayhGwHILIOYXg60PzX129aIMfFik7KObDAC5B7ezbAPqcjR
         a801w3tmNQD2GWdI2cbJFUJdEA2GZ0C7xmzUCWPZ30GrJPlnP+HqNJUj4LqT9d9W4YHU
         JNJUNGArZsuaivQTvfGaVZnxK9AeglZF1fYP4xA0LLvFjjMncBPykmbIP136ZQaOZNxT
         5/MAjOrqEFOEN/v63RrOaIUrDsJb4rXyRPIN3REZB8DgkxB1KFhZUJ4Bm/Sfh3I73+NX
         TCUxnLqXnfKBs4ka+OJdKp11GhGATnWDp9eX8WzKE2VRMlNbrG1gwEN6FK0yaDvo/++F
         Qkdg==
X-Gm-Message-State: AOAM531q/9KgZgSViRAT7+Rsx5AZg0+7pvKgYDpBzY+KThiM5r4HXl9J
        DPuSIpG5KOPLvQESrHDhTE/KnnJw
X-Google-Smtp-Source: ABdhPJwCD8x0dr0OFaIsfxoDUnkYVUAjEWCNVb8RLYHnd1ttl1pbXRvQ/2WNBAF6wPffleQKpl078g==
X-Received: by 2002:adf:f389:: with SMTP id m9mr8938054wro.195.1591362039404;
        Fri, 05 Jun 2020 06:00:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f71sm10699684wmf.22.2020.06.05.06.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 06:00:38 -0700 (PDT)
Message-Id: <32a6f11cc475f5292075093dcdc3b2a5c6d02ed0.1591362033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.650.git.1591362032.gitgitgadget@gmail.com>
References: <pull.650.git.1591362032.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 05 Jun 2020 13:00:26 +0000
Subject: [PATCH 04/10] commit-slab: add a function to deep free entries on the
 slab
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, jnareb@gmail.com,
        peff@peff.net, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>

clear_##slabname() frees only the memory allocated for a commit slab
itself, but entries in the commit slab might own additional memory
outside the slab that should be freed as well.  We already have (at
least) one such commit slab, and this patch series is about to add one
more.

To free all additional memory owned by entries on the commit slab the
user of such a slab could iterate over all commits it knows about,
peek whether there is a valid entry associated with each commit, and
free the additional memory, if any.  Or it could rely on intimate
knowledge about the internals of the commit slab implementation, and
could itself iterate directly through all entries in the slab, and
free the additional memory.  Or it could just leak the additional
memory...

Introduce deep_clear_##slabname() to allow releasing memory owned by
commit slab entries by invoking the 'void free_fn(elemtype *ptr)'
function specified as parameter for each entry in the slab.

Use it in get_shallow_commits() in 'shallow.c' to replace an
open-coded iteration over a commit slab's entries.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-slab-decl.h |  1 +
 commit-slab-impl.h | 13 +++++++++++++
 commit-slab.h      | 10 ++++++++++
 shallow.c          | 14 +++++---------
 4 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/commit-slab-decl.h b/commit-slab-decl.h
index adc7b46c83b..286164b7e27 100644
--- a/commit-slab-decl.h
+++ b/commit-slab-decl.h
@@ -32,6 +32,7 @@ struct slabname {							\
 void init_ ##slabname## _with_stride(struct slabname *s, unsigned stride); \
 void init_ ##slabname(struct slabname *s);				\
 void clear_ ##slabname(struct slabname *s);				\
+void deep_clear_ ##slabname(struct slabname *s, void (*free_fn)(elemtype *ptr)); \
 elemtype *slabname## _at_peek(struct slabname *s, const struct commit *c, int add_if_missing); \
 elemtype *slabname## _at(struct slabname *s, const struct commit *c);	\
 elemtype *slabname## _peek(struct slabname *s, const struct commit *c)
diff --git a/commit-slab-impl.h b/commit-slab-impl.h
index 5c0eb91a5d1..557738df271 100644
--- a/commit-slab-impl.h
+++ b/commit-slab-impl.h
@@ -38,6 +38,19 @@ scope void clear_ ##slabname(struct slabname *s)			\
 	FREE_AND_NULL(s->slab);						\
 }									\
 									\
+scope void deep_clear_ ##slabname(struct slabname *s, void (*free_fn)(elemtype *)) \
+{									\
+	unsigned int i;							\
+	for (i = 0; i < s->slab_count; i++) {				\
+		unsigned int j;						\
+		if (!s->slab[i])					\
+			continue;					\
+		for (j = 0; j < s->slab_size; j++)			\
+			free_fn(&s->slab[i][j * s->stride]);		\
+	}								\
+	clear_ ##slabname(s);						\
+}									\
+									\
 scope elemtype *slabname## _at_peek(struct slabname *s,			\
 						  const struct commit *c, \
 						  int add_if_missing)   \
diff --git a/commit-slab.h b/commit-slab.h
index 05b3f2804e7..8e72a305365 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -47,6 +47,16 @@
  *
  *   Call this function before the slab falls out of scope to avoid
  *   leaking memory.
+ *
+ * - void deep_clear_indegree(struct indegree *, void (*free_fn)(int*))
+ *
+ *   Empties the slab, similar to clear_indegree(), but in addition it
+ *   calls the given 'free_fn' for each slab entry to release any
+ *   additional memory that might be owned by the entry (but not the
+ *   entry itself!).
+ *   Note that 'free_fn' might be called even for entries for which no
+ *   indegree_at() call has been made; in this case 'free_fn' is invoked
+ *   with a pointer to a zero-initialized location.
  */
 
 #define define_commit_slab(slabname, elemtype) \
diff --git a/shallow.c b/shallow.c
index 7fd04afed19..c4ac8a73273 100644
--- a/shallow.c
+++ b/shallow.c
@@ -84,6 +84,10 @@ int is_repository_shallow(struct repository *r)
  * supports a "valid" flag.
  */
 define_commit_slab(commit_depth, int *);
+static void free_depth_in_slab(int **ptr)
+{
+	FREE_AND_NULL(*ptr);
+}
 struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 		int shallow_flag, int not_shallow_flag)
 {
@@ -150,15 +154,7 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 			}
 		}
 	}
-	for (i = 0; i < depths.slab_count; i++) {
-		int j;
-
-		if (!depths.slab[i])
-			continue;
-		for (j = 0; j < depths.slab_size; j++)
-			free(depths.slab[i][j]);
-	}
-	clear_commit_depth(&depths);
+	deep_clear_commit_depth(&depths, free_depth_in_slab);
 
 	return result;
 }
-- 
gitgitgadget

