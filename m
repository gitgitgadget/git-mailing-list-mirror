Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6613520229
	for <e@80x24.org>; Tue,  1 Nov 2016 20:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754615AbcKAUIj (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 16:08:39 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33396 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754364AbcKAUIg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 16:08:36 -0400
Received: by mail-pf0-f178.google.com with SMTP id d2so25428226pfd.0
        for <git@vger.kernel.org>; Tue, 01 Nov 2016 13:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=AkN+CG0PIihhLxbbQH75AYSt1eKoP+OJo0fPxTs8fNo=;
        b=dvrWKcv23rN3kVgdOrRJePxxyUKXX7Bq/6faRkflBTKb/0Z3MRaRooAcrpVXw6Kcg2
         A0Z2yljncxaoi2rJX2FBnREq0uvwlwXY91wKct9/3k8cPuQEfzP+JGxBtv3dckormKpg
         o05BSlwetFHvxXJKokJAGwYyS6p67yXFpWqNeeE3UmkIricDdHgtSOcqEaS0FRzxDeNR
         5Sy4vVHHieGkBLhiCN1gpUHcjisun8QJDGq4/2ir3OdOHUhbbdmmVFywfIi1c+2CcSqh
         rMznTnsLEqYJsiUNoxg9q8704lIqmI2IobfAHBAylfmDJgnIJPqKQ3yUy+jdtNCMSpBK
         Pqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=AkN+CG0PIihhLxbbQH75AYSt1eKoP+OJo0fPxTs8fNo=;
        b=fsm2x9yv0wz1TE2gr/7xiIhUj6SmJY2Nzql8RANw1Me/2FnoUKVz5xD1B4FJMNLDk2
         J31G8hb2GxhB6SN8i7beclMQ7CEqY3kcn/mpMxAJabhalNJjmxbg15jU2iMY3ZNr+/PE
         JWOi0RzyNjV9gkpmoTeri38Z78QaJ0VNkbYPknsZCD/3HIxdLwDl8DQBVr/pHKVQKhRG
         WfkfMCtGy+D+1Ht+/7WLWLPF0qGZQmFgw56RjHYrRK2Og0rabiF6juFvfIxqr3MgLBdK
         hDbi6365x+Twnq3cTPcpK/GM5kvZjUe3jrMnv6cP30Jtz2dMJdOo7RVcQo5dUbK6/xik
         z04w==
X-Gm-Message-State: ABUngvd2Io6BlmQgB8gxnemEhXmQCaFM+k9zOzfns52c0vI/XmA9w9JOLju3mUUQqFbSC9gm
X-Received: by 10.98.208.3 with SMTP id p3mr62327786pfg.125.1478030915700;
        Tue, 01 Nov 2016 13:08:35 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id v4sm44093272pfb.52.2016.11.01.13.08.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Nov 2016 13:08:34 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        christian.couder@gmail.com
Subject: [PATCH v2 3/5] trailer: avoid unnecessary splitting on lines
Date:   Tue,  1 Nov 2016 13:08:23 -0700
Message-Id: <31f32c6118bad2ba3604177ab448e97d4db0282f.1478028700.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1478028700.git.jonathantanmy@google.com>
References: <cover.1478028700.git.jonathantanmy@google.com>
In-Reply-To: <cover.1478028700.git.jonathantanmy@google.com>
References: <cover.1477698917.git.jonathantanmy@google.com> <cover.1478028700.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

trailer.c currently splits lines while processing a buffer (and also
rejoins lines when needing to invoke ignore_non_trailer).

Avoid such line splitting, except when generating the strings
corresponding to trailers (for ease of use by clients - a subsequent
patch will allow other components to obtain the layout of a trailer
block in a buffer, including the trailers themselves). The main purpose
of this is to make it easy to return pointers into the original buffer
(for a subsequent patch), but this also significantly reduces the number
of memory allocations required.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 trailer.c | 195 ++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 101 insertions(+), 94 deletions(-)

diff --git a/trailer.c b/trailer.c
index 04edab2..f5427ec 100644
--- a/trailer.c
+++ b/trailer.c
@@ -102,12 +102,12 @@ static int same_trailer(struct trailer_item *a, struct arg_item *b)
 	return same_token(a, b) && same_value(a, b);
 }
 
-static inline int contains_only_spaces(const char *str)
+static inline int is_blank_line(const char *str)
 {
 	const char *s = str;
-	while (*s && isspace(*s))
+	while (*s && *s != '\n' && isspace(*s))
 		s++;
-	return !*s;
+	return !*s || *s == '\n';
 }
 
 static inline void strbuf_replace(struct strbuf *sb, const char *a, const char *b)
@@ -696,51 +696,71 @@ static void process_command_line_args(struct list_head *arg_head,
 	free(cl_separators);
 }
 
-static struct strbuf **read_input_file(const char *file)
+static void read_input_file(struct strbuf *sb, const char *file)
 {
-	struct strbuf **lines;
-	struct strbuf sb = STRBUF_INIT;
-
 	if (file) {
-		if (strbuf_read_file(&sb, file, 0) < 0)
+		if (strbuf_read_file(sb, file, 0) < 0)
 			die_errno(_("could not read input file '%s'"), file);
 	} else {
-		if (strbuf_read(&sb, fileno(stdin), 0) < 0)
+		if (strbuf_read(sb, fileno(stdin), 0) < 0)
 			die_errno(_("could not read from stdin"));
 	}
+}
 
-	lines = strbuf_split(&sb, '\n');
+static const char *next_line(const char *str)
+{
+	const char *nl = strchrnul(str, '\n');
+	return nl + !!*nl;
+}
 
-	strbuf_release(&sb);
+/*
+ * Return the position of the start of the last line. If len is 0, return -1.
+ */
+static int last_line(const char *buf, size_t len)
+{
+	int i;
+	if (len == 0)
+		return -1;
+	if (len == 1)
+		return 0;
+	/*
+	 * Skip the last character (in addition to the null terminator),
+	 * because if the last character is a newline, it is considered as part
+	 * of the last line anyway.
+	 */
+	i = len - 2;
 
-	return lines;
+	for (; i >= 0; i--) {
+		if (buf[i] == '\n')
+			return i + 1;
+	}
+	return 0;
 }
 
 /*
- * Return the (0 based) index of the start of the patch or the line
- * count if there is no patch in the message.
+ * Return the position of the start of the patch or the length of str if there
+ * is no patch in the message.
  */
-static int find_patch_start(struct strbuf **lines, int count)
+static int find_patch_start(const char *str)
 {
-	int i;
+	const char *s;
 
-	/* Get the start of the patch part if any */
-	for (i = 0; i < count; i++) {
-		if (starts_with(lines[i]->buf, "---"))
-			return i;
+	for (s = str; *s; s = next_line(s)) {
+		if (starts_with(s, "---"))
+			return s - str;
 	}
 
-	return count;
+	return s - str;
 }
 
 /*
- * Return the (0 based) index of the first trailer line or count if
- * there are no trailers. Trailers are searched only in the lines from
- * index (count - 1) down to index 0.
+ * Return the position of the first trailer line or len if there are no
+ * trailers.
  */
-static int find_trailer_start(struct strbuf **lines, int count)
+static int find_trailer_start(const char *buf, size_t len)
 {
-	int start, end_of_title, only_spaces = 1;
+	const char *s;
+	int end_of_title, l, only_spaces = 1;
 	int recognized_prefix = 0, trailer_lines = 0, non_trailer_lines = 0;
 	/*
 	 * Number of possible continuation lines encountered. This will be
@@ -750,15 +770,16 @@ static int find_trailer_start(struct strbuf **lines, int count)
 	 * are to be considered non-trailers).
 	 */
 	int possible_continuation_lines = 0;
+	int ret;
 
 	/* The first paragraph is the title and cannot be trailers */
-	for (start = 0; start < count; start++) {
-		if (lines[start]->buf[0] == comment_line_char)
+	for (s = buf; s < buf + len; s = next_line(s)) {
+		if (s[0] == comment_line_char)
 			continue;
-		if (contains_only_spaces(lines[start]->buf))
+		if (is_blank_line(s))
 			break;
 	}
-	end_of_title = start;
+	end_of_title = s - buf;
 
 	/*
 	 * Get the start of the trailers by looking starting from the end for a
@@ -766,30 +787,33 @@ static int find_trailer_start(struct strbuf **lines, int count)
 	 * trailers, or (ii) contains at least one Git-generated trailer and
 	 * consists of at least 25% trailers.
 	 */
-	for (start = count - 1; start >= end_of_title; start--) {
+	for (l = last_line(buf, len);
+	     l >= end_of_title;
+	     l = last_line(buf, l)) {
+		const char *bol = buf + l;
 		const char **p;
 		int separator_pos;
 
-		if (lines[start]->buf[0] == comment_line_char) {
+		if (bol[0] == comment_line_char) {
 			non_trailer_lines += possible_continuation_lines;
 			possible_continuation_lines = 0;
 			continue;
 		}
-		if (contains_only_spaces(lines[start]->buf)) {
+		if (is_blank_line(bol)) {
 			if (only_spaces)
 				continue;
 			non_trailer_lines += possible_continuation_lines;
 			if (recognized_prefix &&
 			    trailer_lines * 3 >= non_trailer_lines)
-				return start + 1;
-			if (trailer_lines && !non_trailer_lines)
-				return start + 1;
-			return count;
+				return next_line(bol) - buf;
+			else if (trailer_lines && !non_trailer_lines)
+				return next_line(bol) - buf;
+			return len;
 		}
 		only_spaces = 0;
 
 		for (p = git_generated_prefixes; *p; p++) {
-			if (starts_with(lines[start]->buf, *p)) {
+			if (starts_with(bol, *p)) {
 				trailer_lines++;
 				possible_continuation_lines = 0;
 				recognized_prefix = 1;
@@ -797,8 +821,8 @@ static int find_trailer_start(struct strbuf **lines, int count)
 			}
 		}
 
-		separator_pos = find_separator(lines[start]->buf, separators);
-		if (separator_pos >= 1 && !isspace(lines[start]->buf[0])) {
+		separator_pos = find_separator(bol, separators);
+		if (separator_pos >= 1 && !isspace(bol[0])) {
 			struct list_head *pos;
 
 			trailer_lines++;
@@ -808,13 +832,13 @@ static int find_trailer_start(struct strbuf **lines, int count)
 			list_for_each(pos, &conf_head) {
 				struct arg_item *item;
 				item = list_entry(pos, struct arg_item, list);
-				if (token_matches_item(lines[start]->buf, item,
+				if (token_matches_item(bol, item,
 						       separator_pos)) {
 					recognized_prefix = 1;
 					break;
 				}
 			}
-		} else if (isspace(lines[start]->buf[0]))
+		} else if (isspace(bol[0]))
 			possible_continuation_lines++;
 		else {
 			non_trailer_lines++;
@@ -825,88 +849,70 @@ static int find_trailer_start(struct strbuf **lines, int count)
 		;
 	}
 
-	return count;
-}
-
-/* Get the index of the end of the trailers */
-static int find_trailer_end(struct strbuf **lines, int patch_start)
-{
-	struct strbuf sb = STRBUF_INIT;
-	int i, ignore_bytes;
-
-	for (i = 0; i < patch_start; i++)
-		strbuf_addbuf(&sb, lines[i]);
-	ignore_bytes = ignore_non_trailer(sb.buf, sb.len);
-	strbuf_release(&sb);
-	for (i = patch_start - 1; i >= 0 && ignore_bytes > 0; i--)
-		ignore_bytes -= lines[i]->len;
-
-	return i + 1;
+	return len;
 }
 
-static int has_blank_line_before(struct strbuf **lines, int start)
+/* Return the position of the end of the trailers. */
+static int find_trailer_end(const char *buf, size_t len)
 {
-	for (;start >= 0; start--) {
-		if (lines[start]->buf[0] == comment_line_char)
-			continue;
-		return contains_only_spaces(lines[start]->buf);
-	}
-	return 0;
+	return len - ignore_non_trailer(buf, len);
 }
 
-static void print_lines(FILE *outfile, struct strbuf **lines, int start, int end)
+static int ends_with_blank_line(const char *buf, size_t len)
 {
-	int i;
-	for (i = start; lines[i] && i < end; i++)
-		fprintf(outfile, "%s", lines[i]->buf);
+	int ll = last_line(buf, len);
+	if (ll < 0)
+		return 0;
+	return is_blank_line(buf + ll);
 }
 
 static int process_input_file(FILE *outfile,
-			      struct strbuf **lines,
+			      const char *str,
 			      struct list_head *head)
 {
-	int count = 0;
-	int patch_start, trailer_start, trailer_end, i;
+	int patch_start, trailer_start, trailer_end;
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
 	struct trailer_item *last = NULL;
+	struct strbuf *trailer, **trailer_lines, **ptr;
 
-	/* Get the line count */
-	while (lines[count])
-		count++;
-
-	patch_start = find_patch_start(lines, count);
-	trailer_end = find_trailer_end(lines, patch_start);
-	trailer_start = find_trailer_start(lines, trailer_end);
+	patch_start = find_patch_start(str);
+	trailer_end = find_trailer_end(str, patch_start);
+	trailer_start = find_trailer_start(str, trailer_end);
 
 	/* Print lines before the trailers as is */
-	print_lines(outfile, lines, 0, trailer_start);
+	fwrite(str, 1, trailer_start, outfile);
 
-	if (!has_blank_line_before(lines, trailer_start - 1))
+	if (!ends_with_blank_line(str, trailer_start))
 		fprintf(outfile, "\n");
 
 	/* Parse trailer lines */
-	for (i = trailer_start; i < trailer_end; i++) {
+	trailer_lines = strbuf_split_buf(str + trailer_start,
+					 trailer_end - trailer_start,
+					 '\n',
+					 0);
+	for (ptr = trailer_lines; *ptr; ptr++) {
 		int separator_pos;
-		if (lines[i]->buf[0] == comment_line_char)
+		trailer = *ptr;
+		if (trailer->buf[0] == comment_line_char)
 			continue;
-		if (last && isspace(lines[i]->buf[0])) {
+		if (last && isspace(trailer->buf[0])) {
 			struct strbuf sb = STRBUF_INIT;
-			strbuf_addf(&sb, "%s\n%s", last->value, lines[i]->buf);
+			strbuf_addf(&sb, "%s\n%s", last->value, trailer->buf);
 			strbuf_strip_suffix(&sb, "\n");
 			free(last->value);
 			last->value = strbuf_detach(&sb, NULL);
 			continue;
 		}
-		separator_pos = find_separator(lines[i]->buf, separators);
+		separator_pos = find_separator(trailer->buf, separators);
 		if (separator_pos >= 1) {
-			parse_trailer(&tok, &val, NULL, lines[i]->buf,
+			parse_trailer(&tok, &val, NULL, trailer->buf,
 				      separator_pos);
 			last = add_trailer_item(head,
 						strbuf_detach(&tok, NULL),
 						strbuf_detach(&val, NULL));
 		} else {
-			strbuf_addbuf(&val, lines[i]);
+			strbuf_addbuf(&val, trailer);
 			strbuf_strip_suffix(&val, "\n");
 			add_trailer_item(head,
 					 NULL,
@@ -914,6 +920,7 @@ static int process_input_file(FILE *outfile,
 			last = NULL;
 		}
 	}
+	strbuf_list_free(trailer_lines);
 
 	return trailer_end;
 }
@@ -962,7 +969,7 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
 {
 	LIST_HEAD(head);
 	LIST_HEAD(arg_head);
-	struct strbuf **lines;
+	struct strbuf sb = STRBUF_INIT;
 	int trailer_end;
 	FILE *outfile = stdout;
 
@@ -970,13 +977,13 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
 	git_config(git_trailer_default_config, NULL);
 	git_config(git_trailer_config, NULL);
 
-	lines = read_input_file(file);
+	read_input_file(&sb, file);
 
 	if (in_place)
 		outfile = create_in_place_tempfile(file);
 
 	/* Print the lines before the trailers */
-	trailer_end = process_input_file(outfile, lines, &head);
+	trailer_end = process_input_file(outfile, sb.buf, &head);
 
 	process_command_line_args(&arg_head, trailers);
 
@@ -987,11 +994,11 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
 	free_all(&head);
 
 	/* Print the lines after the trailers as is */
-	print_lines(outfile, lines, trailer_end, INT_MAX);
+	fwrite(sb.buf + trailer_end, 1, sb.len - trailer_end, outfile);
 
 	if (in_place)
 		if (rename_tempfile(&trailers_tempfile, file))
 			die_errno(_("could not rename temporary file to %s"), file);
 
-	strbuf_list_free(lines);
+	strbuf_release(&sb);
 }
-- 
2.8.0.rc3.226.g39d4020

