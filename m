Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9767DC4332D
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 13:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B70C64F26
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 13:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhCMNmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 08:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbhCMNmb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 08:42:31 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30C5C061574
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 05:42:31 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id y67so3762543pfb.2
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 05:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mcS+cwJAO9Eb4R+IsReFOa08QcwCUEWiCUs1P4606Mk=;
        b=XzoAhE/rFL858RLsXnT3mCi+Qcc2LTYI4aIes0HadC0nJegEcos8RJq4zE8+YcrlUo
         dVhU/jQ2rip3g/wNeEIP8BsuneQqu5pMLGLLPql90lQ6JNUQNXnXfxt5eHPUeVKtFk0k
         rJ8njReOYUwdHogsAyf1YGBKRcnhgsVyEmjnVVwsmJF+r1YJHm0uTwpOiGmSFLW1QxrT
         rrnCr2hug1wTkdzFGNgjLljSMPe1hQieaEA+h5TcEJGqNPIgRngQ5vhRfVnUtMNtAkKj
         5lcl2Zq/PG2NZtTOCNEU6Oo5ZY7zOC+ZgqwSJN0OmrVzhBz6RHWslOUUjJMottPn5lgg
         5hgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mcS+cwJAO9Eb4R+IsReFOa08QcwCUEWiCUs1P4606Mk=;
        b=CjXIbjqEZOlZSBDaR37nGpQ7w6STu8W26au/rpnawHOVeBW8CUhDw0he1Iy1JPixyq
         /MMUQz2xKVkMwlmaIARYXToUeCamyX03aeDgYStmpCnjWfXi8B3DtHJ/MMvecix6jdQ9
         b5WMbsMXsn/ydxI7y7y19ldejYCcKvXs0Rov3c/8ihHU/SU/Z8JCemOObhVPxGBvHpHK
         GOBLEmvc+/dDyTcXsVWITajBoH+GQf8tlOjfgj01CWKFsgEX/JnXqKwu6PfslRajX6l6
         nRCXsdypwZZKqU4cPmvUSh6uOlb6j82yrxThjXO8NRH4R8SOOnA00nxxCgXhrCP4wlTy
         b8yQ==
X-Gm-Message-State: AOAM530v/yf9+FBNoVp/jpL2GpbQ2OdMrCSu0QQitlvE6Y/W8rpmud4i
        VchJXHeCLhnbL8SCqfm0xI1n4sJJqltb5g==
X-Google-Smtp-Source: ABdhPJw/dT15D6HTY/ZIMZMkwZgIX5Cv7a5v7iGnAbOSMNA6xiHcrSF3F7woXU0cVP+lU9PGhN8KTg==
X-Received: by 2002:a63:504a:: with SMTP id q10mr15834833pgl.188.1615642951046;
        Sat, 13 Mar 2021 05:42:31 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d98:f55e:3466:3377:eaba:8d02])
        by smtp.googlemail.com with ESMTPSA id y20sm8657809pfo.210.2021.03.13.05.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 05:42:30 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, sunshine@sunshineco.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 1/6] sequencer: export and rename subject_length()
Date:   Sat, 13 Mar 2021 19:10:08 +0530
Message-Id: <20210313134012.20658-2-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210310194306.32565-1-charvi077@gmail.com>
References: <20210310194306.32565-1-charvi077@gmail.com>
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

