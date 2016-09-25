Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 728A4207EC
	for <e@80x24.org>; Sun, 25 Sep 2016 07:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033978AbcIYHYb (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 03:24:31 -0400
Received: from mout.web.de ([212.227.15.4]:58304 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032943AbcIYHYa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 03:24:30 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0Lvjoa-1atybT40fk-017Ywo; Sun, 25 Sep 2016 09:24:08
 +0200
Subject: [PATCH 6/7] use COPY_ARRAY
To:     Git List <git@vger.kernel.org>
References: <6f402d35-b483-7552-2fb2-a5350112b8a6@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <869cff97-9e5f-ec17-6b64-bd1e4d9d1947@web.de>
Date:   Sun, 25 Sep 2016 09:24:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <6f402d35-b483-7552-2fb2-a5350112b8a6@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:5RZflBwete0mJR9p03BaFUILXvXWrbtswICVTfHxLqK/+2W659o
 /M9h1InV6cOybx2c9f0cXAPJFhJsIqfKwJ1DnBF8KJ0ErwDQ+2tpwgnZ0feXG121Y5WfFof
 mzk9gOi7MSdBu5bUauT1tn+zlnm9OqS5D4UjJEKMIBkkboycUz5p8qDdR7JTZwrYjwbUbl+
 5tsG80CBWeaW8Xm9Wzzcw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uVY/WESriUQ=:l4s3FRrDNJOg+12VwAlMZp
 aDBcmOaTMMhEfG+z4+TnOE6uIZHXm03Dm0SaxNA2RA8qxz6dybF3LQ/2cZW/ZSH+S42Xin1fT
 J/1kfZ9fjdRJcMp/NoMKu+1YnCw5oUiQ5xZ4rLUD25gQOxbfzSwy0iE0p6YIOz/nCmxGC1K/0
 Arx99XFhC0pWBE5tPw98tvtgQYcu9FjhZLRqKCRHbI2hAVjnpGKWTtqqUe1wEeAjF6V6k86CV
 oV6e99nnrxV9IZQx9AFQdFWfxFh7Cd55uWIUmiK7R6/ffFCaAd4qe/J4kGXMMHrX9940ygt3e
 klSuEwCg5RgMesVZbGVnnqAIEARnliA4cnNIPoZQghej9PV8FiRBN4ennAdZt6DO/JKJ5v9fG
 oUL75huWcJMhiIQ/bSAfPf56yT6N+QiY1UgSWDZ9aautBF82wS5SNQypMS2zDxXYyZ0XA2YEK
 h91UBmcFwJyQpuiWzS8hBbV+4jKehFbGg18oMuqPkg7WscxzPGT5jfp6Vl2gQi6h0Ue8+tk1f
 0ANNE4mVCvsy3lZFwwjw6YcwGz+0QRd0glwhQl/ro7nhtqGWikObqbDt5zHakbsP8/m6RoDgA
 Yn+k7xLDQbxqHLVTzqxru0yR3JUJ+f38LPAXtbMN5d0H//vp4wmDjE6888XW666NrbWyJre+P
 RYx7LopNOzOpgS2yoT4HB+lbeo1sZZhCBHu2ipGighmgAa8rZiV97K5O4eaU0asEvb4Fn1ME4
 REomAs42B+eVkM/aNsILLdDZsqGlXBBDWX6oopub//TexP54cmcDXhgdb+Z0QFWMnKbU161yb
 2puv9gk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a semantic patch for converting certain calls of memcpy(3) to
COPY_ARRAY() and apply that transformation to the code base.  The result
is
 shorter and safer code.  For now only consider calls where source and
destination have the same type, or in other words: easy cases.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/mv.c                   |  2 +-
 commit.c                       |  2 +-
 contrib/coccinelle/array.cocci | 26 ++++++++++++++++++++++++++
 pack-revindex.c                |  2 +-
 pathspec.c                     |  3 +--
 split-index.c                  |  6 ++----
 6 files changed, 32 insertions(+), 9 deletions(-)
 create mode 100644 contrib/coccinelle/array.cocci

diff --git a/builtin/mv.c b/builtin/mv.c
index 446a316..2f43877 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -26,7 +26,7 @@ static const char **internal_copy_pathspec(const char *prefix,
 	int i;
 	const char **result;
 	ALLOC_ARRAY(result, count + 1);
-	memcpy(result, pathspec, count * sizeof(const char *));
+	COPY_ARRAY(result, pathspec, count);
 	result[count] = NULL;
 	for (i = 0; i < count; i++) {
 		int length = strlen(result[i]);
diff --git a/commit.c b/commit.c
index ba6dee3..aada266 100644
--- a/commit.c
+++ b/commit.c
@@ -931,7 +931,7 @@ static int remove_redundant(struct commit **array, int cnt)
 	}
 
 	/* Now collect the result */
-	memcpy(work, array, sizeof(*array) * cnt);
+	COPY_ARRAY(work, array, cnt);
 	for (i = filled = 0; i < cnt; i++)
 		if (!redundant[i])
 			array[filled++] = work[i];
diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.cocci
new file mode 100644
index 0000000..2d7f25d
--- /dev/null
+++ b/contrib/coccinelle/array.cocci
@@ -0,0 +1,26 @@
+@@
+type T;
+T *dst;
+T *src;
+expression n;
+@@
+- memcpy(dst, src, n * sizeof(*dst));
++ COPY_ARRAY(dst, src, n);
+
+@@
+type T;
+T *dst;
+T *src;
+expression n;
+@@
+- memcpy(dst, src, n * sizeof(*src));
++ COPY_ARRAY(dst, src, n);
+
+@@
+type T;
+T *dst;
+T *src;
+expression n;
+@@
+- memcpy(dst, src, n * sizeof(T));
++ COPY_ARRAY(dst, src, n);
diff --git a/pack-revindex.c b/pack-revindex.c
index 96d51c3..6bc7c94 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -107,7 +107,7 @@ static void sort_revindex(struct revindex_entry *entries, unsigned n, off_t max)
 	 * we have to move it back from the temporary storage.
 	 */
 	if (from != entries)
-		memcpy(entries, tmp, n * sizeof(*entries));
+		COPY_ARRAY(entries, tmp, n);
 	free(tmp);
 	free(pos);
 
diff --git a/pathspec.c b/pathspec.c
index 24e0dd5..49a5360 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -485,8 +485,7 @@ void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 {
 	*dst = *src;
 	ALLOC_ARRAY(dst->items, dst->nr);
-	memcpy(dst->items, src->items,
-	       sizeof(struct pathspec_item) * dst->nr);
+	COPY_ARRAY(dst->items, src->items, dst->nr);
 }
 
 void clear_pathspec(struct pathspec *pathspec)
diff --git a/split-index.c b/split-index.c
index 3c75d4b..35da553 100644
--- a/split-index.c
+++ b/split-index.c
@@ -83,8 +83,7 @@ void move_cache_to_base_index(struct index_state *istate)
 	si->base->timestamp = istate->timestamp;
 	ALLOC_GROW(si->base->cache, istate->cache_nr, si->base->cache_alloc);
 	si->base->cache_nr = istate->cache_nr;
-	memcpy(si->base->cache, istate->cache,
-	       sizeof(*istate->cache) * istate->cache_nr);
+	COPY_ARRAY(si->base->cache, istate->cache, istate->cache_nr);
 	mark_base_index_entries(si->base);
 	for (i = 0; i < si->base->cache_nr; i++)
 		si->base->cache[i]->ce_flags &= ~CE_UPDATE_IN_BASE;
@@ -141,8 +140,7 @@ void merge_base_index(struct index_state *istate)
 	istate->cache	    = NULL;
 	istate->cache_alloc = 0;
 	ALLOC_GROW(istate->cache, istate->cache_nr, istate->cache_alloc);
-	memcpy(istate->cache, si->base->cache,
-	       sizeof(*istate->cache) * istate->cache_nr);
+	COPY_ARRAY(istate->cache, si->base->cache, istate->cache_nr);
 
 	si->nr_deletions = 0;
 	si->nr_replacements = 0;
-- 
2.10.0

