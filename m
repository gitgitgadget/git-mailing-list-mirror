Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6C4C43334
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 14:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbiGHOUz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 10:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237901AbiGHOUi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 10:20:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C3E24F15
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 07:20:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h17so17614898wrx.0
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 07:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P6/CWBHEQn6aKPGvhsB9HgpFaF6KI7T7maR1L0CjhKY=;
        b=EOsttIjxkTWxNbjLK0/LI1Nde0Y2CyjJ7bvA9yo2JdGSrXqHXYC8ohjnHR2H1sDdn+
         EiWp5AyAxYmd+KDa66oHmNkGJs09ROLqT3Ve6CbhlKSGpJd49+OLeSCEBpV/+UClJ97f
         47WxS0q2Q3uX/lA1wh+p2RA4UH5YN8JHbtSwpmTHl+6WuaWcrhU0tgBrw/iiE1X5pHau
         Th9/i8i3kxFdyjxzlYGvfnLpCGzhVnvus06mn4ZAyfH4s0EU0YAIFYMSm1klbI00M3qe
         tqtsxO6B1WCP29XTQ8eKvqc/NJqgQnOuGCWvBCDGPl4VO57+5LdmH3oSxwfeUoD9fDR0
         uJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P6/CWBHEQn6aKPGvhsB9HgpFaF6KI7T7maR1L0CjhKY=;
        b=CkvwSdw2M4uhUWD/wxbjLgHtf28PLgkG/xwUBWLqfa/6kTSwqAlkzITn3xscZnLNH4
         R+tQuas1BZMQSUBNr0HCgkGB7fpkiXUKk6fVXoNm8ERxytebGfwWKITLIz543QxfNCfw
         R5+OvRf9P8JqbXhHgJj0bYlblswvXTT7GmMHAy1KfeH2vl4NYYQo9+MK7LRqzJSRDTOE
         TkPeZqVwNs/2WP9/4nRzcEB4n9/VeIdAuvEdG7OvKNHU7Qw8HpzrgH+DHJreQnGWT5er
         lyJj1HLLHTr53eXWcL6aKzOaRdldip/3aZ8gYAh1Auzj+cqx1kYfYMO3DttN9pJ/JCX3
         x0DQ==
X-Gm-Message-State: AJIora9ekGmeJnB7lU36T0HAqil109AardDDHu+6RWPb2pzd0Qi8QpZC
        KAjOnXaB0JcERV9fHXm2FtUhStL0/NszAA==
X-Google-Smtp-Source: AGRyM1tuY9jgWKn2fU65RsYH6ZgrSloKgJI1i6ZUwFH5KyYm0K6WmQkopRRTa4R2DTf9wp3D6WEBpw==
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id b13-20020adff90d000000b0020cde324d35mr3479689wrr.583.1657290037251;
        Fri, 08 Jul 2022 07:20:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q5-20020adff945000000b0021b9585276dsm40393924wrr.101.2022.07.08.07.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 07:20:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/7] xdiff: use GALLOC_GROW(), not XDL_ALLOC_GROW()
Date:   Fri,  8 Jul 2022 16:20:17 +0200
Message-Id: <patch-5.7-3665576576f-20220708T140354Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.913.g189dca38629
In-Reply-To: <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com> <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the recently introduced XDL_ALLOC_GROW() with invocations of
the GALLOC_GROW() from git-shared-util.h.

As this change shows the macro + function indirection of
XDL_ALLOC_GROW() is something we needed only because the two callsites
we used it in wanted to use it as an expression, and we thus had to
pass the "sizeof" down.

Let's just check the value afterwards instead, which allows us to use
the shared macro, we can also remove xdl_reallo(), this was its last
user.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 xdiff/xdiff.h    |  1 -
 xdiff/xmacros.h  | 11 -----------
 xdiff/xprepare.c |  8 +++++---
 xdiff/xutils.c   | 17 -----------------
 xdiff/xutils.h   |  2 --
 5 files changed, 5 insertions(+), 34 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 72e25a9ffa5..832cf9d977e 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -121,7 +121,6 @@ typedef struct s_bdiffparam {
 
 #define xdl_malloc(x) xmalloc(x)
 #define xdl_free(ptr) free(ptr)
-#define xdl_realloc(ptr,x) xrealloc(ptr,x)
 
 void *xdl_mmfile_first(mmfile_t *mmf, long *size);
 long xdl_mmfile_size(mmfile_t *mmf);
diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
index 75506bdf17e..6a6b3057375 100644
--- a/xdiff/xmacros.h
+++ b/xdiff/xmacros.h
@@ -48,15 +48,4 @@ do { \
 	(v) = (unsigned long) __p[0] | ((unsigned long) __p[1]) << 8 | \
 		((unsigned long) __p[2]) << 16 | ((unsigned long) __p[3]) << 24; \
 } while (0)
-
-/*
- * Ensure array p can accommodate at least nr elements, growing the
- * array and updating alloc (which is the number of allocated
- * elements) as necessary. Frees p and returns -1 on failure, returns
- * 0 on success
- */
-#define XDL_ALLOC_GROW(p, nr, alloc)	\
-	(-!((nr) <= (alloc) ||		\
-	    ((p) = xdl_alloc_grow_helper((p), (nr), &(alloc), sizeof(*(p))))))
-
 #endif /* #if !defined(XMACROS_H) */
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index d6cbee32a2a..4182d9e1c0a 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -128,8 +128,9 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 			return -1;
 		}
 		rcrec->idx = cf->count++;
-		if (XDL_ALLOC_GROW(cf->rcrecs, cf->count, cf->alloc))
-				return -1;
+		GALLOC_GROW(cf->rcrecs, cf->count, cf->alloc);
+		if (!cf->rcrecs)
+			return -1;
 		cf->rcrecs[rcrec->idx] = rcrec;
 		rcrec->line = line;
 		rcrec->size = rec->size;
@@ -187,7 +188,8 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 		for (top = blk + bsize; cur < top; ) {
 			prev = cur;
 			hav = xdl_hash_record(&cur, top, xpp->flags);
-			if (XDL_ALLOC_GROW(recs, nrec + 1, narec))
+			GALLOC_GROW(recs, nrec + 1, narec);
+			if (!recs)
 				goto abort;
 			if (!(crec = xdl_cha_alloc(&xdf->rcha)))
 				goto abort;
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index a6f10353cff..c0cd5338c4e 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -436,20 +436,3 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
 
 	return status;
 }
-
-void* xdl_alloc_grow_helper(void *p, long nr, long *alloc, size_t size)
-{
-	void *tmp = NULL;
-	size_t n = ((LONG_MAX - 16) / 2 >= *alloc) ? 2 * *alloc + 16 : LONG_MAX;
-	if (nr > n)
-		n = nr;
-	if (SIZE_MAX / size >= n)
-		tmp = xdl_realloc(p, n * size);
-	if (tmp) {
-		*alloc = n;
-	} else {
-		xdl_free(p);
-		*alloc = 0;
-	}
-	return tmp;
-}
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index fd0bba94e8b..7ae3f897bef 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -42,7 +42,5 @@ int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,
 int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
 		       int line1, int count1, int line2, int count2);
 
-/* Do not call this function, use XDL_ALLOC_GROW instead */
-void* xdl_alloc_grow_helper(void* p, long nr, long* alloc, size_t size);
 
 #endif /* #if !defined(XUTILS_H) */
-- 
2.37.0.913.g189dca38629

