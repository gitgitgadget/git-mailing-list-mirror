Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B0A22023D
	for <e@80x24.org>; Tue, 23 May 2017 02:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936108AbdEWClc (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 22:41:32 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36208 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935988AbdEWClW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 22:41:22 -0400
Received: by mail-pf0-f169.google.com with SMTP id m17so99605422pfg.3
        for <git@vger.kernel.org>; Mon, 22 May 2017 19:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GYQ7uI5JzTZHPuAZFng7+iR6XceMlmIrf8F26lr/0eI=;
        b=QpZnEGYzUTu2FzHOq9kilGxkiXxOBD/hP4WHigwirE8CIcfbOKzcKEPO7zDaCYnRn+
         xmUiFTBML7x+Azukj4ddw9XL1qmcO37wH9sFUljfSyNhHGtlkAe1jwiRJ2KNDJorJ36e
         CRcadW9YY3/A3sml8/Aqz+8UEqe1IiUl74rqIFCn4OGB2iPYJU78+iV/QEsLpLcTdR3U
         +WHfoiUDO7SBpGB5yUL5NJFHrqub1Ynws5QtmcRNyMGXmjwCp0Zc7y1V7P2hHd9NrTuk
         8VL9TBT4VE24ZRhXoDYUZF6LABUrNV+9p7GnSo/OoY5amgyTdaiJa5jXamSG/0LXFm7K
         Sbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GYQ7uI5JzTZHPuAZFng7+iR6XceMlmIrf8F26lr/0eI=;
        b=Xx94t8mxtsGx/g62izx/Y/jljwO5qJrOVruhsv5xhE5YhYTRi/pur6MV7KAau/xMH2
         Htmw7OD45PAGkeLQkKJCYrnyLac4RDrdwpVoniwoMNiDAGStCran1uH5J+WXTzl2THPW
         Ctkvj6rBv2vSkvzmVzmvTLWdm99GVZmAyL/HW1QMEeLAVdsYZaaL1VAfsmfvS6YUN+MQ
         AEJ0WTPSdcsCE5U+benJ+aK1j9jgZWoDcmipV52WFaJi7bOwzhRxwUdRrKkJIu/1DZH7
         6MboIqT7oYo//FUMud52WDVyi0kKyVUv0RyvvKbRmC9qc6Mcv+mYCkq8cYHc8GYrFV9Q
         8hlg==
X-Gm-Message-State: AODbwcCd/yGpHVmuMASWesdqoLdlNDdi8pubxRsV/Wr+jXFNnn3k89Rf
        3v48VFy/pU2UCggN
X-Received: by 10.98.157.83 with SMTP id i80mr29026080pfd.166.1495507281194;
        Mon, 22 May 2017 19:41:21 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:6dc1:8d70:6f8f:1c2a])
        by smtp.gmail.com with ESMTPSA id i63sm33019573pgc.26.2017.05.22.19.41.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 19:41:20 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 16/17] diff: buffer all output if asked to
Date:   Mon, 22 May 2017 19:40:47 -0700
Message-Id: <20170523024048.16879-17-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170523024048.16879-1-sbeller@google.com>
References: <20170518193746.486-1-sbeller@google.com>
 <20170523024048.16879-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a new option 'use_buffer' in the struct diff_options which
controls whether all output is buffered up until all output is available.

We'll have a new struct 'diff_line' in diff.h which will be used to buffer
each line.  The diff_line will duplicate the memory of the line to buffer
as that is easiest to reason about for now. In a future patch we may want
to decrease the memory usage by not duplicating all output for buffering
but rather we may want to store offsets into the file or in case of hunk
descriptions such as the similarity score, we could just store the
relevant number and reproduce the text later on.

This approach was chosen as a first step because it is quite simple
compared to the alternative with less memory footprint.

emit_line factors out the emission part into emit_line_emission,
and depending on the diff_options->use_buffer the emission
will be performed directly when calling emit_line or after the
whole process is done, i.e. by buffering we have add the possibility
for a second pass over the whole output before doing the actual
output.

In 6440d34 (2012-03-14, diff: tweak a _copy_ of diff_options with
word-diff) we introduced a duplicate diff options struct for word
emissions as we may have different regex settings in there.
When buffering the output, we need to operate on just one buffer,
so we have to copy back the emissions of the word buffer into the
main buffer.

Unconditionally enable output via buffer in this patch as it yields
a great opportunity for testing, i.e. all the diff tests from the
test suite pass without having reordering issues (i.e. only parts
of the output got buffered, and we forgot to buffer other parts).
The test suite passes, which gives confidence that we converted all
functions to use emit_line for output.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++---------------
 diff.h |  41 +++++++++++++++++
 2 files changed, 161 insertions(+), 35 deletions(-)

diff --git a/diff.c b/diff.c
index 514c5facd7..c0b8afa38f 100644
--- a/diff.c
+++ b/diff.c
@@ -516,54 +516,85 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
 }
 
-
-static void emit_line(struct diff_options *o,
-		      const char *set, const char *reset,
-		      int add_line_prefix, int markup_ws,
-		      int sign, const char *line, int len)
+static void emit_diff_line(struct diff_options *o,
+				     struct diff_line *e)
 {
 	const char *ws;
 	int has_trailing_newline, has_trailing_carriage_return;
+	int len = e->len;
 	FILE *file = o->file;
 
-	if (add_line_prefix)
+	if (e->add_line_prefix)
 		fputs(diff_line_prefix(o), file);
 
-	if (markup_ws) {
+	switch (e->state) {
+	case DIFF_LINE_WS:
 		ws = diff_get_color(o->use_color, DIFF_WHITESPACE);
+		if (e->set)
+			fputs(e->set, file);
+		if (e->sign)
+			fputc(e->sign, file);
+		if (e->reset)
+			fputs(e->reset, file);
+		ws_check_emit(e->line, e->len, o->ws_rule,
+			      file, e->set, e->reset, ws);
+		return;
+	case DIFF_LINE_ASIS:
+		has_trailing_newline = (len > 0 && e->line[len-1] == '\n');
+		if (has_trailing_newline)
+			len--;
+		has_trailing_carriage_return = (len > 0 && e->line[len-1] == '\r');
+		if (has_trailing_carriage_return)
+			len--;
 
-		if (set)
-			fputs(set, file);
-		if (sign)
-			fputc(sign, file);
-		if (reset)
-			fputs(reset, file);
-		ws = diff_get_color(o->use_color, DIFF_WHITESPACE);
-		ws_check_emit(line, len, o->ws_rule,
-			      file, set, reset, ws);
+		if (len || e->sign) {
+			if (e->set)
+				fputs(e->set, file);
+			if (e->sign)
+				fputc(e->sign, file);
+			fwrite(e->line, len, 1, file);
+			if (e->reset)
+				fputs(e->reset, file);
+		}
+		if (has_trailing_carriage_return)
+			fputc('\r', file);
+		if (has_trailing_newline)
+			fputc('\n', file);
+		return;
+	case DIFF_LINE_RELOAD_WS_RULE:
+		o->ws_rule = whitespace_rule(e->line);
 		return;
+	default:
+		die("BUG: malformatted buffered patch line: '%d'", e->state);
 	}
+}
 
-	has_trailing_newline = (len > 0 && line[len-1] == '\n');
-	if (has_trailing_newline)
-		len--;
-	has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
-	if (has_trailing_carriage_return)
-		len--;
+static void append_diff_line(struct diff_options *o,
+				       struct diff_line *e)
+{
+	struct diff_line *f;
+	ALLOC_GROW(o->line_buffer,
+		   o->line_buffer_nr + 1,
+		   o->line_buffer_alloc);
+	f = &o->line_buffer[o->line_buffer_nr++];
 
-	if (len || sign) {
-		if (set)
-			fputs(set, file);
-		if (sign)
-			fputc(sign, file);
-		fwrite(line, len, 1, file);
-		if (reset)
-			fputs(reset, file);
-	}
-	if (has_trailing_carriage_return)
-		fputc('\r', file);
-	if (has_trailing_newline)
-		fputc('\n', file);
+	memcpy(f, e, sizeof(struct diff_line));
+	f->line = e->line ? xmemdupz(e->line, e->len) : NULL;
+}
+
+static void emit_line(struct diff_options *o,
+		      const char *set, const char *reset,
+		      int add_line_prefix, int markup_ws,
+		      int sign, const char *line, int len)
+{
+	struct diff_line e = {set, reset, line,
+		len, sign, add_line_prefix,
+		markup_ws ? DIFF_LINE_WS : DIFF_LINE_ASIS};
+
+	if (o->use_buffer)
+		append_diff_line(o, &e);
+	else
+		emit_diff_line(o, &e);
 }
 
 static void emit_line_fmt(struct diff_options *o,
@@ -1172,6 +1203,18 @@ static void diff_words_flush(struct emit_callback *ecbdata)
 	if (ecbdata->diff_words->minus.text.size ||
 	    ecbdata->diff_words->plus.text.size)
 		diff_words_show(ecbdata->diff_words);
+
+	if (ecbdata->diff_words->opt->line_buffer_nr) {
+		int i;
+		for (i = 0; i < ecbdata->diff_words->opt->line_buffer_nr; i++)
+			append_diff_line(ecbdata->opt,
+				&ecbdata->diff_words->opt->line_buffer[i]);
+
+		for (i = 0; i < ecbdata->diff_words->opt->line_buffer_nr; i++)
+			free((void *)ecbdata->diff_words->opt->line_buffer[i].line);
+
+		ecbdata->diff_words->opt->line_buffer_nr = 0;
+	}
 }
 
 static void diff_filespec_load_driver(struct diff_filespec *one)
@@ -1207,6 +1250,11 @@ static void init_diff_words_data(struct emit_callback *ecbdata,
 		xcalloc(1, sizeof(struct diff_words_data));
 	ecbdata->diff_words->type = o->word_diff;
 	ecbdata->diff_words->opt = o;
+
+	o->line_buffer = NULL;
+	o->line_buffer_nr = 0;
+	o->line_buffer_alloc = 0;
+
 	if (!o->word_regex)
 		o->word_regex = userdiff_word_regex(one);
 	if (!o->word_regex)
@@ -1241,6 +1289,7 @@ static void free_diff_words_data(struct emit_callback *ecbdata)
 {
 	if (ecbdata->diff_words) {
 		diff_words_flush(ecbdata);
+		free (ecbdata->diff_words->opt->line_buffer);
 		free (ecbdata->diff_words->opt);
 		free (ecbdata->diff_words->minus.text.ptr);
 		free (ecbdata->diff_words->minus.orig);
@@ -2579,6 +2628,13 @@ static void builtin_diff(const char *name_a,
 			xecfg.ctxlen = strtoul(v, NULL, 10);
 		if (o->word_diff)
 			init_diff_words_data(&ecbdata, o, one, two);
+		if (o->use_buffer) {
+			struct diff_line e = diff_line_INIT;
+			e.state = DIFF_LINE_RELOAD_WS_RULE;
+			e.line = name_b;
+			e.len = strlen(name_b);
+			append_diff_line(o, &e);
+		}
 		if (xdi_diff_outf(&mf1, &mf2, fn_out_consume, &ecbdata,
 				  &xpp, &xecfg))
 			die("unable to generate diff for %s", one->path);
@@ -3458,6 +3514,10 @@ void diff_setup(struct diff_options *options)
 		options->a_prefix = "a/";
 		options->b_prefix = "b/";
 	}
+
+	options->line_buffer = NULL;
+	options->line_buffer_nr = 0;
+	options->line_buffer_alloc = 0;
 }
 
 void diff_setup_done(struct diff_options *options)
@@ -4796,11 +4856,36 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 {
 	int i;
 	struct diff_queue_struct *q = &diff_queued_diff;
+	/*
+	 * For testing purposes we want to make sure the diff machinery
+	 * works completely with the buffer. If there is anything emitted
+	 * outside the emit_diff_line, then the order is screwed
+	 * up and the tests will fail.
+	 *
+	 * TODO (later in this series):
+	 * We'll unset this flag in a later patch.
+	 */
+	o->use_buffer = 1;
+
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		if (check_pair_status(p))
 			diff_flush_patch(p, o);
 	}
+
+	if (o->use_buffer) {
+		for (i = 0; i < o->line_buffer_nr; i++)
+			emit_diff_line(o, &o->line_buffer[i]);
+
+		for (i = 0; i < o->line_buffer_nr; i++)
+			free((void *)o->line_buffer[i].line);
+
+		free(o->line_buffer);
+
+		o->line_buffer = NULL;
+		o->line_buffer_nr = 0;
+		o->line_buffer_alloc = 0;
+	}
 }
 
 void diff_flush(struct diff_options *options)
diff --git a/diff.h b/diff.h
index 85948ed65a..fad1258556 100644
--- a/diff.h
+++ b/diff.h
@@ -115,6 +115,42 @@ enum diff_submodule_format {
 	DIFF_SUBMODULE_INLINE_DIFF
 };
 
+/*
+ * This struct is used when we need to buffer the output of the diff output.
+ *
+ * NEEDSWORK: Instead of storing a copy of the line, add an offset pointer
+ * into the pre/post image file. This pointer could be a union with the
+ * line pointer. By storing an offset into the file instead of the literal line,
+ * we can decrease the memory footprint for the buffered output. At first we
+ * may want to only have indirection for the content lines, but we could also
+ * enhance the state for emitting prefabricated lines, e.g. the similarity
+ * score line or hunk/file headers would only need to store a number or path
+ * and then the output can be constructed later on depending on state.
+ */
+struct diff_line {
+	const char *set;
+	const char *reset;
+	const char *line;
+	int len;
+	int sign;
+	int add_line_prefix;
+	enum {
+		/*
+		 * Emits [lineprefix][set][sign][reset] and then calls
+		 * ws_check_emit which will output "line", marked up
+		 * according to ws_rule.
+		 */
+		DIFF_LINE_WS,
+
+		/* Emits [lineprefix][set][sign] line [reset] */
+		DIFF_LINE_ASIS,
+
+		/* Reloads the ws_rule; line contains the file name */
+		DIFF_LINE_RELOAD_WS_RULE
+	} state;
+};
+#define diff_line_INIT {NULL, NULL, NULL, 0, 0, 0}
+
 struct diff_options {
 	const char *orderfile;
 	const char *pickaxe;
@@ -188,8 +224,13 @@ struct diff_options {
 	int diff_path_counter;
 
 	unsigned ws_rule;
+	int use_buffer;
+
+	struct diff_line *line_buffer;
+	int line_buffer_nr, line_buffer_alloc;
 };
 
+/* Emit [line_prefix] [set] line [reset] */
 void diff_emit_line(struct diff_options *o, const char *set, const char *reset,
 		    const char *line, int len);
 
-- 
2.13.0.18.g7d86cc8ba0

