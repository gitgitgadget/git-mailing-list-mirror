Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96AEC433E3
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 13:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B031A2072D
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 13:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSDbPxza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgHQNXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbgHQNXO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 09:23:14 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0D2C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 06:23:13 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so15000374wrl.4
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 06:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bJ7GEKpVNH4KMjkH/NQAU3zjbetFVi2nhDRYtm2Nwto=;
        b=SSDbPxzaTOO+50/V6dr0rquUEDZLLkvAKXDd4u7i7eI73CvGxBW1qc5iiSsS1lqiYV
         qoVw71vV6LR6KCH8ip6tydMxaFYw0B3VaUSfRyO5XVex59I10BnqE5ZfH/fchffnSW0o
         zbHta/6S5+2nCqwKnX51hqrWJetotPZoXaOD4xHUfZSMaTtk1Rf2mxoqHL5SbcUpueBL
         LjcgZS7YBgkpd885pn7lST15Cmg7JpCDEEfmVAHgmXDbfebSgC7INOERY3ZwBs0jEFMZ
         t7Ib58obCL5KU47kdgJG+EJiA71xozBIWYBy/SJrKZOqU58dRBpDudHxRaE0tYnM4xPW
         4pFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bJ7GEKpVNH4KMjkH/NQAU3zjbetFVi2nhDRYtm2Nwto=;
        b=V3GiqMhHw9+qQAlwi8sytKziDHqQkfLybLqqWbdNYNN6pavqUmpM7Kb2Q+U6Ce3xSn
         sz2K8UPAPMCn8wJJezN0JKxoh3IoPHx3ddp6zVd8gs+UuUvyyIcdxx6iiBY38sqPIhid
         fgD9xV9z5/Twu6CiGAQIe7zVJNALhXqci3Te2YI613mjyGydJX/xNa7fAV1OpkOp0zt6
         gqkGevL1T7GMS37rXTnfxD+IipWWlapjCjQ7Dd9oH020GyD3mq1QdrOJqSUyeSueHL/y
         K6D5AiAAw/0/p/67nTaEVa7NcJZZFv61ebAdQgzmqLNwfaLxpEgibAo6rfLz6iPF8Crs
         /9rA==
X-Gm-Message-State: AOAM533cHEgwuK09TMijRaSpz92a9/61/WnJhDAvIWNOydkoBwYtrpAo
        2f7ixtC6GEs+Ju0YSpnfT8c2hS4Aip8=
X-Google-Smtp-Source: ABdhPJzYXyny7hQl27lDJwg/M9fT0/RE+WuMVu3X1tPeskLTFrPYP44e8A1tuka1ojwmsBHe2GSWCA==
X-Received: by 2002:adf:fbc6:: with SMTP id d6mr15854950wrs.189.1597670591704;
        Mon, 17 Aug 2020 06:23:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b77sm56807753wmb.3.2020.08.17.06.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 06:23:11 -0700 (PDT)
Message-Id: <752e13fb9fd9fd7930d83a0915dbbc0274a99908.1597670589.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.702.git.1597670589.gitgitgadget@gmail.com>
References: <pull.702.git.1597670589.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 13:23:08 +0000
Subject: [PATCH 2/2] add -p: fix checking of user input
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When a file has been deleted the C version of add -p allows the user
to edit a hunk even though 'e' is not in the list of allowed
responses. (I think 'e' is disallowed because if the file is edited it
is no longer a deletion and we're not set up to rewrite the diff
header).

The invalid response was allowed because the test that determines
whether to display 'e' was not duplicated correctly in the code that
processes the user's choice. Fix this by using flags that are set when
constructing the prompt and checked when processing the user's choice
rather than repeating the check itself.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 add-patch.c | 54 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index a15fa407be..907c05b3c1 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1352,6 +1352,15 @@ static int patch_update_file(struct add_p_state *s,
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int colored = !!s->colored.len, quit = 0;
 	enum prompt_mode_type prompt_mode_type;
+	enum {
+		ALLOW_GOTO_PREVIOUS_HUNK = 1 << 0,
+		ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK = 1 << 1,
+		ALLOW_GOTO_NEXT_HUNK = 1 << 2,
+		ALLOW_GOTO_NEXT_UNDECIDED_HUNK = 1 << 3,
+		ALLOW_SEARCH_AND_GOTO = 1 << 4,
+		ALLOW_SPLIT = 1 << 5,
+		ALLOW_EDIT = 1 << 6
+	} permitted = 0;
 
 	if (!file_diff->hunk_nr)
 		return 0;
@@ -1388,22 +1397,35 @@ static int patch_update_file(struct add_p_state *s,
 		fputs(s->buf.buf, stdout);
 
 		strbuf_reset(&s->buf);
-		if (undecided_previous >= 0)
+		if (undecided_previous >= 0) {
+			permitted |= ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK;
 			strbuf_addstr(&s->buf, ",k");
-		if (hunk_index)
+		}
+		if (hunk_index) {
+			permitted |= ALLOW_GOTO_PREVIOUS_HUNK;
 			strbuf_addstr(&s->buf, ",K");
-		if (undecided_next >= 0)
+		}
+		if (undecided_next >= 0) {
+			permitted |= ALLOW_GOTO_NEXT_UNDECIDED_HUNK;
 			strbuf_addstr(&s->buf, ",j");
-		if (hunk_index + 1 < file_diff->hunk_nr)
+		}
+		if (hunk_index + 1 < file_diff->hunk_nr) {
+			permitted |= ALLOW_GOTO_NEXT_HUNK;
 			strbuf_addstr(&s->buf, ",J");
-		if (file_diff->hunk_nr > 1)
+		}
+		if (file_diff->hunk_nr > 1) {
+			permitted |= ALLOW_SEARCH_AND_GOTO;
 			strbuf_addstr(&s->buf, ",g,/");
-		if (hunk->splittable_into > 1)
+		}
+		if (hunk->splittable_into > 1) {
+			permitted |= ALLOW_SPLIT;
 			strbuf_addstr(&s->buf, ",s");
+		}
 		if (hunk_index + 1 > file_diff->mode_change &&
-		    !file_diff->deleted)
+		    !file_diff->deleted) {
+			permitted |= ALLOW_EDIT;
 			strbuf_addstr(&s->buf, ",e");
-
+		}
 		if (file_diff->deleted)
 			prompt_mode_type = PROMPT_DELETION;
 		else if (file_diff->added)
@@ -1452,22 +1474,22 @@ static int patch_update_file(struct add_p_state *s,
 				break;
 			}
 		} else if (s->answer.buf[0] == 'K') {
-			if (hunk_index)
+			if (permitted & ALLOW_GOTO_PREVIOUS_HUNK)
 				hunk_index--;
 			else
 				err(s, _("No previous hunk"));
 		} else if (s->answer.buf[0] == 'J') {
-			if (hunk_index + 1 < file_diff->hunk_nr)
+			if (permitted & ALLOW_GOTO_NEXT_HUNK)
 				hunk_index++;
 			else
 				err(s, _("No next hunk"));
 		} else if (s->answer.buf[0] == 'k') {
-			if (undecided_previous >= 0)
+			if (permitted & ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK)
 				hunk_index = undecided_previous;
 			else
 				err(s, _("No previous hunk"));
 		} else if (s->answer.buf[0] == 'j') {
-			if (undecided_next >= 0)
+			if (permitted & ALLOW_GOTO_NEXT_UNDECIDED_HUNK)
 				hunk_index = undecided_next;
 			else
 				err(s, _("No next hunk"));
@@ -1475,7 +1497,7 @@ static int patch_update_file(struct add_p_state *s,
 			char *pend;
 			unsigned long response;
 
-			if (file_diff->hunk_nr < 2) {
+			if (!(permitted & ALLOW_SEARCH_AND_GOTO)) {
 				err(s, _("No other hunks to goto"));
 				continue;
 			}
@@ -1512,7 +1534,7 @@ static int patch_update_file(struct add_p_state *s,
 			regex_t regex;
 			int ret;
 
-			if (file_diff->hunk_nr < 2) {
+			if (!(permitted & ALLOW_SEARCH_AND_GOTO)) {
 				err(s, _("No other hunks to search"));
 				continue;
 			}
@@ -1557,7 +1579,7 @@ static int patch_update_file(struct add_p_state *s,
 			hunk_index = i;
 		} else if (s->answer.buf[0] == 's') {
 			size_t splittable_into = hunk->splittable_into;
-			if (splittable_into < 2)
+			if (!(permitted & ALLOW_SPLIT))
 				err(s, _("Sorry, cannot split this hunk"));
 			else if (!split_hunk(s, file_diff,
 					     hunk - file_diff->hunk))
@@ -1565,7 +1587,7 @@ static int patch_update_file(struct add_p_state *s,
 						 _("Split into %d hunks."),
 						 (int)splittable_into);
 		} else if (s->answer.buf[0] == 'e') {
-			if (hunk_index + 1 == file_diff->mode_change)
+			if (!(permitted & ALLOW_EDIT))
 				err(s, _("Sorry, cannot edit this hunk"));
 			else if (edit_hunk_loop(s, file_diff, hunk) >= 0) {
 				hunk->use = USE_HUNK;
-- 
gitgitgadget
