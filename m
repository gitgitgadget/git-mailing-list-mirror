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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F03C433E6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE79C64FD3
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhCJToj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbhCJToN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:44:13 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629F7C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:44:13 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id n17so5447076plc.7
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mcS+cwJAO9Eb4R+IsReFOa08QcwCUEWiCUs1P4606Mk=;
        b=p3+/CDJ65OvwPvlKJOpDxQF5onL7Tse9tUkq7oN4au/zQRnlgPdfDcullCP06MKbrx
         6NFn0pd7J2Vz6BUc6GMGZmUMASSqYqmbxUofvl5mSO0Hw4MWStTOew20++XPzyep9My/
         hHztALzVJdupr/KLkxoMcuscupkyGA147FOvWPndyiHZ6CarPRA30rixeKgj84CRplaU
         zAwgIbAPhLYKH784yevjAR5ANLrCp28OeDkrqr2LyRyCRsjR5b4VC3XK63ursatYYA6N
         xFx5Uxz6/ZV9ys1GqW43+6Btit6A40L5o2hppnaUaqDcQt3Az+/ydvStmqvpVpRYkHYD
         Eodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mcS+cwJAO9Eb4R+IsReFOa08QcwCUEWiCUs1P4606Mk=;
        b=fELg+Yw1vvHiuKfkYFuBW8NzlMt6RgLQsX6kuCkIGJEkIVYXG+Jv/4Ka18bFLpn+f+
         o8cBZ2/6E6RC7RLNR65TDYK/XVWWOXJaaBura7bSfzHyoZ8XwH6BSLJuDb0EfaM6D0FR
         vZImg6s20sa/7GmtIFhziiGxsaSmrPdfPHFPMZvZza6vjOBOtY9pVtYQqW/DIG0ftU4b
         3ji9GWdbm59fvttdMTSWLOll5mVn1pyehnPG+Bhe+G26ptlO6ILRJwVn8timONzTReDi
         rl4p5iFAbz61oq/CHvD9fmLYCFIiBf0m4FGXLflA0TuCDb4U1Ot3Q95hhVZKXcj6PQty
         PGGg==
X-Gm-Message-State: AOAM533RVLxGVyDB6DnLhC5NjEkiCeldhM1qqDm3mkqh9a9pODzQimlu
        qWyNCsXwXaiDvPb65xi8MnY4n0wuenVUVA==
X-Google-Smtp-Source: ABdhPJxE6DtTSlIcw6MAk0MypxeHuitAHRW2dZtunFq2bznH8wEq5A5mOIjDfsWDQWnKH9MQiIM2Ww==
X-Received: by 2002:a17:90a:7103:: with SMTP id h3mr5167004pjk.82.1615405452696;
        Wed, 10 Mar 2021 11:44:12 -0800 (PST)
Received: from localhost.localdomain ([2405:204:130f:1562:5082:417f:76e8:c75])
        by smtp.googlemail.com with ESMTPSA id p5sm296480pfq.56.2021.03.10.11.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:44:12 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        chriscool@tuxfamily.org, phillip.wood@dunelm.org.uk,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v4 1/6] sequencer: export and rename subject_length()
Date:   Thu, 11 Mar 2021 01:13:04 +0530
Message-Id: <20210310194306.32565-2-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210301084512.27170-1-charvi077@gmail.com>
References: <20210301084512.27170-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function can be used in other parts of git. Let's move the
function to commit.c and also rename it to make the name of the
function more generic.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 commit.c    | 14 ++++++++++++++
 commit.h    |  3 +++
 sequencer.c | 16 +---------------
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/commit.c b/commit.c
index bab8d5ab07..199c7e274c 100644
--- a/commit.c
+++ b/commit.c
@@ -535,6 +535,20 @@ int find_commit_subject(const char *commit_buffer, const char **subject)
 	return eol - p;
 }
 
+size_t commit_subject_length(const char *body)
+{
+	const char *p = body;
+	while (*p) {
+		const char *next = skip_blank_lines(p);
+		if (next != p)
+			break;
+		p = strchrnul(p, '\n');
+		if (*p)
+			p++;
+	}
+	return p - body;
+}
+
 struct commit_list *commit_list_insert(struct commit *item, struct commit_list **list_p)
 {
 	struct commit_list *new_list = xmalloc(sizeof(struct commit_list));
diff --git a/commit.h b/commit.h
index f4e7b0158e..e65d9b3e75 100644
--- a/commit.h
+++ b/commit.h
@@ -165,6 +165,9 @@ const void *detach_commit_buffer(struct commit *, unsigned long *sizep);
 /* Find beginning and length of commit subject. */
 int find_commit_subject(const char *commit_buffer, const char **subject);
 
+/* Return length of the commit subject from commit log message. */
+size_t commit_subject_length(const char *body);
+
 struct commit_list *commit_list_insert(struct commit *item,
 					struct commit_list **list);
 int commit_list_contains(struct commit *item,
diff --git a/sequencer.c b/sequencer.c
index abc6d5cdfd..da7d54c7ce 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1724,20 +1724,6 @@ enum todo_item_flags {
 	TODO_EDIT_FIXUP_MSG    = (1 << 2),
 };
 
-static size_t subject_length(const char *body)
-{
-	const char *p = body;
-	while (*p) {
-		const char *next = skip_blank_lines(p);
-		if (next != p)
-			break;
-		p = strchrnul(p, '\n');
-		if (*p)
-			p++;
-	}
-	return p - body;
-}
-
 static const char first_commit_msg_str[] = N_("This is the 1st commit message:");
 static const char nth_commit_msg_fmt[] = N_("This is the commit message #%d:");
 static const char skip_first_commit_msg_str[] = N_("The 1st commit message will be skipped:");
@@ -1861,7 +1847,7 @@ static int append_squash_message(struct strbuf *buf, const char *body,
 	if (starts_with(body, "amend!") ||
 	    ((command == TODO_SQUASH || seen_squash(opts)) &&
 	     (starts_with(body, "squash!") || starts_with(body, "fixup!"))))
-		commented_len = subject_length(body);
+		commented_len = commit_subject_length(body);
 
 	strbuf_addf(buf, "\n%c ", comment_line_char);
 	strbuf_addf(buf, _(nth_commit_msg_fmt),
-- 
2.29.0.rc1

