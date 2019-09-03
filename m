Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AEF71F461
	for <e@80x24.org>; Tue,  3 Sep 2019 19:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfICTKu (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 15:10:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55333 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfICTKt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 15:10:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id g207so642885wmg.5
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 12:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lkitX9/Yct+qYCp+CzaX96mAr/7OypfSkTJZmiskgng=;
        b=ASyFms4gyrBJ9YhXA99hTfK8E978OZnpvRw8jXLzwM4otZX99ovdyhtj89uWVp1HRI
         PsaoohW6CuEdpuvjL5oQx3Yh3HxWw7d0EVyijmuxG5C1WJcPO37A1qDkxOGcZOcyaGNU
         1PvZhtnWclR1zeVI/tc7ZejseqJ7zErMpvJNDP7UpKnR6rRbe2nLkL51jQ9G8Fo79zCA
         PBbNZl+bSbVPRqSud+8MUeSTq0XNZ0VOmo/soL7RwFRf8AAUYdnbv9SUm5Ayn9BpN8Gn
         xXbjWGzvnHR9SbPqAcsO3HvKGy2Hve6fR0obxzFv2etkcPY//P3BLgmJ9XbUu0OCN2x4
         2BEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lkitX9/Yct+qYCp+CzaX96mAr/7OypfSkTJZmiskgng=;
        b=lHcisiHVpYP3Le/410CwHmffrzmAd3BPnr2DaxV4j70CWSsCQ+Vlz/SEI8qohZwdcB
         XsnmUKazEniFvsFMhU6PAepMgHRh8c5p3DWG8KYh7CKF28amhtfBX9e7zXohJx7bJB9J
         hutRxsQTWaXqm/aWMCG9neEsza7V4TARgh3RFOaAn6IDq86e9BsxTKNR1CZgNWeJ4w9S
         x0WUjqcvjLD3vpMBScC5HycCIZxhxxTe0nhgoF0mCzo3JFA4ER6cXJDwiQuykC6bisVL
         muwtRB8tjBwFf42tZYos0BAOVKomrWvMutv8+COL22VhZj0ZFTJd9DjIX0wd8fSkbwoi
         8hZQ==
X-Gm-Message-State: APjAAAXSfMZMa1K24qqtUNtMTi9WmTjBf8dyNTrLJXIMv84F3eGROJaL
        Z6esJIDbKeLOmIuuozJhjvCyHYEA
X-Google-Smtp-Source: APXvYqzBNwRY5vVe3JaL3vyBtcd2ZsJ2fQzbotrPrm1tJFvMwJBceGXJMlLy1yHLhVcZgT9DpqlOHw==
X-Received: by 2002:a7b:cc0f:: with SMTP id f15mr1037624wmh.39.1567537847700;
        Tue, 03 Sep 2019 12:10:47 -0700 (PDT)
Received: from localhost ([95.148.214.9])
        by smtp.gmail.com with ESMTPSA id f197sm427242wme.22.2019.09.03.12.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Sep 2019 12:10:47 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 2/3] merge: use refresh_and_write_cache
Date:   Tue,  3 Sep 2019 20:10:40 +0100
Message-Id: <20190903191041.10470-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.194.ge5444969c9
In-Reply-To: <20190903191041.10470-1-t.gummerer@gmail.com>
References: <20190829182748.43802-1-t.gummerer@gmail.com>
 <20190903191041.10470-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the 'refresh_and_write_cache()' convenience function introduced in
the last commit, instead of refreshing and writing the index manually
in merge.c

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/merge.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index e2ccbc44e2..0148d938c9 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -688,16 +688,13 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			      struct commit_list *remoteheads,
 			      struct commit *head)
 {
-	struct lock_file lock = LOCK_INIT;
 	const char *head_arg = "HEAD";
 
-	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
-	refresh_cache(REFRESH_QUIET);
-	if (write_locked_index(&the_index, &lock,
-			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
+	if (refresh_and_write_cache(REFRESH_QUIET, SKIP_IF_UNCHANGED) < 0)
 		return error(_("Unable to write index."));
 
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
+		struct lock_file lock = LOCK_INIT;
 		int clean, x;
 		struct commit *result;
 		struct commit_list *reversed = NULL;
@@ -860,12 +857,8 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 {
 	struct object_id result_tree, result_commit;
 	struct commit_list *parents, **pptr = &parents;
-	struct lock_file lock = LOCK_INIT;
 
-	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
-	refresh_cache(REFRESH_QUIET);
-	if (write_locked_index(&the_index, &lock,
-			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
+	if (refresh_and_write_cache(REFRESH_QUIET, SKIP_IF_UNCHANGED) < 0)
 		return error(_("Unable to write index."));
 
 	write_tree_trivial(&result_tree);
-- 
2.23.0.rc2.194.ge5444969c9

