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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8768CC433E0
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 07:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A89664E67
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 07:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhCOHzy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 03:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhCOHzW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 03:55:22 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CAAC061574
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 00:55:22 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c17so2453287pfv.12
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 00:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mcS+cwJAO9Eb4R+IsReFOa08QcwCUEWiCUs1P4606Mk=;
        b=NAOj5LH6gGLqz45RGAv89KwYwFIJIJVJQL0cmkwENonkzvi48sq5pbc+nEn0iY4NYV
         LJFUpRyyv2JR6c0wBWWVoHA+om1tLnFa4pD+rTvZb9+EyhnF+v8tqfFfN2cQ81Y7e+1G
         uRFcUldqozpR21FqBJydiJChsRIVY0GQbgZ86ttWKuat2suP/v4Xv5O1Hl1D/mbWFl9O
         +gBkWO7oiQTU8ziEmSP3GR0m762cf28xFshmdtkTafw4823Dnm9mhXwqLajyXh9tirIZ
         Oo1q7I7R9mU4DPDPqsOTJiJ3osK3LmlwFE2zbEc5h3Tgph1HVROM2ngewF24R+EX2l0Q
         QTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mcS+cwJAO9Eb4R+IsReFOa08QcwCUEWiCUs1P4606Mk=;
        b=UhCwBiJq30qk+KkhmvjcLm4g+kzFkzMWKPoprJSg83bJ9yGMVGipmT/bU0OgecsyTh
         L0SHxHhgC8KRJkI+mcwrIrMAcuOA1k8zEiSxpxpTfzxDMgcuZ5uqAtZuWo7RXY3+F+LD
         PiNdgSMMYKG0Jjj0w/q2b19e02Cgd0Hn297c5muw1PpbRMCYryzw/7ruJzKuJkzYZb5m
         FDdlRjv53OoVakgQ7RrwAEBly+cfwZsJimVrKdj7U1/JFxibF9blUMC3NxaFRjMKcMVy
         8RDOo8FMGpWZspBFzPAeh05DXsG38EYGAO+5FTSEqzcfdb2UKdqIjTNWKfOOwxxsWrdg
         3Sqg==
X-Gm-Message-State: AOAM533zzJ3hFTRKsrAeE7oL/7uDb4+Px3/vJwj2w5fsB80Y4IpAVIaL
        qo4i9G5mihpGuCsRL47TQ32tKdWjQP/hUg==
X-Google-Smtp-Source: ABdhPJxbeR9NObawtDi/UzFXDu8zqXAuSgSdP/gRVCLYAABjENlKektkAZA7flH38YZCwRmYFGtPKA==
X-Received: by 2002:a62:fc10:0:b029:1ef:141f:609 with SMTP id e16-20020a62fc100000b02901ef141f0609mr23095178pfh.78.1615794921733;
        Mon, 15 Mar 2021 00:55:21 -0700 (PDT)
Received: from localhost.localdomain ([223.233.99.139])
        by smtp.googlemail.com with ESMTPSA id fs9sm9350911pjb.40.2021.03.15.00.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 00:55:21 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v6 1/6] sequencer: export and rename subject_length()
Date:   Mon, 15 Mar 2021 13:24:31 +0530
Message-Id: <20210315075435.18229-2-charvi077@gmail.com>
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

