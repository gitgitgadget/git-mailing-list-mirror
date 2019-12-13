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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737B9C2D0C9
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3994524671
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpCHmcIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfLMIIP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:08:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51727 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfLMIIN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 03:08:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id d73so5270937wmd.1
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 00:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+PpfMtGZebBWSOtAUXgzbvL3kkBMsHYpj4TYS3Xx4uc=;
        b=dpCHmcIe+izi6Q8i+cS0BIpEfoTqI+Kt6I/YOf0TaWhXIuJyPxPCb55EgfQtWfm7F+
         JWBWg31JhD0f47Mfsap1Nv+0vgn4mG6gv8H6aQFPKRa0800zuHIT16AO84qhqDRoo23H
         XQ7YvnHZFvtf5WBGD5gUsALaOfQbQSws786fUfEWY2UuWjTfyaw2/Up+1XFitygLziP6
         +1LfTBNH56P9sbw1LuT9N2a53r2EakgsM2zIDqm3sEVeLyDMN1Z7dwlqszmiv9OUQaHy
         UjbOiTdtWVl5oDulZBsT04IkGpK8r+pSoWruGMCmF8n4dEWF+sHzL1a7utLgDLIZmwMG
         t7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+PpfMtGZebBWSOtAUXgzbvL3kkBMsHYpj4TYS3Xx4uc=;
        b=HrVqroyWaZxDLY+S4NXX1WEfMeqlkp5mqBl6pE+Ud4tgxTNWwZJ/pb3dhw5rvV7dSe
         aAhrWTMH6xYv6L+bFWCouz5v3R1Pl43pm7XgzfLVf99+3YQv5DL5QU6XKSW/Ny1d0gT8
         omqRcOnVh2naSrMJFHQpvYzHL4g2iKVsg/OHK7k2U7eFoKFEISI3Qdgp6W4+FyKHSHyZ
         FyPi6IJLAajm0pKjzwPfkvd2UcqWYs41g5rq6naUCnSm9zamVmRKJnZ7WhtrU7Dd+bwd
         hkdhy7UXLknfnM+LCj6M0ii/6G2dmumHZmMW9YyR279hueNUdI16WH6BBuIwB8DRfF55
         pILA==
X-Gm-Message-State: APjAAAVFHQi1J4WbFwA+gG4w5gTmoQ1fuGBNkagaKMvM2oEjADo6khiH
        w7ZK1nNatCOKZcar1/rKc9RZPBxk
X-Google-Smtp-Source: APXvYqxYhEp2054YVD/O+xxkXn9wG2j0uOBvyXT2e3aitAuqkY/4M3P4X+j6SV2VXERRx4rs2X0wTg==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr11999794wmb.150.1576224490433;
        Fri, 13 Dec 2019 00:08:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y22sm3559418wma.35.2019.12.13.00.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 00:08:09 -0800 (PST)
Message-Id: <438e6519fb7e81c451ebba3ea9efffc26b4c7a17.1576224486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.173.git.1576224486.gitgitgadget@gmail.com>
References: <pull.173.git.1576224486.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 08:07:50 +0000
Subject: [PATCH 03/19] built-in add -p: show colored hunks by default
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

Just like the Perl version, we now generate two diffs if `color.diff` is
set: one with and one without color. Then we parse them in parallel and
record which hunks start at which offsets in both.

Note that this is a (slight) deviation from the way the Perl version did
it: we are no longer reading the output of `diff-files` line by line
(which is more natural for Perl than for C), but in one go, and parse
everything later, so we might just as well do it in synchrony.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c | 79 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 62 insertions(+), 17 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index d1b1a080e4..79eefa9505 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -4,9 +4,10 @@
 #include "run-command.h"
 #include "argv-array.h"
 #include "pathspec.h"
+#include "color.h"
 
 struct hunk {
-	size_t start, end;
+	size_t start, end, colored_start, colored_end;
 	enum { UNDECIDED_HUNK = 0, SKIP_HUNK, USE_HUNK } use;
 };
 
@@ -15,7 +16,7 @@ struct add_p_state {
 	struct strbuf answer, buf;
 
 	/* parsed diff */
-	struct strbuf plain;
+	struct strbuf plain, colored;
 	struct hunk head;
 	struct hunk *hunk;
 	size_t hunk_nr, hunk_alloc;
@@ -39,26 +40,50 @@ static void setup_child_process(struct add_p_state *s,
 
 static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 {
-	struct strbuf *plain = &s->plain;
+	struct argv_array args = ARGV_ARRAY_INIT;
+	struct strbuf *plain = &s->plain, *colored = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
-	char *p, *pend;
-	size_t i;
+	char *p, *pend, *colored_p = NULL, *colored_pend = NULL;
+	size_t i, color_arg_index;
 	struct hunk *hunk = NULL;
 	int res;
 
 	/* Use `--no-color` explicitly, just in case `diff.color = always`. */
-	setup_child_process(s, &cp,
-			 "diff-files", "-p", "--no-color", "--", NULL);
+	argv_array_pushl(&args, "diff-files", "-p", "--no-color", "--", NULL);
+	color_arg_index = args.argc - 2;
 	for (i = 0; i < ps->nr; i++)
-		argv_array_push(&cp.args, ps->items[i].original);
+		argv_array_push(&args, ps->items[i].original);
 
+	setup_child_process(s, &cp, NULL);
+	cp.argv = args.argv;
 	res = capture_command(&cp, plain, 0);
-	if (res)
+	if (res) {
+		argv_array_clear(&args);
 		return error(_("could not parse diff"));
-	if (!plain->len)
+	}
+	if (!plain->len) {
+		argv_array_clear(&args);
 		return 0;
+	}
 	strbuf_complete_line(plain);
 
+	if (want_color_fd(1, -1)) {
+		struct child_process colored_cp = CHILD_PROCESS_INIT;
+
+		setup_child_process(s, &colored_cp, NULL);
+		xsnprintf((char *)args.argv[color_arg_index], 8, "--color");
+		colored_cp.argv = args.argv;
+		colored = &s->colored;
+		res = capture_command(&colored_cp, colored, 0);
+		argv_array_clear(&args);
+		if (res)
+			return error(_("could not parse colored diff"));
+		strbuf_complete_line(colored);
+		colored_p = colored->buf;
+		colored_pend = colored_p + colored->len;
+	}
+	argv_array_clear(&args);
+
 	/* parse hunks */
 	p = plain->buf;
 	pend = p + plain->len;
@@ -82,20 +107,37 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 			memset(hunk, 0, sizeof(*hunk));
 
 			hunk->start = p - plain->buf;
+			if (colored)
+				hunk->colored_start = colored_p - colored->buf;
 		}
 
 		p = eol == pend ? pend : eol + 1;
 		hunk->end = p - plain->buf;
+
+		if (colored) {
+			char *colored_eol = memchr(colored_p, '\n',
+						   colored_pend - colored_p);
+			if (colored_eol)
+				colored_p = colored_eol + 1;
+			else
+				colored_p = colored_pend;
+
+			hunk->colored_end = colored_p - colored->buf;
+		}
 	}
 
 	return 0;
 }
 
 static void render_hunk(struct add_p_state *s, struct hunk *hunk,
-			struct strbuf *out)
+			int colored, struct strbuf *out)
 {
-	strbuf_add(out, s->plain.buf + hunk->start,
-		   hunk->end - hunk->start);
+	if (colored)
+		strbuf_add(out, s->colored.buf + hunk->colored_start,
+			   hunk->colored_end - hunk->colored_start);
+	else
+		strbuf_add(out, s->plain.buf + hunk->start,
+			   hunk->end - hunk->start);
 }
 
 static void reassemble_patch(struct add_p_state *s, struct strbuf *out)
@@ -103,12 +145,12 @@ static void reassemble_patch(struct add_p_state *s, struct strbuf *out)
 	struct hunk *hunk;
 	size_t i;
 
-	render_hunk(s, &s->head, out);
+	render_hunk(s, &s->head, 0, out);
 
 	for (i = 0; i < s->hunk_nr; i++) {
 		hunk = s->hunk + i;
 		if (hunk->use == USE_HUNK)
-			render_hunk(s, hunk, out);
+			render_hunk(s, hunk, 0, out);
 	}
 }
 
@@ -130,12 +172,13 @@ static int patch_update_file(struct add_p_state *s)
 	struct hunk *hunk;
 	char ch;
 	struct child_process cp = CHILD_PROCESS_INIT;
+	int colored = !!s->colored.len;
 
 	if (!s->hunk_nr)
 		return 0;
 
 	strbuf_reset(&s->buf);
-	render_hunk(s, &s->head, &s->buf);
+	render_hunk(s, &s->head, colored, &s->buf);
 	fputs(s->buf.buf, stdout);
 	for (;;) {
 		if (hunk_index >= s->hunk_nr)
@@ -162,7 +205,7 @@ static int patch_update_file(struct add_p_state *s)
 			break;
 
 		strbuf_reset(&s->buf);
-		render_hunk(s, hunk, &s->buf);
+		render_hunk(s, hunk, colored, &s->buf);
 		fputs(s->buf.buf, stdout);
 
 		strbuf_reset(&s->buf);
@@ -252,6 +295,7 @@ int run_add_p(struct repository *r, const struct pathspec *ps)
 					 NULL, NULL, NULL) < 0 ||
 	    parse_diff(&s, ps) < 0) {
 		strbuf_release(&s.plain);
+		strbuf_release(&s.colored);
 		return -1;
 	}
 
@@ -261,5 +305,6 @@ int run_add_p(struct repository *r, const struct pathspec *ps)
 	strbuf_release(&s.answer);
 	strbuf_release(&s.buf);
 	strbuf_release(&s.plain);
+	strbuf_release(&s.colored);
 	return 0;
 }
-- 
gitgitgadget

