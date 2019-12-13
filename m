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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D169C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39DE2465A
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAY3f37T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLMII1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:08:27 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:50595 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfLMIIX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 03:08:23 -0500
Received: by mail-wm1-f52.google.com with SMTP id a5so5281230wmb.0
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 00:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oIKUqb8zXvthx3CpYus3Q8kPps4SSG3JdA7cfqHGew0=;
        b=XAY3f37TXd/wB/WLzgo2dA1/rAdjldsopXqSDgHuHeaWz0CkZlRtJ78OeXEAdN0bRf
         E5UBf11y5hji7EcS86vSxjwJievw/volb8o939WD8mQGwVwxq5x+2LALuIjwduHN10fv
         cY72v4I5+LqjVOWjwS64NHIfAVjhiswUZiLaWPllz6URnLg8zlG9LzHflTzXoKOBN6Cn
         TbPxRajiFyMHrgt70pOoWUz99KCO3fGK7zKf6krlk8M/x6RtZI+HZos1m+9EbAdpeDZl
         eRzqoEukCWn5GcGc4Vv9xR1K9t9xL8Xwm5rrycx19lO0Jfz2yG/s3gA1LiwavUCCAQZz
         lkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oIKUqb8zXvthx3CpYus3Q8kPps4SSG3JdA7cfqHGew0=;
        b=T4sKR7DgKv3vsIK21nqgWXV+MgtECVBG8URiRvRVH+hEm+24Fap/QaSq8pPHGbx68H
         RrCCuhH3z9vR0UbBMeWzM7DE/f9Zx8WiQEaoCMtIQaBsu5S6lDvs/wmxt532patVK5OY
         RLyNh29TpzbGDncukN7jjoQojsG/c+5yDnpi+sqgXNTGIXt0f4WXsz6YUuA0WU7n96nV
         grcfobTAynm6XiYtPEFsfBRQ4hSsTkNcF812e3hVKrIdeAr3beMDB7YXIb2UlhfphiHe
         gagyftX16Dv85A5LkbyBtMwQL/wf4Ep7M9T8+GYIFw6vGHOov7JI+oH1gU+DUNzW4IXU
         rV8Q==
X-Gm-Message-State: APjAAAWfCzQJHTPc27ptsdwYWIHW/clRsg8rWSn4v6GAZG0q2F04Uwpj
        yyEdMoPLgjjaSo+dR1aK9dlq+hKW
X-Google-Smtp-Source: APXvYqwWdteYRm775CxiuZxJ1TTmHxGu0Ynz8M1z51nYgMzII5b2SzOeeXC1BAHSU5B9/Bo54TdCSg==
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr11453216wml.83.1576224499162;
        Fri, 13 Dec 2019 00:08:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11sm9364325wmg.46.2019.12.13.00.08.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 00:08:18 -0800 (PST)
Message-Id: <1e23fcd44e17b2980da5997344d6aaa7efe0754a.1576224486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.173.git.1576224486.gitgitgadget@gmail.com>
References: <pull.173.git.1576224486.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 08:08:01 +0000
Subject: [PATCH 14/19] built-in add -p: implement hunk editing
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

Just like `git add --edit` allows the user to edit the diff before it is
being applied to the index, this feature allows the user to edit the
diff *hunk*.

Naturally, it gets a bit more complicated here because the result has
to play well with the remaining hunks of the overall diff. Therefore,
we have to do a loop in which we let the user edit the hunk, then test
whether the result would work, and if not, drop the edits and let the
user decide whether to try editing the hunk again.

Note: in contrast to the Perl version, we use the same diff
"coalescing" (i.e. merging overlapping hunks into a single one) also for
the check after editing, and we introduce a new flag for that purpose
that asks the `reassemble_patch()` function to pretend that all hunks
were selected for use.

This allows us to continue to run `git apply` *without* the
`--allow-overlap` option (unlike the Perl version), and it also fixes
two known breakages in `t3701-add-interactive.sh` (which we cannot mark
as resolved so far because the Perl script version is still the default
and continues to have those breakages).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c |   6 +
 add-interactive.h |   3 +
 add-patch.c       | 333 +++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 325 insertions(+), 17 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 29356c5aa2..6a5048c83e 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -46,6 +46,12 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 	init_color(r, s, "reset", s->reset_color, GIT_COLOR_RESET);
 	init_color(r, s, "fraginfo", s->fraginfo_color,
 		   diff_get_color(s->use_color, DIFF_FRAGINFO));
+	init_color(r, s, "context", s->context_color,
+		diff_get_color(s->use_color, DIFF_CONTEXT));
+	init_color(r, s, "old", s->file_old_color,
+		diff_get_color(s->use_color, DIFF_FILE_OLD));
+	init_color(r, s, "new", s->file_new_color,
+		diff_get_color(s->use_color, DIFF_FILE_NEW));
 }
 
 /*
diff --git a/add-interactive.h b/add-interactive.h
index 584f304a9a..062dc3646c 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -12,6 +12,9 @@ struct add_i_state {
 	char error_color[COLOR_MAXLEN];
 	char reset_color[COLOR_MAXLEN];
 	char fraginfo_color[COLOR_MAXLEN];
+	char context_color[COLOR_MAXLEN];
+	char file_old_color[COLOR_MAXLEN];
+	char file_new_color[COLOR_MAXLEN];
 };
 
 void init_add_i_state(struct add_i_state *s, struct repository *r);
diff --git a/add-patch.c b/add-patch.c
index c8d84aec68..ea863ca09d 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -29,6 +29,7 @@ struct hunk_header {
 
 struct hunk {
 	size_t start, end, colored_start, colored_end, splittable_into;
+	ssize_t delta;
 	enum { UNDECIDED_HUNK = 0, SKIP_HUNK, USE_HUNK } use;
 	struct hunk_header header;
 };
@@ -435,14 +436,14 @@ static void render_diff_header(struct add_p_state *s,
 
 /* Coalesce hunks again that were split */
 static int merge_hunks(struct add_p_state *s, struct file_diff *file_diff,
-		       size_t *hunk_index, struct hunk *merged)
+		       size_t *hunk_index, int use_all, struct hunk *merged)
 {
-	size_t i = *hunk_index;
+	size_t i = *hunk_index, delta;
 	struct hunk *hunk = file_diff->hunk + i;
 	/* `header` corresponds to the merged hunk */
 	struct hunk_header *header = &merged->header, *next;
 
-	if (hunk->use != USE_HUNK)
+	if (!use_all && hunk->use != USE_HUNK)
 		return 0;
 
 	*merged = *hunk;
@@ -459,20 +460,99 @@ static int merge_hunks(struct add_p_state *s, struct file_diff *file_diff,
 		 * - the hunk is not selected for use, or
 		 * - the hunk does not overlap with the already-merged hunk(s)
 		 */
-		if (hunk->use != USE_HUNK ||
-		    header->new_offset >= next->new_offset ||
-		    header->new_offset + header->new_count < next->new_offset ||
-		    merged->start >= hunk->start ||
-		    merged->end < hunk->start)
+		if ((!use_all && hunk->use != USE_HUNK) ||
+		    header->new_offset >= next->new_offset + merged->delta ||
+		    header->new_offset + header->new_count
+		    < next->new_offset + merged->delta)
 			break;
 
-		merged->end = hunk->end;
-		merged->colored_end = hunk->colored_end;
+		/*
+		 * If the hunks were not edited, and overlap, we can simply
+		 * extend the line range.
+		 */
+		if (merged->start < hunk->start && merged->end > hunk->start) {
+			merged->end = hunk->end;
+			merged->colored_end = hunk->colored_end;
+			delta = 0;
+		} else {
+			const char *plain = s->plain.buf;
+			size_t  overlapping_line_count = header->new_offset
+				+ header->new_count - merged->delta
+				- next->new_offset;
+			size_t overlap_end = hunk->start;
+			size_t overlap_start = overlap_end;
+			size_t overlap_next, len, j;
+
+			/*
+			 * One of the hunks was edited: the modified hunk was
+			 * appended to the strbuf `s->plain`.
+			 *
+			 * Let's ensure that at least the last context line of
+			 * the first hunk overlaps with the corresponding line
+			 * of the second hunk, and then merge.
+			 */
+			for (j = 0; j < overlapping_line_count; j++) {
+				overlap_next = find_next_line(&s->plain,
+							      overlap_end);
+
+				if (overlap_next > hunk->end)
+					BUG("failed to find %d context lines "
+					    "in:\n%.*s",
+					    (int)overlapping_line_count,
+					    (int)(hunk->end - hunk->start),
+					    plain + hunk->start);
+
+				if (plain[overlap_end] != ' ')
+					return error(_("expected context line "
+						       "#%d in\n%.*s"),
+						     (int)(j + 1),
+						     (int)(hunk->end
+							   - hunk->start),
+						     plain + hunk->start);
+
+				overlap_start = overlap_end;
+				overlap_end = overlap_next;
+			}
+			len = overlap_end - overlap_start;
+
+			if (len > merged->end - merged->start ||
+			    memcmp(plain + merged->end - len,
+				   plain + overlap_start, len))
+				return error(_("hunks do not overlap:\n%.*s\n"
+					       "\tdoes not end with:\n%.*s"),
+					     (int)(merged->end - merged->start),
+					     plain + merged->start,
+					     (int)len, plain + overlap_start);
+
+			/*
+			 * Since the start-end ranges are not adjacent, we
+			 * cannot simply take the union of the ranges. To
+			 * address that, we temporarily append the union of the
+			 * lines to the `plain` strbuf.
+			 */
+			if (merged->end != s->plain.len) {
+				size_t start = s->plain.len;
+
+				strbuf_add(&s->plain, plain + merged->start,
+					   merged->end - merged->start);
+				plain = s->plain.buf;
+				merged->start = start;
+				merged->end = s->plain.len;
+			}
+
+			strbuf_add(&s->plain,
+				   plain + overlap_end,
+				   hunk->end - overlap_end);
+			merged->end = s->plain.len;
+			merged->splittable_into += hunk->splittable_into;
+			delta = merged->delta;
+			merged->delta += hunk->delta;
+		}
 
 		header->old_count = next->old_offset + next->old_count
 			- header->old_offset;
-		header->new_count = next->new_offset + next->new_count
-			- header->new_offset;
+		header->new_count = next->new_offset + delta
+			+ next->new_count - header->new_offset;
 	}
 
 	if (i == *hunk_index)
@@ -483,10 +563,11 @@ static int merge_hunks(struct add_p_state *s, struct file_diff *file_diff,
 }
 
 static void reassemble_patch(struct add_p_state *s,
-			     struct file_diff *file_diff, struct strbuf *out)
+			     struct file_diff *file_diff, int use_all,
+			     struct strbuf *out)
 {
 	struct hunk *hunk;
-	size_t i;
+	size_t save_len = s->plain.len, i;
 	ssize_t delta = 0;
 
 	render_diff_header(s, file_diff, 0, out);
@@ -495,15 +576,24 @@ static void reassemble_patch(struct add_p_state *s,
 		struct hunk merged = { 0 };
 
 		hunk = file_diff->hunk + i;
-		if (hunk->use != USE_HUNK)
+		if (!use_all && hunk->use != USE_HUNK)
 			delta += hunk->header.old_count
 				- hunk->header.new_count;
 		else {
 			/* merge overlapping hunks into a temporary hunk */
-			if (merge_hunks(s, file_diff, &i, &merged))
+			if (merge_hunks(s, file_diff, &i, use_all, &merged))
 				hunk = &merged;
 
 			render_hunk(s, hunk, delta, 0, out);
+
+			/*
+			 * In case `merge_hunks()` used `plain` as a scratch
+			 * pad (this happens when an edited hunk had to be
+			 * coalesced with another hunk).
+			 */
+			strbuf_setlen(&s->plain, save_len);
+
+			delta += hunk->delta;
 		}
 	}
 }
@@ -667,6 +757,204 @@ static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
 	return 0;
 }
 
+static void recolor_hunk(struct add_p_state *s, struct hunk *hunk)
+{
+	const char *plain = s->plain.buf;
+	size_t current, eol, next;
+
+	if (!s->colored.len)
+		return;
+
+	hunk->colored_start = s->colored.len;
+	for (current = hunk->start; current < hunk->end; ) {
+		for (eol = current; eol < hunk->end; eol++)
+			if (plain[eol] == '\n')
+				break;
+		next = eol + (eol < hunk->end);
+		if (eol > current && plain[eol - 1] == '\r')
+			eol--;
+
+		strbuf_addstr(&s->colored,
+			      plain[current] == '-' ?
+			      s->s.file_old_color :
+			      plain[current] == '+' ?
+			      s->s.file_new_color :
+			      s->s.context_color);
+		strbuf_add(&s->colored, plain + current, eol - current);
+		strbuf_addstr(&s->colored, GIT_COLOR_RESET);
+		if (next > eol)
+			strbuf_add(&s->colored, plain + eol, next - eol);
+		current = next;
+	}
+	hunk->colored_end = s->colored.len;
+}
+
+static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
+{
+	size_t i;
+
+	strbuf_reset(&s->buf);
+	strbuf_commented_addf(&s->buf, _("Manual hunk edit mode -- see bottom for "
+				      "a quick guide.\n"));
+	render_hunk(s, hunk, 0, 0, &s->buf);
+	strbuf_commented_addf(&s->buf,
+			      _("---\n"
+				"To remove '%c' lines, make them ' ' lines "
+				"(context).\n"
+				"To remove '%c' lines, delete them.\n"
+				"Lines starting with %c will be removed.\n"),
+			      '-', '+', comment_line_char);
+	strbuf_commented_addf(&s->buf,
+			      _("If the patch applies cleanly, the edited hunk "
+				"will immediately be\n"
+				"marked for staging.\n"));
+	/*
+	 * TRANSLATORS: 'it' refers to the patch mentioned in the previous
+	 * messages.
+	 */
+	strbuf_commented_addf(&s->buf,
+			      _("If it does not apply cleanly, you will be "
+				"given an opportunity to\n"
+				"edit again.  If all lines of the hunk are "
+				"removed, then the edit is\n"
+				"aborted and the hunk is left unchanged.\n"));
+
+	if (strbuf_edit_interactively(&s->buf, "addp-hunk-edit.diff", NULL) < 0)
+		return -1;
+
+	/* strip out commented lines */
+	hunk->start = s->plain.len;
+	for (i = 0; i < s->buf.len; ) {
+		size_t next = find_next_line(&s->buf, i);
+
+		if (s->buf.buf[i] != comment_line_char)
+			strbuf_add(&s->plain, s->buf.buf + i, next - i);
+		i = next;
+	}
+
+	hunk->end = s->plain.len;
+	if (hunk->end == hunk->start)
+		/* The user aborted editing by deleting everything */
+		return 0;
+
+	recolor_hunk(s, hunk);
+
+	/*
+	 * If the hunk header is intact, parse it, otherwise simply use the
+	 * hunk header prior to editing (which will adjust `hunk->start` to
+	 * skip the hunk header).
+	 */
+	if (s->plain.buf[hunk->start] == '@' &&
+	    parse_hunk_header(s, hunk) < 0)
+		return error(_("could not parse hunk header"));
+
+	return 1;
+}
+
+static ssize_t recount_edited_hunk(struct add_p_state *s, struct hunk *hunk,
+				   size_t orig_old_count, size_t orig_new_count)
+{
+	struct hunk_header *header = &hunk->header;
+	size_t i;
+
+	header->old_count = header->new_count = 0;
+	for (i = hunk->start; i < hunk->end; ) {
+		switch (s->plain.buf[i]) {
+		case '-':
+			header->old_count++;
+			break;
+		case '+':
+			header->new_count++;
+			break;
+		case ' ': case '\r': case '\n':
+			header->old_count++;
+			header->new_count++;
+			break;
+		}
+
+		i = find_next_line(&s->plain, i);
+	}
+
+	return orig_old_count - orig_new_count
+		- header->old_count + header->new_count;
+}
+
+static int run_apply_check(struct add_p_state *s,
+			   struct file_diff *file_diff)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	strbuf_reset(&s->buf);
+	reassemble_patch(s, file_diff, 1, &s->buf);
+
+	setup_child_process(s, &cp,
+			    "apply", "--cached", "--check", NULL);
+	if (pipe_command(&cp, s->buf.buf, s->buf.len, NULL, 0, NULL, 0))
+		return error(_("'git apply --cached' failed"));
+
+	return 0;
+}
+
+static int prompt_yesno(struct add_p_state *s, const char *prompt)
+{
+	for (;;) {
+		color_fprintf(stdout, s->s.prompt_color, "%s", _(prompt));
+		fflush(stdout);
+		if (strbuf_getline(&s->answer, stdin) == EOF)
+			return -1;
+		strbuf_trim_trailing_newline(&s->answer);
+		switch (tolower(s->answer.buf[0])) {
+		case 'n': return 0;
+		case 'y': return 1;
+		}
+	}
+}
+
+static int edit_hunk_loop(struct add_p_state *s,
+			  struct file_diff *file_diff, struct hunk *hunk)
+{
+	size_t plain_len = s->plain.len, colored_len = s->colored.len;
+	struct hunk backup;
+
+	backup = *hunk;
+
+	for (;;) {
+		int res = edit_hunk_manually(s, hunk);
+		if (res == 0) {
+			/* abandonded */
+			*hunk = backup;
+			return -1;
+		}
+
+		if (res > 0) {
+			hunk->delta +=
+				recount_edited_hunk(s, hunk,
+						    backup.header.old_count,
+						    backup.header.new_count);
+			if (!run_apply_check(s, file_diff))
+				return 0;
+		}
+
+		/* Drop edits (they were appended to s->plain) */
+		strbuf_setlen(&s->plain, plain_len);
+		strbuf_setlen(&s->colored, colored_len);
+		*hunk = backup;
+
+		/*
+		 * TRANSLATORS: do not translate [y/n]
+		 * The program will only accept that input at this point.
+		 * Consider translating (saying "no" discards!) as
+		 * (saying "n" for "no" discards!) if the translation
+		 * of the word "no" does not start with n.
+		 */
+		res = prompt_yesno(s, _("Your edited hunk does not apply. "
+					"Edit again (saying \"no\" discards!) "
+					"[y/n]? "));
+		if (res < 1)
+			return -1;
+	}
+}
+
 static const char help_patch_text[] =
 N_("y - stage this hunk\n"
    "n - do not stage this hunk\n"
@@ -677,6 +965,7 @@ N_("y - stage this hunk\n"
    "k - leave this hunk undecided, see previous undecided hunk\n"
    "K - leave this hunk undecided, see previous hunk\n"
    "s - split the current hunk into smaller hunks\n"
+   "e - manually edit the current hunk\n"
    "? - print help\n");
 
 static int patch_update_file(struct add_p_state *s,
@@ -735,6 +1024,9 @@ static int patch_update_file(struct add_p_state *s,
 			strbuf_addstr(&s->buf, ",J");
 		if (hunk->splittable_into > 1)
 			strbuf_addstr(&s->buf, ",s");
+		if (hunk_index + 1 > file_diff->mode_change &&
+		    !file_diff->deleted)
+			strbuf_addstr(&s->buf, ",e");
 
 		if (file_diff->deleted)
 			prompt_mode_type = PROMPT_DELETION;
@@ -806,6 +1098,13 @@ static int patch_update_file(struct add_p_state *s,
 				color_fprintf_ln(stdout, s->s.header_color,
 						 _("Split into %d hunks."),
 						 (int)splittable_into);
+		} else if (s->answer.buf[0] == 'e') {
+			if (hunk_index + 1 == file_diff->mode_change)
+				err(s, _("Sorry, cannot edit this hunk"));
+			else if (edit_hunk_loop(s, file_diff, hunk) >= 0) {
+				hunk->use = USE_HUNK;
+				goto soft_increment;
+			}
 		} else
 			color_fprintf(stdout, s->s.help_color,
 				      _(help_patch_text));
@@ -819,7 +1118,7 @@ static int patch_update_file(struct add_p_state *s,
 	if (i < file_diff->hunk_nr) {
 		/* At least one hunk selected: apply */
 		strbuf_reset(&s->buf);
-		reassemble_patch(s, file_diff, &s->buf);
+		reassemble_patch(s, file_diff, 0, &s->buf);
 
 		discard_index(s->s.r->index);
 		setup_child_process(s, &cp, "apply", "--cached", NULL);
-- 
gitgitgadget

