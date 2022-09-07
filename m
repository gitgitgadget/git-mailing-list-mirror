Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F21C6FA86
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 14:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIGOph (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 10:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiIGOpd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 10:45:33 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BD94F1A8
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 07:45:26 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1225219ee46so36630863fac.2
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 07:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ffsrV/9vlkg2FAxSVU4XF1MY8+Cs/g+XtIKN3CCyojo=;
        b=sTTzGLhbSqE64z6x4Q2wPYbSEfEwRf6kBtgHOGWwB+jdrzlzP5z5tAw+upQNScZTeU
         I7jkdnVJoUxS+A3EFzEyQq63cv1G1ZbKKTwShYVZQaSY6xG4w4yAaxywk9iR1ntJ7YzR
         A16y95wuI7kebw8+kz2WI1fv20xx1pL+zRYuIFiP33WduspROvLDOPt55LSMGTgiQlVm
         /O5zZnB9YxJVtmqoQZfPURwT0VfJZCyMucOhB9MZUXkA29/PjT7cqqEHW+U706MEdE/3
         eiQIgpZ/2OiBfh031ErYDJpQ6OzLb182b6yrdDtY8hHMOIKmJ8CrC6cnvQFonurpaLFC
         RQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ffsrV/9vlkg2FAxSVU4XF1MY8+Cs/g+XtIKN3CCyojo=;
        b=PSbsn5G3h4ImHSYwOzkIcr4kxrCulfAOEVDJ/jz8/0E7455PHLSCDO7YZ2VyLu0vv0
         ynYZbWg/Hpiln0CRPi7bmRovdS4mKqxysBcA5OEoixR1Ry9zRX48isBmSbuCyQBxlaeu
         hxLyfSWEWn3DE52b8KcmhF/zl9DCSml3mCtUaYcAGBPTCynl/pXfCLzZvxqy/zHPIIjl
         +SQuoA5gTffWdsr/jeSHnX08tO10Zp273JyDjJt+/foHiUoZCpBcdk4n1HTzPnBCxGNk
         7S27kWH25oUX4LR4tLCc2peaGMwOiofgwcseGv60MFxv29HyIKqYvgTibCYZ7zk7g3Lm
         8oLA==
X-Gm-Message-State: ACgBeo0SHYxcIdB4B5xogi7dQeso2Z44Xs3bBCnMRJF6d1OniJ6daY6a
        2tqoTuGc75R/fwzGSdNkaHFuH+gQzdp4Tg==
X-Google-Smtp-Source: AA6agR6H6/xFOrPnNA6nJh6VyQn8GyWgEtFjSuMbfYdzivl8BDTCv0qqsfFLzRFJcebRCD4wmdwchA==
X-Received: by 2002:a05:6808:1995:b0:343:4888:fb7b with SMTP id bj21-20020a056808199500b003434888fb7bmr12538996oib.163.1662561925435;
        Wed, 07 Sep 2022 07:45:25 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id p21-20020a056830319500b00638bfd0673bsm7175012ots.51.2022.09.07.07.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 07:45:24 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, l.s.r@web.de
Subject: [PATCH v2 1/2] patchbreak(), is_scissors_line(): work with a buf/len pair
Date:   Wed,  7 Sep 2022 11:44:56 -0300
Message-Id: <99012733e440be15afc7fd45272e738c71b3ef27.1662559356.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1662559356.git.matheus.bernardino@usp.br>
References: <cover.1662559356.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: René Scharfe <l.s.r@web.de>

The next patch will add calls to these two functions from code that
works with a char */size_t pair. So let's adapt the functions in
preparation.
---
 mailinfo.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 9621ba62a3..f0a690b6e8 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -646,32 +646,30 @@ static void decode_transfer_encoding(struct mailinfo *mi, struct strbuf *line)
 	free(ret);
 }
 
-static inline int patchbreak(const struct strbuf *line)
+static inline int patchbreak(const char *buf, size_t len)
 {
-	size_t i;
-
 	/* Beginning of a "diff -" header? */
-	if (starts_with(line->buf, "diff -"))
+	if (skip_prefix_mem(buf, len, "diff -", &buf, &len))
 		return 1;
 
 	/* CVS "Index: " line? */
-	if (starts_with(line->buf, "Index: "))
+	if (skip_prefix_mem(buf, len, "Index: ", &buf, &len))
 		return 1;
 
 	/*
 	 * "--- <filename>" starts patches without headers
 	 * "---<sp>*" is a manual separator
 	 */
-	if (line->len < 4)
+	if (len < 4)
 		return 0;
 
-	if (starts_with(line->buf, "---")) {
+	if (skip_prefix_mem(buf, len, "---", &buf, &len)) {
 		/* space followed by a filename? */
-		if (line->buf[3] == ' ' && !isspace(line->buf[4]))
+		if (len > 1 && buf[0] == ' ' && !isspace(buf[1]))
 			return 1;
 		/* Just whitespace? */
-		for (i = 3; i < line->len; i++) {
-			unsigned char c = line->buf[i];
+		for (; len; buf++, len--) {
+			unsigned char c = buf[0];
 			if (c == '\n')
 				return 1;
 			if (!isspace(c))
@@ -682,14 +680,14 @@ static inline int patchbreak(const struct strbuf *line)
 	return 0;
 }
 
-static int is_scissors_line(const char *line)
+static int is_scissors_line(const char *line, size_t len)
 {
 	const char *c;
 	int scissors = 0, gap = 0;
 	const char *first_nonblank = NULL, *last_nonblank = NULL;
 	int visible, perforation = 0, in_perforation = 0;
 
-	for (c = line; *c; c++) {
+	for (c = line; len; c++, len--) {
 		if (isspace(*c)) {
 			if (in_perforation) {
 				perforation++;
@@ -705,12 +703,14 @@ static int is_scissors_line(const char *line)
 			perforation++;
 			continue;
 		}
-		if (starts_with(c, ">8") || starts_with(c, "8<") ||
-		    starts_with(c, ">%") || starts_with(c, "%<")) {
+		if (skip_prefix_mem(c, len, ">8", &c, &len) ||
+		    skip_prefix_mem(c, len, "8<", &c, &len) ||
+		    skip_prefix_mem(c, len, ">%", &c, &len) ||
+		    skip_prefix_mem(c, len, "%<", &c, &len)) {
 			in_perforation = 1;
 			perforation += 2;
 			scissors += 2;
-			c++;
+			c--, len++;
 			continue;
 		}
 		in_perforation = 0;
@@ -747,7 +747,8 @@ static int check_inbody_header(struct mailinfo *mi, const struct strbuf *line)
 {
 	if (mi->inbody_header_accum.len &&
 	    (line->buf[0] == ' ' || line->buf[0] == '\t')) {
-		if (mi->use_scissors && is_scissors_line(line->buf)) {
+		if (mi->use_scissors &&
+		    is_scissors_line(line->buf, line->len)) {
 			/*
 			 * This is a scissors line; do not consider this line
 			 * as a header continuation line.
@@ -808,7 +809,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 	if (convert_to_utf8(mi, line, mi->charset.buf))
 		return 0; /* mi->input_error already set */
 
-	if (mi->use_scissors && is_scissors_line(line->buf)) {
+	if (mi->use_scissors && is_scissors_line(line->buf, line->len)) {
 		int i;
 
 		strbuf_setlen(&mi->log_message, 0);
@@ -826,7 +827,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 		return 0;
 	}
 
-	if (patchbreak(line)) {
+	if (patchbreak(line->buf, line->len)) {
 		if (mi->message_id)
 			strbuf_addf(&mi->log_message,
 				    "Message-Id: %s\n", mi->message_id);
-- 
2.37.2

