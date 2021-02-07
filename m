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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184CAC433E0
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD96364D9E
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhBGSTh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 13:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhBGSTf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 13:19:35 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D06DC061756
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 10:18:55 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id o7so8815137pgl.1
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 10:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hkVWdNQiQTnGfiwViD6nDYqlHF5k8u66zHfNdY58TMY=;
        b=RzjYY1arwXM1GEfy/ocvlkHX+x/dQQ+49Ci9gIt2bvoN2sND+qZFeUsW/Bd2coOT9I
         8ndjQzX3K0N3CF6910JxbPKt218siikf/gshIThkxFAV2uZeMYxBHW69pi9J5mXDkK1x
         /mMsotqUoKn51hPEd3Ax/6g2i1qjhJxU9BZKgGiRTCBGBscpVIEAUctSL7T0VReLnrKa
         PzyC1o38+444svvwGJ9JIXDkdsP8tA6RHn7ia2Ah8rjBc4v64Or71iuO4yQ2HQaxg/G8
         8LRdwdXWvZuqjRqG9TY+SrfJvxnC7NY1Cdit+wJGQRc+f6xqYPH++T2+adQ86gKalBRu
         RCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hkVWdNQiQTnGfiwViD6nDYqlHF5k8u66zHfNdY58TMY=;
        b=WHUTFzJyZZTFV5FAv2Oq5UQZ4vl8W5nEHXEMlglJrWZQN+FaTc6Ks6fZr194UObT9D
         45sGDyzgUSONtFjpeKhHAkYZbmBUKyRTfcao62kRVYV1M5n8CAuCtiwfAskuQYKuSuSZ
         W9FSCzvu0N8j1DSOt2SEPovMAK3bcIW/s3ExB7BvV/O+gcRLNfqCxfYwb+I7fG/u0mrH
         Dijcm1VnEQBKO/E0YZgG2lqyxX9Q+2xlIzMiqBi6bLsvGXozZ9GjdZyHLvdldeZsrVs5
         9FYdgYDVY3+D2lmrZk1aQlLug505L0F44x/oICTljYqYX0cQJxdgM4bzsMUyQC4cLVsO
         lamQ==
X-Gm-Message-State: AOAM533EFepAmGftY3MHQqRAxaZYl7SX0dUjt30r8KqyIvtIzYocmYsv
        Ud0q2IY57uPnB9JReSWZPj663ySCf7ApZA==
X-Google-Smtp-Source: ABdhPJwpxRFub5b8HlVqiOjblfaj9uN3RkGkDFGTZXUQGaZ2oVobGBcyA1W7khFEK7Uw/Y0AcsXVcQ==
X-Received: by 2002:a63:db03:: with SMTP id e3mr13723174pgg.225.1612721934376;
        Sun, 07 Feb 2021 10:18:54 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2e07:af0b:4438:7fbe:1d1f:8bc])
        by smtp.googlemail.com with ESMTPSA id n7sm16375194pfn.141.2021.02.07.10.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 10:18:53 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/7] sequencer: fixup the datatype of the 'flag' argument
Date:   Sun,  7 Feb 2021 23:44:34 +0530
Message-Id: <20210207181439.1178-2-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As 'flag' is a combination of bits, so change its datatype from
'enum todo_item_flags' to 'unsigned'.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 sequencer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index d09ce446b6..f3928cf45c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1744,8 +1744,7 @@ static const char skip_first_commit_msg_str[] = N_("The 1st commit message will
 static const char skip_nth_commit_msg_fmt[] = N_("The commit message #%d will be skipped:");
 static const char combined_commit_msg_fmt[] = N_("This is a combination of %d commits.");
 
-static int check_fixup_flag(enum todo_command command,
-			    enum todo_item_flags flag)
+static int check_fixup_flag(enum todo_command command, unsigned flag)
 {
 	return command == TODO_FIXUP && ((flag & TODO_REPLACE_FIXUP_MSG) ||
 					 (flag & TODO_EDIT_FIXUP_MSG));
@@ -1850,7 +1849,7 @@ static void update_squash_message_for_fixup(struct strbuf *msg)
 
 static int append_squash_message(struct strbuf *buf, const char *body,
 			 enum todo_command command, struct replay_opts *opts,
-			 enum todo_item_flags flag)
+			 unsigned flag)
 {
 	const char *fixup_msg;
 	size_t commented_len = 0, fixup_off;
@@ -1906,7 +1905,7 @@ static int update_squash_messages(struct repository *r,
 				  enum todo_command command,
 				  struct commit *commit,
 				  struct replay_opts *opts,
-				  enum todo_item_flags flag)
+				  unsigned flag)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int res = 0;
-- 
2.29.0.rc1

