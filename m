Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93531C48BE6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 13:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7348C61283
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 13:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbhFNNHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 09:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbhFNNG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 09:06:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9247C061767
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 06:04:56 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l2so14516792wrw.6
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Owa0Wj5cHYR3NtWykogb2MAtPFNqZSpM0GNud+2c33w=;
        b=gvE06SrhNoSa3z8jJ1PYRZktdJQuWSzLexQsfGFeEorzJNESW96ON4loQLGn92EyN4
         vl9UBI2ixPkNDMpAYuECFqsIaHAAedFWRbSHbuhExTm7DnRJJqAlt/zNrcvxRAfeMiCU
         1DpnK8/Ao4/RzD/KPEAZbM55vwvc9DSKHVvxD3M5qUgJx3pPvAdeVLme72Ra4tgOSd/u
         SkbhyM8/AzR8gRoKc1SLFrMcTh9SNg2LveT9lJWhv1axxVD9gWhuN5v8xffnENZO/Y7V
         E09JVIgqPpYlvM7S6Tec05Uy0vrtvJFFAokXyVvdSOwaX/PSLsihUY976o3BWnrOYraG
         b8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Owa0Wj5cHYR3NtWykogb2MAtPFNqZSpM0GNud+2c33w=;
        b=FDiF9+yBUEufmu63RorL9jAIa625DJCjGJcq0gwgZzupBDSC2YN7GrcWdM4RE6YEf6
         i2TmnBgG0k4pJ81Ac4oxt6/IsbTVmo3RVubv99yfeaRDa6X82KbSttHsrPgOpW5EGMmb
         4gYj5eTL5nhakEdCnJYQFdaUurlJM72gLqwI2uczd0IQiDpde0Rmk+E5N7v+V6qOcZnC
         EzpQtdAOvDhNdXsiXcvrJNNHVmJAUdJb/n0fec11AdZ7mh5vzILjqjGhl2N+wppsyu5V
         1yFC61eOP6/BeWUJpZMACn+DfAR3rj6dBbnX58SfBcH8W04xylvygOQQS+fOgrV7qf/t
         R3aw==
X-Gm-Message-State: AOAM533yXA0T74KaZSfuTYwWrprDp1sfW8EA7kOXbbQCMJwkHs+bJAJF
        qd+t4e5Rtcxax/5HiJDqRfK9hb5gkes=
X-Google-Smtp-Source: ABdhPJwZVx2mphKURRdfxEk4Dw2SrDqRjWb2bEeP7eigKiSRrgC7EEgmFCuNviXBI8H2kN+ObVtefQ==
X-Received: by 2002:a5d:474f:: with SMTP id o15mr18944346wrs.298.1623675895562;
        Mon, 14 Jun 2021 06:04:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s62sm20372162wms.13.2021.06.14.06.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 06:04:55 -0700 (PDT)
Message-Id: <41cdedd60907b966dffa6cf0c9825ffb448f4971.1623675889.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.git.1623675888.gitgitgadget@gmail.com>
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Jun 2021 13:04:47 +0000
Subject: [PATCH 09/10] diff --color-moved-ws=allow-indentation-change: improve
 hash lookups
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

As libxdiff does not have a whitespace flag to ignore the indentation
the code for --color-moved-ws=allow-indentation-change uses
XDF_IGNORE_WHITESPACE and then filters out any hash lookups where
there are non-indentation changes. This is filtering is inefficient as
we have to perform another string comparison.

By using the offset data that we have already computed to skip the
indentation we can avoid using XDF_IGNORE_WHITESPACE and safely remove
the extra checks which improves the performance by 14% and paves the
way for the elimination of string comparisons in the next commit.

This change slightly increases the runtime of other --color-moved
modes. This could be avoided by using different comparison functions
for the different modes but after the changes in the next commit there
is no measurable benefit.

Before this change
Benchmark #1: bin-wrappers/git diff --diff-algorithm=myers --color-moved --no-color-moved-ws v2.28.0 v2.29.0
  Time (mean ± σ):      1.116 s ±  0.005 s    [User: 1.057 s, System: 0.056 s]
  Range (min … max):    1.109 s …  1.123 s    10 runs

Benchmark #2: bin-wrappers/git diff --diff-algorithm=myers --color-moved --color-moved-ws=allow-indentation-change v2.28.0 v2.29.0
  Time (mean ± σ):      1.216 s ±  0.005 s    [User: 1.155 s, System: 0.059 s]
  Range (min … max):    1.206 s …  1.223 s    10 runs

After this change
Benchmark #1: bin-wrappers/git diff --diff-algorithm=myers --color-moved --no-color-moved-ws v2.28.0 v2.29.0
  Time (mean ± σ):      1.147 s ±  0.005 s    [User: 1.085 s, System: 0.059 s]
  Range (min … max):    1.140 s …  1.154 s    10 runs

Benchmark #2: bin-wrappers/git diff --diff-algorithm=myers --color-moved --color-moved-ws=allow-indentation-change v2.28.0 v2.29.0
  Time (mean ± σ):      1.048 s ±  0.005 s    [User: 987.4 ms, System: 58.8 ms]
  Range (min … max):    1.043 s …  1.056 s    10 runs

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 66 +++++++++++++++++-----------------------------------------
 1 file changed, 19 insertions(+), 47 deletions(-)

diff --git a/diff.c b/diff.c
index ee58373f55f8..e6f3586b39bf 100644
--- a/diff.c
+++ b/diff.c
@@ -850,28 +850,15 @@ static void fill_es_indent_data(struct emitted_diff_symbol *es)
 }
 
 static int compute_ws_delta(const struct emitted_diff_symbol *a,
-			    const struct emitted_diff_symbol *b,
-			    int *out)
-{
-	int a_len = a->len,
-	    b_len = b->len,
-	    a_off = a->indent_off,
-	    a_width = a->indent_width,
-	    b_off = b->indent_off,
+			    const struct emitted_diff_symbol *b)
+{
+	int a_width = a->indent_width,
 	    b_width = b->indent_width;
 
-	if (a_width == INDENT_BLANKLINE && b_width == INDENT_BLANKLINE) {
-		*out = INDENT_BLANKLINE;
-		return 1;
-	}
-
-	if (a_len - a_off != b_len - b_off ||
-	    memcmp(a->line + a_off, b->line + b_off, a_len - a_off))
-		return 0;
-
-	*out = a_width - b_width;
+	if (a_width == INDENT_BLANKLINE && b_width == INDENT_BLANKLINE)
+		return INDENT_BLANKLINE;
 
-	return 1;
+	return a_width - b_width;
 }
 
 static int cmp_in_block_with_wsd(const struct diff_options *o,
@@ -917,26 +904,17 @@ static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
 			   const void *keydata)
 {
 	const struct diff_options *diffopt = hashmap_cmp_fn_data;
-	const struct moved_entry *a, *b;
+	const struct emitted_diff_symbol *a, *b;
 	unsigned flags = diffopt->color_moved_ws_handling
 			 & XDF_WHITESPACE_FLAGS;
 
-	a = container_of(eptr, const struct moved_entry, ent);
-	b = container_of(entry_or_key, const struct moved_entry, ent);
-
-	if (diffopt->color_moved_ws_handling &
-	    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
-		/*
-		 * As there is not specific white space config given,
-		 * we'd need to check for a new block, so ignore all
-		 * white space. The setup of the white space
-		 * configuration for the next block is done else where
-		 */
-		flags |= XDF_IGNORE_WHITESPACE;
+	a = container_of(eptr, const struct moved_entry, ent)->es;
+	b = container_of(entry_or_key, const struct moved_entry, ent)->es;
 
-	return !xdiff_compare_lines(a->es->line, a->es->len,
-				    b->es->line, b->es->len,
-				    flags);
+	return !xdiff_compare_lines(a->line + a->indent_off,
+				    a->len - a->indent_off,
+				    b->line + b->indent_off,
+				    b->len - b->indent_off, flags);
 }
 
 static struct moved_entry *prepare_entry(struct diff_options *o,
@@ -945,7 +923,8 @@ static struct moved_entry *prepare_entry(struct diff_options *o,
 	struct moved_entry *ret = xmalloc(sizeof(*ret));
 	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[line_no];
 	unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
-	unsigned int hash = xdiff_hash_string(l->line, l->len, flags);
+	unsigned int hash = xdiff_hash_string(l->line + l->indent_off,
+					      l->len - l->indent_off, flags);
 
 	hashmap_entry_init(&ret->ent, hash);
 	ret->es = l;
@@ -1113,14 +1092,11 @@ static void mark_color_as_moved(struct diff_options *o,
 			hashmap_for_each_entry_from(hm, match, ent) {
 				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
 				if (o->color_moved_ws_handling &
-				    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) {
-					if (compute_ws_delta(l, match->es,
-							     &pmb[pmb_nr].wsd))
-						pmb[pmb_nr++].match = match;
-				} else {
+				    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
+					pmb[pmb_nr].wsd = compute_ws_delta(l, match->es);
+				else
 					pmb[pmb_nr].wsd = 0;
-					pmb[pmb_nr++].match = match;
-				}
+				pmb[pmb_nr++].match = match;
 			}
 
 			if (adjust_last_block(o, n, block_length) &&
@@ -6240,10 +6216,6 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 		if (o->color_moved) {
 			struct hashmap add_lines, del_lines;
 
-			if (o->color_moved_ws_handling &
-			    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
-				o->color_moved_ws_handling |= XDF_IGNORE_WHITESPACE;
-
 			hashmap_init(&del_lines, moved_entry_cmp, o, 0);
 			hashmap_init(&add_lines, moved_entry_cmp, o, 0);
 
-- 
gitgitgadget

