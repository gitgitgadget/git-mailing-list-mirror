Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F37FC2D0CD
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2330924656
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uyU3mKL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfLMIIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:08:17 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:43097 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLMIIO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 03:08:14 -0500
Received: by mail-wr1-f41.google.com with SMTP id d16so5564627wre.10
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 00:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5xjkS7Z9o9dvGIhDDQ0kagnHCtEfbWQjQvVhgQFReMI=;
        b=uyU3mKL68lyOYrBLk0265nD3CyEzj5Hq7fcFFV3OQ1hCbPVX/+0BwOQcQM5ST8DGx0
         ohqnxjIyOzOZ0fj/wRdehHSDg09rMyWPA+crdn4O59UTIKs7wdv20KiyQo5sEmksA+Mo
         DFWynme8RsGcsdhEFkkrD/F0TP7qE3Eg4MKizbI7tRd991J6iFgzWcbmcFz2Cv0076sX
         N5D3LF658Akv9zssk4paMhKaI4zt/QZN3ZlYIDct/9voh2uLcTZd6fGltoQ+5qSe2MGJ
         +ooj78dYXXqzfjnWzbhllmmTjBCeP0xX7oGjHOSU+HLKfu3stPCe8AfVX2Rbh1tYUper
         5Piw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5xjkS7Z9o9dvGIhDDQ0kagnHCtEfbWQjQvVhgQFReMI=;
        b=falPiYK0qCaHekpfm8nrcK148Y9TQcuizbw4ELvt0LZaEpQKw+3JaRQWgOTtjHe4a5
         W8d808UaIRNSzyOdaQXGxFvmDYjHXo3X50Z2lCExHPlEQpk8xVyIrXMhEukacbljbPoa
         eiL8C9WlJG9uSMTV8VK7PRZqthCpECD7x1pk8n2DCWrSvRsFOwo/IAPQ/5tDaKFoWZPa
         PUzbfuH4dWhTJakJF47JXQiCzL7lMNJma98TNikuzzw3cH5LVnHIb5l90R1JyLsQD5TX
         mU2p2irSJr2ju9cYXTStoFOQ/n0aGdcciN4m7DWLQ7yQAnh3PTx7KzyDIocgcgAyiLlV
         YEQQ==
X-Gm-Message-State: APjAAAWjgT5jzr0f7KNazct5T/BIVEHTmpexfCvV+qfhMZ3QPuwCz73Q
        p+ElXtyabtwvgoVnGzczjeLvuJX8
X-Google-Smtp-Source: APXvYqxr/1/esf6VA5QvC8O2LwQ81KWbnilPeUgxSNm6Z/G16lArLa32C0gfy9eieznWsM6XAOrHqw==
X-Received: by 2002:adf:f103:: with SMTP id r3mr10796449wro.295.1576224491228;
        Fri, 13 Dec 2019 00:08:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm8913307wrx.71.2019.12.13.00.08.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 00:08:10 -0800 (PST)
Message-Id: <ab94f43c0d1c190430da56b3ce08ee48b486a7db.1576224486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.173.git.1576224486.gitgitgadget@gmail.com>
References: <pull.173.git.1576224486.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 08:07:51 +0000
Subject: [PATCH 04/19] built-in add -p: adjust hunk headers as needed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When skipping a hunk that adds a different number of lines than it
removes, we need to adjust the subsequent hunk headers of non-skipped
hunks: in pathological cases, the context is not enough to determine
precisely where the patch should be applied.

This problem was identified in 23fea4c240 (t3701: add failing test for
pathological context lines, 2018-03-01) and fixed in the Perl version in
fecc6f3a68 (add -p: adjust offsets of subsequent hunks when one is
skipped, 2018-03-01).

And this patch fixes it in the C version of `git add -p`.

In contrast to the Perl version, we try to keep the extra text on the
hunk header (which typically contains the signature of the function
whose code is changed in the hunk) intact.

Note: while the C version does not support staging mode changes at this
stage, we already prepare for this by simply skipping the hunk header if
both old and new offset is 0 (this cannot happen for regular hunks, and
we will use this as an indicator that we are looking at a special hunk).

Likewise, we already prepare for hunk splitting by handling the absence
of extra text in the hunk header gracefully: only the first split hunk
will have that text, the others will not (indicated by an empty extra
text start/end range). Preparing for hunk splitting already at this
stage avoids an indentation change of the entire hunk header-printing
block later, and is almost as easy to review as without that handling.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c |  14 +----
 add-interactive.h |  15 +++++
 add-patch.c       | 145 ++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 151 insertions(+), 23 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 034c1dc02f..29356c5aa2 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -10,16 +10,6 @@
 #include "dir.h"
 #include "run-command.h"
 
-struct add_i_state {
-	struct repository *r;
-	int use_color;
-	char header_color[COLOR_MAXLEN];
-	char help_color[COLOR_MAXLEN];
-	char prompt_color[COLOR_MAXLEN];
-	char error_color[COLOR_MAXLEN];
-	char reset_color[COLOR_MAXLEN];
-};
-
 static void init_color(struct repository *r, struct add_i_state *s,
 		       const char *slot_name, char *dst,
 		       const char *default_color)
@@ -36,7 +26,7 @@ static void init_color(struct repository *r, struct add_i_state *s,
 	free(key);
 }
 
-static void init_add_i_state(struct add_i_state *s, struct repository *r)
+void init_add_i_state(struct add_i_state *s, struct repository *r)
 {
 	const char *value;
 
@@ -54,6 +44,8 @@ static void init_add_i_state(struct add_i_state *s, struct repository *r)
 	init_color(r, s, "prompt", s->prompt_color, GIT_COLOR_BOLD_BLUE);
 	init_color(r, s, "error", s->error_color, GIT_COLOR_BOLD_RED);
 	init_color(r, s, "reset", s->reset_color, GIT_COLOR_RESET);
+	init_color(r, s, "fraginfo", s->fraginfo_color,
+		   diff_get_color(s->use_color, DIFF_FRAGINFO));
 }
 
 /*
diff --git a/add-interactive.h b/add-interactive.h
index 0e3d93acc9..584f304a9a 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -1,6 +1,21 @@
 #ifndef ADD_INTERACTIVE_H
 #define ADD_INTERACTIVE_H
 
+#include "color.h"
+
+struct add_i_state {
+	struct repository *r;
+	int use_color;
+	char header_color[COLOR_MAXLEN];
+	char help_color[COLOR_MAXLEN];
+	char prompt_color[COLOR_MAXLEN];
+	char error_color[COLOR_MAXLEN];
+	char reset_color[COLOR_MAXLEN];
+	char fraginfo_color[COLOR_MAXLEN];
+};
+
+void init_add_i_state(struct add_i_state *s, struct repository *r);
+
 struct repository;
 struct pathspec;
 int run_add_i(struct repository *r, const struct pathspec *ps);
diff --git a/add-patch.c b/add-patch.c
index 79eefa9505..e266a96ca7 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -5,14 +5,26 @@
 #include "argv-array.h"
 #include "pathspec.h"
 #include "color.h"
+#include "diff.h"
+
+struct hunk_header {
+	unsigned long old_offset, old_count, new_offset, new_count;
+	/*
+	 * Start/end offsets to the extra text after the second `@@` in the
+	 * hunk header, e.g. the function signature. This is expected to
+	 * include the newline.
+	 */
+	size_t extra_start, extra_end, colored_extra_start, colored_extra_end;
+};
 
 struct hunk {
 	size_t start, end, colored_start, colored_end;
 	enum { UNDECIDED_HUNK = 0, SKIP_HUNK, USE_HUNK } use;
+	struct hunk_header header;
 };
 
 struct add_p_state {
-	struct repository *r;
+	struct add_i_state s;
 	struct strbuf answer, buf;
 
 	/* parsed diff */
@@ -35,7 +47,70 @@ static void setup_child_process(struct add_p_state *s,
 
 	cp->git_cmd = 1;
 	argv_array_pushf(&cp->env_array,
-			 INDEX_ENVIRONMENT "=%s", s->r->index_file);
+			 INDEX_ENVIRONMENT "=%s", s->s.r->index_file);
+}
+
+static int parse_range(const char **p,
+		       unsigned long *offset, unsigned long *count)
+{
+	char *pend;
+
+	*offset = strtoul(*p, &pend, 10);
+	if (pend == *p)
+		return -1;
+	if (*pend != ',') {
+		*count = 1;
+		*p = pend;
+		return 0;
+	}
+	*count = strtoul(pend + 1, (char **)p, 10);
+	return *p == pend + 1 ? -1 : 0;
+}
+
+static int parse_hunk_header(struct add_p_state *s, struct hunk *hunk)
+{
+	struct hunk_header *header = &hunk->header;
+	const char *line = s->plain.buf + hunk->start, *p = line;
+	char *eol = memchr(p, '\n', s->plain.len - hunk->start);
+
+	if (!eol)
+		eol = s->plain.buf + s->plain.len;
+
+	if (!skip_prefix(p, "@@ -", &p) ||
+	    parse_range(&p, &header->old_offset, &header->old_count) < 0 ||
+	    !skip_prefix(p, " +", &p) ||
+	    parse_range(&p, &header->new_offset, &header->new_count) < 0 ||
+	    !skip_prefix(p, " @@", &p))
+		return error(_("could not parse hunk header '%.*s'"),
+			     (int)(eol - line), line);
+
+	hunk->start = eol - s->plain.buf + (*eol == '\n');
+	header->extra_start = p - s->plain.buf;
+	header->extra_end = hunk->start;
+
+	if (!s->colored.len) {
+		header->colored_extra_start = header->colored_extra_end = 0;
+		return 0;
+	}
+
+	/* Now find the extra text in the colored diff */
+	line = s->colored.buf + hunk->colored_start;
+	eol = memchr(line, '\n', s->colored.len - hunk->colored_start);
+	if (!eol)
+		eol = s->colored.buf + s->colored.len;
+	p = memmem(line, eol - line, "@@ -", 4);
+	if (!p)
+		return error(_("could not parse colored hunk header '%.*s'"),
+			     (int)(eol - line), line);
+	p = memmem(p + 4, eol - p - 4, " @@", 3);
+	if (!p)
+		return error(_("could not parse colored hunk header '%.*s'"),
+			     (int)(eol - line), line);
+	hunk->colored_start = eol - s->colored.buf + (*eol == '\n');
+	header->colored_extra_start = p + 3 - s->colored.buf;
+	header->colored_extra_end = hunk->colored_start;
+
+	return 0;
 }
 
 static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
@@ -109,6 +184,9 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 			hunk->start = p - plain->buf;
 			if (colored)
 				hunk->colored_start = colored_p - colored->buf;
+
+			if (parse_hunk_header(s, hunk) < 0)
+				return -1;
 		}
 
 		p = eol == pend ? pend : eol + 1;
@@ -130,8 +208,43 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 }
 
 static void render_hunk(struct add_p_state *s, struct hunk *hunk,
-			int colored, struct strbuf *out)
+			ssize_t delta, int colored, struct strbuf *out)
 {
+	struct hunk_header *header = &hunk->header;
+
+	if (hunk->header.old_offset != 0 || hunk->header.new_offset != 0) {
+		/*
+		 * Generate the hunk header dynamically, except for special
+		 * hunks (such as the diff header).
+		 */
+		const char *p;
+		size_t len;
+		unsigned long old_offset = header->old_offset;
+		unsigned long new_offset = header->new_offset;
+
+		if (!colored) {
+			p = s->plain.buf + header->extra_start;
+			len = header->extra_end - header->extra_start;
+		} else {
+			strbuf_addstr(out, s->s.fraginfo_color);
+			p = s->colored.buf + header->colored_extra_start;
+			len = header->colored_extra_end
+				- header->colored_extra_start;
+		}
+
+		new_offset += delta;
+
+		strbuf_addf(out, "@@ -%lu,%lu +%lu,%lu @@",
+			    old_offset, header->old_count,
+			    new_offset, header->new_count);
+		if (len)
+			strbuf_add(out, p, len);
+		else if (colored)
+			strbuf_addf(out, "%s\n", GIT_COLOR_RESET);
+		else
+			strbuf_addch(out, '\n');
+	}
+
 	if (colored)
 		strbuf_add(out, s->colored.buf + hunk->colored_start,
 			   hunk->colored_end - hunk->colored_start);
@@ -144,13 +257,17 @@ static void reassemble_patch(struct add_p_state *s, struct strbuf *out)
 {
 	struct hunk *hunk;
 	size_t i;
+	ssize_t delta = 0;
 
-	render_hunk(s, &s->head, 0, out);
+	render_hunk(s, &s->head, 0, 0, out);
 
 	for (i = 0; i < s->hunk_nr; i++) {
 		hunk = s->hunk + i;
-		if (hunk->use == USE_HUNK)
-			render_hunk(s, hunk, 0, out);
+		if (hunk->use != USE_HUNK)
+			delta += hunk->header.old_count
+				- hunk->header.new_count;
+		else
+			render_hunk(s, hunk, delta, 0, out);
 	}
 }
 
@@ -178,7 +295,7 @@ static int patch_update_file(struct add_p_state *s)
 		return 0;
 
 	strbuf_reset(&s->buf);
-	render_hunk(s, &s->head, colored, &s->buf);
+	render_hunk(s, &s->head, 0, colored, &s->buf);
 	fputs(s->buf.buf, stdout);
 	for (;;) {
 		if (hunk_index >= s->hunk_nr)
@@ -205,7 +322,7 @@ static int patch_update_file(struct add_p_state *s)
 			break;
 
 		strbuf_reset(&s->buf);
-		render_hunk(s, hunk, colored, &s->buf);
+		render_hunk(s, hunk, 0, colored, &s->buf);
 		fputs(s->buf.buf, stdout);
 
 		strbuf_reset(&s->buf);
@@ -272,13 +389,13 @@ static int patch_update_file(struct add_p_state *s)
 		strbuf_reset(&s->buf);
 		reassemble_patch(s, &s->buf);
 
-		discard_index(s->r->index);
+		discard_index(s->s.r->index);
 		setup_child_process(s, &cp, "apply", "--cached", NULL);
 		if (pipe_command(&cp, s->buf.buf, s->buf.len,
 				 NULL, 0, NULL, 0))
 			error(_("'git apply --cached' failed"));
-		if (!repo_read_index(s->r))
-			repo_refresh_and_write_index(s->r, REFRESH_QUIET, 0,
+		if (!repo_read_index(s->s.r))
+			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
 						     1, NULL, NULL, NULL);
 	}
 
@@ -288,7 +405,11 @@ static int patch_update_file(struct add_p_state *s)
 
 int run_add_p(struct repository *r, const struct pathspec *ps)
 {
-	struct add_p_state s = { r, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT };
+	struct add_p_state s = {
+		{ r }, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
+	};
+
+	init_add_i_state(&s.s, r);
 
 	if (discard_index(r->index) < 0 || repo_read_index(r) < 0 ||
 	    repo_refresh_and_write_index(r, REFRESH_QUIET, 0, 1,
-- 
gitgitgadget

