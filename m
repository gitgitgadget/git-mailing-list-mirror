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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0314EC47080
	for <git@archiver.kernel.org>; Sun, 23 May 2021 09:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D56756128A
	for <git@archiver.kernel.org>; Sun, 23 May 2021 09:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhEWJzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 05:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhEWJzD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 05:55:03 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9B1C06138B
        for <git@vger.kernel.org>; Sun, 23 May 2021 02:53:36 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id f20-20020a05600c4e94b0290181f6edda88so2856137wmq.2
        for <git@vger.kernel.org>; Sun, 23 May 2021 02:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3yTrKIUoG5vad3xXtvnIP0lrgCFt55YWyKQg/2T3Iec=;
        b=YVSgiYhjKStflMbHYkZQy35vxl6FekKtGC5GPjprUpDbbFi/4IM6h3Rxc1NE8YrBCL
         LABhhfe1X3H/1Uu6lfOwKEKnNfK4PXmF6fRYY12OUQwwNL9IGBpGt5fBZgeofTxCe272
         Qc4mEiN4rnFZVdn02XCROoJCm+Tvu6PyTtT1jBXWI/y5haKaem7YDyt5AYcZM5XOgKxG
         fHgdHhiXn5sEz8bW3rZU2S4yHXVCHr6IJvJYocR76DyzP2PzAfw5ykqUgle/PxLjxeXo
         WwT51yZP+lufUMPvXiBykFKDzcsj5Wcc00Xu/C0XFI3FpHo4/XxmLz9VkuIPgBEx2wZX
         /RtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3yTrKIUoG5vad3xXtvnIP0lrgCFt55YWyKQg/2T3Iec=;
        b=fb8uS2VlqqvaeSj0oW20bVfHT6CrqvvPJtU3+V/FnC6oYG/tkJjXSH32+jYHGIDVAH
         GIEe6lyPpVYkW7O7PL5FCVYVEmYg1hB2V5D9kNbNLBt6NtzeKZ0hbSnR5ktUI8h+5VKE
         o2G00x1Tac2Q3FsZSKPgjGxmHiBPpxnK2LYbvzj9omXTxaD7hBQu5w0p58NVFZsvHgx6
         +C++NUpoGZnd+G5Gg7OViaWwT00iXjcICeHu8gB71gBebOfv5Mu+VqUQQBvGBBud2ysO
         wrUOyqgmo/9Namhq8IXDhAY3xM8tC8atUWaT1ivSUsFFYKLmFRCf1P7+1jf3havnoiqi
         bmyg==
X-Gm-Message-State: AOAM533G0RdrkIYYrdBnvrz0IwUZemxJSqJJtiGq+k0m4t+z3lVoZ+yv
        nQkvRYo+LstAou+xLyZksGnIdrEoJkw=
X-Google-Smtp-Source: ABdhPJzz0B1HZyB9J4SgjtoF76448I6XrmLIyJ5EjW7XuFEDh67/72WX7YsoxpxiXIWFM8FSfdzCbg==
X-Received: by 2002:a1c:4043:: with SMTP id n64mr15750803wma.9.1621763615051;
        Sun, 23 May 2021 02:53:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e26sm4531348wmh.39.2021.05.23.02.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 02:53:34 -0700 (PDT)
Message-Id: <19413cfdb1ea50de401ab958b954a550b6514688.1621763612.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.959.git.1621763612.gitgitgadget@gmail.com>
References: <pull.959.git.1621763612.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 23 May 2021 09:53:31 +0000
Subject: [PATCH 2/3] [GSOC] ref-filter: support %(contents) for blob, tree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

In order to let `cat-file --batch` use ref-filter logic,
we need to print the original content of an object. We
can reuse the existing atom `%(contents)` in `ref-filter`,
The original `%(contents)` only supports tag and commit
objects. If we want to support both blob and tree objects,
we must consider the following issues:

The original contents of blob, tree objects may contain '\0',
most of the logic in `ref-filter` depends on the output of
the atom being a string (end with '\0'):

`quote_formatting()` use `strbuf_addstr()` or `*._quote_buf()`
add content to the buffer. E.g. The original content of a tree
object is `100644 one\0...`, only the `100644 one` will be
added to the buffer, which is incorrect.

Therefore, add a new member in `struct atom_value`: `s_size`,
when we record the original content of the blob and tree
objects in `grab_contents()`, use `v->s_size` to record
the size of the objects contents, then in `quote_formatting()`,
if the length of the contents passed in `quote_formatting()` is
not equal to 0, we can use `strbuf_add()` instead of
`strbuf_addstr()`  or `*._quote_buf_with_size()` instead of
`*._quote_buf()` to add contents with a specified length if the
length of the contents is not equal to 0. It will not cause
truncation problems.

Similarly, in `append_atom()`, we use `strbuf_add()` instead
of `strbuf_addstr()`; In `then_atom_handler()`, we use `memcmp()`
instread of `strcmp()`; In `cmp_ref_sorting()`, we use `memcmp()`
and `memcasecmp()` instead of `strcmp()` and `strcasecmp()` when
the `v->s_size` of one of the two atoms is not equals to 0.

Based-on-patch-by: Olga Telezhnaya <olyatelezhnaya@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-for-each-ref.txt |  11 +-
 ref-filter.c                       | 220 +++++++++++++++++++++--------
 t/t6300-for-each-ref.sh            | 166 +++++++++++++++++++++-
 3 files changed, 327 insertions(+), 70 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 2ae2478de706..30b93d2e5178 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -235,11 +235,12 @@ and `date` to extract the named component.  For email fields (`authoremail`,
 without angle brackets, and `:localpart` to get the part before the `@` symbol
 out of the trimmed email.
 
-The message in a commit or a tag object is `contents`, from which
-`contents:<part>` can be used to extract various parts out of:
+The data in a object is `contents`, from which `contents:<part>` can be used
+to extract various parts out of:
 
 contents:size::
-	The size in bytes of the commit or tag message.
+	The size in bytes of the commit or tag message, and the raw object size
+	of the blob or tree.
 
 contents:subject::
 	The first paragraph of the message, which typically is a
@@ -257,7 +258,9 @@ contents:signature::
 	The optional GPG signature of the tag.
 
 contents:lines=N::
-	The first `N` lines of the message.
+	The first `N` lines of the message of the commit or tag message.
+
+Note: blob and tree objects only support `%(contents)` and `%(contents:size)`.
 
 Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
 are obtained as `trailers[:options]` (or by using the historical alias
diff --git a/ref-filter.c b/ref-filter.c
index e2eac50d9508..e59907188e79 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -564,6 +564,7 @@ struct ref_formatting_state {
 
 struct atom_value {
 	const char *s;
+	size_t s_size;
 	int (*handler)(struct atom_value *atomv, struct ref_formatting_state *state,
 		       struct strbuf *err);
 	uintmax_t value; /* used for sorting when not FIELD_STR */
@@ -652,23 +653,38 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 	return at;
 }
 
-static void quote_formatting(struct strbuf *s, const char *str, int quote_style)
+static void quote_formatting(struct strbuf *s, const char *str, size_t len, int quote_style)
 {
 	switch (quote_style) {
 	case QUOTE_NONE:
-		strbuf_addstr(s, str);
+		if (len)
+			strbuf_add(s, str, len);
+		else
+			strbuf_addstr(s, str);
 		break;
 	case QUOTE_SHELL:
-		sq_quote_buf(s, str);
+		if (len)
+			sq_quote_buf_with_size(s, str, len);
+		else
+			sq_quote_buf(s, str);
 		break;
 	case QUOTE_PERL:
-		perl_quote_buf(s, str);
+		if (len)
+			perl_quote_buf_with_size(s, str, len);
+		else
+			perl_quote_buf(s, str);
 		break;
 	case QUOTE_PYTHON:
-		python_quote_buf(s, str);
+		if (len)
+			python_quote_buf_with_size(s, str, len);
+		else
+			python_quote_buf(s, str);
 		break;
 	case QUOTE_TCL:
-		tcl_quote_buf(s, str);
+		if (len)
+			tcl_quote_buf_with_size(s, str, len);
+		else
+			tcl_quote_buf(s, str);
 		break;
 	}
 }
@@ -683,9 +699,12 @@ static int append_atom(struct atom_value *v, struct ref_formatting_state *state,
 	 * encountered.
 	 */
 	if (!state->stack->prev)
-		quote_formatting(&state->stack->output, v->s, state->quote_style);
+		quote_formatting(&state->stack->output, v->s, v->s_size, state->quote_style);
 	else
-		strbuf_addstr(&state->stack->output, v->s);
+		if (v->s_size)
+			strbuf_add(&state->stack->output, v->s, v->s_size);
+		else
+			strbuf_addstr(&state->stack->output, v->s);
 	return 0;
 }
 
@@ -785,14 +804,16 @@ static int if_atom_handler(struct atom_value *atomv, struct ref_formatting_state
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
@@ -800,6 +821,7 @@ static int then_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
 {
 	struct ref_formatting_stack *cur = state->stack;
 	struct if_then_else *if_then_else = NULL;
+	size_t str_len = 0;
 
 	if (cur->at_end == if_then_else_handler)
 		if_then_else = (struct if_then_else *)cur->at_end_data;
@@ -810,18 +832,30 @@ static int then_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
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
+		if (cur->output.len > str_len)
+			str_len = cur->output.len;
+		if (!if_then_else->str)
+			BUG("when if_then_else->cmp_status == COMPARE_EQUAL,"
+			    "if_then_else->str must not be null");
+		if (!memcmp(if_then_else->str, cur->output.buf, str_len))
 			if_then_else->condition_satisfied = 1;
 	} else if (if_then_else->cmp_status == COMPARE_UNEQUAL) {
-		if (strcmp(if_then_else->str, cur->output.buf))
+		if (cur->output.len > str_len)
+			str_len = cur->output.len;
+		if (!if_then_else->str)
+			BUG("when if_then_else->cmp_status == COMPARE_UNEQUAL,"
+			    "if_then_else->str must not be null");
+		if (memcmp(if_then_else->str, cur->output.buf, str_len))
 			if_then_else->condition_satisfied = 1;
-	} else if (cur->output.len && !is_empty(cur->output.buf))
+	} else if (cur->output.len && !is_empty(&cur->output))
 		if_then_else->condition_satisfied = 1;
 	strbuf_reset(&cur->output);
 	return 0;
@@ -867,7 +901,7 @@ static int end_atom_handler(struct atom_value *atomv, struct ref_formatting_stat
 	 * only on the topmost supporting atom.
 	 */
 	if (!current->prev->prev) {
-		quote_formatting(&s, current->output.buf, state->quote_style);
+		quote_formatting(&s, current->output.buf, current->output.len, state->quote_style);
 		strbuf_swap(&current->output, &s);
 	}
 	strbuf_release(&s);
@@ -1292,7 +1326,8 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
 }
 
 /* See grab_values */
-static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
+static void grab_contents(struct atom_value *val, int deref, void *buf,
+			  unsigned long buf_size, enum object_type object_type)
 {
 	int i;
 	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
@@ -1312,43 +1347,60 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 		    !starts_with(name, "trailers") &&
 		    !starts_with(name, "contents"))
 			continue;
-		if (!subpos)
-			find_subpos(buf,
-				    &subpos, &sublen,
-				    &bodypos, &bodylen, &nonsiglen,
-				    &sigpos, &siglen);
-
-		if (atom->u.contents.option == C_SUB)
-			v->s = copy_subject(subpos, sublen);
-		else if (atom->u.contents.option == C_SUB_SANITIZE) {
-			struct strbuf sb = STRBUF_INIT;
-			format_sanitized_subject(&sb, subpos, sublen);
-			v->s = strbuf_detach(&sb, NULL);
-		} else if (atom->u.contents.option == C_BODY_DEP)
-			v->s = xmemdupz(bodypos, bodylen);
-		else if (atom->u.contents.option == C_LENGTH)
-			v->s = xstrfmt("%"PRIuMAX, (uintmax_t)strlen(subpos));
-		else if (atom->u.contents.option == C_BODY)
-			v->s = xmemdupz(bodypos, nonsiglen);
-		else if (atom->u.contents.option == C_SIG)
-			v->s = xmemdupz(sigpos, siglen);
-		else if (atom->u.contents.option == C_LINES) {
-			struct strbuf s = STRBUF_INIT;
-			const char *contents_end = bodypos + nonsiglen;
-
-			/*  Size is the length of the message after removing the signature */
-			append_lines(&s, subpos, contents_end - subpos, atom->u.contents.nlines);
-			v->s = strbuf_detach(&s, NULL);
-		} else if (atom->u.contents.option == C_TRAILERS) {
-			struct strbuf s = STRBUF_INIT;
-
-			/* Format the trailer info according to the trailer_opts given */
-			format_trailers_from_commit(&s, subpos, &atom->u.contents.trailer_opts);
-
-			v->s = strbuf_detach(&s, NULL);
-		} else if (atom->u.contents.option == C_BARE)
-			v->s = xstrdup(subpos);
 
+		switch (object_type) {
+		case OBJ_TAG:
+		case OBJ_COMMIT: {
+			if (!subpos)
+				find_subpos(buf,
+					&subpos, &sublen,
+					&bodypos, &bodylen, &nonsiglen,
+					&sigpos, &siglen);
+
+			if (atom->u.contents.option == C_SUB)
+				v->s = copy_subject(subpos, sublen);
+			else if (atom->u.contents.option == C_SUB_SANITIZE) {
+				struct strbuf sb = STRBUF_INIT;
+				format_sanitized_subject(&sb, subpos, sublen);
+				v->s = strbuf_detach(&sb, NULL);
+			} else if (atom->u.contents.option == C_BODY_DEP)
+				v->s = xmemdupz(bodypos, bodylen);
+			else if (atom->u.contents.option == C_LENGTH)
+				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)strlen(subpos));
+			else if (atom->u.contents.option == C_BODY)
+				v->s = xmemdupz(bodypos, nonsiglen);
+			else if (atom->u.contents.option == C_SIG)
+				v->s = xmemdupz(sigpos, siglen);
+			else if (atom->u.contents.option == C_LINES) {
+				struct strbuf s = STRBUF_INIT;
+				const char *contents_end = bodypos + nonsiglen;
+
+				/*  Size is the length of the message after removing the signature */
+				append_lines(&s, subpos, contents_end - subpos, atom->u.contents.nlines);
+				v->s = strbuf_detach(&s, NULL);
+			} else if (atom->u.contents.option == C_TRAILERS) {
+				struct strbuf s = STRBUF_INIT;
+
+				/* Format the trailer info according to the trailer_opts given */
+				format_trailers_from_commit(&s, subpos, &atom->u.contents.trailer_opts);
+
+				v->s = strbuf_detach(&s, NULL);
+			} else if (atom->u.contents.option == C_BARE)
+				v->s = xstrdup(subpos);
+			break;
+		}
+		case OBJ_BLOB:
+		case OBJ_TREE: {
+			if (atom->u.contents.option == C_BARE) {
+				v->s_size = buf_size;
+				v->s = xmemdupz(buf, buf_size);
+			} else if (atom->u.contents.option == C_LENGTH)
+				v->s = xstrfmt("%"PRIuMAX, buf_size);
+			break;
+		}
+		default:
+			BUG("unknown object type");
+		}
 	}
 	free((void *)sigpos);
 }
@@ -1374,25 +1426,30 @@ static void fill_missing_values(struct atom_value *val)
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
+		grab_contents(val, deref, buf, buf_size, obj->type);
 		grab_person("tagger", val, deref, buf);
 		break;
 	case OBJ_COMMIT:
 		grab_commit_values(val, deref, obj);
-		grab_sub_body_contents(val, deref, buf);
+		grab_contents(val, deref, buf, buf_size, obj->type);
 		grab_person("author", val, deref, buf);
 		grab_person("committer", val, deref, buf);
 		break;
 	case OBJ_TREE:
 		/* grab_tree_values(val, deref, obj, buf, sz); */
+		grab_contents(val, deref, buf, buf_size, obj->type);
 		break;
 	case OBJ_BLOB:
 		/* grab_blob_values(val, deref, obj, buf, sz); */
+		grab_contents(val, deref, buf, buf_size, obj->type);
 		break;
 	default:
 		die("Eh?  Object of type %d?", obj->type);
@@ -1614,7 +1671,7 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
 					       oid_to_hex(&oi->oid), ref->refname);
 		}
-		grab_values(ref->value, deref, *obj, oi->content);
+		grab_values(ref->value, deref, *obj, oi);
 	}
 
 	grab_common_values(ref->value, deref, oi);
@@ -2297,6 +2354,25 @@ static int compare_detached_head(struct ref_array_item *a, struct ref_array_item
 	return 0;
 }
 
+static int memcasecmp(const void *vs1, const void *vs2, size_t n)
+{
+  size_t i;
+  const char *s1 = (const char *)vs1;
+  const char *s2 = (const char *)vs2;
+
+  for (i = 0; i < n; i++) {
+	unsigned char u1 = s1[i];
+	unsigned char u2 = s2[i];
+	int U1 = toupper (u1);
+	int U2 = toupper (u2);
+	int diff = (UCHAR_MAX <= INT_MAX ? U1 - U2
+		    : U1 < U2 ? -1 : U2 < U1);
+	if (diff)
+		return diff;
+	}
+	return 0;
+}
+
 static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, struct ref_array_item *b)
 {
 	struct atom_value *va, *vb;
@@ -2304,6 +2380,7 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	int cmp_detached_head = 0;
 	cmp_type cmp_type = used_atom[s->atom].type;
 	struct strbuf err = STRBUF_INIT;
+	size_t slen = 0;
 
 	if (get_ref_atom_value(a, s->atom, &va, &err))
 		die("%s", err.buf);
@@ -2317,10 +2394,28 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	} else if (s->sort_flags & REF_SORTING_VERSION) {
 		cmp = versioncmp(va->s, vb->s);
 	} else if (cmp_type == FIELD_STR) {
-		int (*cmp_fn)(const char *, const char *);
-		cmp_fn = s->sort_flags & REF_SORTING_ICASE
-			? strcasecmp : strcmp;
-		cmp = cmp_fn(va->s, vb->s);
+		if (!va->s_size && !vb->s_size) {
+			int (*cmp_fn)(const char *, const char *);
+			cmp_fn = s->sort_flags & REF_SORTING_ICASE
+				? strcasecmp : strcmp;
+			cmp = cmp_fn(va->s, vb->s);
+		} else {
+			int (*cmp_fn)(const void *, const void *, size_t);
+			cmp_fn = s->sort_flags & REF_SORTING_ICASE
+				? memcasecmp : memcmp;
+			if (va->s_size && vb->s_size) {
+				cmp = cmp_fn(va->s, vb->s, va->s_size > vb->s_size ?
+					     va->s_size : vb->s_size);
+			} else if (!va->s_size) {
+				slen = strlen(va->s);
+				cmp = cmp_fn(va->s, vb->s, slen > vb->s_size ?
+					     slen : vb->s_size);
+			} else {
+				slen = strlen(vb->s);
+				cmp = cmp_fn(va->s, vb->s, va->s_size > slen ?
+					     va->s_size : slen);
+			}
+		}
 	} else {
 		if (va->value < vb->value)
 			cmp = -1;
@@ -2420,6 +2515,7 @@ int format_ref_array_item(struct ref_array_item *info,
 	}
 	if (format->need_color_reset_at_eol) {
 		struct atom_value resetv;
+		resetv.s_size = 0;
 		resetv.s = GIT_COLOR_RESET;
 		if (append_atom(&resetv, &state, error_buf)) {
 			pop_stack_element(&state.stack);
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 9e0214076b4d..4754ec639797 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -63,8 +63,10 @@ test_atom() {
 		tag)
 			# We cannot use $3 as it expects sanitize_pgp to run
 			expect=$(git cat-file tag $ref | tail -n +6 | wc -c) ;;
-		tree | blob)
-			expect='' ;;
+		tree)
+			expect=$(git cat-file tree $ref | wc -c) ;;
+		blob)
+			expect=$(git cat-file blob $ref | wc -c) ;;
 		commit)
 			expect=$(printf '%s' "$3" | wc -c) ;;
 		esac
@@ -718,14 +720,170 @@ test_atom refs/mytrees/first contents:subject ""
 test_atom refs/mytrees/first body ""
 test_atom refs/mytrees/first contents:body ""
 test_atom refs/mytrees/first contents:signature ""
-test_atom refs/mytrees/first contents ""
+
+test_expect_success 'basic atom: refs/mytrees/first contents' '
+	git cat-file tree refs/mytrees/first >expected &&
+	cat expected | wc -c >size_expected &&
+	echo "" >>expected &&
+	git for-each-ref --format="%(contents)" refs/mytrees/first >actual &&
+	test_cmp expected actual &&
+	git for-each-ref --format="%(contents:size)" refs/mytrees/first >actual &&
+	test_cmp size_expected actual
+'
+
+test_expect_success 'basic atom: refs/mytrees/first contents with --python' '
+	cat >expected <<-\EOF &&
+	0000000 030447 030060 032066 020064 067157 000145 157155 153143
+	0000020 106210 070754 101352 115504 123726 045150 042451 077455
+	0000040 030061 033060 032064 072040 067567 072056 173400 167431
+	0000060 030324 025725 144317 065126 131103 062753 104126 104323
+	0000100 023561 000012
+	0000103
+	EOF
+	git for-each-ref --python --format="%(contents)" refs/mytrees/first >actual &&
+	od actual >od_actual &&
+	test_cmp expected od_actual
+'
+
+test_expect_success 'basic atom: refs/mytrees/first contents with --tcl' '
+	cat >expected <<-\EOF &&
+	0000000 030442 030060 032066 020064 067157 000145 157155 153143
+	0000020 106210 070754 101352 115504 123726 045150 042451 077455
+	0000040 030061 033060 032064 072040 067567 072056 173400 167431
+	0000060 030324 025725 144317 065126 131103 062753 104126 104323
+	0000100 021161 000012
+	0000103
+	EOF
+	git for-each-ref --tcl --format="%(contents)" refs/mytrees/first >actual &&
+	od actual >od_actual &&
+	test_cmp expected od_actual
+'
+
+test_expect_success 'basic atom: refs/mytrees/first contents with --shell' '
+	cat >expected <<-\EOF &&
+	0000000 030447 030060 032066 020064 067157 000145 157155 153143
+	0000020 106210 070754 101352 115504 123726 045150 042451 077455
+	0000040 030061 033060 032064 072040 067567 072056 173400 167431
+	0000060 030324 025725 144317 065126 131103 062753 104126 104323
+	0000100 023561 000012
+	0000103
+	EOF
+	git for-each-ref --shell --format="%(contents)" refs/mytrees/first >actual &&
+	od actual >od_actual &&
+	test_cmp expected od_actual
+'
+
+test_expect_success 'basic atom: refs/mytrees/first contents with --perl' '
+	cat >expected <<-\EOF &&
+	0000000 030447 030060 032066 020064 067157 000145 157155 153143
+	0000020 106210 070754 101352 115504 123726 045150 042451 077455
+	0000040 030061 033060 032064 072040 067567 072056 173400 167431
+	0000060 030324 025725 144317 065126 131103 062753 104126 104323
+	0000100 023561 000012
+	0000103
+	EOF
+	git for-each-ref --perl --format="%(contents)" refs/mytrees/first >actual &&
+	od actual >od_actual &&
+	test_cmp expected od_actual
+'
 
 test_atom refs/myblobs/first subject ""
 test_atom refs/myblobs/first contents:subject ""
 test_atom refs/myblobs/first body ""
 test_atom refs/myblobs/first contents:body ""
 test_atom refs/myblobs/first contents:signature ""
-test_atom refs/myblobs/first contents ""
+
+test_expect_success 'basic atom: refs/myblobs/first contents' '
+	git cat-file blob refs/myblobs/first >expected &&
+	cat expected | wc -c >size_expected &&
+	echo "" >>expected &&
+	git for-each-ref --format="%(contents)" refs/myblobs/first >actual &&
+	test_cmp expected actual &&
+	git for-each-ref --format="%(contents:size)" refs/myblobs/first >actual &&
+	test_cmp size_expected actual
+'
+
+test_expect_success 'set up refs pointing to binary blob' '
+	printf "%b" "a\0b\0c" >blob1 &&
+	printf "%b" "a\0c\0b" >blob2 &&
+	printf "%b" "\0a\0b\0c" >blob3 &&
+	printf "%b" "abc" >blob4 &&
+	printf "%b" "\0 \0 \0 " >blob5 &&
+	printf "%b" "\0 \0a\0 " >blob6 &&
+	git hash-object blob1 -w | xargs git update-ref refs/myblobs/blob1 &&
+	git hash-object blob2 -w | xargs git update-ref refs/myblobs/blob2 &&
+	git hash-object blob3 -w | xargs git update-ref refs/myblobs/blob3 &&
+	git hash-object blob4 -w | xargs git update-ref refs/myblobs/blob4 &&
+	git hash-object blob5 -w | xargs git update-ref refs/myblobs/blob5 &&
+	git hash-object blob6 -w | xargs git update-ref refs/myblobs/blob6
+'
+
+test_expect_success 'Verify sorts with contents' '
+	cat >expected <<-EOF &&
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
+	git for-each-ref --format="%(refname)" --sort=contents \
+		refs/heads/main refs/myblobs/ refs/mytrees/first >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'validate contents atom with %(if:equals)' '
+	cat >expect <<-EOF &&
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
+	EOF
+	git for-each-ref --format="%(if:equals=abc)%(contents)%(then)%(refname)%(else)not equals%(end)" \
+		refs/myblobs/ refs/heads/ >actual &&
+	test_cmp expect actual
+'
+test_expect_success 'validate contents atom with %(if:notequals)' '
+	cat >expect <<-EOF &&
+	refs/heads/ambiguous
+	refs/heads/main
+	refs/heads/newtag
+	refs/myblobs/blob1
+	refs/myblobs/blob2
+	refs/myblobs/blob3
+	equals
+	refs/myblobs/blob5
+	refs/myblobs/blob6
+	refs/myblobs/first
+	EOF
+	git for-each-ref --format="%(if:notequals=abc)%(contents)%(then)%(refname)%(else)equals%(end)" \
+		refs/myblobs/ refs/heads/ >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'empty contents refs with %(if)' '
+	cat >expect <<-EOF &&
+	refs/myblobs/blob1 not empty
+	refs/myblobs/blob2 not empty
+	refs/myblobs/blob3 not empty
+	refs/myblobs/blob4 not empty
+	refs/myblobs/blob5 empty
+	refs/myblobs/blob6 not empty
+	refs/myblobs/first not empty
+	EOF
+	git for-each-ref --format="%(refname) %(if)%(contents)%(then)not empty%(else)empty%(end)" \
+	refs/myblobs/ >actual &&
+	test_cmp expect actual
+'
 
 test_expect_success 'set up multiple-sort tags' '
 	for when in 100000 200000
-- 
gitgitgadget

