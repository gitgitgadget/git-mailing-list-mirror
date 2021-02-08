Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687CBC43331
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3565464E8F
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbhBHT2T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbhBHT1s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 14:27:48 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880EDC061786
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 11:27:04 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 189so1331204pfy.6
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 11:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lC4QR429u0+7ZPSy8kdmBfdRM5ddttlVJKfi+xAtjSA=;
        b=sykkWHnBjPuAdd44hr7vKcj4BQ7WDTULWPGD9Kar/ts527xvdSZiB4iv40nV4eMIfe
         QltqcI31v669B+LOwj0Y1+XAxs7NBzBxvtjJcB9dNjL7WH9vg/Ya92OOQdd0A0JggPh7
         MKtlSoJjO36Foc1IbWCvecNp0jh++TRX7/VJqH00/2+uv8N/wOAp3Fy0F4a36Jkjn5j9
         XTfPr5r3McvspHl2jj/0i0MyMrknXsXKgPcnP2VzhgL2BvC6fn2Y4Yrl2Dozjsk7xWqz
         1sCyr/WJXUQH7DnzZ7/9hVtfqM5d1mpPOmjcroHPbkpYdvvidZoh7yTEnCvBtNqqC9pM
         yjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lC4QR429u0+7ZPSy8kdmBfdRM5ddttlVJKfi+xAtjSA=;
        b=TUPIn+hQup/VFqkuLPHf9PSC0VO6EC+Xx3kxPlpyGZ1TUhHRqBvoLEwavUzpVnJnDS
         IipK7CvZjas5Y4fn0E86la4StwC565sKU8gOizuP82uvgEOyRP2tq1rc8mEclGJQgHjk
         Qw21lIWCqczxIcpHayMMIuM1ywx33uRqUYwh8RlfobJ8TgXjm6AIt6DwhtA6fDWbOH54
         7UrU8KkNvBef29xOLR/TTpuV7w1LmO9vET9CTnZ5Fjo73b8dEl0Fv6IAq3XcjGDNDHD4
         Imya1/7177B/VPRoJRMTFzUGvWTBmwJp9WyHgcPie5umOuh94wxt++5yceMB0Lk20Gey
         cb9A==
X-Gm-Message-State: AOAM532tKPCyEjl8C87LfdDb382diBN8e4+4iab1NkxywxAj5agpnKnl
        UiCpLXn2z8kqIVYIv4T4YjnxMvPKxHu+gg==
X-Google-Smtp-Source: ABdhPJwF2/uMrRhx3wVKL++j61w7lBzrGJunaek4Y8clBqoX6HYQwaVLwffo66TVhPT2mHvvD3aoug==
X-Received: by 2002:aa7:8485:0:b029:1dd:bf6a:a9ec with SMTP id u5-20020aa784850000b02901ddbf6aa9ecmr5633995pfn.47.1612812423871;
        Mon, 08 Feb 2021 11:27:03 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2e07:af0b:91c3:5a1c:9f2d:b1e6])
        by smtp.googlemail.com with ESMTPSA id a141sm19765444pfa.189.2021.02.08.11.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:27:03 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 02/11] sequencer: rename a few functions
Date:   Tue,  9 Feb 2021 00:55:20 +0530
Message-Id: <20210208192528.21399-3-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename functions to make them more descriptive and while at it, remove
unnecessary 'inline' of the skip_fixupish() function.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 sequencer.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f3928cf45c..abc6d5cdfd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1744,7 +1744,7 @@ static const char skip_first_commit_msg_str[] = N_("The 1st commit message will
 static const char skip_nth_commit_msg_fmt[] = N_("The commit message #%d will be skipped:");
 static const char combined_commit_msg_fmt[] = N_("This is a combination of %d commits.");
 
-static int check_fixup_flag(enum todo_command command, unsigned flag)
+static int is_fixup_flag(enum todo_command command, unsigned flag)
 {
 	return command == TODO_FIXUP && ((flag & TODO_REPLACE_FIXUP_MSG) ||
 					 (flag & TODO_EDIT_FIXUP_MSG));
@@ -1873,7 +1873,7 @@ static int append_squash_message(struct strbuf *buf, const char *body,
 	strbuf_addstr(buf, body + commented_len);
 
 	/* fixup -C after squash behaves like squash */
-	if (check_fixup_flag(command, flag) && !seen_squash(opts)) {
+	if (is_fixup_flag(command, flag) && !seen_squash(opts)) {
 		/*
 		 * We're replacing the commit message so we need to
 		 * append the Signed-off-by: trailer if the user
@@ -1928,7 +1928,7 @@ static int update_squash_messages(struct repository *r,
 			    opts->current_fixup_count + 2);
 		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
 		strbuf_release(&header);
-		if (check_fixup_flag(command, flag) && !seen_squash(opts))
+		if (is_fixup_flag(command, flag) && !seen_squash(opts))
 			update_squash_message_for_fixup(&buf);
 	} else {
 		struct object_id head;
@@ -1951,11 +1951,11 @@ static int update_squash_messages(struct repository *r,
 		strbuf_addf(&buf, "%c ", comment_line_char);
 		strbuf_addf(&buf, _(combined_commit_msg_fmt), 2);
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
-		strbuf_addstr(&buf, check_fixup_flag(command, flag) ?
+		strbuf_addstr(&buf, is_fixup_flag(command, flag) ?
 			      _(skip_first_commit_msg_str) :
 			      _(first_commit_msg_str));
 		strbuf_addstr(&buf, "\n\n");
-		if (check_fixup_flag(command, flag))
+		if (is_fixup_flag(command, flag))
 			strbuf_add_commented_lines(&buf, body, strlen(body));
 		else
 			strbuf_addstr(&buf, body);
@@ -1968,7 +1968,7 @@ static int update_squash_messages(struct repository *r,
 			     oid_to_hex(&commit->object.oid));
 	find_commit_subject(message, &body);
 
-	if (command == TODO_SQUASH || check_fixup_flag(command, flag)) {
+	if (command == TODO_SQUASH || is_fixup_flag(command, flag)) {
 		res = append_squash_message(&buf, body, command, opts, flag);
 	} else if (command == TODO_FIXUP) {
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
@@ -5661,7 +5661,7 @@ static int subject2item_cmp(const void *fndata,
 
 define_commit_slab(commit_todo_item, struct todo_item *);
 
-static inline int skip_fixup_amend_squash(const char *subject, const char **p) {
+static int skip_fixupish(const char *subject, const char **p) {
 	return skip_prefix(subject, "fixup! ", p) ||
 	       skip_prefix(subject, "amend! ", p) ||
 	       skip_prefix(subject, "squash! ", p);
@@ -5725,13 +5725,13 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 		format_subject(&buf, subject, " ");
 		subject = subjects[i] = strbuf_detach(&buf, &subject_len);
 		unuse_commit_buffer(item->commit, commit_buffer);
-		if (skip_fixup_amend_squash(subject, &p)) {
+		if (skip_fixupish(subject, &p)) {
 			struct commit *commit2;
 
 			for (;;) {
 				while (isspace(*p))
 					p++;
-				if (!skip_fixup_amend_squash(p, &p))
+				if (!skip_fixupish(p, &p))
 					break;
 			}
 
-- 
2.29.0.rc1

