Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C0771F667
	for <e@80x24.org>; Wed, 16 Aug 2017 20:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbdHPUQy (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 16:16:54 -0400
Received: from vie01a-dmta-pe04-1.mx.upcmail.net ([62.179.121.163]:62440 "EHLO
        vie01a-dmta-pe04-1.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752545AbdHPUQu (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Aug 2017 16:16:50 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe04.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1di4kD-0005Qt-6l
        for git@vger.kernel.org; Wed, 16 Aug 2017 22:16:49 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id xwGn1v0095BuuEg01wGoNB; Wed, 16 Aug 2017 22:16:48 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id 10DDC45D4621; Wed, 16 Aug 2017 22:16:47 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [Patch size_t V3 19/19] Convert xdiff-interface to size_t
Date:   Wed, 16 Aug 2017 22:16:31 +0200
Message-Id: <1502914591-26215-20-git-send-email-martin@mail.zuhause>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Koegler <martin.koegler@chello.at>

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
 combine-diff.c     |  2 +-
 diff.c             | 28 ++++++++++++++--------------
 diffcore-pickaxe.c |  4 ++--
 xdiff-interface.c  |  8 ++++----
 xdiff-interface.h  |  6 +++---
 5 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index acf39ec..ad5d177 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -343,7 +343,7 @@ struct combine_diff_state {
 	struct sline *lost_bucket;
 };
 
-static void consume_line(void *state_, char *line, unsigned long len)
+static void consume_line(void *state_, char *line, size_t len)
 {
 	struct combine_diff_state *state = state_;
 	if (5 < len && !memcmp("@@ -", line, 4)) {
diff --git a/diff.c b/diff.c
index c12d062..f665f8d 100644
--- a/diff.c
+++ b/diff.c
@@ -406,7 +406,7 @@ static struct diff_tempfile {
 	struct tempfile tempfile;
 } diff_temp[2];
 
-typedef unsigned long (*sane_truncate_fn)(char *line, unsigned long len);
+typedef size_t (*sane_truncate_fn)(char *line, size_t len);
 
 struct emit_callback {
 	int color_diff;
@@ -461,7 +461,7 @@ static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
 }
 
 /* like fill_mmfile, but only for size, so we can avoid retrieving blob */
-static unsigned long diff_filespec_size(struct diff_filespec *one)
+static size_t diff_filespec_size(struct diff_filespec *one)
 {
 	if (!DIFF_FILE_VALID(one))
 		return 0;
@@ -832,7 +832,7 @@ struct diff_words_buffer {
 	int orig_nr, orig_alloc;
 };
 
-static void diff_words_append(char *line, unsigned long len,
+static void diff_words_append(char *line, size_t len,
 		struct diff_words_buffer *buffer)
 {
 	ALLOC_GROW(buffer->text.ptr, buffer->text.size + len, buffer->alloc);
@@ -949,7 +949,7 @@ static int color_words_output_graph_prefix(struct diff_words_data *diff_words)
 	}
 }
 
-static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
+static void fn_out_diff_words_aux(void *priv, char *line, size_t len)
 {
 	struct diff_words_data *diff_words = priv;
 	struct diff_words_style *style = diff_words->style;
@@ -1237,10 +1237,10 @@ const char *diff_line_prefix(struct diff_options *opt)
 	return msgbuf->buf;
 }
 
-static unsigned long sane_truncate_line(struct emit_callback *ecb, char *line, unsigned long len)
+static size_t sane_truncate_line(struct emit_callback *ecb, char *line, size_t len)
 {
 	const char *cp;
-	unsigned long allot;
+	size_t allot;
 	size_t l = len;
 
 	if (ecb->truncate)
@@ -1270,7 +1270,7 @@ static void find_lno(const char *line, struct emit_callback *ecbdata)
 	ecbdata->lno_in_postimage = strtol(p + 1, NULL, 10);
 }
 
-static void fn_out_consume(void *priv, char *line, unsigned long len)
+static void fn_out_consume(void *priv, char *line, size_t len)
 {
 	struct emit_callback *ecbdata = priv;
 	const char *meta = diff_get_color(ecbdata->color_diff, DIFF_METAINFO);
@@ -1492,7 +1492,7 @@ static struct diffstat_file *diffstat_add(struct diffstat_t *diffstat,
 	return x;
 }
 
-static void diffstat_consume(void *priv, char *line, unsigned long len)
+static void diffstat_consume(void *priv, char *line, size_t len)
 {
 	struct diffstat_t *diffstat = priv;
 	struct diffstat_file *x = diffstat->files[diffstat->nr - 1];
@@ -2132,7 +2132,7 @@ struct checkdiff_t {
 	unsigned status;
 };
 
-static int is_conflict_marker(const char *line, int marker_size, unsigned long len)
+static int is_conflict_marker(const char *line, int marker_size, size_t len)
 {
 	char firstchar;
 	int cnt;
@@ -2155,7 +2155,7 @@ static int is_conflict_marker(const char *line, int marker_size, unsigned long l
 	return 1;
 }
 
-static void checkdiff_consume(void *priv, char *line, unsigned long len)
+static void checkdiff_consume(void *priv, char *line, size_t len)
 {
 	struct checkdiff_t *data = priv;
 	int marker_size = data->conflict_marker_size;
@@ -2953,7 +2953,7 @@ void diff_free_filespec_data(struct diff_filespec *s)
 
 static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 			   void *blob,
-			   unsigned long size,
+			   size_t size,
 			   const struct object_id *oid,
 			   int mode)
 {
@@ -4536,7 +4536,7 @@ struct patch_id_t {
 	int patchlen;
 };
 
-static int remove_space(char *line, int len)
+static size_t remove_space(char *line, size_t len)
 {
 	int i;
 	char *dst = line;
@@ -4549,10 +4549,10 @@ static int remove_space(char *line, int len)
 	return dst - line;
 }
 
-static void patch_id_consume(void *priv, char *line, unsigned long len)
+static void patch_id_consume(void *priv, char *line, size_t len)
 {
 	struct patch_id_t *data = priv;
-	int new_len;
+	size_t new_len;
 
 	/* Ignore line numbers when computing the SHA1 of the patch */
 	if (starts_with(line, "@@ -"))
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 341529b..db73cb4 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -19,7 +19,7 @@ struct diffgrep_cb {
 	int hit;
 };
 
-static void diffgrep_consume(void *priv, char *line, unsigned long len)
+static void diffgrep_consume(void *priv, char *line, size_t len)
 {
 	struct diffgrep_cb *data = priv;
 	regmatch_t regmatch;
@@ -70,7 +70,7 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
 {
 	unsigned int cnt;
-	unsigned long sz;
+	size_t sz;
 	const char *data;
 
 	sz = mf->size;
diff --git a/xdiff-interface.c b/xdiff-interface.c
index d82cd4a..f12285d 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -26,7 +26,7 @@ static int parse_num(char **cp_p, int *num_p)
 	return 0;
 }
 
-int parse_hunk_header(char *line, int len,
+int parse_hunk_header(char *line, size_t len,
 		      int *ob, int *on,
 		      int *nb, int *nn)
 {
@@ -57,12 +57,12 @@ int parse_hunk_header(char *line, int len,
 	return -!!memcmp(cp, " @@", 3);
 }
 
-static void consume_one(void *priv_, char *s, unsigned long size)
+static void consume_one(void *priv_, char *s, size_t size)
 {
 	struct xdiff_emit_state *priv = priv_;
 	char *ep;
 	while (size) {
-		unsigned long this_size;
+		size_t this_size;
 		ep = memchr(s, '\n', size);
 		this_size = (ep == NULL) ? size : (ep - s + 1);
 		priv->consume(priv->consume_callback_data, s, this_size);
@@ -197,7 +197,7 @@ void read_mmblob(mmfile_t *ptr, const struct object_id *oid)
 }
 
 #define FIRST_FEW_BYTES 8000
-int buffer_is_binary(const char *ptr, unsigned long size)
+int buffer_is_binary(const char *ptr, size_t size)
 {
 	if (FIRST_FEW_BYTES < size)
 		size = FIRST_FEW_BYTES;
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 6f6ba90..7eb58ad 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -11,18 +11,18 @@
  */
 #define MAX_XDIFF_SIZE (1024UL * 1024 * 1023)
 
-typedef void (*xdiff_emit_consume_fn)(void *, char *, unsigned long);
+typedef void (*xdiff_emit_consume_fn)(void *, char *, size_t);
 
 int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t const *xecfg, xdemitcb_t *ecb);
 int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 		  xdiff_emit_consume_fn fn, void *consume_callback_data,
 		  xpparam_t const *xpp, xdemitconf_t const *xecfg);
-int parse_hunk_header(char *line, int len,
+int parse_hunk_header(char *line, size_t len,
 		      int *ob, int *on,
 		      int *nb, int *nn);
 int read_mmfile(mmfile_t *ptr, const char *filename);
 void read_mmblob(mmfile_t *ptr, const struct object_id *oid);
-int buffer_is_binary(const char *ptr, unsigned long size);
+int buffer_is_binary(const char *ptr, size_t size);
 
 extern void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflags);
 extern void xdiff_clear_find_func(xdemitconf_t *xecfg);
-- 
2.1.4

