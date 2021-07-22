Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB84C4320A
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89B9760E8F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhGVUsa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 16:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbhGVUsW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 16:48:22 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA6DC061796
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:28:55 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o3-20020a05600c5103b029024c0f9e1a5fso2093165wms.4
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ig84R0Sxm6LpAKCKuu0dx6i2mLBpT0q/MOLlR15s+eE=;
        b=IHpQyRlLFxLLe6tZVoZ6WZbPfRbzsaml1NMfyW5dY6kCg0/mdVxHHTEtbfXrluqgCx
         t7iWJf+DKw3wktHE+h1j7Uu0kjvKKXtSOyrHpgcEhumn1nJfaUmY7VkP6iMpuefCgCdC
         GY4RhEQG6YCF+n2h+12WzzsbCllVQweTwgyzM62TtBGGzEXw+YjmkI9vxTNvmUiOEHVJ
         cuy0Ig5h93aqWWFvRZ9DDzX9FObhKAtr5kdKYj2oXfY/0GFQ06iNtaorG00ZVwQGtGUD
         0IzmUPiDUXIb1ofe2oRFpc1M8+cd/G4BiRrqB1Kn6m9pKMwCzqbf4CxO7gSguxWdH620
         7waA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ig84R0Sxm6LpAKCKuu0dx6i2mLBpT0q/MOLlR15s+eE=;
        b=pzVFwKBy29cyyos43Aul9eIZl2AI/OyUFyAbVhxt1P3P/q7yQeGvOc9T3kAe5I2ljc
         BSLYerszftlM9phtFu8H/i4WWNf6GBGJ+EDuk85m58MJzoQqPcQae+1W3L7HaibRmjrY
         lbvO5WxkNHkv3/X1FVdgLPw/pVnhf9npshTWhkdZyVbyrcC4QmWBcUIX51RSSx5102cq
         aOeAXs0o44CX6R8+fElcJ9IUOXHbLif+VYPORjC6wkdq60EF5ZjLqeXoWuhawvkzUfd0
         fzD/HNNToCPgIN3OgtmGm5jL+/kBzTBqhhQl5HeHymNJ57uUMxlSzuAirEBM7D0osoJ/
         ZbvQ==
X-Gm-Message-State: AOAM531v0EkFRH8gSuvqzaVXRH7V2Dslw+4Krp53uqlx/zf2uX6IttKi
        Z1rX4rl8IrKVVRTJlV1R8tNn+EbOvbE=
X-Google-Smtp-Source: ABdhPJzGjIL3aNhvyVHCnJCNKf46/nzZeBeG2ObtaKnbiRst2k+DutZN2ce0CIVCPvAxroYo0RfgVQ==
X-Received: by 2002:a1c:cc02:: with SMTP id h2mr1420671wmb.39.1626989334446;
        Thu, 22 Jul 2021 14:28:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm3422434wmd.4.2021.07.22.14.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:28:54 -0700 (PDT)
Message-Id: <ccdbf3749fe6444e2638a62fdb594836e67450af.1626989327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
        <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Jul 2021 21:28:46 +0000
Subject: [PATCH v2 10/11] t6500: use "ls -1" to snapshot ref database state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

By doing ls -1 .git/{reftable,refs/heads}, we can capture changes to both
reftable and packed/loose ref storage.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t6500-gc.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 10c7ae7f09c..c2021267f2c 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -241,7 +241,7 @@ test_expect_success 'background auto gc respects lock for all operations' '
 
 	# create a ref whose loose presence we can use to detect a pack-refs run
 	git update-ref refs/heads/should-be-loose HEAD &&
-	test_path_is_file .git/refs/heads/should-be-loose &&
+	(ls -1 .git/refs/heads .git/reftable >expect || true) &&
 
 	# now fake a concurrent gc that holds the lock; we can use our
 	# shell pid so that it looks valid.
@@ -258,7 +258,8 @@ test_expect_success 'background auto gc respects lock for all operations' '
 
 	# our gc should exit zero without doing anything
 	run_and_wait_for_auto_gc &&
-	test_path_is_file .git/refs/heads/should-be-loose
+	(ls -1 .git/refs/heads .git/reftable >actual || true) &&
+	test_cmp expect actual
 '
 
 # DO NOT leave a detached auto gc process running near the end of the
-- 
gitgitgadget

