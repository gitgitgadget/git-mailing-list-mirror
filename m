Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9465C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B402F61278
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244468AbhDLRQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244026AbhDLRQY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:16:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAF4C06134D
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5-20020a05600c0245b029011a8273f85eso7335890wmj.1
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fOPnKrrXoU1yg/QhFQcdGcElNSW1AB4SW6Dkip6MODA=;
        b=Xf/d5noy/ofELodLH2AVx9caIUI82b9wAgigqLgT98yLK3E1Ixsxsv4X9ZkOBfwPS+
         CUvYMrT6vXcrHjgr4cqIrocA5fpjrJ75agr+aKBsLdkYvy503R1nQ5x4jDH6nnOoXXul
         h/iVRE6UQM68G8FWNJFo7351Wt/ObdXX2ZtEfGBNDlNHmAnFJ+rl9r+LcZUqc5Lhkf7a
         wXIgMwgNIr8uTHK1Y3xTVrx/O9YNraiWtiCvTzzeygOcV7n4h7v4XdwafTxJ+KZB2NFv
         gpVCmkGn9l4bk55uNWPvhCC3gVeFfcIUd8gVlnHv+7HjufbLwbjwjCdGPNBAwuQG7b8J
         GntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fOPnKrrXoU1yg/QhFQcdGcElNSW1AB4SW6Dkip6MODA=;
        b=SePma3/6xOaYv6ASXSRf+5orlSrLFGQ8a5HaR7j+k42rbpxPADg9FQ7MpP8IGiybQk
         eWfKhH8c4ptBxKQAi6N4P1H0XvfS+ufqpM4jkfpZUo0sbytgPFuOL3KTbGQ5/1tKRt7V
         qk2uG0AWgv4xAx201fRxgS/kJUgX/UMkrG7bJvhHH8UHrH/E8zwJ+ssjOdp0acMWg4Hy
         ToTuHA+OIQo8hbs74GszqLj9SYvTnsVUEFrxIjjTy2hnq62vFb9CZSM1/21UyCzZrZOQ
         JMwnFv1sUvNciHK0ai/JH04zyoI6AQzeQmVAeB1UMLkUm378zaNUeoj37tldq0SwYGGe
         PIxQ==
X-Gm-Message-State: AOAM533EBeCe/wk+IlbBq7ToccfqBlttWfxk95v4OdVwiiDVARurwBZd
        kJ4FE8WBD58YqQcdACj8uPIZ2MaNW29nIg==
X-Google-Smtp-Source: ABdhPJyM+bYLGEjDvKsBgXx1ZuJteUmKhF0UxbIju9leapz/k7BxLpSid881dKKkjlBh/ZGIyghcBg==
X-Received: by 2002:a7b:c2ef:: with SMTP id e15mr154977wmk.140.1618247751151;
        Mon, 12 Apr 2021 10:15:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j1sm7828625wrr.33.2021.04.12.10.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:15:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 17/22] xdiff-interface: prepare for allowing early return
Date:   Mon, 12 Apr 2021 19:15:24 +0200
Message-Id: <patch-17.22-62c306275c7-20210412T170457Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.639.g3d04783866f
In-Reply-To: <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
References: <20210216115801.4773-1-avarab@gmail.com> <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the function prototype of xdiff_emit_line_fn to return an "int"
instead of "void". Change all of those functions to "return 0",
nothing checks those return values yet, and no behavior is being
changed.

In subsequent commits the interface will be changed to allow early
return via this new return value.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 combine-diff.c     |  5 +++--
 diff.c             | 26 +++++++++++++++-----------
 diffcore-pickaxe.c |  7 ++++---
 range-diff.c       |  3 ++-
 xdiff-interface.c  |  3 ++-
 xdiff-interface.h  |  2 +-
 6 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 06635f91bc2..a12d3bc0d9c 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -403,11 +403,11 @@ static void consume_hunk(void *state_,
 	state->sline[state->nb-1].p_lno[state->n] = state->ob;
 }
 
-static void consume_line(void *state_, char *line, unsigned long len)
+static int consume_line(void *state_, char *line, unsigned long len)
 {
 	struct combine_diff_state *state = state_;
 	if (!state->lost_bucket)
-		return; /* not in any hunk yet */
+		return 0; /* not in any hunk yet */
 	switch (line[0]) {
 	case '-':
 		append_lost(state->lost_bucket, state->n, line+1, len-1);
@@ -417,6 +417,7 @@ static void consume_line(void *state_, char *line, unsigned long len)
 		state->lno++;
 		break;
 	}
+	return 0;
 }
 
 static void combine_diff(struct repository *r,
diff --git a/diff.c b/diff.c
index c1f47a7f013..7a03c581c79 100644
--- a/diff.c
+++ b/diff.c
@@ -2336,7 +2336,7 @@ static void find_lno(const char *line, struct emit_callback *ecbdata)
 	ecbdata->lno_in_postimage = strtol(p + 1, NULL, 10);
 }
 
-static void fn_out_consume(void *priv, char *line, unsigned long len)
+static int fn_out_consume(void *priv, char *line, unsigned long len)
 {
 	struct emit_callback *ecbdata = priv;
 	struct diff_options *o = ecbdata->opt;
@@ -2372,7 +2372,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		len = sane_truncate_line(line, len);
 		find_lno(line, ecbdata);
 		emit_hunk_header(ecbdata, line, len);
-		return;
+		return 0;
 	}
 
 	if (ecbdata->diff_words) {
@@ -2382,11 +2382,11 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		if (line[0] == '-') {
 			diff_words_append(line, len,
 					  &ecbdata->diff_words->minus);
-			return;
+			return 0;
 		} else if (line[0] == '+') {
 			diff_words_append(line, len,
 					  &ecbdata->diff_words->plus);
-			return;
+			return 0;
 		} else if (starts_with(line, "\\ ")) {
 			/*
 			 * Eat the "no newline at eof" marker as if we
@@ -2395,11 +2395,11 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 			 * defer processing. If this is the end of
 			 * preimage, more "+" lines may come after it.
 			 */
-			return;
+			return 0;
 		}
 		diff_words_flush(ecbdata);
 		emit_diff_symbol(o, s, line, len, 0);
-		return;
+		return 0;
 	}
 
 	switch (line[0]) {
@@ -2423,6 +2423,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 				 line, len, 0);
 		break;
 	}
+	return 0;
 }
 
 static void pprint_rename(struct strbuf *name, const char *a, const char *b)
@@ -2522,7 +2523,7 @@ static struct diffstat_file *diffstat_add(struct diffstat_t *diffstat,
 	return x;
 }
 
-static void diffstat_consume(void *priv, char *line, unsigned long len)
+static int diffstat_consume(void *priv, char *line, unsigned long len)
 {
 	struct diffstat_t *diffstat = priv;
 	struct diffstat_file *x = diffstat->files[diffstat->nr - 1];
@@ -2531,6 +2532,7 @@ static void diffstat_consume(void *priv, char *line, unsigned long len)
 		x->added++;
 	else if (line[0] == '-')
 		x->deleted++;
+	return 0;
 }
 
 const char mime_boundary_leader[] = "------------";
@@ -3208,7 +3210,7 @@ static void checkdiff_consume_hunk(void *priv,
 	data->lineno = nb - 1;
 }
 
-static void checkdiff_consume(void *priv, char *line, unsigned long len)
+static int checkdiff_consume(void *priv, char *line, unsigned long len)
 {
 	struct checkdiff_t *data = priv;
 	int marker_size = data->conflict_marker_size;
@@ -3232,7 +3234,7 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 		}
 		bad = ws_check(line + 1, len - 1, data->ws_rule);
 		if (!bad)
-			return;
+			return 0;
 		data->status |= bad;
 		err = whitespace_error_string(bad);
 		fprintf(data->o->file, "%s%s:%d: %s.\n",
@@ -3244,6 +3246,7 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 	} else if (line[0] == ' ') {
 		data->lineno++;
 	}
+	return 0;
 }
 
 static unsigned char *deflate_it(char *data,
@@ -6121,17 +6124,18 @@ void flush_one_hunk(struct object_id *result, git_hash_ctx *ctx)
 	}
 }
 
-static void patch_id_consume(void *priv, char *line, unsigned long len)
+static int patch_id_consume(void *priv, char *line, unsigned long len)
 {
 	struct patch_id_t *data = priv;
 	int new_len;
 
 	if (len > 12 && starts_with(line, "\\ "))
-		return;
+		return 0;
 	new_len = remove_space(line, len);
 
 	the_hash_algo->update_fn(data->ctx, line, new_len);
 	data->patchlen += new_len;
+	return 0;
 }
 
 static void patch_id_add_string(git_hash_ctx *ctx, const char *str)
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index b7494fdf89c..27aa20be350 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -19,21 +19,22 @@ struct diffgrep_cb {
 	int hit;
 };
 
-static void diffgrep_consume(void *priv, char *line, unsigned long len)
+static int diffgrep_consume(void *priv, char *line, unsigned long len)
 {
 	struct diffgrep_cb *data = priv;
 	regmatch_t regmatch;
 
 	if (line[0] != '+' && line[0] != '-')
-		return;
+		return 0;
 	if (data->hit)
 		/*
 		 * NEEDSWORK: we should have a way to terminate the
 		 * caller early.
 		 */
-		return;
+		return 0;
 	data->hit = !regexec_buf(data->regexp, line + 1, len - 1, 1,
 				 &regmatch, 0);
+	return 0;
 }
 
 static int diff_grep(mmfile_t *one, mmfile_t *two,
diff --git a/range-diff.c b/range-diff.c
index 116fb0735c6..83c90f946ea 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -274,9 +274,10 @@ static void find_exact_matches(struct string_list *a, struct string_list *b)
 	hashmap_clear(&map);
 }
 
-static void diffsize_consume(void *data, char *line, unsigned long len)
+static int diffsize_consume(void *data, char *line, unsigned long len)
 {
 	(*(int *)data)++;
+	return 0;
 }
 
 static void diffsize_hunk(void *data, long ob, long on, long nb, long nn,
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 4d20069302b..5d8c8c67dc2 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -31,7 +31,7 @@ static int xdiff_out_hunk(void *priv_,
 	return 0;
 }
 
-static void consume_one(void *priv_, char *s, unsigned long size)
+static int consume_one(void *priv_, char *s, unsigned long size)
 {
 	struct xdiff_emit_state *priv = priv_;
 	char *ep;
@@ -43,6 +43,7 @@ static void consume_one(void *priv_, char *s, unsigned long size)
 		size -= this_size;
 		s += this_size;
 	}
+	return 0;
 }
 
 static int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 93df26900c2..0198f9632f5 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -11,7 +11,7 @@
  */
 #define MAX_XDIFF_SIZE (1024UL * 1024 * 1023)
 
-typedef void (*xdiff_emit_line_fn)(void *, char *, unsigned long);
+typedef int (*xdiff_emit_line_fn)(void *, char *, unsigned long);
 typedef void (*xdiff_emit_hunk_fn)(void *data,
 				   long old_begin, long old_nr,
 				   long new_begin, long new_nr,
-- 
2.31.1.639.g3d04783866f

