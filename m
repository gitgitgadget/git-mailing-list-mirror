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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1BCC2D0CB
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BA822527
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLYnWps/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfLMII2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:08:28 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:35532 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfLMIIU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 03:08:20 -0500
Received: by mail-wr1-f48.google.com with SMTP id g17so5618363wro.2
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 00:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=39e6o6WIMT5n4pTJWFwh4ccy+MRiSfyrnLdNUVcDxOM=;
        b=sLYnWps/TMPEvceTn+Co3NLGjZFIkRMsrQk7GaRQhjjQKeNKoFgbPDnujdlUnb9A3U
         9aH8S7znkznFCYkK5ANMeIbYtqi4FjOvgDyaoItId6t4MJLinw+jpzvNCpogIGala2ns
         MN+HbSzYAKFnB+fn0hk9IQu2HpUP/i0/txUnCBQNi5rTaG6DQbv0Y9N455eaXAA4UJqd
         doOG5bjxyFviH0K48UZpGm+UuRgwKU8fJV4TGVEJr+wQaIgQcHhDWsIbx0K5YtxLHr0l
         6uPA9FnE8+XFoWJ0jHCtW9/gMyqu1Ejms39S+rmYsbwfuaCUru7/ZXThNbJsuVwIm6PZ
         WFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=39e6o6WIMT5n4pTJWFwh4ccy+MRiSfyrnLdNUVcDxOM=;
        b=uiC7pFtPKoCvj4ALrci/2bV9LWSyIp6FDyLLu7gtc691EIBeeMPpkSXUQrEcVVys+E
         ZZJ8hyM8DbYPnxslym0uIEo79dUNacDxs6jrTctxNg03sKtkvGu/h0vCQ2gu5NJ6ZDQ+
         sj7l0dOVuqAJiE5BXnnWQANH78AViRsY56l37tKXq3KpgECl/VMKzqSKDqmY2D1eCTde
         9YIA670Iv1YoW/eLpsyCNKh1e0fZWQNQTAQ2+U9QeSVewJ6iYeJEBtVXZzaiqaQN3Yvf
         ahbvmhCLU/LIXAAUiJOjiandpvQqQRvLQwor6ZVuzzHS5WjpZsgmayrd7HivPSGzes+Q
         A2pg==
X-Gm-Message-State: APjAAAVl6XFaUGdlzZb/XV+og3cu5XmXu3CTynF+EtHxwuT/xhd2vPKU
        2uZZq/y33kI9zxaPmX1u3b8cYSXQ
X-Google-Smtp-Source: APXvYqzyj3ZD1AdonIAW1DsbOvJXMmvpL45yqynIwgk+GwVu4KHbhV3qlFbft5lK6FqgLeMAnLIiXg==
X-Received: by 2002:adf:e3d0:: with SMTP id k16mr11407388wrm.241.1576224496673;
        Fri, 13 Dec 2019 00:08:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k13sm9197603wrx.59.2019.12.13.00.08.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 00:08:16 -0800 (PST)
Message-Id: <2cd9855fffe97ce31640dfa5ed22bffa98047403.1576224486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.173.git.1576224486.gitgitgadget@gmail.com>
References: <pull.173.git.1576224486.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 08:07:58 +0000
Subject: [PATCH 11/19] built-in add -p: implement the hunk splitting feature
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

If this developer's workflow is any indication, then this is *the* most
useful feature of Git's interactive `add `command.

Note: once again, this is not a verbatim conversion from the Perl code
to C: the `hunk_splittable()` function, for example, essentially did all
the work of splitting the hunk, just to find out whether more than one
hunk would have been the result (and then tossed that result into the
trash). In C we instead count the number of resulting hunks (without
actually doing the work of splitting, but just counting the transitions
from non-context lines to context lines), and store that information
with the hunk, and we do that *while* parsing the diff in the first
place.

Another deviation: the built-in `git add -p` was designed with a single
strbuf holding the diff (and another one holding the colored diff, if
that one was asked for) in mind, and hunks essentially store just the
start and end offsets pointing into that strbuf. As a consequence, when
we split hunks, we now use a special mode where the hunk header is
generated dynamically, and only the rest of the hunk is stored using
such start/end offsets. This way, we also avoid the frequent
formatting/re-parsing of the hunk header of the Perl version.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c                | 215 ++++++++++++++++++++++++++++++++++++-
 t/t3701-add-interactive.sh |  12 +++
 2 files changed, 225 insertions(+), 2 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 171025b08d..2d34ddd7f4 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -28,7 +28,7 @@ struct hunk_header {
 };
 
 struct hunk {
-	size_t start, end, colored_start, colored_end;
+	size_t start, end, colored_start, colored_end, splittable_into;
 	enum { UNDECIDED_HUNK = 0, SKIP_HUNK, USE_HUNK } use;
 	struct hunk_header header;
 };
@@ -155,7 +155,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	struct argv_array args = ARGV_ARRAY_INIT;
 	struct strbuf *plain = &s->plain, *colored = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
-	char *p, *pend, *colored_p = NULL, *colored_pend = NULL;
+	char *p, *pend, *colored_p = NULL, *colored_pend = NULL, marker = '\0';
 	size_t file_diff_alloc = 0, i, color_arg_index;
 	struct file_diff *file_diff = NULL;
 	struct hunk *hunk = NULL;
@@ -217,6 +217,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 			hunk->start = p - plain->buf;
 			if (colored_p)
 				hunk->colored_start = colored_p - colored->buf;
+			marker = '\0';
 		} else if (p == plain->buf)
 			BUG("diff starts with unexpected line:\n"
 			    "%.*s\n", (int)(eol - p), p);
@@ -225,6 +226,13 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 		else if (starts_with(p, "@@ ") ||
 			 (hunk == &file_diff->head &&
 			  skip_prefix(p, "deleted file", &deleted))) {
+			if (marker == '-' || marker == '+')
+				/*
+				 * Should not happen; previous hunk did not end
+				 * in a context line? Handle it anyway.
+				 */
+				hunk->splittable_into++;
+
 			file_diff->hunk_nr++;
 			ALLOC_GROW(file_diff->hunk, file_diff->hunk_nr,
 				   file_diff->hunk_alloc);
@@ -239,6 +247,12 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 				file_diff->deleted = 1;
 			else if (parse_hunk_header(s, hunk) < 0)
 				return -1;
+
+			/*
+			 * Start counting into how many hunks this one can be
+			 * split
+			 */
+			marker = *p;
 		} else if (hunk == &file_diff->head &&
 			   skip_prefix(p, "old mode ", &mode_change) &&
 			   is_octal(mode_change, eol - mode_change)) {
@@ -286,6 +300,11 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 			    (int)(eol - (plain->buf + file_diff->head.start)),
 			    plain->buf + file_diff->head.start);
 
+		if ((marker == '-' || marker == '+') && *p == ' ')
+			hunk->splittable_into++;
+		if (marker && *p != '\\')
+			marker = *p;
+
 		p = eol == pend ? pend : eol + 1;
 		hunk->end = p - plain->buf;
 
@@ -311,9 +330,30 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 		}
 	}
 
+	if (marker == '-' || marker == '+')
+		/*
+		 * Last hunk ended in non-context line (i.e. it appended lines
+		 * to the file, so there are no trailing context lines).
+		 */
+		hunk->splittable_into++;
+
 	return 0;
 }
 
+static size_t find_next_line(struct strbuf *sb, size_t offset)
+{
+	char *eol;
+
+	if (offset >= sb->len)
+		BUG("looking for next line beyond buffer (%d >= %d)\n%s",
+		    (int)offset, (int)sb->len, sb->buf);
+
+	eol = memchr(sb->buf + offset, '\n', sb->len - offset);
+	if (!eol)
+		return sb->len;
+	return eol - sb->buf + 1;
+}
+
 static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 			ssize_t delta, int colored, struct strbuf *out)
 {
@@ -412,6 +452,165 @@ static void reassemble_patch(struct add_p_state *s,
 	}
 }
 
+static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
+		       size_t hunk_index)
+{
+	int colored = !!s->colored.len, first = 1;
+	struct hunk *hunk = file_diff->hunk + hunk_index;
+	size_t splittable_into;
+	size_t end, colored_end, current, colored_current = 0, context_line_count;
+	struct hunk_header remaining, *header;
+	char marker, ch;
+
+	if (hunk_index >= file_diff->hunk_nr)
+		BUG("invalid hunk index: %d (must be >= 0 and < %d)",
+		    (int)hunk_index, (int)file_diff->hunk_nr);
+
+	if (hunk->splittable_into < 2)
+		return 0;
+	splittable_into = hunk->splittable_into;
+
+	end = hunk->end;
+	colored_end = hunk->colored_end;
+
+	remaining = hunk->header;
+
+	file_diff->hunk_nr += splittable_into - 1;
+	ALLOC_GROW(file_diff->hunk, file_diff->hunk_nr, file_diff->hunk_alloc);
+	if (hunk_index + splittable_into < file_diff->hunk_nr)
+		memmove(file_diff->hunk + hunk_index + splittable_into,
+			file_diff->hunk + hunk_index + 1,
+			(file_diff->hunk_nr - hunk_index - splittable_into)
+			* sizeof(*hunk));
+	hunk = file_diff->hunk + hunk_index;
+	hunk->splittable_into = 1;
+	memset(hunk + 1, 0, (splittable_into - 1) * sizeof(*hunk));
+
+	header = &hunk->header;
+	header->old_count = header->new_count = 0;
+
+	current = hunk->start;
+	if (colored)
+		colored_current = hunk->colored_start;
+	marker = '\0';
+	context_line_count = 0;
+
+	while (splittable_into > 1) {
+		ch = s->plain.buf[current];
+
+		if (!ch)
+			BUG("buffer overrun while splitting hunks");
+
+		/*
+		 * Is this the first context line after a chain of +/- lines?
+		 * Then record the start of the next split hunk.
+		 */
+		if ((marker == '-' || marker == '+') && ch == ' ') {
+			first = 0;
+			hunk[1].start = current;
+			if (colored)
+				hunk[1].colored_start = colored_current;
+			context_line_count = 0;
+		}
+
+		/*
+		 * Was the previous line a +/- one? Alternatively, is this the
+		 * first line (and not a +/- one)?
+		 *
+		 * Then just increment the appropriate counter and continue
+		 * with the next line.
+		 */
+		if (marker != ' ' || (ch != '-' && ch != '+')) {
+next_hunk_line:
+			/* Comment lines are attached to the previous line */
+			if (ch == '\\')
+				ch = marker ? marker : ' ';
+
+			/* current hunk not done yet */
+			if (ch == ' ')
+				context_line_count++;
+			else if (ch == '-')
+				header->old_count++;
+			else if (ch == '+')
+				header->new_count++;
+			else
+				BUG("unhandled diff marker: '%c'", ch);
+			marker = ch;
+			current = find_next_line(&s->plain, current);
+			if (colored)
+				colored_current =
+					find_next_line(&s->colored,
+						       colored_current);
+			continue;
+		}
+
+		/*
+		 * We got us the start of a new hunk!
+		 *
+		 * This is a context line, so it is shared with the previous
+		 * hunk, if any.
+		 */
+
+		if (first) {
+			if (header->old_count || header->new_count)
+				BUG("counts are off: %d/%d",
+				    (int)header->old_count,
+				    (int)header->new_count);
+
+			header->old_count = context_line_count;
+			header->new_count = context_line_count;
+			context_line_count = 0;
+			first = 0;
+			goto next_hunk_line;
+		}
+
+		remaining.old_offset += header->old_count;
+		remaining.old_count -= header->old_count;
+		remaining.new_offset += header->new_count;
+		remaining.new_count -= header->new_count;
+
+		/* initialize next hunk header's offsets */
+		hunk[1].header.old_offset =
+			header->old_offset + header->old_count;
+		hunk[1].header.new_offset =
+			header->new_offset + header->new_count;
+
+		/* add one split hunk */
+		header->old_count += context_line_count;
+		header->new_count += context_line_count;
+
+		hunk->end = current;
+		if (colored)
+			hunk->colored_end = colored_current;
+
+		hunk++;
+		hunk->splittable_into = 1;
+		hunk->use = hunk[-1].use;
+		header = &hunk->header;
+
+		header->old_count = header->new_count = context_line_count;
+		context_line_count = 0;
+
+		splittable_into--;
+		marker = ch;
+	}
+
+	/* last hunk simply gets the rest */
+	if (header->old_offset != remaining.old_offset)
+		BUG("miscounted old_offset: %lu != %lu",
+		    header->old_offset, remaining.old_offset);
+	if (header->new_offset != remaining.new_offset)
+		BUG("miscounted new_offset: %lu != %lu",
+		    header->new_offset, remaining.new_offset);
+	header->old_count = remaining.old_count;
+	header->new_count = remaining.new_count;
+	hunk->end = end;
+	if (colored)
+		hunk->colored_end = colored_end;
+
+	return 0;
+}
+
 static const char help_patch_text[] =
 N_("y - stage this hunk\n"
    "n - do not stage this hunk\n"
@@ -421,6 +620,7 @@ N_("y - stage this hunk\n"
    "J - leave this hunk undecided, see next hunk\n"
    "k - leave this hunk undecided, see previous undecided hunk\n"
    "K - leave this hunk undecided, see previous hunk\n"
+   "s - split the current hunk into smaller hunks\n"
    "? - print help\n");
 
 static int patch_update_file(struct add_p_state *s,
@@ -477,6 +677,8 @@ static int patch_update_file(struct add_p_state *s,
 			strbuf_addstr(&s->buf, ",j");
 		if (hunk_index + 1 < file_diff->hunk_nr)
 			strbuf_addstr(&s->buf, ",J");
+		if (hunk->splittable_into > 1)
+			strbuf_addstr(&s->buf, ",s");
 
 		if (file_diff->deleted)
 			prompt_mode_type = PROMPT_DELETION;
@@ -539,6 +741,15 @@ static int patch_update_file(struct add_p_state *s,
 				hunk_index = undecided_next;
 			else
 				err(s, _("No next hunk"));
+		} else if (s->answer.buf[0] == 's') {
+			size_t splittable_into = hunk->splittable_into;
+			if (splittable_into < 2)
+				err(s, _("Sorry, cannot split this hunk"));
+			else if (!split_hunk(s, file_diff,
+					     hunk - file_diff->hunk))
+				color_fprintf_ln(stdout, s->s.header_color,
+						 _("Split into %d hunks."),
+						 (int)splittable_into);
 		} else
 			color_fprintf(stdout, s->s.help_color,
 				      _(help_patch_text));
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 5db6432e33..fe383be50e 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -442,6 +442,18 @@ test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
 	! grep "^+31" actual
 '
 
+test_expect_success 'split hunk with incomplete line at end' '
+	git reset --hard &&
+	printf "missing LF" >>test &&
+	git add test &&
+	test_write_lines before 10 20 30 40 50 60 70 >test &&
+	git grep --cached missing &&
+	test_write_lines s n y q | git add -p &&
+	test_must_fail git grep --cached missing &&
+	git grep before &&
+	test_must_fail git grep --cached before
+'
+
 test_expect_failure 'edit, adding lines to the first hunk' '
 	test_write_lines 10 11 20 30 40 50 51 60 >test &&
 	git reset &&
-- 
gitgitgadget

