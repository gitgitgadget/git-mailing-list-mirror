Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE0B4206A4
	for <e@80x24.org>; Sat, 29 Oct 2016 00:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933767AbcJ2AFX (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 20:05:23 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34794 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755688AbcJ2AFT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 20:05:19 -0400
Received: by mail-pf0-f171.google.com with SMTP id n85so44900999pfi.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 17:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=/y7YPSzJHI2/QY1XwhUJcfcfQ5Q09eRnP1xKCFDHvpo=;
        b=kwRAcBykvT4kHzi6qYd2lZ8UB4et1DZIrDTvMLsHch+qpY9gK0SxLKZRpsTfbWHh2j
         /Cb0TtKSWleCEKv/rM2eBVae6u+bRO+I1/O66huhXgxMmd1iQmYQzx1yd+lNxZISYHKR
         erlW5Go4zpeqpjfFn1LaoHTXCYfRQS8wZy06YjJg49q6K4QomddMdDmi6n8TyREqm7wd
         Tp3oj8stnEp3l+QmOy5iNmg/JVGrXnbnSX89o4IlKpi0ftC3ASe7At+hYBiwCUrOXOxz
         YIoujc67OzmiYKlEJ/ArVul9PyoNlYTVxt9KRdJ08sxBWyYUpjks6/VmI3ZF1OUNAzvA
         XSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/y7YPSzJHI2/QY1XwhUJcfcfQ5Q09eRnP1xKCFDHvpo=;
        b=Xfy+4pysdb22q0rKQXoO+slkFmr+GyTpmnMMMF8dnWJgxPUEwTnqT56HhiLdZvx6er
         k4ggQQs26D/vM21iA8/RIz7/LkhgQZp2UvhZ+gS3eaaPEOEiLAMWt6WkTpyULWUzUwyQ
         shZ6AlLmZ2nl3MvLX/MWLLXIxvFbTn+fApxyQE0n3KVXFT66GVnBczLgwvh5QS1wF5XA
         tZaMg2L2sL6YurSReqs2+jDfWUjqpY1/6z29+8CFhRqBmgFBUZ9Qs299RwISNPC0w5Z+
         DfUNAMYNy4rbnYl8H7BS0ynjXMkebU71AH3AIGqXC1XmsdQx74K+5cUWnIpwKKZHK26z
         X/iA==
X-Gm-Message-State: ABUngvf9u1iWL+XxQJtdHL7k2gCjIhDmAuLQbyvmxhcpq1hprvzj/0whd8rXpXUwCp8+3eWZ
X-Received: by 10.99.159.17 with SMTP id g17mr24457421pge.149.1477699517918;
        Fri, 28 Oct 2016 17:05:17 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id b66sm21356750pfg.10.2016.10.28.17.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 17:05:16 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 2/4] trailer: avoid unnecessary splitting on lines
Date:   Fri, 28 Oct 2016 17:05:09 -0700
Message-Id: <db609e13740415ac4e5e357493661347b0f681f7.1477698917.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1477698917.git.jonathantanmy@google.com>
References: <cover.1477698917.git.jonathantanmy@google.com>
In-Reply-To: <cover.1477698917.git.jonathantanmy@google.com>
References: <cover.1477698917.git.jonathantanmy@google.com>
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
 trailer.c | 215 +++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 116 insertions(+), 99 deletions(-)

diff --git a/trailer.c b/trailer.c
index 6d8375b..d4d9e10 100644
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
@@ -566,13 +566,18 @@ static int token_matches_item(const char *tok, struct arg_item *item, int tok_le
 }
 
 /*
- * Return the location of the first separator in line, or -1 if there is no
- * separator.
+ * Return the location of the first separator in the given line, or -1 if there
+ * is no separator.
+ *
+ * The interests parameter must contain the acceptable separators and may
+ * contain '\n'. If interests contains '\n', the input line is considered to
+ * end at the first newline encountered. Otherwise, the input line is
+ * considered to end at its null terminator.
  */
-static int find_separator(const char *line, const char *separators)
+static int find_separator(const char *line, const char *interests)
 {
-	int loc = strcspn(line, separators);
-	if (!line[loc])
+	int loc = strcspn(line, interests);
+	if (!line[loc] || line[loc] == '\n')
 		return -1;
 	return loc;
 }
@@ -688,51 +693,71 @@ static void process_command_line_args(struct list_head *arg_head,
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
+	int title_end, l, only_spaces = 1;
 	int recognized_prefix = 0, trailer_lines = 0, non_trailer_lines = 0;
 	/*
 	 * Number of possible continuation lines encountered. This will be
@@ -742,15 +767,18 @@ static int find_trailer_start(struct strbuf **lines, int count)
 	 * are to be considered non-trailers).
 	 */
 	int possible_continuation_lines = 0;
+	int ret;
+
+	char *sep_nl = xstrfmt("%s\n", separators);
 
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
+	title_end = s - buf;
 
 	/*
 	 * Get the start of the trailers by looking starting from the end for a
@@ -758,30 +786,33 @@ static int find_trailer_start(struct strbuf **lines, int count)
 	 * trailers, or (ii) contains at least one Git-generated trailer and
 	 * consists of at least 25% trailers.
 	 */
-	for (start = count - 1; start >= end_of_title; start--) {
+	for (l = last_line(buf, len); l >= title_end; l = last_line(buf, l)) {
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
+				ret = next_line(bol) - buf;
+			else if (trailer_lines && !non_trailer_lines)
+				ret = next_line(bol) - buf;
+			else
+				ret = len;
+			goto cleanup;
 		}
 		only_spaces = 0;
 
 		for (p = git_generated_prefixes; *p; p++) {
-			if (starts_with(lines[start]->buf, *p)) {
+			if (starts_with(bol, *p)) {
 				trailer_lines++;
 				possible_continuation_lines = 0;
 				recognized_prefix = 1;
@@ -789,8 +820,8 @@ static int find_trailer_start(struct strbuf **lines, int count)
 			}
 		}
 
-		separator_pos = find_separator(lines[start]->buf, separators);
-		if (separator_pos >= 1 && !isspace(lines[start]->buf[0])) {
+		separator_pos = find_separator(bol, sep_nl);
+		if (separator_pos >= 1 && !isspace(bol[0])) {
 			struct list_head *pos;
 
 			trailer_lines++;
@@ -800,13 +831,13 @@ static int find_trailer_start(struct strbuf **lines, int count)
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
@@ -817,88 +848,73 @@ static int find_trailer_start(struct strbuf **lines, int count)
 		;
 	}
 
-	return count;
+	ret = len;
+cleanup:
+	free(sep_nl);
+	return ret;
 }
 
-/* Get the index of the end of the trailers */
-static int find_trailer_end(struct strbuf **lines, int patch_start)
+/* Return the position of the end of the trailers. */
+static int find_trailer_end(const char *buf, size_t len)
 {
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
+	return len - ignore_non_trailer(buf, len);
 }
 
-static int has_blank_line_before(struct strbuf **lines, int start)
+static int ends_with_blank_line(const char *buf, size_t len)
 {
-	for (;start >= 0; start--) {
-		if (lines[start]->buf[0] == comment_line_char)
-			continue;
-		return contains_only_spaces(lines[start]->buf);
-	}
-	return 0;
-}
-
-static void print_lines(FILE *outfile, struct strbuf **lines, int start, int end)
-{
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
@@ -906,6 +922,7 @@ static int process_input_file(FILE *outfile,
 			last = NULL;
 		}
 	}
+	strbuf_list_free(trailer_lines);
 
 	return trailer_end;
 }
@@ -954,7 +971,7 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
 {
 	LIST_HEAD(head);
 	LIST_HEAD(arg_head);
-	struct strbuf **lines;
+	struct strbuf sb = STRBUF_INIT;
 	int trailer_end;
 	FILE *outfile = stdout;
 
@@ -962,13 +979,13 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
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
 
@@ -979,11 +996,11 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
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

