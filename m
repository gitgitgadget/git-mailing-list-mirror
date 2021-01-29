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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC0BC433E6
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 18:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83B8764DED
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 18:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbhA2SXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 13:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhA2SWt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 13:22:49 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB84C0613D6
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 10:22:09 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id w14so6754993pfi.2
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 10:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wq7AT0GeWUiw6/y3jlwDs7feIY/g4Gw8ax680CWXrw4=;
        b=IeLCEcfZkH00Uzwr8YWoT5WqhjmFSAS57vphWMVfRqZUnpzPd2i+NL51gEZEvR7TTM
         muKUU47B5OAXPVSfPxDmiD3Lupo30fUiWpkTK24Jwc+396MUDeBdwguLDE7FKOV+QwF/
         COipCfaNtE1pxwElT/hEMq/55FJafTbaB1TA7PL3QYnwr0HY8iLPPBYyn+b6qgXLTxWx
         YJNTJtcN+LfKAb17C9bhBoV7bGbqJmrYM37hpex/nhe+HZdDeUKgsSo/sXt7WqDEjJ2u
         GMVW0MchY2Ezu1lSls4NXAPlhCBuKADzcYUOMb5D2wDd0dnoySSaDF6I9sozuXSbjRNl
         yzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wq7AT0GeWUiw6/y3jlwDs7feIY/g4Gw8ax680CWXrw4=;
        b=cDH7lgIaK9kI8HJBJDvFAb3E2g+CHMfCOgmI5JDOMiDISnsINHqGRNwUXx/MDPEoM/
         BV3nvL5ha1NnjcTlxhPd4qrlYAzxGVNyY0TwAXu5wFGSS+joGI2bSpDstcEGH82FYE3u
         USTibErWl90jpjUv8WQEmkCQA/w+66SfHbSb945BAOTqBbJkffS8hZSzVSBoNQyFWI7J
         dOwY54uC/vJSTa08FBqerSMYCfl1Lj+tX07UBGcWjiVw+w9a2ww9/50I9Ulc8vWfnn9A
         xiAZSdJwSU79L61o/WD/Cx56NXfylB7hpMk0a5T0WP2F7R6pomfrbz4etb1wJfkKhwwD
         80VA==
X-Gm-Message-State: AOAM533gW19yUgWIktC1QnpLUI8437ZMCeVMylsLtYbadKpALSv3vBhq
        ikHUgkyJwwMwiwNBSAYkkT9zALMI1wU=
X-Google-Smtp-Source: ABdhPJx5ShswnaUzxKYiQd47IuM8g56/yVYNT8ZBFWpRSPt0q/8V54JnkUOTyfdZYHxd/gjB7tVzUw==
X-Received: by 2002:a63:c64:: with SMTP id 36mr5961889pgm.282.1611944528711;
        Fri, 29 Jan 2021 10:22:08 -0800 (PST)
Received: from localhost.localdomain ([2402:8100:396a:4597:fd76:2af1:5584:160e])
        by smtp.googlemail.com with ESMTPSA id x141sm9497834pfc.128.2021.01.29.10.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 10:22:08 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood123@gmail.com,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v4 2/9] sequencer: factor out code to append squash message
Date:   Fri, 29 Jan 2021 23:50:43 +0530
Message-Id: <20210129182050.26143-3-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210129182050.26143-1-charvi077@gmail.com>
References: <20210124170405.30583-1-charvi077@gmail.com>
 <20210129182050.26143-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This code is going to grow over the next two commits so move it to
its own function.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 sequencer.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a59e0c84af..08cce40834 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1718,6 +1718,17 @@ static int is_pick_or_similar(enum todo_command command)
 	}
 }
 
+static void append_squash_message(struct strbuf *buf, const char *body,
+				  struct replay_opts *opts)
+{
+	unlink(rebase_path_fixup_msg());
+	strbuf_addf(buf, "\n%c ", comment_line_char);
+	strbuf_addf(buf, _("This is the commit message #%d:"),
+		    ++opts->current_fixup_count + 1);
+	strbuf_addstr(buf, "\n\n");
+	strbuf_addstr(buf, body);
+}
+
 static int update_squash_messages(struct repository *r,
 				  enum todo_command command,
 				  struct commit *commit,
@@ -1779,12 +1790,7 @@ static int update_squash_messages(struct repository *r,
 	find_commit_subject(message, &body);
 
 	if (command == TODO_SQUASH) {
-		unlink(rebase_path_fixup_msg());
-		strbuf_addf(&buf, "\n%c ", comment_line_char);
-		strbuf_addf(&buf, _("This is the commit message #%d:"),
-			    ++opts->current_fixup_count + 1);
-		strbuf_addstr(&buf, "\n\n");
-		strbuf_addstr(&buf, body);
+		append_squash_message(&buf, body, opts);
 	} else if (command == TODO_FIXUP) {
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
 		strbuf_addf(&buf, _("The commit message #%d will be skipped:"),
-- 
2.29.0.rc1

