Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D67DC4338F
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 14:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A37060EAF
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 14:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbhGXNd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jul 2021 09:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhGXNdz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jul 2021 09:33:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A730C061575
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 07:14:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l11-20020a7bc34b0000b029021f84fcaf75so5225406wmj.1
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 07:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=SHsVlPfOgwjx7fzSXzef5tcoU3WHYRAMJlMoT2vvzBc=;
        b=PIrd0qpO/0EAHgTu9hyeUKLsnrSdnnyCnpzT9HJepKzTmCgTEDCP2rvER0/l6a7kNL
         b/BRuY1yuqio8aiI5mjHWq0UwUro/uI8+nT5uI2SFB/Ng3HMO7si/jqBZHBWue0EC3Dy
         YIMknMUY/eDY1TZVYeKcrEknz5L+/IUfLPX3XX1YgbC7L1WA9Gm4zwijziSnhlNKonfa
         ALd5UkQm3ankR3/rCkIsQpzne52Vsg7nkKav/KRJs/eYSLmicHrTGjqeS+jrv8te5YyK
         u0vyz1W9voas3akloLrmbE879w3K8INNjnc5ZF117QeAbSMaYPORqTxrWNWrJMZ0PBmD
         x+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=SHsVlPfOgwjx7fzSXzef5tcoU3WHYRAMJlMoT2vvzBc=;
        b=B8AZlsJKoWk5qc6Xej2pZQ3TPD4WC00JCYHVycdq72UbIY970/Hh7c+A+8CZkmK/2I
         y5Qvr/QktLbvgAdMWJ7ddrA3lAYFHj454+snzHsHVfffc1XuunzPBw2heiNKHskd+O/G
         FVZ9mfTUYidIf5PffoXkdhnLCjMKU4C+Z7rXI+U9DRCOX2jifrBSiynEiK7lgHQUAVCo
         o0lXDeihtsIF/c2iSSTFQVOb3bc7OYO35u2cFJT/mfug2OgH8pMRnLX+MdlxKJo00Pkr
         MHMFB/R3i1AcsvSdPaQffA0pr0t+sjUAhF6IxMrZDr1ZTzOItiyiTII656FpQfcmKOsl
         SlmQ==
X-Gm-Message-State: AOAM531IcVJIKh8n+8p7FEWycLwq2dO6CBUS0GNskHVv3N6BzT+PSqAD
        dWHc5ZChV0RZlOcWNSHYGQNLpx7NY6E=
X-Google-Smtp-Source: ABdhPJzYJL7MxwOT1sjDPhYSnIScONdCxr2wwmpzwms6VMJIL8GqsVkDlatcnzqwbgX0crki7wemKA==
X-Received: by 2002:a05:600c:3b92:: with SMTP id n18mr9241314wms.69.1627136064930;
        Sat, 24 Jul 2021 07:14:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b16sm36154418wrw.46.2021.07.24.07.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 07:14:24 -0700 (PDT)
Message-Id: <0ffa549da6ef5c17e491970ca9b15719077e1f51.1627136062.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1000.v3.git.1627136061.gitgitgadget@gmail.com>
References: <pull.1000.v2.git.1627031043.gitgitgadget@gmail.com>
        <pull.1000.v3.git.1627136061.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 24 Jul 2021 14:14:18 +0000
Subject: [PATCH v3 2/5] [GSOC] ref-filter: add %(raw) atom
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        Jacob Keller <jacob.keller@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Add new formatting option `%(raw)`, which will print the raw
object data without any changes. It will help further to migrate
all cat-file formatting logic from cat-file to ref-filter.

The raw data of blob, tree objects may contain '\0', but most of
the logic in `ref-filter` depends on the output of the atom being
text (specifically, no embedded NULs in it).

E.g. `quote_formatting()` use `strbuf_addstr()` or `*._quote_buf()`
add the data to the buffer. The raw data of a tree object is
`100644 one\0...`, only the `100644 one` will be added to the buffer,
which is incorrect.

Therefore, we need to find a way to record the length of the
atom_value's member `s`. Although strbuf can already record the
string and its length, if we want to replace the type of atom_value's
member `s` with strbuf, many places in ref-filter that are filled
with dynamically allocated mermory in `v->s` are not easy to replace.
At the same time, we need to check if `v->s == NULL` in
populate_value(), and strbuf cannot easily distinguish NULL and empty
strings, but c-style "const char *" can do it. So add a new member in
`struct atom_value`: `s_size`, which can record raw object size, it
can help us add raw object data to the buffer or compare two buffers
which contain raw object data.

Note that `--format=%(raw)` cannot be used with `--python`, `--shell`,
`--tcl`, and `--perl` because if the binary raw data is passed to a
variable in such languages, these may not support arbitrary binary data
in their string variable type.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Helped-by: Bagas Sanjaya <bagasdotme@gmail.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Felipe Contreras <felipe.contreras@gmail.com>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Based-on-patch-by: Olga Telezhnaya <olyatelezhnaya@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-for-each-ref.txt |   9 ++
 ref-filter.c                       | 144 +++++++++++++++----
 t/t6300-for-each-ref.sh            | 216 +++++++++++++++++++++++++++++
 3 files changed, 341 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 2ae2478de70..cbb6f87d13f 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -235,6 +235,15 @@ and `date` to extract the named component.  For email fields (`authoremail`,
 without angle brackets, and `:localpart` to get the part before the `@` symbol
 out of the trimmed email.
 
+The raw data in an object is `raw`.
+
+raw:size::
+	The raw data size of the object.
+
+Note that `--format=%(raw)` can not be used with `--python`, `--shell`, `--tcl`,
+`--perl` because such language may not support arbitrary binary data in their
+string variable type.
+
 The message in a commit or a tag object is `contents`, from which
 `contents:<part>` can be used to extract various parts out of:
 
diff --git a/ref-filter.c b/ref-filter.c
index 5cee6512fba..01545618101 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -144,6 +144,7 @@ enum atom_type {
 	ATOM_BODY,
 	ATOM_TRAILERS,
 	ATOM_CONTENTS,
+	ATOM_RAW,
 	ATOM_UPSTREAM,
 	ATOM_PUSH,
 	ATOM_SYMREF,
@@ -189,6 +190,9 @@ static struct used_atom {
 			struct process_trailer_options trailer_opts;
 			unsigned int nlines;
 		} contents;
+		struct {
+			enum { RAW_BARE, RAW_LENGTH } option;
+		} raw_data;
 		struct {
 			cmp_status cmp_status;
 			const char *str;
@@ -426,6 +430,18 @@ static int contents_atom_parser(const struct ref_format *format, struct used_ato
 	return 0;
 }
 
+static int raw_atom_parser(const struct ref_format *format, struct used_atom *atom,
+				const char *arg, struct strbuf *err)
+{
+	if (!arg)
+		atom->u.raw_data.option = RAW_BARE;
+	else if (!strcmp(arg, "size"))
+		atom->u.raw_data.option = RAW_LENGTH;
+	else
+		return strbuf_addf_ret(err, -1, _("unrecognized %%(raw) argument: %s"), arg);
+	return 0;
+}
+
 static int oid_atom_parser(const struct ref_format *format, struct used_atom *atom,
 			   const char *arg, struct strbuf *err)
 {
@@ -586,6 +602,7 @@ static struct {
 	[ATOM_BODY] = { "body", SOURCE_OBJ, FIELD_STR, body_atom_parser },
 	[ATOM_TRAILERS] = { "trailers", SOURCE_OBJ, FIELD_STR, trailers_atom_parser },
 	[ATOM_CONTENTS] = { "contents", SOURCE_OBJ, FIELD_STR, contents_atom_parser },
+	[ATOM_RAW] = { "raw", SOURCE_OBJ, FIELD_STR, raw_atom_parser },
 	[ATOM_UPSTREAM] = { "upstream", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
 	[ATOM_PUSH] = { "push", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
 	[ATOM_SYMREF] = { "symref", SOURCE_NONE, FIELD_STR, refname_atom_parser },
@@ -620,12 +637,19 @@ struct ref_formatting_state {
 
 struct atom_value {
 	const char *s;
+	size_t s_size;
 	int (*handler)(struct atom_value *atomv, struct ref_formatting_state *state,
 		       struct strbuf *err);
 	uintmax_t value; /* used for sorting when not FIELD_STR */
 	struct used_atom *atom;
 };
 
+#define ATOM_SIZE_UNSPECIFIED (-1)
+
+#define ATOM_VALUE_INIT { \
+	.s_size = ATOM_SIZE_UNSPECIFIED \
+}
+
 /*
  * Used to parse format string and sort specifiers
  */
@@ -644,13 +668,6 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 		return strbuf_addf_ret(err, -1, _("malformed field name: %.*s"),
 				       (int)(ep-atom), atom);
 
-	/* Do we have the atom already used elsewhere? */
-	for (i = 0; i < used_atom_cnt; i++) {
-		int len = strlen(used_atom[i].name);
-		if (len == ep - atom && !memcmp(used_atom[i].name, atom, len))
-			return i;
-	}
-
 	/*
 	 * If the atom name has a colon, strip it and everything after
 	 * it off - it specifies the format for this entry, and
@@ -660,6 +677,13 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 	arg = memchr(sp, ':', ep - sp);
 	atom_len = (arg ? arg : ep) - sp;
 
+	/* Do we have the atom already used elsewhere? */
+	for (i = 0; i < used_atom_cnt; i++) {
+		int len = strlen(used_atom[i].name);
+		if (len == ep - atom && !memcmp(used_atom[i].name, atom, len))
+			return i;
+	}
+
 	/* Is the atom a valid one? */
 	for (i = 0; i < ARRAY_SIZE(valid_atom); i++) {
 		int len = strlen(valid_atom[i].name);
@@ -709,11 +733,14 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 	return at;
 }
 
-static void quote_formatting(struct strbuf *s, const char *str, int quote_style)
+static void quote_formatting(struct strbuf *s, const char *str, size_t len, int quote_style)
 {
 	switch (quote_style) {
 	case QUOTE_NONE:
-		strbuf_addstr(s, str);
+		if (len != -1)
+			strbuf_add(s, str, len);
+		else
+			strbuf_addstr(s, str);
 		break;
 	case QUOTE_SHELL:
 		sq_quote_buf(s, str);
@@ -740,9 +767,12 @@ static int append_atom(struct atom_value *v, struct ref_formatting_state *state,
 	 * encountered.
 	 */
 	if (!state->stack->prev)
-		quote_formatting(&state->stack->output, v->s, state->quote_style);
+		quote_formatting(&state->stack->output, v->s, v->s_size, state->quote_style);
 	else
-		strbuf_addstr(&state->stack->output, v->s);
+		if (v->s_size != ATOM_SIZE_UNSPECIFIED)
+			strbuf_add(&state->stack->output, v->s, v->s_size);
+		else
+			strbuf_addstr(&state->stack->output, v->s);
 	return 0;
 }
 
@@ -842,21 +872,23 @@ static int if_atom_handler(struct atom_value *atomv, struct ref_formatting_state
 	return 0;
 }
 
-static int is_empty(const char *s)
+static int is_empty(struct strbuf *buf)
 {
-	while (*s != '\0') {
-		if (!isspace(*s))
-			return 0;
-		s++;
-	}
-	return 1;
-}
+	const char *cur = buf->buf;
+	const char *end = buf->buf + buf->len;
+
+	while (cur != end && (isspace(*cur)))
+		cur++;
+
+	return cur == end;
+ }
 
 static int then_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state,
 			     struct strbuf *err)
 {
 	struct ref_formatting_stack *cur = state->stack;
 	struct if_then_else *if_then_else = NULL;
+	size_t str_len = 0;
 
 	if (cur->at_end == if_then_else_handler)
 		if_then_else = (struct if_then_else *)cur->at_end_data;
@@ -867,18 +899,22 @@ static int then_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
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
+		if (str_len == cur->output.len &&
+		    !memcmp(if_then_else->str, cur->output.buf, cur->output.len))
 			if_then_else->condition_satisfied = 1;
 	} else if (if_then_else->cmp_status == COMPARE_UNEQUAL) {
-		if (strcmp(if_then_else->str, cur->output.buf))
+		if (str_len != cur->output.len ||
+		    memcmp(if_then_else->str, cur->output.buf, cur->output.len))
 			if_then_else->condition_satisfied = 1;
-	} else if (cur->output.len && !is_empty(cur->output.buf))
+	} else if (cur->output.len && !is_empty(&cur->output))
 		if_then_else->condition_satisfied = 1;
 	strbuf_reset(&cur->output);
 	return 0;
@@ -924,7 +960,7 @@ static int end_atom_handler(struct atom_value *atomv, struct ref_formatting_stat
 	 * only on the topmost supporting atom.
 	 */
 	if (!current->prev->prev) {
-		quote_formatting(&s, current->output.buf, state->quote_style);
+		quote_formatting(&s, current->output.buf, current->output.len, state->quote_style);
 		strbuf_swap(&current->output, &s);
 	}
 	strbuf_release(&s);
@@ -974,6 +1010,10 @@ int verify_ref_format(struct ref_format *format)
 		at = parse_ref_filter_atom(format, sp + 2, ep, &err);
 		if (at < 0)
 			die("%s", err.buf);
+		if (format->quote_style && used_atom[at].atom_type == ATOM_RAW &&
+		    used_atom[at].u.raw_data.option == RAW_BARE)
+			die(_("--format=%.*s cannot be used with"
+			      "--python, --shell, --tcl, --perl"), (int)(ep - sp - 2), sp + 2);
 		cp = ep + 1;
 
 		if (skip_prefix(used_atom[at].name, "color:", &color))
@@ -1367,12 +1407,25 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
 		struct used_atom *atom = &used_atom[i];
 		const char *name = atom->name;
 		struct atom_value *v = &val[i];
+		enum atom_type atom_type = atom->atom_type;
 
 		if (!!deref != (*name == '*'))
 			continue;
 		if (deref)
 			name++;
 
+		if (atom_type == ATOM_RAW) {
+			unsigned long buf_size = data->size;
+
+			if (atom->u.raw_data.option == RAW_BARE) {
+				v->s = xmemdupz(buf, buf_size);
+				v->s_size = buf_size;
+			} else if (atom->u.raw_data.option == RAW_LENGTH) {
+				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)buf_size);
+			}
+			continue;
+		}
+
 		if ((data->type != OBJ_TAG &&
 		     data->type != OBJ_COMMIT) ||
 		    (strcmp(name, "body") &&
@@ -1460,9 +1513,11 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, s
 		break;
 	case OBJ_TREE:
 		/* grab_tree_values(val, deref, obj, buf, sz); */
+		grab_sub_body_contents(val, deref, data);
 		break;
 	case OBJ_BLOB:
 		/* grab_blob_values(val, deref, obj, buf, sz); */
+		grab_sub_body_contents(val, deref, data);
 		break;
 	default:
 		die("Eh?  Object of type %d?", obj->type);
@@ -1766,6 +1821,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 		const char *refname;
 		struct branch *branch = NULL;
 
+		v->s_size = ATOM_SIZE_UNSPECIFIED;
 		v->handler = append_atom;
 		v->atom = atom;
 
@@ -2369,6 +2425,19 @@ static int compare_detached_head(struct ref_array_item *a, struct ref_array_item
 	return 0;
 }
 
+static int memcasecmp(const void *vs1, const void *vs2, size_t n)
+{
+	const char *s1 = vs1, *s2 = vs2;
+	const char *end = s1 + n;
+
+	for (; s1 < end; s1++, s2++) {
+		int diff = tolower(*s1) - tolower(*s2);
+		if (diff)
+			return diff;
+	}
+	return 0;
+}
+
 static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, struct ref_array_item *b)
 {
 	struct atom_value *va, *vb;
@@ -2389,10 +2458,29 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	} else if (s->sort_flags & REF_SORTING_VERSION) {
 		cmp = versioncmp(va->s, vb->s);
 	} else if (cmp_type == FIELD_STR) {
-		int (*cmp_fn)(const char *, const char *);
-		cmp_fn = s->sort_flags & REF_SORTING_ICASE
-			? strcasecmp : strcmp;
-		cmp = cmp_fn(va->s, vb->s);
+		if (va->s_size == ATOM_SIZE_UNSPECIFIED && vb->s_size == ATOM_SIZE_UNSPECIFIED) {
+			int (*cmp_fn)(const char *, const char *);
+			cmp_fn = s->sort_flags & REF_SORTING_ICASE
+				? strcasecmp : strcmp;
+			cmp = cmp_fn(va->s, vb->s);
+		} else {
+			size_t a_size = va->s_size == ATOM_SIZE_UNSPECIFIED ?
+					strlen(va->s) : va->s_size;
+			size_t b_size = vb->s_size == ATOM_SIZE_UNSPECIFIED ?
+					strlen(vb->s) : vb->s_size;
+			int (*cmp_fn)(const void *, const void *, size_t);
+			cmp_fn = s->sort_flags & REF_SORTING_ICASE
+				? memcasecmp : memcmp;
+
+			cmp = cmp_fn(va->s, vb->s, b_size > a_size ?
+				     a_size : b_size);
+			if (!cmp) {
+				if (a_size > b_size)
+					cmp = 1;
+				else if (a_size < b_size)
+					cmp = -1;
+			}
+		}
 	} else {
 		if (va->value < vb->value)
 			cmp = -1;
@@ -2491,7 +2579,7 @@ int format_ref_array_item(struct ref_array_item *info,
 		append_literal(cp, sp, &state);
 	}
 	if (format->need_color_reset_at_eol) {
-		struct atom_value resetv;
+		struct atom_value resetv = ATOM_VALUE_INIT;
 		resetv.s = GIT_COLOR_RESET;
 		if (append_atom(&resetv, &state, error_buf)) {
 			pop_stack_element(&state.stack);
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 9e0214076b4..18554f62d94 100755
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
+	echo >>expected.clean &&
+	sanitize_pgp <actual >actual.clean &&
+	test_cmp expected.clean actual.clean
+'
+
 test_expect_success 'Check invalid atoms names are errors' '
 	test_must_fail git for-each-ref --format="%(INVALID)" refs/heads
 '
@@ -686,6 +697,15 @@ test_atom refs/tags/signed-empty contents:body ''
 test_atom refs/tags/signed-empty contents:signature "$sig"
 test_atom refs/tags/signed-empty contents "$sig"
 
+test_expect_success GPG 'basic atom: refs/tags/signed-empty raw' '
+	git cat-file tag refs/tags/signed-empty >expected &&
+	git for-each-ref --format="%(raw)" refs/tags/signed-empty >actual &&
+	sanitize_pgp <expected >expected.clean &&
+	echo >>expected.clean &&
+	sanitize_pgp <actual >actual.clean &&
+	test_cmp expected.clean actual.clean
+'
+
 test_atom refs/tags/signed-short subject 'subject line'
 test_atom refs/tags/signed-short subject:sanitize 'subject-line'
 test_atom refs/tags/signed-short contents:subject 'subject line'
@@ -695,6 +715,15 @@ test_atom refs/tags/signed-short contents:signature "$sig"
 test_atom refs/tags/signed-short contents "subject line
 $sig"
 
+test_expect_success GPG 'basic atom: refs/tags/signed-short raw' '
+	git cat-file tag refs/tags/signed-short >expected &&
+	git for-each-ref --format="%(raw)" refs/tags/signed-short >actual &&
+	sanitize_pgp <expected >expected.clean &&
+	echo >>expected.clean &&
+	sanitize_pgp <actual >actual.clean &&
+	test_cmp expected.clean actual.clean
+'
+
 test_atom refs/tags/signed-long subject 'subject line'
 test_atom refs/tags/signed-long subject:sanitize 'subject-line'
 test_atom refs/tags/signed-long contents:subject 'subject line'
@@ -708,6 +737,15 @@ test_atom refs/tags/signed-long contents "subject line
 body contents
 $sig"
 
+test_expect_success GPG 'basic atom: refs/tags/signed-long raw' '
+	git cat-file tag refs/tags/signed-long >expected &&
+	git for-each-ref --format="%(raw)" refs/tags/signed-long >actual &&
+	sanitize_pgp <expected >expected.clean &&
+	echo >>expected.clean &&
+	sanitize_pgp <actual >actual.clean &&
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
+	echo >>expected &&
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
@@ -727,6 +775,174 @@ test_atom refs/myblobs/first contents:body ""
 test_atom refs/myblobs/first contents:signature ""
 test_atom refs/myblobs/first contents ""
 
+test_expect_success 'basic atom: refs/myblobs/first raw' '
+	git cat-file blob refs/myblobs/first >expected &&
+	echo >>expected &&
+	git for-each-ref --format="%(raw)" refs/myblobs/first >actual &&
+	test_cmp expected actual &&
+	git cat-file -s refs/myblobs/first >expected &&
+	git for-each-ref --format="%(raw:size)" refs/myblobs/first >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'set up refs pointing to binary blob' '
+	printf "a\0b\0c" >blob1 &&
+	printf "a\0c\0b" >blob2 &&
+	printf "\0a\0b\0c" >blob3 &&
+	printf "abc" >blob4 &&
+	printf "\0 \0 \0 " >blob5 &&
+	printf "\0 \0a\0 " >blob6 &&
+	printf "  " >blob7 &&
+	>blob8 &&
+	obj=$(git hash-object -w blob1) &&
+	git update-ref refs/myblobs/blob1 "$obj" &&
+	obj=$(git hash-object -w blob2) &&
+	git update-ref refs/myblobs/blob2 "$obj" &&
+	obj=$(git hash-object -w blob3) &&
+	git update-ref refs/myblobs/blob3 "$obj" &&
+	obj=$(git hash-object -w blob4) &&
+	git update-ref refs/myblobs/blob4 "$obj" &&
+	obj=$(git hash-object -w blob5) &&
+	git update-ref refs/myblobs/blob5 "$obj" &&
+	obj=$(git hash-object -w blob6) &&
+	git update-ref refs/myblobs/blob6 "$obj" &&
+	obj=$(git hash-object -w blob7) &&
+	git update-ref refs/myblobs/blob7 "$obj" &&
+	obj=$(git hash-object -w blob8) &&
+	git update-ref refs/myblobs/blob8 "$obj"
+'
+
+test_expect_success 'Verify sorts with raw' '
+	cat >expected <<-EOF &&
+	refs/myblobs/blob8
+	refs/myblobs/blob5
+	refs/myblobs/blob6
+	refs/myblobs/blob3
+	refs/myblobs/blob7
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
+	refs/myblobs/blob8
+	refs/myblobs/first
+	refs/myblobs/blob7
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
+	not equals
+	EOF
+	git for-each-ref --format="%(if:equals=abc)%(raw)%(then)%(refname)%(else)not equals%(end)" \
+		refs/myblobs/ refs/heads/ >actual &&
+	test_cmp expected actual
+'
+
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
+	refs/myblobs/blob8
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
+	refs/myblobs/blob5 not empty
+	refs/myblobs/blob6 not empty
+	refs/myblobs/blob7 empty
+	refs/myblobs/blob8 empty
+	refs/myblobs/first not empty
+	EOF
+	git for-each-ref --format="%(refname) %(if)%(raw)%(then)not empty%(else)empty%(end)" \
+		refs/myblobs/ >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '%(raw) with --python must fail' '
+	test_must_fail git for-each-ref --format="%(raw)" --python
+'
+
+test_expect_success '%(raw) with --tcl must fail' '
+	test_must_fail git for-each-ref --format="%(raw)" --tcl
+'
+
+test_expect_success '%(raw) with --perl must fail' '
+	test_must_fail git for-each-ref --format="%(raw)" --perl
+'
+
+test_expect_success '%(raw) with --shell must fail' '
+	test_must_fail git for-each-ref --format="%(raw)" --shell
+'
+
+test_expect_success '%(raw) with --shell and --sort=raw must fail' '
+	test_must_fail git for-each-ref --format="%(raw)" --sort=raw --shell
+'
+
+test_expect_success '%(raw:size) with --shell' '
+	git for-each-ref --format="%(raw:size)" | while read line
+	do
+		echo "'\''$line'\''" >>expect
+	done &&
+	git for-each-ref --format="%(raw:size)" --shell >actual &&
+	test_cmp expect actual
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

