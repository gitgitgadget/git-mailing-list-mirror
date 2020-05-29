Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B155BC433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8722A20723
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKyyOxuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgE2IvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgE2IvF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:05 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EDAC03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:03 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l11so2623710wru.0
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=67gacoTzEwJUoqBISrjk2gqL97djVGYmY6G3JJpyUIs=;
        b=mKyyOxujEpcv73tRmXiPuVcpGxPL69ZUaKSO5ELtwYoQe66w95NW/OBPX7wRg7RaNb
         wI/q2x6HYEwIbBQ+zg9Yp0/tfWr3suSg9fvXi8TV/iQ5yrN+gNvQ8Ixh8wu3M7NVWv81
         7bGHm2Zr1D0g38KVgwHoj9Hw0YRya3IfZ4fpjb7bPcTZ2qXZN50G+COf50D18Elmr9c4
         3cSMiHoKxmhnCsF41f4ZS42Tch4092MXKrKTyb/59my5L7JSaGuS/obb9lEe0qfeIPyT
         Vm0HtI9Q92LyEw1/e2SroNFOquHGyaiR4wFgRvqFQ9PTFF0SgpgLf7VDITq3hgXnjxvO
         HFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=67gacoTzEwJUoqBISrjk2gqL97djVGYmY6G3JJpyUIs=;
        b=p8Cbj6OENlawa7dJw2xav9UNLR9GKMLCt1WG5uJUllY0KReeglBrO650XY53dNQojd
         gcQEtVZfDmgpX82KAkc4L5jYK14sQxhCaRXSvQICdLcryX815MY7LY+wWz03RYub5z3s
         7elzKehbO7Mhw5wiZrecrZL6uGO4zX23kLa+8TmORyeVVEejSpMvypHCwtpXUSt/wVaC
         3BCkEpBJBKUlJxQZjX25RTvctan27kxODq7u2/yj2QTAf1V2lY1UIrGxu8vDb+ceDcKP
         Sy5PsoIvQOjqZQoFvBYczgfY5DZUk1xZTxBOq+OLfwz+uNKMexLCW7jpQc87mC1ktvC6
         HZXw==
X-Gm-Message-State: AOAM533mCuY/yNGRevJBmyOXChoaWm05oS9DzSzPoTQON4DSG9AKVjMk
        xHXf4PGED8ciyK2KHtuPztJhCOUd
X-Google-Smtp-Source: ABdhPJyEPcF3t8u2zplzWL0VcoD4KlIz2pm5x3jSJ4wHGMmHIEF25nPIEhVmHMJvOhZMWILzoKrJ/g==
X-Received: by 2002:a5d:518b:: with SMTP id k11mr8310208wrv.58.1590742262101;
        Fri, 29 May 2020 01:51:02 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:01 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 04/34] commit-slab: add a function to deep free entries on the slab
Date:   Fri, 29 May 2020 10:50:08 +0200
Message-Id: <20200529085038.26008-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
---
 commit-slab-decl.h |  1 +
 commit-slab-impl.h | 13 +++++++++++++
 commit-slab.h      | 10 ++++++++++
 shallow.c          | 14 +++++---------
 4 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/commit-slab-decl.h b/commit-slab-decl.h
index adc7b46c83..286164b7e2 100644
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
index 5c0eb91a5d..557738df27 100644
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
index 69bf0c807c..7bd472171e 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -42,6 +42,16 @@
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
index 7fd04afed1..d02ba494ee 100644
--- a/shallow.c
+++ b/shallow.c
@@ -84,6 +84,10 @@ int is_repository_shallow(struct repository *r)
  * supports a "valid" flag.
  */
 define_commit_slab(commit_depth, int *);
+void free_depth_in_slab(int **ptr)
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
2.27.0.rc1.431.g5c813f95dc

