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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0E5C4708A
	for <git@archiver.kernel.org>; Thu, 27 May 2021 14:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A77AE613D8
	for <git@archiver.kernel.org>; Thu, 27 May 2021 14:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbhE0OpC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 10:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbhE0OpB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 10:45:01 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46B6C061760
        for <git@vger.kernel.org>; Thu, 27 May 2021 07:43:26 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id p7so114063wru.10
        for <git@vger.kernel.org>; Thu, 27 May 2021 07:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JAAfItIZu9jlChbViTD+3xFb+cZVpgo/H+CcRZIoank=;
        b=K298R6G6HKRCkn0w8UfQHhe9EJevC3ANHrBeX0Z8lYF8xq8P1AFxLo00LugwXA0P52
         aKVavvWv9BZe/zc8jlRKT3JsVA2ci3nVE2Z4M4xWf2RmMglqi0RePHRQMQ6DOKrKu2Qy
         A/WeXcn0raakdaBBSmleJvp5Mhw2J7kP9nvxDWGuvVUOHlsCeW29nutIEWcYyjJ42QU7
         kmZ7vBNE9QPlhtmCnQt/GkqKBn7ycZDdFZeQFyGQVQosMNPVvgzUAB/P9hBOXVFFZWvE
         xWstIVgs9s+yesFziV4+UCyi4sDtToLz+bFGAzO5XHOraaU+5P32UE/gklNUIPuCqM3q
         13VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JAAfItIZu9jlChbViTD+3xFb+cZVpgo/H+CcRZIoank=;
        b=pa2ZTrY8A58pDKKU2VC56d57K89h83Z+B50C5AknwaPgb+1FchgSRgorna2OaTPbyR
         VMsc0NRk5sutC6/Efo/gT2tF8kUwbU3Gd32d5NruDfrlmfQYmuPz8xKk7Jr9koBJEIIZ
         vDhjDu31AsMkVLVUSF7hip7kASN1T9kwbMjI73eVBGVp3TxlPLUt3LPc+Axc+7UVURHw
         mNkZn45wJSuzqEgLRHGz8giPFKxrkVO7eKL9t18Xov4HuoKsXdjT7PVxAikeDdDMgcRo
         Hj+BGaw7X8lNaI26mpthzVcUq8mzI6ThYn+LTDaAKa5Q6JRSNyaTI24sa3TbcZqH904m
         0xsg==
X-Gm-Message-State: AOAM530DY+eNxLF/j+zQdhpqPRvyACa/ph6OM2kV1rROMjeVla8Pra7+
        mMZIPqpnCaYg3+49G1sIswtvgluC7OI=
X-Google-Smtp-Source: ABdhPJx2t+eKKx/pAN9/ihvfC/Rbw0mEI61uAaFs4/trdfgEFAiQeIXqlq+U9gMfxHNv3J6HFK32Tw==
X-Received: by 2002:a5d:4003:: with SMTP id n3mr3778665wrp.173.1622126605120;
        Thu, 27 May 2021 07:43:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11sm3387823wrl.13.2021.05.27.07.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 07:43:24 -0700 (PDT)
Message-Id: <b3848f24f2d3f91fc96f20b5a08cbfbe721acbd6.1622126603.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.963.git.1622126603.gitgitgadget@gmail.com>
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 May 2021 14:43:21 +0000
Subject: [PATCH 1/2] [GSOC] ref-filter: add %(raw) atom
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Add new formatting option `%(raw)`, which will print the raw
object data without any changes. It will help further to migrate
all cat-file formatting logic from cat-file to ref-filter.

The raw data of blob, tree objects may contain '\0', but most of
the logic in `ref-filter` depands on the output of the atom being
a structured string (end with '\0').

E.g. `quote_formatting()` use `strbuf_addstr()` or `*._quote_buf()`
add the data to the buffer. The raw data of a tree object is
`100644 one\0...`, only the `100644 one` will be added to the buffer,
which is incorrect.

Therefore, add a new member in `struct atom_value`: `s_size`, which
can record raw object size, it can help us add raw object data to
the buffer or compare two buffers which contain raw object data.

Beyond, `--format=%(raw)` should not combine with `--python`, `--shell`,
`--tcl`, `--perl` because if our binary raw data is passed to a variable
in the host language, the host languages may cause escape errors.

Based-on-patch-by: Olga Telezhnaya <olyatelezhnaya@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-for-each-ref.txt |  14 +++
 ref-filter.c                       | 156 +++++++++++++++++++----
 t/t6300-for-each-ref.sh            | 191 +++++++++++++++++++++++++++++
 3 files changed, 334 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 2ae2478de706..f6ae751fd256 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -235,6 +235,20 @@ and `date` to extract the named component.  For email fields (`authoremail`,
 without angle brackets, and `:localpart` to get the part before the `@` symbol
 out of the trimmed email.
 
+The raw data in a object is `raw`, For commit and tag objects, `raw` contain
+`header` and `contents` two parts, `header` is structured part of raw data, it
+composed of "tree XXX", "parent YYY", etc lines in commits , or composed of
+"object OOO", "type TTT", etc lines in tags; `contents` is unstructured "free
+text" part of raw object data. For blob and tree objects, their raw data don't
+have `header` and `contents` parts.
+
+raw:size::
+	The raw data size of the object.
+
+Note that `--format=%(raw)` should not combine with `--python`, `--shell`, `--tcl`,
+`--perl` because if our binary raw data is passed to a variable in the host language,
+the host languages may cause escape errors.
+
 The message in a commit or a tag object is `contents`, from which
 `contents:<part>` can be used to extract various parts out of:
 
diff --git a/ref-filter.c b/ref-filter.c
index 97116e12d7c4..c2abf5da7006 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -138,6 +138,9 @@ static struct used_atom {
 			struct process_trailer_options trailer_opts;
 			unsigned int nlines;
 		} contents;
+		struct {
+			enum { RAW_BARE, RAW_LENGTH } option;
+		} raw_data;
 		struct {
 			cmp_status cmp_status;
 			const char *str;
@@ -370,6 +373,18 @@ static int contents_atom_parser(const struct ref_format *format, struct used_ato
 	return 0;
 }
 
+static int raw_atom_parser(const struct ref_format *format, struct used_atom *atom,
+				const char *arg, struct strbuf *err)
+{
+	if (!arg) {
+		atom->u.raw_data.option = RAW_BARE;
+	} else if (!strcmp(arg, "size"))
+		atom->u.raw_data.option = RAW_LENGTH;
+	else
+		return strbuf_addf_ret(err, -1, _("unrecognized %%(raw) argument: %s"), arg);
+	return 0;
+}
+
 static int oid_atom_parser(const struct ref_format *format, struct used_atom *atom,
 			   const char *arg, struct strbuf *err)
 {
@@ -530,6 +545,7 @@ static struct {
 	{ "body", SOURCE_OBJ, FIELD_STR, body_atom_parser },
 	{ "trailers", SOURCE_OBJ, FIELD_STR, trailers_atom_parser },
 	{ "contents", SOURCE_OBJ, FIELD_STR, contents_atom_parser },
+	{ "raw", SOURCE_OBJ, FIELD_STR, raw_atom_parser },
 	{ "upstream", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
 	{ "push", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
 	{ "symref", SOURCE_NONE, FIELD_STR, refname_atom_parser },
@@ -564,12 +580,15 @@ struct ref_formatting_state {
 
 struct atom_value {
 	const char *s;
+	size_t s_size;
 	int (*handler)(struct atom_value *atomv, struct ref_formatting_state *state,
 		       struct strbuf *err);
 	uintmax_t value; /* used for sorting when not FIELD_STR */
 	struct used_atom *atom;
 };
 
+#define ATOM_VALUE_S_SIZE_INIT (-1)
+
 /*
  * Used to parse format string and sort specifiers
  */
@@ -588,6 +607,10 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 		return strbuf_addf_ret(err, -1, _("malformed field name: %.*s"),
 				       (int)(ep-atom), atom);
 
+	if (format->quote_style && starts_with(sp, "raw"))
+		return strbuf_addf_ret(err, -1, _("--format=%.*s should not combine with"
+				"--python, --shell, --tcl, --perl"), (int)(ep-atom), atom);
+
 	/* Do we have the atom already used elsewhere? */
 	for (i = 0; i < used_atom_cnt; i++) {
 		int len = strlen(used_atom[i].name);
@@ -652,11 +675,14 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 	return at;
 }
 
-static void quote_formatting(struct strbuf *s, const char *str, int quote_style)
+static void quote_formatting(struct strbuf *s, const char *str, size_t len, int quote_style)
 {
 	switch (quote_style) {
 	case QUOTE_NONE:
-		strbuf_addstr(s, str);
+		if (len != ATOM_VALUE_S_SIZE_INIT)
+			strbuf_add(s, str, len);
+		else
+			strbuf_addstr(s, str);
 		break;
 	case QUOTE_SHELL:
 		sq_quote_buf(s, str);
@@ -683,9 +709,12 @@ static int append_atom(struct atom_value *v, struct ref_formatting_state *state,
 	 * encountered.
 	 */
 	if (!state->stack->prev)
-		quote_formatting(&state->stack->output, v->s, state->quote_style);
+		quote_formatting(&state->stack->output, v->s, v->s_size, state->quote_style);
 	else
-		strbuf_addstr(&state->stack->output, v->s);
+		if (v->s_size != ATOM_VALUE_S_SIZE_INIT)
+			strbuf_add(&state->stack->output, v->s, v->s_size);
+		else
+			strbuf_addstr(&state->stack->output, v->s);
 	return 0;
 }
 
@@ -785,14 +814,16 @@ static int if_atom_handler(struct atom_value *atomv, struct ref_formatting_state
 	return 0;
 }
 
-static int is_empty(const char *s)
+static int is_empty(struct strbuf *buf)
 {
-	while (*s != '\0') {
-		if (!isspace(*s))
-			return 0;
+	const char *s = buf->buf;
+	size_t cur_len = 0;
+
+	while ((cur_len != buf->len) && (isspace(*s) || *s == '\0')) {
 		s++;
+		cur_len++;
 	}
-	return 1;
+	return cur_len == buf->len;
 }
 
 static int then_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state,
@@ -800,6 +831,7 @@ static int then_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
 {
 	struct ref_formatting_stack *cur = state->stack;
 	struct if_then_else *if_then_else = NULL;
+	size_t str_len = 0;
 
 	if (cur->at_end == if_then_else_handler)
 		if_then_else = (struct if_then_else *)cur->at_end_data;
@@ -810,18 +842,28 @@ static int then_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
 	if (if_then_else->else_atom_seen)
 		return strbuf_addf_ret(err, -1, _("format: %%(then) atom used after %%(else)"));
 	if_then_else->then_atom_seen = 1;
+	if (if_then_else->str)
+		str_len = strlen(if_then_else->str);
 	/*
 	 * If the 'equals' or 'notequals' attribute is used then
 	 * perform the required comparison. If not, only non-empty
 	 * strings satisfy the 'if' condition.
 	 */
 	if (if_then_else->cmp_status == COMPARE_EQUAL) {
-		if (!strcmp(if_then_else->str, cur->output.buf))
+		if (!if_then_else->str)
+			BUG("when if_then_else->cmp_status == COMPARE_EQUAL,"
+			    "if_then_else->str must not be null");
+		if (str_len == cur->output.len &&
+		    !memcmp(if_then_else->str, cur->output.buf, cur->output.len))
 			if_then_else->condition_satisfied = 1;
 	} else if (if_then_else->cmp_status == COMPARE_UNEQUAL) {
-		if (strcmp(if_then_else->str, cur->output.buf))
+		if (!if_then_else->str)
+			BUG("when if_then_else->cmp_status == COMPARE_UNEQUAL,"
+			    "if_then_else->str must not be null");
+		if (str_len != cur->output.len ||
+		    memcmp(if_then_else->str, cur->output.buf, cur->output.len))
 			if_then_else->condition_satisfied = 1;
-	} else if (cur->output.len && !is_empty(cur->output.buf))
+	} else if (cur->output.len && !is_empty(&cur->output))
 		if_then_else->condition_satisfied = 1;
 	strbuf_reset(&cur->output);
 	return 0;
@@ -867,7 +909,7 @@ static int end_atom_handler(struct atom_value *atomv, struct ref_formatting_stat
 	 * only on the topmost supporting atom.
 	 */
 	if (!current->prev->prev) {
-		quote_formatting(&s, current->output.buf, state->quote_style);
+		quote_formatting(&s, current->output.buf, current->output.len, state->quote_style);
 		strbuf_swap(&current->output, &s);
 	}
 	strbuf_release(&s);
@@ -1292,7 +1334,7 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
 }
 
 /* See grab_values */
-static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
+static void grab_raw_data(struct atom_value *val, int deref, void *buf, unsigned long buf_size, struct object *obj)
 {
 	int i;
 	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
@@ -1307,10 +1349,22 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 			continue;
 		if (deref)
 			name++;
-		if (strcmp(name, "body") &&
-		    !starts_with(name, "subject") &&
-		    !starts_with(name, "trailers") &&
-		    !starts_with(name, "contents"))
+
+		if (starts_with(name, "raw")) {
+			if (atom->u.raw_data.option == RAW_BARE) {
+				v->s = xmemdupz(buf, buf_size);
+				v->s_size = buf_size;
+			} else if (atom->u.raw_data.option == RAW_LENGTH)
+				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)buf_size);
+			continue;
+		}
+
+		if ((obj->type != OBJ_TAG &&
+		     obj->type != OBJ_COMMIT) ||
+		    (strcmp(name, "body") &&
+		     !starts_with(name, "subject") &&
+		     !starts_with(name, "trailers") &&
+		     !starts_with(name, "contents")))
 			continue;
 		if (!subpos)
 			find_subpos(buf,
@@ -1374,25 +1428,30 @@ static void fill_missing_values(struct atom_value *val)
  * pointed at by the ref itself; otherwise it is the object the
  * ref (which is a tag) refers to.
  */
-static void grab_values(struct atom_value *val, int deref, struct object *obj, void *buf)
+static void grab_values(struct atom_value *val, int deref, struct object *obj, struct expand_data *data)
 {
+	void *buf = data->content;
+	unsigned long buf_size = data->size;
+
 	switch (obj->type) {
 	case OBJ_TAG:
 		grab_tag_values(val, deref, obj);
-		grab_sub_body_contents(val, deref, buf);
+		grab_raw_data(val, deref, buf, buf_size, obj);
 		grab_person("tagger", val, deref, buf);
 		break;
 	case OBJ_COMMIT:
 		grab_commit_values(val, deref, obj);
-		grab_sub_body_contents(val, deref, buf);
+		grab_raw_data(val, deref, buf, buf_size, obj);
 		grab_person("author", val, deref, buf);
 		grab_person("committer", val, deref, buf);
 		break;
 	case OBJ_TREE:
 		/* grab_tree_values(val, deref, obj, buf, sz); */
+		grab_raw_data(val, deref, buf, buf_size, obj);
 		break;
 	case OBJ_BLOB:
 		/* grab_blob_values(val, deref, obj, buf, sz); */
+		grab_raw_data(val, deref, buf, buf_size, obj);
 		break;
 	default:
 		die("Eh?  Object of type %d?", obj->type);
@@ -1614,7 +1673,7 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
 					       oid_to_hex(&oi->oid), ref->refname);
 		}
-		grab_values(ref->value, deref, *obj, oi->content);
+		grab_values(ref->value, deref, *obj, oi);
 	}
 
 	grab_common_values(ref->value, deref, oi);
@@ -1694,7 +1753,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 		int deref = 0;
 		const char *refname;
 		struct branch *branch = NULL;
-
+		v->s_size = ATOM_VALUE_S_SIZE_INIT;
 		v->handler = append_atom;
 		v->atom = atom;
 
@@ -2297,6 +2356,25 @@ static int compare_detached_head(struct ref_array_item *a, struct ref_array_item
 	return 0;
 }
 
+static int memcasecmp(const void *vs1, const void *vs2, size_t n)
+{
+	size_t i;
+	const char *s1 = (const char *)vs1;
+	const char *s2 = (const char *)vs2;
+
+	for (i = 0; i < n; i++) {
+		unsigned char u1 = s1[i];
+		unsigned char u2 = s2[i];
+		int U1 = toupper (u1);
+		int U2 = toupper (u2);
+		int diff = (UCHAR_MAX <= INT_MAX ? U1 - U2
+			: U1 < U2 ? -1 : U2 < U1);
+		if (diff)
+			return diff;
+	}
+	return 0;
+}
+
 static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, struct ref_array_item *b)
 {
 	struct atom_value *va, *vb;
@@ -2304,6 +2382,7 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	int cmp_detached_head = 0;
 	cmp_type cmp_type = used_atom[s->atom].type;
 	struct strbuf err = STRBUF_INIT;
+	size_t slen = 0;
 
 	if (get_ref_atom_value(a, s->atom, &va, &err))
 		die("%s", err.buf);
@@ -2317,10 +2396,32 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	} else if (s->sort_flags & REF_SORTING_VERSION) {
 		cmp = versioncmp(va->s, vb->s);
 	} else if (cmp_type == FIELD_STR) {
-		int (*cmp_fn)(const char *, const char *);
-		cmp_fn = s->sort_flags & REF_SORTING_ICASE
-			? strcasecmp : strcmp;
-		cmp = cmp_fn(va->s, vb->s);
+		if (va->s_size == ATOM_VALUE_S_SIZE_INIT &&
+		    vb->s_size == ATOM_VALUE_S_SIZE_INIT) {
+			int (*cmp_fn)(const char *, const char *);
+			cmp_fn = s->sort_flags & REF_SORTING_ICASE
+				? strcasecmp : strcmp;
+			cmp = cmp_fn(va->s, vb->s);
+		} else {
+			int (*cmp_fn)(const void *, const void *, size_t);
+			cmp_fn = s->sort_flags & REF_SORTING_ICASE
+				? memcasecmp : memcmp;
+
+			if (va->s_size != ATOM_VALUE_S_SIZE_INIT &&
+			    vb->s_size != ATOM_VALUE_S_SIZE_INIT) {
+				cmp = cmp_fn(va->s, vb->s, va->s_size > vb->s_size ?
+				       vb->s_size : va->s_size);
+			} else if (va->s_size == ATOM_VALUE_S_SIZE_INIT) {
+				slen = strlen(va->s);
+				cmp = cmp_fn(va->s, vb->s, slen > vb->s_size ?
+					     vb->s_size : slen);
+			} else {
+				slen = strlen(vb->s);
+				cmp = cmp_fn(va->s, vb->s, slen > va->s_size ?
+					     slen : va->s_size);
+			}
+			cmp = cmp ? cmp : va->s_size - vb->s_size;
+		}
 	} else {
 		if (va->value < vb->value)
 			cmp = -1;
@@ -2420,6 +2521,7 @@ int format_ref_array_item(struct ref_array_item *info,
 	}
 	if (format->need_color_reset_at_eol) {
 		struct atom_value resetv;
+		resetv.s_size = ATOM_VALUE_S_SIZE_INIT;
 		resetv.s = GIT_COLOR_RESET;
 		if (append_atom(&resetv, &state, error_buf)) {
 			pop_stack_element(&state.stack);
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 9e0214076b4d..07de4a84d70b 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -130,6 +130,8 @@ test_atom head parent:short=10 ''
 test_atom head numparent 0
 test_atom head object ''
 test_atom head type ''
+test_atom head raw "$(git cat-file commit refs/heads/main)
+"
 test_atom head '*objectname' ''
 test_atom head '*objecttype' ''
 test_atom head author 'A U Thor <author@example.com> 1151968724 +0200'
@@ -221,6 +223,15 @@ test_atom tag contents 'Tagging at 1151968727
 '
 test_atom tag HEAD ' '
 
+test_expect_success 'basic atom: refs/tags/testtag *raw' '
+	git cat-file commit refs/tags/testtag^{} >expected &&
+	git for-each-ref --format="%(*raw)" refs/tags/testtag >actual &&
+	sanitize_pgp <expected >expected.clean &&
+	sanitize_pgp <actual >actual.clean &&
+	echo "" >>expected.clean &&
+	test_cmp expected.clean actual.clean
+'
+
 test_expect_success 'Check invalid atoms names are errors' '
 	test_must_fail git for-each-ref --format="%(INVALID)" refs/heads
 '
@@ -686,6 +697,15 @@ test_atom refs/tags/signed-empty contents:body ''
 test_atom refs/tags/signed-empty contents:signature "$sig"
 test_atom refs/tags/signed-empty contents "$sig"
 
+test_expect_success 'basic atom: refs/tags/signed-empty raw' '
+	git cat-file tag refs/tags/signed-empty >expected &&
+	git for-each-ref --format="%(raw)" refs/tags/signed-empty >actual &&
+	sanitize_pgp <expected >expected.clean &&
+	sanitize_pgp <actual >actual.clean &&
+	echo "" >>expected.clean &&
+	test_cmp expected.clean actual.clean
+'
+
 test_atom refs/tags/signed-short subject 'subject line'
 test_atom refs/tags/signed-short subject:sanitize 'subject-line'
 test_atom refs/tags/signed-short contents:subject 'subject line'
@@ -695,6 +715,15 @@ test_atom refs/tags/signed-short contents:signature "$sig"
 test_atom refs/tags/signed-short contents "subject line
 $sig"
 
+test_expect_success 'basic atom: refs/tags/signed-short raw' '
+	git cat-file tag refs/tags/signed-short >expected &&
+	git for-each-ref --format="%(raw)" refs/tags/signed-short >actual &&
+	sanitize_pgp <expected >expected.clean &&
+	sanitize_pgp <actual >actual.clean &&
+	echo "" >>expected.clean &&
+	test_cmp expected.clean actual.clean
+'
+
 test_atom refs/tags/signed-long subject 'subject line'
 test_atom refs/tags/signed-long subject:sanitize 'subject-line'
 test_atom refs/tags/signed-long contents:subject 'subject line'
@@ -708,6 +737,15 @@ test_atom refs/tags/signed-long contents "subject line
 body contents
 $sig"
 
+test_expect_success 'basic atom: refs/tags/signed-long raw' '
+	git cat-file tag refs/tags/signed-long >expected &&
+	git for-each-ref --format="%(raw)" refs/tags/signed-long >actual &&
+	sanitize_pgp <expected >expected.clean &&
+	sanitize_pgp <actual >actual.clean &&
+	echo "" >>expected.clean &&
+	test_cmp expected.clean actual.clean
+'
+
 test_expect_success 'set up refs pointing to tree and blob' '
 	git update-ref refs/mytrees/first refs/heads/main^{tree} &&
 	git update-ref refs/myblobs/first refs/heads/main:one
@@ -720,6 +758,16 @@ test_atom refs/mytrees/first contents:body ""
 test_atom refs/mytrees/first contents:signature ""
 test_atom refs/mytrees/first contents ""
 
+test_expect_success 'basic atom: refs/mytrees/first raw' '
+	git cat-file tree refs/mytrees/first >expected &&
+	echo "" >>expected &&
+	git for-each-ref --format="%(raw)" refs/mytrees/first >actual &&
+	test_cmp expected actual &&
+	git cat-file -s refs/mytrees/first >expected &&
+	git for-each-ref --format="%(raw:size)" refs/mytrees/first >actual &&
+	test_cmp expected actual
+'
+
 test_atom refs/myblobs/first subject ""
 test_atom refs/myblobs/first contents:subject ""
 test_atom refs/myblobs/first body ""
@@ -727,6 +775,149 @@ test_atom refs/myblobs/first contents:body ""
 test_atom refs/myblobs/first contents:signature ""
 test_atom refs/myblobs/first contents ""
 
+test_expect_success 'basic atom: refs/myblobs/first raw' '
+	git cat-file blob refs/myblobs/first >expected &&
+	echo "" >>expected &&
+	git for-each-ref --format="%(raw)" refs/myblobs/first >actual &&
+	test_cmp expected actual &&
+	git cat-file -s refs/myblobs/first >expected &&
+	git for-each-ref --format="%(raw:size)" refs/myblobs/first >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'set up refs pointing to binary blob' '
+	printf "%b" "a\0b\0c" >blob1 &&
+	printf "%b" "a\0c\0b" >blob2 &&
+	printf "%b" "\0a\0b\0c" >blob3 &&
+	printf "%b" "abc" >blob4 &&
+	printf "%b" "\0 \0 \0 " >blob5 &&
+	printf "%b" "\0 \0a\0 " >blob6 &&
+	>blob7 &&
+	git hash-object blob1 -w | xargs git update-ref refs/myblobs/blob1 &&
+	git hash-object blob2 -w | xargs git update-ref refs/myblobs/blob2 &&
+	git hash-object blob3 -w | xargs git update-ref refs/myblobs/blob3 &&
+	git hash-object blob4 -w | xargs git update-ref refs/myblobs/blob4 &&
+	git hash-object blob5 -w | xargs git update-ref refs/myblobs/blob5 &&
+	git hash-object blob6 -w | xargs git update-ref refs/myblobs/blob6 &&
+	git hash-object blob7 -w | xargs git update-ref refs/myblobs/blob7
+'
+
+test_expect_success 'Verify sorts with raw' '
+	cat >expected <<-EOF &&
+	refs/myblobs/blob7
+	refs/myblobs/blob5
+	refs/myblobs/blob6
+	refs/myblobs/blob3
+	refs/mytrees/first
+	refs/myblobs/first
+	refs/myblobs/blob1
+	refs/myblobs/blob2
+	refs/myblobs/blob4
+	refs/heads/main
+	EOF
+	git for-each-ref --format="%(refname)" --sort=raw \
+		refs/heads/main refs/myblobs/ refs/mytrees/first >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Verify sorts with raw:size' '
+	cat >expected <<-EOF &&
+	refs/myblobs/blob7
+	refs/myblobs/first
+	refs/heads/main
+	refs/myblobs/blob4
+	refs/myblobs/blob1
+	refs/myblobs/blob2
+	refs/myblobs/blob3
+	refs/myblobs/blob5
+	refs/myblobs/blob6
+	refs/mytrees/first
+	EOF
+	git for-each-ref --format="%(refname)" --sort=raw:size \
+		refs/heads/main refs/myblobs/ refs/mytrees/first >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'validate raw atom with %(if:equals)' '
+	cat >expected <<-EOF &&
+	not equals
+	not equals
+	not equals
+	not equals
+	not equals
+	not equals
+	refs/myblobs/blob4
+	not equals
+	not equals
+	not equals
+	not equals
+	EOF
+	git for-each-ref --format="%(if:equals=abc)%(raw)%(then)%(refname)%(else)not equals%(end)" \
+		refs/myblobs/ refs/heads/ >actual &&
+	test_cmp expected actual
+'
+test_expect_success 'validate raw atom with %(if:notequals)' '
+	cat >expected <<-EOF &&
+	refs/heads/ambiguous
+	refs/heads/main
+	refs/heads/newtag
+	refs/myblobs/blob1
+	refs/myblobs/blob2
+	refs/myblobs/blob3
+	equals
+	refs/myblobs/blob5
+	refs/myblobs/blob6
+	refs/myblobs/blob7
+	refs/myblobs/first
+	EOF
+	git for-each-ref --format="%(if:notequals=abc)%(raw)%(then)%(refname)%(else)equals%(end)" \
+		refs/myblobs/ refs/heads/ >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'empty raw refs with %(if)' '
+	cat >expected <<-EOF &&
+	refs/myblobs/blob1 not empty
+	refs/myblobs/blob2 not empty
+	refs/myblobs/blob3 not empty
+	refs/myblobs/blob4 not empty
+	refs/myblobs/blob5 empty
+	refs/myblobs/blob6 not empty
+	refs/myblobs/blob7 empty
+	refs/myblobs/first not empty
+	EOF
+	git for-each-ref --format="%(refname) %(if)%(raw)%(then)not empty%(else)empty%(end)" \
+	refs/myblobs/ >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '%(raw) with --python must failed' '
+	test_must_fail git for-each-ref --format="%(raw)" --python
+'
+
+test_expect_success '%(raw) with --tcl must failed' '
+	test_must_fail git for-each-ref --format="%(raw)" --tcl
+'
+
+test_expect_success '%(raw) with --perl must failed' '
+	test_must_fail git for-each-ref --format="%(raw)" --perl
+'
+
+test_expect_success '%(raw) with --shell must failed' '
+	test_must_fail git for-each-ref --format="%(raw)" --shell
+'
+
+test_expect_success '%(raw) with --shell and --sort=raw must failed' '
+	test_must_fail git for-each-ref --format="%(raw)" --sort=raw --shell
+'
+
+test_expect_success 'for-each-ref --format compare with cat-file --batch' '
+	git rev-parse refs/mytrees/first | git cat-file --batch >expected &&
+	git for-each-ref --format="%(objectname) %(objecttype) %(objectsize)
+%(raw)" refs/mytrees/first >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'set up multiple-sort tags' '
 	for when in 100000 200000
 	do
-- 
gitgitgadget

