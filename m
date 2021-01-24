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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6091C433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8810B22D57
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbhAXRHc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 12:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbhAXRHU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 12:07:20 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D755C0613D6
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 09:06:40 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id n7so7338255pgg.2
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 09:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+sN6HX1BqV3b1XdRd5cbt+4ED2RdKrpGKUBRJZU//UU=;
        b=ezpVNRi81eD9RjPJaLarA7xXtvNB51L47fGG8YrX+TwB52JI02MmsFaTW9U9p70jZM
         42y+qLVL8XO1MAAggzKvCnyNcRlB4I1AtibhjUzq0Du58tmixz3mBI450q7x6DMjWr68
         ZjAf0sP8cGS4kCA+cnN6o+al8g++xctiKzzhHf9dF95kfJ7QFiZdTqeGDjCJvb74LarK
         uaJMYVSpFkrrowKoQtdzcWphCuaSwuhb7K/C4DFC6ThDEqeKUwVXFBiBfXJqTH97RHQU
         YQfbSsKMSJ0KOx4x4kyD86SR4DJUfqQdaxiOws+2XKqRifs8v77W1COyCgz2gJGYZVcq
         GyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+sN6HX1BqV3b1XdRd5cbt+4ED2RdKrpGKUBRJZU//UU=;
        b=stWJRIEZmxR/W8oLGQR3bJlT6c0tkXHoD8UnfDZuyOOVQSjHK7psZsC4SPMrMsnzu3
         TaclFh4HvklnJ3nf3+ldjwCfup2ZljilhKX7AoIjP/qGqMQj/jwu/D5eGGKsU7VslOCz
         MYzvKzJRf9MqDiXGqGYMrNzG8HzTgPeGoOaEb2yND2Qu7z9NJiKEZ3e9JLJFeKAD39xT
         riM360Cv1jVH91l1VS+qUUi4dC6GifPih3gbK1gBt2fvMHcN9TEXQfT8/jkRc3nQCxTl
         ieXfy0+CB/GIRhUPUGJzGD7UEad1MtcO/UT3R1XI1f8Hc5ikYJFTsU7pPpwLYXcoUYl5
         0Dhg==
X-Gm-Message-State: AOAM533ePt9ie5xvy5j74HI5pXX1COOT1f/Iv7oU3tEsuR92fdzqyPO9
        6bn/XHphdW8Sy55i+SKyFtxQdfkUyoNvpA==
X-Google-Smtp-Source: ABdhPJx3kw7cPHXxnsdv99Aq9VXCIRwKjSBxxUpDpWw7GjAvZ+2F8XZcmoWz7u9IPOG2K94dSnLsEQ==
X-Received: by 2002:a62:2f07:0:b029:1bb:5f75:f985 with SMTP id v7-20020a622f070000b02901bb5f75f985mr8400262pfv.76.1611507999210;
        Sun, 24 Jan 2021 09:06:39 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d0e:58a:f516:739c:ea0e:a6ba])
        by smtp.googlemail.com with ESMTPSA id r30sm16283308pjg.43.2021.01.24.09.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 09:06:38 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        marcnarc@xiplink.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 5/9] sequencer: use const variable for commit message comments
Date:   Sun, 24 Jan 2021 22:34:03 +0530
Message-Id: <20210124170405.30583-6-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210124170405.30583-1-charvi077@gmail.com>
References: <20210119074102.21598-1-charvi077@gmail.com>
 <20210124170405.30583-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it easier to use and reuse the comments.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Reviewed-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 sequencer.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 09cbb17f87..6d9a10afcf 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1732,6 +1732,11 @@ static size_t subject_length(const char *body)
 	return p - body;
 }
 
+static const char first_commit_msg_str[] = N_("This is the 1st commit message:");
+static const char nth_commit_msg_fmt[] = N_("This is the commit message #%d:");
+static const char skip_nth_commit_msg_fmt[] = N_("The commit message #%d will be skipped:");
+static const char combined_commit_msg_fmt[] = N_("This is a combination of %d commits.");
+
 static void append_squash_message(struct strbuf *buf, const char *body,
 				  struct replay_opts *opts)
 {
@@ -1741,7 +1746,7 @@ static void append_squash_message(struct strbuf *buf, const char *body,
 	if (starts_with(body, "squash!") || starts_with(body, "fixup!"))
 		commented_len = subject_length(body);
 	strbuf_addf(buf, "\n%c ", comment_line_char);
-	strbuf_addf(buf, _("This is the commit message #%d:"),
+	strbuf_addf(buf, _(nth_commit_msg_fmt),
 		    ++opts->current_fixup_count + 1);
 	strbuf_addstr(buf, "\n\n");
 	strbuf_add_commented_lines(buf, body, commented_len);
@@ -1770,7 +1775,7 @@ static int update_squash_messages(struct repository *r,
 			buf.buf : strchrnul(buf.buf, '\n');
 
 		strbuf_addf(&header, "%c ", comment_line_char);
-		strbuf_addf(&header, _("This is a combination of %d commits."),
+		strbuf_addf(&header, _(combined_commit_msg_fmt),
 			    opts->current_fixup_count + 2);
 		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
 		strbuf_release(&header);
@@ -1794,9 +1799,9 @@ static int update_squash_messages(struct repository *r,
 		}
 
 		strbuf_addf(&buf, "%c ", comment_line_char);
-		strbuf_addf(&buf, _("This is a combination of %d commits."), 2);
+		strbuf_addf(&buf, _(combined_commit_msg_fmt), 2);
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
-		strbuf_addstr(&buf, _("This is the 1st commit message:"));
+		strbuf_addstr(&buf, _(first_commit_msg_str));
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_addstr(&buf, body);
 
@@ -1812,7 +1817,7 @@ static int update_squash_messages(struct repository *r,
 		append_squash_message(&buf, body, opts);
 	} else if (command == TODO_FIXUP) {
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
-		strbuf_addf(&buf, _("The commit message #%d will be skipped:"),
+		strbuf_addf(&buf, _(skip_nth_commit_msg_fmt),
 			    ++opts->current_fixup_count + 1);
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_add_commented_lines(&buf, body, strlen(body));
-- 
2.29.0.rc1

