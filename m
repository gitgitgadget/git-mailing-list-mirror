Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E04C2D0CA
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CD124676
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4D5DgFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfLMIIT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:08:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33500 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLMIIP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 03:08:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so5652995wrq.0
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 00:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b/wl3nCG4T1rjxfgLJQySEL32poHbbqczxEu4yayelM=;
        b=R4D5DgFdaWMlilR9abT/8H+MnBDE7W5VILo+6y3mNNevCA+r8GHnEzrP5EfGkDphUK
         o0nP8543ZmtpdTbaAwmT0B9d176PhvxBFpkLj+juS2SDwMyH2/4ToKcZQlGyiAWHElWu
         rCg7YJCLcafvLSrG1udaVztg1yVU7WpPiIBRaLg3jVJMpgw48gMHcpRqajoKOmAOBUx5
         e/+iMdayKw7SO78jw80ZOx8s3B3jPQBoFqGr1EyAjqTJXrPv3mmPB85CETSu9YAcIH7R
         47ICl5rVleXx/6wYEV1FGsNtSlPLFNPBbxX+ZFYEVg8qjL1MFWIanKkokb1+FNiRi40d
         VFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b/wl3nCG4T1rjxfgLJQySEL32poHbbqczxEu4yayelM=;
        b=ggOYtJqJebW6Vh+1/MSibrFC6V9hkXnTRgtRGmIO1xGEOm3S7SX2oVglqxNHGtupky
         qiun/j35tFg3swnGRYFmp1/rNoHISQbd1VAszjYmMkoiv6pko55f9HPiAuwcwsFoS3PD
         8XbJysOYBnX2uV7EMC4SwHnfExNsGzhIqbgFv44r5nyFzAA074gAJgi3ETjh/keEgvVU
         08iKfnXdgTtY52klDg8A1aGz4B3k3oBoogi3IWNE7TeFYRpv02GJXJJPgzdQAM9b0SNq
         fDHqlY5xzVxzVqcevzF7mnOuMpO60JdkswM4bs5FJLxsq2X2q16ZZJnr/1l6Sz3gsWI3
         uNzw==
X-Gm-Message-State: APjAAAUcQQumZ5f5w4pGcu3bhGdlPpRxDY/nFLS2p0gXnOS6bTYyXI6z
        a+nCpRqxXn/Zqi5p/kGywG00PBoT
X-Google-Smtp-Source: APXvYqx5R1TNR7Jv14DrwkgJaZjaEDih9NpltaAwMJEXidXYE1T3RhfSRgEuRy/Ed8ilh/2dOLgezQ==
X-Received: by 2002:a5d:50cf:: with SMTP id f15mr11146983wrt.381.1576224493641;
        Fri, 13 Dec 2019 00:08:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11sm9364123wmg.46.2019.12.13.00.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 00:08:13 -0800 (PST)
Message-Id: <0cd1522044c238286c4762dfb18d413e856f59e8.1576224486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.173.git.1576224486.gitgitgadget@gmail.com>
References: <pull.173.git.1576224486.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 08:07:54 +0000
Subject: [PATCH 07/19] built-in add -p: support multi-file diffs
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

For simplicity, the initial implementation in C handled only a single
modified file. Now it handles an arbitrary number of files.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c | 91 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 53 insertions(+), 38 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index f59471cdf2..7c1b3b3935 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -29,9 +29,12 @@ struct add_p_state {
 
 	/* parsed diff */
 	struct strbuf plain, colored;
-	struct hunk head;
-	struct hunk *hunk;
-	size_t hunk_nr, hunk_alloc;
+	struct file_diff {
+		struct hunk head;
+		struct hunk *hunk;
+		size_t hunk_nr, hunk_alloc;
+	} *file_diff;
+	size_t file_diff_nr;
 };
 
 static void err(struct add_p_state *s, const char *fmt, ...)
@@ -131,7 +134,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	struct strbuf *plain = &s->plain, *colored = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *p, *pend, *colored_p = NULL, *colored_pend = NULL;
-	size_t i, color_arg_index;
+	size_t file_diff_alloc = 0, i, color_arg_index;
+	struct file_diff *file_diff = NULL;
 	struct hunk *hunk = NULL;
 	int res;
 
@@ -171,7 +175,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	}
 	argv_array_clear(&args);
 
-	/* parse hunks */
+	/* parse files and hunks */
 	p = plain->buf;
 	pend = p + plain->len;
 	while (p != pend) {
@@ -180,17 +184,23 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 			eol = pend;
 
 		if (starts_with(p, "diff ")) {
-			if (p != plain->buf)
-				BUG("multi-file diff not yet handled");
-			hunk = &s->head;
+			s->file_diff_nr++;
+			ALLOC_GROW(s->file_diff, s->file_diff_nr,
+				   file_diff_alloc);
+			file_diff = s->file_diff + s->file_diff_nr - 1;
+			memset(file_diff, 0, sizeof(*file_diff));
+			hunk = &file_diff->head;
+			hunk->start = p - plain->buf;
+			if (colored_p)
+				hunk->colored_start = colored_p - colored->buf;
 		} else if (p == plain->buf)
 			BUG("diff starts with unexpected line:\n"
 			    "%.*s\n", (int)(eol - p), p);
 		else if (starts_with(p, "@@ ")) {
-			s->hunk_nr++;
-			ALLOC_GROW(s->hunk, s->hunk_nr,
-				   s->hunk_alloc);
-			hunk = s->hunk + s->hunk_nr - 1;
+			file_diff->hunk_nr++;
+			ALLOC_GROW(file_diff->hunk, file_diff->hunk_nr,
+				   file_diff->hunk_alloc);
+			hunk = file_diff->hunk + file_diff->hunk_nr - 1;
 			memset(hunk, 0, sizeof(*hunk));
 
 			hunk->start = p - plain->buf;
@@ -265,16 +275,17 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 			   hunk->end - hunk->start);
 }
 
-static void reassemble_patch(struct add_p_state *s, struct strbuf *out)
+static void reassemble_patch(struct add_p_state *s,
+			     struct file_diff *file_diff, struct strbuf *out)
 {
 	struct hunk *hunk;
 	size_t i;
 	ssize_t delta = 0;
 
-	render_hunk(s, &s->head, 0, 0, out);
+	render_hunk(s, &file_diff->head, 0, 0, out);
 
-	for (i = 0; i < s->hunk_nr; i++) {
-		hunk = s->hunk + i;
+	for (i = 0; i < file_diff->hunk_nr; i++) {
+		hunk = file_diff->hunk + i;
 		if (hunk->use != USE_HUNK)
 			delta += hunk->header.old_count
 				- hunk->header.new_count;
@@ -294,7 +305,8 @@ N_("y - stage this hunk\n"
    "K - leave this hunk undecided, see previous hunk\n"
    "? - print help\n");
 
-static int patch_update_file(struct add_p_state *s)
+static int patch_update_file(struct add_p_state *s,
+			     struct file_diff *file_diff)
 {
 	size_t hunk_index = 0;
 	ssize_t i, undecided_previous, undecided_next;
@@ -303,27 +315,27 @@ static int patch_update_file(struct add_p_state *s)
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int colored = !!s->colored.len;
 
-	if (!s->hunk_nr)
+	if (!file_diff->hunk_nr)
 		return 0;
 
 	strbuf_reset(&s->buf);
-	render_hunk(s, &s->head, 0, colored, &s->buf);
+	render_hunk(s, &file_diff->head, 0, colored, &s->buf);
 	fputs(s->buf.buf, stdout);
 	for (;;) {
-		if (hunk_index >= s->hunk_nr)
+		if (hunk_index >= file_diff->hunk_nr)
 			hunk_index = 0;
-		hunk = s->hunk + hunk_index;
+		hunk = file_diff->hunk + hunk_index;
 
 		undecided_previous = -1;
 		for (i = hunk_index - 1; i >= 0; i--)
-			if (s->hunk[i].use == UNDECIDED_HUNK) {
+			if (file_diff->hunk[i].use == UNDECIDED_HUNK) {
 				undecided_previous = i;
 				break;
 			}
 
 		undecided_next = -1;
-		for (i = hunk_index + 1; i < s->hunk_nr; i++)
-			if (s->hunk[i].use == UNDECIDED_HUNK) {
+		for (i = hunk_index + 1; i < file_diff->hunk_nr; i++)
+			if (file_diff->hunk[i].use == UNDECIDED_HUNK) {
 				undecided_next = i;
 				break;
 			}
@@ -344,11 +356,12 @@ static int patch_update_file(struct add_p_state *s)
 			strbuf_addstr(&s->buf, ",K");
 		if (undecided_next >= 0)
 			strbuf_addstr(&s->buf, ",j");
-		if (hunk_index + 1 < s->hunk_nr)
+		if (hunk_index + 1 < file_diff->hunk_nr)
 			strbuf_addstr(&s->buf, ",J");
 		color_fprintf(stdout, s->s.prompt_color,
 			      "(%"PRIuMAX"/%"PRIuMAX") ",
-			      (uintmax_t)hunk_index + 1, (uintmax_t)s->hunk_nr);
+			      (uintmax_t)hunk_index + 1,
+			      (uintmax_t)file_diff->hunk_nr);
 		color_fprintf(stdout, s->s.prompt_color,
 			      _("Stage this hunk [y,n,a,d%s,?]? "),
 			      s->buf.buf);
@@ -364,19 +377,19 @@ static int patch_update_file(struct add_p_state *s)
 			hunk->use = USE_HUNK;
 soft_increment:
 			hunk_index = undecided_next < 0 ?
-				s->hunk_nr : undecided_next;
+				file_diff->hunk_nr : undecided_next;
 		} else if (ch == 'n') {
 			hunk->use = SKIP_HUNK;
 			goto soft_increment;
 		} else if (ch == 'a') {
-			for (; hunk_index < s->hunk_nr; hunk_index++) {
-				hunk = s->hunk + hunk_index;
+			for (; hunk_index < file_diff->hunk_nr; hunk_index++) {
+				hunk = file_diff->hunk + hunk_index;
 				if (hunk->use == UNDECIDED_HUNK)
 					hunk->use = USE_HUNK;
 			}
 		} else if (ch == 'd') {
-			for (; hunk_index < s->hunk_nr; hunk_index++) {
-				hunk = s->hunk + hunk_index;
+			for (; hunk_index < file_diff->hunk_nr; hunk_index++) {
+				hunk = file_diff->hunk + hunk_index;
 				if (hunk->use == UNDECIDED_HUNK)
 					hunk->use = SKIP_HUNK;
 			}
@@ -386,7 +399,7 @@ static int patch_update_file(struct add_p_state *s)
 			else
 				err(s, _("No previous hunk"));
 		} else if (s->answer.buf[0] == 'J') {
-			if (hunk_index + 1 < s->hunk_nr)
+			if (hunk_index + 1 < file_diff->hunk_nr)
 				hunk_index++;
 			else
 				err(s, _("No next hunk"));
@@ -406,14 +419,14 @@ static int patch_update_file(struct add_p_state *s)
 	}
 
 	/* Any hunk to be used? */
-	for (i = 0; i < s->hunk_nr; i++)
-		if (s->hunk[i].use == USE_HUNK)
+	for (i = 0; i < file_diff->hunk_nr; i++)
+		if (file_diff->hunk[i].use == USE_HUNK)
 			break;
 
-	if (i < s->hunk_nr) {
+	if (i < file_diff->hunk_nr) {
 		/* At least one hunk selected: apply */
 		strbuf_reset(&s->buf);
-		reassemble_patch(s, &s->buf);
+		reassemble_patch(s, file_diff, &s->buf);
 
 		discard_index(s->s.r->index);
 		setup_child_process(s, &cp, "apply", "--cached", NULL);
@@ -434,6 +447,7 @@ int run_add_p(struct repository *r, const struct pathspec *ps)
 	struct add_p_state s = {
 		{ r }, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
 	};
+	size_t i;
 
 	init_add_i_state(&s.s, r);
 
@@ -446,8 +460,9 @@ int run_add_p(struct repository *r, const struct pathspec *ps)
 		return -1;
 	}
 
-	if (s.hunk_nr)
-		patch_update_file(&s);
+	for (i = 0; i < s.file_diff_nr; i++)
+		if (patch_update_file(&s, s.file_diff + i))
+			break;
 
 	strbuf_release(&s.answer);
 	strbuf_release(&s.buf);
-- 
gitgitgadget

