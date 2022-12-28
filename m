Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92B9C46467
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 18:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbiL1SBt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 13:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbiL1SA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 13:00:56 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4C09593
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:45 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id y16so15544526wrm.2
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fidQFlaoa7Dfo31jFTP7XB3GTHt0mBrPuMV3HSHbZws=;
        b=GNdYe05pbN8yHa4rUI6dtcc2+7wwPJt4GhuHGjS1HmzDoguiOQQKakTR1nfNCry5Bp
         Dm6eKtOB9i3qZHRBZ87YTrEFUSC4nacaik5600/HadT1FKy+C6TnxoH49ryUbmfQyYIq
         mMp9/Ju5w0VcwMfxh3bXk7Fma4p4crOjVjuGeZzxkwpE8AZ0o4P5PLKdUFa6yms43QnJ
         B2lwzTHHIr6r73MSKEA3H/2q90GPgqabVIkbL0scZOjpvcKMrzPZwHEThnFdRxEWwziS
         X4emIKWoi3lyPPqT8j5bWwCDDB65bgbE4iAN3zoBAFc2menl2nDQGQH6wg7HPf1tczhO
         dHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fidQFlaoa7Dfo31jFTP7XB3GTHt0mBrPuMV3HSHbZws=;
        b=For4FRWZFqPnIyny3A2zg251FxUG95E/SqXDk5Ktf/iN4mBZDzuWJ1aAnhygh2SoWH
         GHiqxJpSfUOyxOXVgnJ6pyISePMTWXHLYWCAdnsH9O5BIU2ajDCV0+QZM6nHeTfDC3gq
         CPMa/HufW0R/JH6pqadysKmieGqI3kyeB9LvLNxoZclrIMTWXw4AZwdluy0NS1wGRlmd
         KAZfdf8uA37c0vb7YMCE0CmUdGtpkCmDHOlIDd671dI6uxsEEZ0gc73dL73azTkLd4gI
         JbJRAlrEJiQ5KTP7NOuxxMfHl0DOgyNHima2WAPLHUkf5Z7H5oKqd5SOtz4MsH/iNNsi
         a7kw==
X-Gm-Message-State: AFqh2kpFm2LtZjzPI7ER529huU05fZllNih44sfHWob5VupnIqyy61zs
        U8QmgAgpIBDX7ExLhXgdmKd6hR0uc3Yd1g==
X-Google-Smtp-Source: AMrXdXtqvzHuJSQCHnWgEWGU4Z9VOqlXDT5fo25DShkSmIQ0gyecYmAxz1Av+GjcN6N/3g5kctW/Sw==
X-Received: by 2002:adf:fa0b:0:b0:268:2971:465f with SMTP id m11-20020adffa0b000000b002682971465fmr15656637wrr.50.1672250443485;
        Wed, 28 Dec 2022 10:00:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002428c4fb16asm16022480wrq.10.2022.12.28.10.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 10:00:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 18/20] object-file.c: free the "t.tag" in check_tag()
Date:   Wed, 28 Dec 2022 19:00:18 +0100
Message-Id: <patch-18.20-aa4df0e1b5c-20221228T175512Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.gb0033028ca9
In-Reply-To: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been with us ever since c879daa2372 (Make
hash-object more robust against malformed objects, 2011-02-05). With
"HASH_FORMAT_CHECK" (used by "hash-object" and "replace") we'll parse
tags into a throwaway variable on the stack, but weren't freeing the
"item->tag" we might malloc() when doing so.

Mark the tests that now pass in their entirety as passing under
"SANITIZE=leak", which means we'll test them as part of the
"linux-leaks" CI job.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c         | 1 +
 t/t3800-mktag.sh      | 1 +
 t/t5302-pack-index.sh | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/object-file.c b/object-file.c
index c1b71c28347..36ed6c3122c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2331,6 +2331,7 @@ static void check_tag(const void *buf, size_t size)
 	memset(&t, 0, sizeof(t));
 	if (parse_tag_buffer(the_repository, &t, buf, size))
 		die(_("corrupt tag"));
+	free(t.tag);
 }
 
 static int index_mem(struct index_state *istate,
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index e3cf0ffbe59..d3e428ff46e 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -4,6 +4,7 @@
 
 test_description='git mktag: tag object verify test'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 ###########################################################
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index b0095ab41d3..54b11f81c63 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='pack index with 64-bit offsets and object CRC'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.39.0.1153.gb0033028ca9

