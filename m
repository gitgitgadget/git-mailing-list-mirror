Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB61D1F463
	for <e@80x24.org>; Wed, 11 Sep 2019 18:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfIKSVR (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 14:21:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32948 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbfIKSVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 14:21:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id r17so2829038wme.0
        for <git@vger.kernel.org>; Wed, 11 Sep 2019 11:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yzr0H2zKHhfVvG2fxuqRx6GmKY11fhhSrlzJfnheXSs=;
        b=vC/vTquXW4ER4O98uXz7psXXH0TIuadnSw1yebh0/BUiQeD6WAYsMpfZHDifSBgiEH
         AXWTp8MMo5r0HA7x29itNvUbo2lCgpn4g76wW7/k4Y4XnlFu9poI6HtikDo2wKKIxG0O
         D/tEFkupKon2CL/MhH2txAp1uz/ApjMi0LAKL8fAhZC0v8F5pT3LKrVqjkCoXcKUf3O+
         VP7YxtlLjJvudlahAuF38uyeP2dR8m2cmpyJcPF9WL6MsFLLZ3CtzoBb3jfKGGPo8Mtn
         9egYLkXeqkz+ROZcd39bIghxX3xfBILp0WzjcVlMO1Eo/NKkU+f9CNtQnT7q2gs9fDhX
         CMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yzr0H2zKHhfVvG2fxuqRx6GmKY11fhhSrlzJfnheXSs=;
        b=YbD8xZFNfUD9yy6oamGW8km2P7wUHaVgDQ+bKTOEbavq/ZmPhAGWemdmcAAd87iNsi
         Y97hEGBJLtsAX/QCzG6d4UdGDzARlGg8jaZ3trFCLZicBjhiYJpSO6GcMFkPxb92XJs7
         vcdhk8pGDatW2AYxNgYDNAyf7Ty8lD0YCBwisNY1k6KzbjZTTpn5W42uNlea5U8zfGZV
         WmnYYCxWnXgD7XkOgvU0WJE6YmDwVhBfZkzRisNWyJKmjfzhPRg+uYwOS1pcpeEq4JhG
         XOpYjXEJxsvRMH/S2z/KFALr4vcf0qlxerCg7H6WE+0gFY2Qee38RemMRIgFfVqv5+dt
         gjGQ==
X-Gm-Message-State: APjAAAVywfldt6/vLHwPHIJnAH/T1uO8EK0+7+8KHz/QXsxR2U6pr0hN
        to/Eq2B7yeSLGXjBCuhJ5ldeR7sU
X-Google-Smtp-Source: APXvYqyOwSNzogqCZFZkEaq+Dh4ELl3RCWwsix9/LF1YpFmBtcLG1hgL0fD6x8JB0eIqSzbReurhpA==
X-Received: by 2002:a1c:720e:: with SMTP id n14mr4862612wmc.54.1568226074285;
        Wed, 11 Sep 2019 11:21:14 -0700 (PDT)
Received: from localhost ([95.148.214.9])
        by smtp.gmail.com with ESMTPSA id o8sm3409146wmc.30.2019.09.11.11.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 11:21:13 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 2/3] merge: use refresh_and_write_cache
Date:   Wed, 11 Sep 2019 19:20:26 +0100
Message-Id: <20190911182027.41284-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.194.ge5444969c9
In-Reply-To: <20190911182027.41284-1-t.gummerer@gmail.com>
References: <20190903191041.10470-1-t.gummerer@gmail.com>
 <20190911182027.41284-1-t.gummerer@gmail.com>
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
index e2ccbc44e2..83e42fcb10 100644
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
+	if (refresh_and_write_cache(REFRESH_QUIET, SKIP_IF_UNCHANGED, 0) < 0)
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
+	if (refresh_and_write_cache(REFRESH_QUIET, SKIP_IF_UNCHANGED, 0) < 0)
 		return error(_("Unable to write index."));
 
 	write_tree_trivial(&result_tree);
-- 
2.23.0.rc2.194.ge5444969c9

