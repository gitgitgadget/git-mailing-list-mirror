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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860D8C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2825264DDA
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhBPMEn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhBPMBx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 07:01:53 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC01C06121E
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:30 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t15so12530505wrx.13
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=109pyCw2QBo6NfJiuUWSvRBGrEVwm9A5hF49WxQCV3Q=;
        b=Yh2UufRYgU0PbA8WIzhZZcXR8s/+oy9872Trz3pFbbX5ckejipUEtziQfw20/NaJhv
         XIyAHCoIvaXeFrDl1cE3NOnFQ1ETgXJ9iduIc5OoiSen+gPzfJJJa8cdVI54yTNoWQWm
         vgeaDh9udv3NSdVHLfFXmcteqbW1B2mMnds/szJ77PLuRfekatkKPtRIsY1t6YR2zoBs
         GWEMQMvRBCEMkRo0hl+8pk/ZrlqenT6mHLb8LyVtPowEQ4eq9LZwh5LQ6rwPf8s5c0C/
         73cxfsNNXc5tIDmORZ4+YIzZzszpuOt/R9pJM8USBlmTfGOG6BE+x7hfebCQim+Ac4ge
         RH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=109pyCw2QBo6NfJiuUWSvRBGrEVwm9A5hF49WxQCV3Q=;
        b=byM5YZRZ/KU3Y30V2kmVGudK30h+yBCNtLEV8vQcBSumkcZ6ncoFqw7s7lJn7EQ6+H
         5XJgADVMGd2J1xFtMrlmVmeC90tpWPNBJ4WxHsKnyG7C3UPOJ00i++L/QLFR1YGKbzpm
         s+2A7sLnGphVRc46CauYhtnTODm33MDGoaL0WwQUqbTN2fAHFSaA3kcn7hDnHIjOaQa9
         m2ls7aazbSG60u6yzOU47l3XP91+NbRKn+BrJJlqQamDtYOYY+xjxEd0sCrWI1AAHvSE
         syb8ah5TUDCyLvKYYP23OXsfibEf2+UVH6AQrIxbk1k3VjHOl8JJKGgedNcFrSf+Zp0n
         tR4w==
X-Gm-Message-State: AOAM531KQlk11Noncubk2JgAvOZcToMHC8hcEm/JPRySwVB5i4oTp0b0
        8mwx5ziquFQYWGEJh32Q7aX2cBng88iV/g==
X-Google-Smtp-Source: ABdhPJy/5Yw9JP5QLvIUYAbS4syk9c3KFaT7mUKmrSA1o+ee9nCbKHeAmQ6RrhWTdupA6Zyam9qu6Q==
X-Received: by 2002:a05:6000:1a8c:: with SMTP id f12mr23312728wry.173.1613476709090;
        Tue, 16 Feb 2021 03:58:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b2sm27968246wrv.73.2021.02.16.03.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:58:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 19/22] xdiff-interface: allow early return from xdiff_emit_{line,hunk}_fn
Date:   Tue, 16 Feb 2021 12:57:58 +0100
Message-Id: <20210216115801.4773-20-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the function prototype of xdiff_emit_{line,hunk}_fn to return
an int instead of void. This will allow for returning early from hunk
& diff consumers that want some of the data, but not all of it.

No behavior is being changed here, just replacing the equivalent of
"return" with "return 0", nothing acts on the changed return values
yet.

There was some work in this area of xdiff-interface.[ch] recently with
3b40a090fd4 (diff: avoid generating unused hunk header lines,
2018-11-02) and 7c61e25fbf1 (diff: use hunk callback for word-diff,
2018-11-02).

In combination those two changes allow us to not do any work on the
hunks and diff at all, but didn't change the status quo with regards
to consumers that e.g. want the diff lines, but might want to abort
early.

Whereas soon we can abort e.g. on the first "-line" of a 1000 line
diff if that's all we needed.

This interface is rather scary as noted in the comment to
xdiff-interface.h being added here, but it will be useful for
diffcore-pickaxe.c in a subsequent commit. A future change could
e.g. add more exit codes, and hack xdl_emit_diff() and friends to
ignore or skip things more selectively as a result.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 combine-diff.c     |  9 ++++++---
 diff.c             | 39 +++++++++++++++++++++++----------------
 diffcore-pickaxe.c |  7 ++++---
 range-diff.c       |  8 +++++---
 xdiff-interface.c  | 10 ++++++----
 xdiff-interface.h  | 31 +++++++++++++++++++++++--------
 6 files changed, 67 insertions(+), 37 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 9228aebc16b..6590c4b5fb7 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -369,7 +369,7 @@ struct combine_diff_state {
 	struct sline *lost_bucket;
 };
 
-static void consume_hunk(void *state_,
+static int consume_hunk(void *state_,
 			 long ob, long on,
 			 long nb, long nn,
 			 const char *funcline, long funclen)
@@ -401,13 +401,15 @@ static void consume_hunk(void *state_,
 		state->sline[state->nb-1].p_lno =
 			xcalloc(state->num_parent, sizeof(unsigned long));
 	state->sline[state->nb-1].p_lno[state->n] = state->ob;
+
+	return 0;
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
@@ -417,6 +419,7 @@ static void consume_line(void *state_, char *line, unsigned long len)
 		state->lno++;
 		break;
 	}
+	return 0;
 }
 
 static void combine_diff(struct repository *r,
diff --git a/diff.c b/diff.c
index 63c49ecaef1..4d554281147 100644
--- a/diff.c
+++ b/diff.c
@@ -1996,10 +1996,10 @@ static int color_words_output_graph_prefix(struct diff_words_data *diff_words)
 	}
 }
 
-static void fn_out_diff_words_aux(void *priv,
-				  long minus_first, long minus_len,
-				  long plus_first, long plus_len,
-				  const char *func, long funclen)
+static int fn_out_diff_words_aux(void *priv,
+				 long minus_first, long minus_len,
+				 long plus_first, long plus_len,
+				 const char *func, long funclen)
 {
 	struct diff_words_data *diff_words = priv;
 	struct diff_words_style *style = diff_words->style;
@@ -2047,6 +2047,8 @@ static void fn_out_diff_words_aux(void *priv,
 
 	diff_words->current_plus = plus_end;
 	diff_words->last_minus = minus_first;
+
+	return 0;
 }
 
 /* This function starts looking at *begin, and returns 0 iff a word was found. */
@@ -2338,7 +2340,7 @@ static void find_lno(const char *line, struct emit_callback *ecbdata)
 	ecbdata->lno_in_postimage = strtol(p + 1, NULL, 10);
 }
 
-static void fn_out_consume(void *priv, char *line, unsigned long len)
+static int fn_out_consume(void *priv, char *line, unsigned long len)
 {
 	struct emit_callback *ecbdata = priv;
 	struct diff_options *o = ecbdata->opt;
@@ -2374,7 +2376,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		len = sane_truncate_line(line, len);
 		find_lno(line, ecbdata);
 		emit_hunk_header(ecbdata, line, len);
-		return;
+		return 0;
 	}
 
 	if (ecbdata->diff_words) {
@@ -2384,11 +2386,11 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
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
@@ -2397,11 +2399,11 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
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
@@ -2425,6 +2427,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 				 line, len, 0);
 		break;
 	}
+	return 0;
 }
 
 static void pprint_rename(struct strbuf *name, const char *a, const char *b)
@@ -2524,7 +2527,7 @@ static struct diffstat_file *diffstat_add(struct diffstat_t *diffstat,
 	return x;
 }
 
-static void diffstat_consume(void *priv, char *line, unsigned long len)
+static int diffstat_consume(void *priv, char *line, unsigned long len)
 {
 	struct diffstat_t *diffstat = priv;
 	struct diffstat_file *x = diffstat->files[diffstat->nr - 1];
@@ -2533,6 +2536,7 @@ static void diffstat_consume(void *priv, char *line, unsigned long len)
 		x->added++;
 	else if (line[0] == '-')
 		x->deleted++;
+	return 0;
 }
 
 const char mime_boundary_leader[] = "------------";
@@ -3201,16 +3205,17 @@ static int is_conflict_marker(const char *line, int marker_size, unsigned long l
 	return 1;
 }
 
-static void checkdiff_consume_hunk(void *priv,
+static int checkdiff_consume_hunk(void *priv,
 				   long ob, long on, long nb, long nn,
 				   const char *func, long funclen)
 
 {
 	struct checkdiff_t *data = priv;
 	data->lineno = nb - 1;
+	return 0;
 }
 
-static void checkdiff_consume(void *priv, char *line, unsigned long len)
+static int checkdiff_consume(void *priv, char *line, unsigned long len)
 {
 	struct checkdiff_t *data = priv;
 	int marker_size = data->conflict_marker_size;
@@ -3234,7 +3239,7 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 		}
 		bad = ws_check(line + 1, len - 1, data->ws_rule);
 		if (!bad)
-			return;
+			return 0;
 		data->status |= bad;
 		err = whitespace_error_string(bad);
 		fprintf(data->o->file, "%s%s:%d: %s.\n",
@@ -3246,6 +3251,7 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 	} else if (line[0] == ' ') {
 		data->lineno++;
 	}
+	return 0;
 }
 
 static unsigned char *deflate_it(char *data,
@@ -6104,17 +6110,18 @@ void flush_one_hunk(struct object_id *result, git_hash_ctx *ctx)
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
index 76c178bae2b..94601072bde 100644
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
index a3cc7c94a3d..f51c6a67712 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -274,15 +274,17 @@ static void find_exact_matches(struct string_list *a, struct string_list *b)
 	hashmap_clear(&map);
 }
 
-static void diffsize_consume(void *data, char *line, unsigned long len)
+static int diffsize_consume(void *data, char *line, unsigned long len)
 {
 	(*(int *)data)++;
+	return 0;
 }
 
-static void diffsize_hunk(void *data, long ob, long on, long nb, long nn,
-			  const char *funcline, long funclen)
+static int diffsize_hunk(void *data, long ob, long on, long nb, long nn,
+			 const char *funcline, long funclen)
 {
 	diffsize_consume(data, NULL, 0);
+	return 0;
 }
 
 static int diffsize(const char *a, const char *b)
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 4d20069302b..ef557dc4e63 100644
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
@@ -115,10 +116,11 @@ int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t co
 	return xdl_diff(&a, &b, xpp, xecfg, xecb);
 }
 
-void discard_hunk_line(void *priv,
-		       long ob, long on, long nb, long nn,
-		       const char *func, long funclen)
+int discard_hunk_line(void *priv,
+		      long ob, long on, long nb, long nn,
+		      const char *func, long funclen)
 {
+	return 0;
 }
 
 int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 93df26900c2..1b27d6104ce 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -11,11 +11,26 @@
  */
 #define MAX_XDIFF_SIZE (1024UL * 1024 * 1023)
 
-typedef void (*xdiff_emit_line_fn)(void *, char *, unsigned long);
-typedef void (*xdiff_emit_hunk_fn)(void *data,
-				   long old_begin, long old_nr,
-				   long new_begin, long new_nr,
-				   const char *func, long funclen);
+/*
+ * The xdiff_emit_{line,hunk}_fn consumers can return -1 to abort
+ * early, or 0 to continue processing. Note that doing so is an
+ * all-or-nothing affair, as returning -1 will return all the way to
+ * the top-level, e.g. the xdi_diff_outf() call to generate the diff.
+ *
+ * Thus returning -1 from a hunk header callback means you won't be
+ * getting any more hunks, or diffs, and likewise returning from a
+ * line callback means you won't be getting anymore lines.
+ *
+ * We may extend the interface in the future to understand other more
+ * granular return values, but for now use it carefully, or consider
+ * e.g. using discard_hunk_line() if you say just don't care about
+ * hunk headers.
+ */
+typedef int (*xdiff_emit_line_fn)(void *, char *, unsigned long);
+typedef int (*xdiff_emit_hunk_fn)(void *data,
+				  long old_begin, long old_nr,
+				  long new_begin, long new_nr,
+				  const char *func, long funclen);
 
 int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t const *xecfg, xdemitcb_t *ecb);
 int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
@@ -36,9 +51,9 @@ extern int git_xmerge_style;
  * Can be used as a no-op hunk_fn for xdi_diff_outf(), since a NULL
  * one just sends the hunk line to the line_fn callback).
  */
-void discard_hunk_line(void *priv,
-		       long ob, long on, long nb, long nn,
-		       const char *func, long funclen);
+int discard_hunk_line(void *priv,
+		      long ob, long on, long nb, long nn,
+		      const char *func, long funclen);
 
 /*
  * Compare the strings l1 with l2 which are of size s1 and s2 respectively.
-- 
2.30.0.284.gd98b1dd5eaa7

