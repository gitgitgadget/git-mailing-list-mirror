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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28598C433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 11:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0C5164E45
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 11:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhBJLmm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 06:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhBJLkS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 06:40:18 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB74DC061793
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 03:38:30 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id m6so1097294pfk.1
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 03:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1S+9qI7dosHUPtDz8ArucglwPASI6YX3ven3u+zRB3E=;
        b=ihPlpNxgio0xI8vXmKO5SJiovRV3HdsDe+8pZAejTGTH7HcJG259rsAY4Bt062CHuW
         9IVbAIcUnFQLNs71xScayFk5Nn7mcm8sbLWORghsjpNZc6DL5yrWftNAigln5vMBzjyC
         EW1EhOlXNuOH0Mnk+MQ7FFnakKbr1Hggw2KCRKjNG8jx83T5XH6eUhJHDgAhLJCNf/iT
         cnD3SWv6Ntn8xJ8gHfspgHVmqlJtkmLHFipegzShw2RvQ2mrl7qE0GNCuQW3fhhFZ+zg
         ZJXL8/3VjcQs6RJLtzPkyqbswrbjCBeyVaPsdgNGtF5hgxIQYWI3anmdi9Is06nQSKAd
         3+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1S+9qI7dosHUPtDz8ArucglwPASI6YX3ven3u+zRB3E=;
        b=PSIeUWhM9tZpVtjWItuj5qIG9no1H8HFkf4tWbrh3AquodnaJ4ElE3pr3ZQibtgyqx
         Tmzbq01xTmMQ4fjL5UFo1tFWefNQTgP8mPDHso/3vCJHBMfvlsbic62psqB4vllGTWMs
         vMADrYK6qf5mMuO59rMPwvgcLIfJudaBw49oS866tNokV7VXIB2wYdviWAkCJxFwHGlc
         +YE2wlTljcAsx0Vx6RwVS+DtN+Mv40bw+gNHg7qGvLA1FFOQq1nZUtsTY2rCDRMZmgeq
         eXgn7C+u5ebBuacCmMgXfbqXNXC7hdDYkPtND7d1xB1ctDCxhGN4xAw/t44I4H3r4BSQ
         jkZw==
X-Gm-Message-State: AOAM532q1D8nPJAHRtYhVNIHT/ruYznYSk5mNAoOiRcsZxt/bGAcIR85
        yG+tis60twkT5iZikeJuV578huHdZh9nbA==
X-Google-Smtp-Source: ABdhPJwLjhjwRuESIhPtkDMUqjwqGK4DwH0yZ/Q382LqtXkZnfyRhM/zEyNLR9mfw+uaEWGPkTPU9A==
X-Received: by 2002:a63:eb14:: with SMTP id t20mr2714901pgh.336.1612957110014;
        Wed, 10 Feb 2021 03:38:30 -0800 (PST)
Received: from localhost.localdomain ([171.76.0.223])
        by smtp.googlemail.com with ESMTPSA id y3sm2123731pfr.125.2021.02.10.03.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 03:38:29 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 06/11] t/t3437: remove the dependency of 'expected-message' file from tests
Date:   Wed, 10 Feb 2021 17:06:46 +0530
Message-Id: <20210210113650.19715-7-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As it is currently implemented, it's too difficult to follow along and
remember the value of "expected-message" from test to test. It also
makes it difficult to extend tests or add new tests in between existing
tests without negatively impacting other tests.

Let's set up "expected-message" to the precise content needed by the
test, so that both the problems go away and also makes easier to run
tests selectively with '--run' or 'GIT_SKIP_TESTS'

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t3437-rebase-fixup-options.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index f599da3e08..d368ab4d4b 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -46,8 +46,6 @@ test_expect_success 'setup' '
 	body
 	EOF
 
-	sed "1,2d" message >expected-message &&
-
 	test_commit A A &&
 	test_commit B B &&
 	get_author HEAD >expected-author &&
@@ -134,6 +132,7 @@ test_expect_success 'simple fixup -c works' '
 test_expect_success 'fixup -C removes amend! from message' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout --detach A1 &&
+	git log -1 --pretty=format:%b >expected-message &&
 	FAKE_LINES="1 fixup_-C 2" git rebase -i A &&
 	test_cmp_rev HEAD^ A &&
 	test_cmp_rev HEAD^{tree} A1^{tree} &&
@@ -145,13 +144,14 @@ test_expect_success 'fixup -C removes amend! from message' '
 test_expect_success 'fixup -C with conflicts gives correct message' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout --detach A1 &&
+	git log -1 --pretty=format:%b >expected-message &&
+	test_write_lines "" "edited" >>expected-message &&
 	test_must_fail env FAKE_LINES="1 fixup_-C 2" git rebase -i conflicts &&
 	git checkout --theirs -- A &&
 	git add A &&
 	FAKE_COMMIT_AMEND=edited git rebase --continue &&
 	test_cmp_rev HEAD^ conflicts &&
 	test_cmp_rev HEAD^{tree} A1^{tree} &&
-	test_write_lines "" edited >>expected-message &&
 	test_commit_message HEAD expected-message &&
 	get_author HEAD >actual-author &&
 	test_cmp expected-author actual-author
-- 
2.29.0.rc1

