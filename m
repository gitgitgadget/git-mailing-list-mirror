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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3238C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 11:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85FEB64E57
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 11:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhBJLox (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 06:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbhBJLmd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 06:42:33 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9B9C0617AB
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 03:38:55 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id e7so1069201pge.0
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 03:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mvuwopjN7OnNPHLC0X4qMbrIGrMqiGqpbGzfrmtsdVg=;
        b=EziCSazacNFX5EVCgRc8Zlx4ELgNvmnn2b3PkEQBQOKaQhNkkbc1fJjed8EZVXhfaw
         XeuyCHrkPOJvtGGiighpEWI4AhQ4PLutKfTWMLCrZWqK/CXblRpBxpbnVazvAr3HxXGg
         UqCOzGgGu3Aonk42MiceCE3liRI5QvR9stVZ5BE9f1LvzSFayZ/ofAPb2IsFyeY5LytB
         TqCFHMQmDtKd3HWZjXDCSPF+cGsiW5PQ2GLSkgCCGWcMT2w5wKX7ldectNCJk8/34u2v
         WqHwN4OZ3pU9EB3UQBaX1aI8r9sGXEbC1wpDib8hHIuF5/XAvVAFBdEvimxOWPCC7P19
         wWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mvuwopjN7OnNPHLC0X4qMbrIGrMqiGqpbGzfrmtsdVg=;
        b=NqTsTlJUGIvu7VIenw2/ytiU+wBBY9L0aQXYZj0PA4C5J7QkGB4r9EP0GTCTvU1Mo3
         vPQN/eEp26f9POFqoxHdAuGf1uoBt5p07cKrDjzI3+mAo8WvtoqxiIrHmYhZgZJXFqLH
         3WFW0UJPFZdmPcD4N28+FTjI6chEUUGZSCN3D62fDtTnX4VIyWoaFywpbO+VSbvCaRc4
         4qAV3i+DMVenXTR74LwnhzI9EiOTFXAm3ITJD/Rmv67+NMN4I9ZHayPlk7bKrwnVM1GL
         o6z7szd+693QFpPpN4O06IUwLtG3uLVLUKIH32klvl7iY+ezwk6xvj+KDs9AM7+HNz5z
         BRbg==
X-Gm-Message-State: AOAM5337QJFTx5ABKvCIZyOc58TqEl55RWrJ0ptt3Q9sy7hqa0NKUBf6
        pOImP98wsAo0p1DW/wxLS0nCb7KzvIYI8g==
X-Google-Smtp-Source: ABdhPJwuCzPEZKIjDI2OmaLHKUMg9wGwhd8ZO8OEyyRV6wLgRHO+oEfnhyfFfVaxZDiingiP9S+/oA==
X-Received: by 2002:a62:6d06:0:b029:1d0:f7ca:59d0 with SMTP id i6-20020a626d060000b02901d0f7ca59d0mr2794632pfc.75.1612957135055;
        Wed, 10 Feb 2021 03:38:55 -0800 (PST)
Received: from localhost.localdomain ([171.76.0.223])
        by smtp.googlemail.com with ESMTPSA id y3sm2123731pfr.125.2021.02.10.03.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 03:38:54 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 10/11] t/t3437: fixup the test 'multiple fixup -c opens editor once'
Date:   Wed, 10 Feb 2021 17:06:50 +0530
Message-Id: <20210210113650.19715-11-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the test, FAKE_COMMIT_MESSAGE replaces the commit message each
time it is invoked so there will be only one instance of "Modified-A3"
no matter how many times we invoke the editor. Let's fix this and use
FAKE_COMMIT_AMEND instead so that it adds "Modified-A3" once for each
time the editor is invoked.

This patch also removes the check for counting the number of
"Modified-A3" lines and instead compares the whole message to check
that the commenting code works correctly for 'fixup -c' as well as
'fixup -C'.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t3437-rebase-fixup-options.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index 6e981fa487..a5a20354e3 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -197,14 +197,16 @@ test_expect_success 'first fixup -C commented out in sequence fixup fixup -C fix
 test_expect_success 'multiple fixup -c opens editor once' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout --detach A3 &&
-	FAKE_COMMIT_MESSAGE="Modified-A3" \
+	git log -1 --pretty=format:%B >expected-message &&
+	test_write_lines "" "Modified-A3" >>expected-message &&
+	FAKE_COMMIT_AMEND="Modified-A3" \
 		FAKE_LINES="1 fixup_-C 2 fixup_-c 3 fixup_-c 4" \
 		EXPECT_HEADER_COUNT=4 \
 		git rebase -i A &&
 	test_cmp_rev HEAD^ A &&
 	get_author HEAD >actual-author &&
 	test_cmp expected-author actual-author &&
-	test 1 = $(git show | grep Modified-A3 | wc -l)
+	test_commit_message HEAD expected-message
 '
 
 test_expect_success 'sequence squash, fixup & fixup -c gives combined message' '
-- 
2.29.0.rc1

