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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF81EC432BE
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 01:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A803D610C9
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 01:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhHPBQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Aug 2021 21:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbhHPBQc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Aug 2021 21:16:32 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168B7C0613C1
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 18:16:02 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id b207so7885791qkg.9
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 18:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wyA3dN81AVx2GzmtkHaue0dKNMMuOYh+IsxYXeo10C0=;
        b=McL32aSI/6ZfiQCl8DjqtX8y4lNevnN7081P5/j9BHZS9fvujkBt1CZJnKhJZ6IYos
         n5B6mZWQS9malTg+4lQwLnoBMgxJCZLjlSOvlF9BtOMFnvbsRAuPwYiG0h5p1vNAfQd6
         Mm5z/uZVLBUQJaTIrvESSscCpvmjCmIEuqMwrWM+J43E94IHLhIcfXDXJHPGfhMtqGrh
         h0NakfEIVPxza/wqXEde573T9fqhK7uXjwagrvUWsgetsvJtWuHpvSN4B4d+n1kP9MDl
         L//oCmCizR5XJMS5cAzr0YoB3xM0NuZFmpUiatDKJ6TA1PirCL+t1aLss0HDIriufgom
         yhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wyA3dN81AVx2GzmtkHaue0dKNMMuOYh+IsxYXeo10C0=;
        b=uSUkoHIFDcd0rUiSFlqROv44dPcT0bQYytoYzIdIwj8AVVYqGYtltJmSatKhSUlyMO
         VmwiHJDoIMlkGCVn+7A4JYzox8cpKfBP5mZqfLJvTa+G5CvoXNxxsCWVlWOpR7HoMdfP
         aqvnEkzcMcXMHCcCYppoJkrPhGJ+kAH1FvGtLApo3ZahvF4mK4qbcClh0d9fuCQfZkWJ
         Q6ygkZtoVgxExPsEdRsnGBIZqXO4l1H30UT9xEEPBmDb4mRLsCo6bu7hm66F6URdLOB+
         Y23URe3FTLMxLQtjtMUxNLUtuRiHKmQEPbr0bcs8LuIqwC5znACL4w97ruhUCzHjMKBq
         qxMg==
X-Gm-Message-State: AOAM532ugugMx5YILZzuseO+pgWQ8h4nnAmHhY3i8Mgoufelx1P+QtQW
        1Ae2DuFYL8lHrp/IEUZ3Oh4Sj1SP0hE=
X-Google-Smtp-Source: ABdhPJyahuRsyBVAIWW4N5EHTTAuvYF9XBFoeMj7ibNgpgkEXQ7tgbFgUqGJUuVHxWb1ZOtJmbHeCA==
X-Received: by 2002:a05:620a:28c5:: with SMTP id l5mr13680779qkp.130.1629076561125;
        Sun, 15 Aug 2021 18:16:01 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id f2sm4121181qth.11.2021.08.15.18.16.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Aug 2021 18:16:00 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 6/7] fixup! reftable: reftable file level tests
Date:   Sun, 15 Aug 2021 18:15:37 -0700
Message-Id: <20210816011538.34199-7-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc2.476.g1b09a32a73
In-Reply-To: <20210816011538.34199-1-carenas@gmail.com>
References: <20210802190054.58282-1-carenas@gmail.com>
 <20210816011538.34199-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

C99 style loop initializers still problematic with gnu89 C in older
compilers.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 reftable/readwrite_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 42ca48f83c..146b00cb02 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -120,7 +120,7 @@ static void test_log_buffer_size(void)
 	struct reftable_write_options opts = {
 		.block_size = 4096,
 	};
-	int err;
+	int err, i;
 	struct reftable_log_record log = { .refname = "refs/heads/master",
 					   .update_index = 0xa,
 					   .value_type = REFTABLE_LOG_UPDATE,
@@ -138,7 +138,7 @@ static void test_log_buffer_size(void)
 	   hash, to ensure that the compressed part is larger than the original.
 	*/
 	uint8_t hash1[GIT_SHA1_RAWSZ], hash2[GIT_SHA1_RAWSZ];
-	for (int i = 0; i < GIT_SHA1_RAWSZ; i++) {
+	for (i = 0; i < GIT_SHA1_RAWSZ; i++) {
 		hash1[i] = (uint8_t)(rand() % 256);
 		hash2[i] = (uint8_t)(rand() % 256);
 	}
-- 
2.33.0.rc2.476.g1b09a32a73

