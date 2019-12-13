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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EFFC2D0CE
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EEFE24658
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJLMFOye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfLMIIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:08:22 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42081 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfLMIIS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 03:08:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id q6so5566642wro.9
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 00:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qXuPaAPMgSHBDfzvUw3jAPvhvc003sVj6D1eanc8WVI=;
        b=CJLMFOyeWE0+PxbLFWvRN6kUwxmVVQzikbrz4tteqScaNR6smqDzYyD8qhy8ExHRzn
         snc7W8l214A0ckd4KGM/Hqi0qN+9bdmYQpXSa6Y9lixmFXov8lRwgE+FL4RPk55SuonW
         yNc/XQkZREC9FA0GsfR/CQ6xeTw5Ck4FSZRx2V5xUI/Grq4yvTLQFqAKcx0U0tGV6URa
         uk0O3gnBfqe9d9kzVa0s1OQatjG8osoorteqVjspJE7EnlkQQwc7FN8GrsKaziWUKdbv
         bTNpAHCp4luTRXD0mCjBTd5JQ9GbmIkT5Qv6KY78ofDsdz2RAdhSMWcpRDyADn4wmuF+
         7gEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qXuPaAPMgSHBDfzvUw3jAPvhvc003sVj6D1eanc8WVI=;
        b=KVqqTrnFLyqR+OvQLb0KAcQyLodT3pOF5W1pCmyle9h65Gge15rRlKDYSxOPgq2sfg
         8JAXdk/mhgy9Zl6LHBcCICPHxyLiRy/HKCTZF0sq7MhMy2Jb2jJDDQ4dhBIjUgFpAmxd
         WE1XlTUaOtaKuOJfhpqhpWIQG+l1opggM/TgnpjmTyZq8VLfCRV7iW9xMMvCleC1oGoZ
         33BVDnikLH3XvCREg1gz9xAxUr10ZCWzkipKiTklpEswH29qBqvahxXoyuZxzfyAoFot
         b7jhV9tBhn/C+B/H8dqhS6ar713OJf8O20tla/1zLQ81Sm2QRkeuD8tweRvo6o6cIncG
         tyOQ==
X-Gm-Message-State: APjAAAWNueWFclAT9GuxmJpbKktH0QNgeFK7DHanCyxpzmAPeXPrppy6
        2Gbv+Lp9kichzpJQjMZRlew6KEx/
X-Google-Smtp-Source: APXvYqyE6nOhFEnWRHYnntPBZae/WUrkKEEUcFfExbCjb4BmOV0MqWoF9tgQ/3kMdRsbtg10NzBQFA==
X-Received: by 2002:adf:d184:: with SMTP id v4mr11192984wrc.76.1576224495327;
        Fri, 13 Dec 2019 00:08:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s15sm8980480wrp.4.2019.12.13.00.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 00:08:14 -0800 (PST)
Message-Id: <a3624d720fa6aa77a3ef0f34618f27c417526fe7.1576224486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.173.git.1576224486.gitgitgadget@gmail.com>
References: <pull.173.git.1576224486.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 08:07:56 +0000
Subject: [PATCH 09/19] built-in app -p: allow selecting a mode change as a
 "hunk"
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

This imitates the way the Perl version treats mode changes: it offers
the mode change up for the user to decide, as if it was a diff hunk.

In contrast to the Perl version, we make use of the fact that the mode
line is the first hunk, and explicitly strip out that line from the diff
header if that "hunk" was not selected to be applied, and skipping that
hunk while coalescing the diff. The Perl version plays some kind of diff
line lego instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 104 insertions(+), 5 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index c32541f46d..2007f55e04 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -33,7 +33,7 @@ struct add_p_state {
 		struct hunk head;
 		struct hunk *hunk;
 		size_t hunk_nr, hunk_alloc;
-		unsigned deleted:1;
+		unsigned deleted:1, mode_change:1;
 	} *file_diff;
 	size_t file_diff_nr;
 };
@@ -129,6 +129,17 @@ static int parse_hunk_header(struct add_p_state *s, struct hunk *hunk)
 	return 0;
 }
 
+static int is_octal(const char *p, size_t len)
+{
+	if (!len)
+		return 0;
+
+	while (len--)
+		if (*p < '0' || *(p++) > '7')
+			return 0;
+	return 1;
+}
+
 static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 {
 	struct argv_array args = ARGV_ARRAY_INIT;
@@ -181,7 +192,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	pend = p + plain->len;
 	while (p != pend) {
 		char *eol = memchr(p, '\n', pend - p);
-		const char *deleted = NULL;
+		const char *deleted = NULL, *mode_change = NULL;
 
 		if (!eol)
 			eol = pend;
@@ -218,8 +229,53 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 				file_diff->deleted = 1;
 			else if (parse_hunk_header(s, hunk) < 0)
 				return -1;
+		} else if (hunk == &file_diff->head &&
+			   skip_prefix(p, "old mode ", &mode_change) &&
+			   is_octal(mode_change, eol - mode_change)) {
+			if (file_diff->mode_change)
+				BUG("double mode change?\n\n%.*s",
+				    (int)(eol - plain->buf), plain->buf);
+			if (file_diff->hunk_nr++)
+				BUG("mode change in the middle?\n\n%.*s",
+				    (int)(eol - plain->buf), plain->buf);
+
+			/*
+			 * Do *not* change `hunk`: the mode change pseudo-hunk
+			 * is _part of_ the header "hunk".
+			 */
+			file_diff->mode_change = 1;
+			ALLOC_GROW(file_diff->hunk, file_diff->hunk_nr,
+				   file_diff->hunk_alloc);
+			memset(file_diff->hunk, 0, sizeof(struct hunk));
+			file_diff->hunk->start = p - plain->buf;
+			if (colored_p)
+				file_diff->hunk->colored_start =
+					colored_p - colored->buf;
+		} else if (hunk == &file_diff->head &&
+			   skip_prefix(p, "new mode ", &mode_change) &&
+			   is_octal(mode_change, eol - mode_change)) {
+
+			/*
+			 * Extend the "mode change" pseudo-hunk to include also
+			 * the "new mode" line.
+			 */
+			if (!file_diff->mode_change)
+				BUG("'new mode' without 'old mode'?\n\n%.*s",
+				    (int)(eol - plain->buf), plain->buf);
+			if (file_diff->hunk_nr != 1)
+				BUG("mode change in the middle?\n\n%.*s",
+				    (int)(eol - plain->buf), plain->buf);
+			if (p - plain->buf != file_diff->hunk->end)
+				BUG("'new mode' does not immediately follow "
+				    "'old mode'?\n\n%.*s",
+				    (int)(eol - plain->buf), plain->buf);
 		}
 
+		if (file_diff->deleted && file_diff->mode_change)
+			BUG("diff contains delete *and* a mode change?!?\n%.*s",
+			    (int)(eol - (plain->buf + file_diff->head.start)),
+			    plain->buf + file_diff->head.start);
+
 		p = eol == pend ? pend : eol + 1;
 		hunk->end = p - plain->buf;
 
@@ -233,6 +289,16 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 
 			hunk->colored_end = colored_p - colored->buf;
 		}
+
+		if (mode_change) {
+			if (file_diff->hunk_nr != 1)
+				BUG("mode change in hunk #%d???",
+				    (int)file_diff->hunk_nr);
+			/* Adjust the end of the "mode change" pseudo-hunk */
+			file_diff->hunk->end = hunk->end;
+			if (colored)
+				file_diff->hunk->colored_end = hunk->colored_end;
+		}
 	}
 
 	return 0;
@@ -284,6 +350,39 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 			   hunk->end - hunk->start);
 }
 
+static void render_diff_header(struct add_p_state *s,
+			       struct file_diff *file_diff, int colored,
+			       struct strbuf *out)
+{
+	/*
+	 * If there was a mode change, the first hunk is a pseudo hunk that
+	 * corresponds to the mode line in the header. If the user did not want
+	 * to stage that "hunk", we actually have to cut it out from the header.
+	 */
+	int skip_mode_change =
+		file_diff->mode_change && file_diff->hunk->use != USE_HUNK;
+	struct hunk *head = &file_diff->head, *first = file_diff->hunk;
+
+	if (!skip_mode_change) {
+		render_hunk(s, head, 0, colored, out);
+		return;
+	}
+
+	if (colored) {
+		const char *p = s->colored.buf;
+
+		strbuf_add(out, p + head->colored_start,
+			    first->colored_start - head->colored_start);
+		strbuf_add(out, p + first->colored_end,
+			    head->colored_end - first->colored_end);
+	} else {
+		const char *p = s->plain.buf;
+
+		strbuf_add(out, p + head->start, first->start - head->start);
+		strbuf_add(out, p + first->end, head->end - first->end);
+	}
+}
+
 static void reassemble_patch(struct add_p_state *s,
 			     struct file_diff *file_diff, struct strbuf *out)
 {
@@ -291,9 +390,9 @@ static void reassemble_patch(struct add_p_state *s,
 	size_t i;
 	ssize_t delta = 0;
 
-	render_hunk(s, &file_diff->head, 0, 0, out);
+	render_diff_header(s, file_diff, 0, out);
 
-	for (i = 0; i < file_diff->hunk_nr; i++) {
+	for (i = file_diff->mode_change; i < file_diff->hunk_nr; i++) {
 		hunk = file_diff->hunk + i;
 		if (hunk->use != USE_HUNK)
 			delta += hunk->header.old_count
@@ -328,7 +427,7 @@ static int patch_update_file(struct add_p_state *s,
 		return 0;
 
 	strbuf_reset(&s->buf);
-	render_hunk(s, &file_diff->head, 0, colored, &s->buf);
+	render_diff_header(s, file_diff, colored, &s->buf);
 	fputs(s->buf.buf, stdout);
 	for (;;) {
 		if (hunk_index >= file_diff->hunk_nr)
-- 
gitgitgadget

