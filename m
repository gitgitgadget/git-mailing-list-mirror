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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A411C4332D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D090C6510A
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238343AbhCPP7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238266AbhCPP65 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:58:57 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C69C061756
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:55 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so1764084wmj.2
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BBovOeWSldocWwSfGIvadIZvA4VzyvsdqtM9aM50gFg=;
        b=g3G2RZCDKejpg5R6YFDhZKB8s9xW9GbwZtTLzL4VVYJ5ej1DO3r6MlocHa/SnvDmQB
         Cucdzp9pt2YA3jq58THTuGhF4uINUpvpRAqITZJv5EX6iez2nHO1TJbLBp+fKY47IflM
         /taRHt3DaBu4dzDSc4gkXJsQDb/7uCOsTu5jegWiaIZR/uk+dp9w+uEbR66UnLSFphF6
         z4r6Yy5RPLcLOj22lQsy6qFBWHu9Im/AlYFYDZwF2aGG8Xva90QxuI/Ut7Qqjodgh2wH
         6pFyWds/nqQVs7oE+NFwK2N+xZG/7pu/W8fi8j9LP93C5m1+FmCOrN3OiLkH1w11tSu1
         5YTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BBovOeWSldocWwSfGIvadIZvA4VzyvsdqtM9aM50gFg=;
        b=QYdscxSaaQYqtOvMe0U7i8466CItW97qrCmFfMAAkO0BnLCtlVhudgzJJsh+WCwr0b
         QSxEiyY3GNVdyXCzkq/hcnpBFucCyOQtnkvAcPWAvOXbZOLn7WPGNUB6iD2YxHP5TzeI
         ZHPru5mIRH4N98tduC/TJycJDdhzFvE+xBHVzShDBjJE1FpFJ6f8BAUsMrWQPJjb+oL0
         BRPmzsnHR34Mwk5mLkzcTsHbJFZOyedoumCuebFRZPjLdbnpg9Q2WojqdTrHIVB+xDTT
         l/mFEOeHcHMhhOyq27XhrhZJbUYRB5NAOIOC5ZA8EGp2NNSpXp23DtZWyaVA1CmBM4ZF
         JFlQ==
X-Gm-Message-State: AOAM533jdOE1oa8KKOSSXEw/46n9dVM414YM3EnZ0L5bDzg3xzHYQqof
        A0u/l1lP+uB5ETi1U4GYjfbm3rocIlbcZQ==
X-Google-Smtp-Source: ABdhPJykk1AcE1KgObVHP234QQNXYORLW0p3nkTZyGNqf6UsvdAXqhMVDrBku0ueh9Zz/gBu0pz8xQ==
X-Received: by 2002:a05:600c:4f03:: with SMTP id l3mr281182wmq.149.1615910334325;
        Tue, 16 Mar 2021 08:58:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:58:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 18/32] merge-tree tests: test for the mode comparison in same_entry()
Date:   Tue, 16 Mar 2021 16:58:15 +0100
Message-Id: <20210316155829.31242-19-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test to stress the "a->mode == b->mode" comparison in
merge-tree.c's same_entry().

That code was initially added by Linus in 33deb63a36f (Add
"merge-tree" helper program. Maybe it's retarded, maybe it's helpful.,
2005-04-14), and then again in its current form in
492e0759bfe (Handling large files with GIT, 2006-02-14).

However, nothing was testing that we handled this case
correctly. Simply removing the mode comparison left all tests passing,
but as seen here it's important that we don't think a path with the
same content but different modes is the same_entry().

The rest of this series will touch code that's relevant to this, but
won't change its behavior. This test is just something I came up with
in testing whether the mode test in same_entry() was needed at all.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4300-merge-tree.sh | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
index e59601e5fe..f783d784d0 100755
--- a/t/t4300-merge-tree.sh
+++ b/t/t4300-merge-tree.sh
@@ -40,6 +40,25 @@ test_expect_success 'file add A, B (same)' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'file add A, B (different mode)' '
+	git reset --hard initial &&
+	test_commit "add-a-b-same-diff-mode-A" "ONE" "AAA" &&
+	git reset --hard initial &&
+	echo AAA >ONE &&
+	test_chmod +x ONE &&
+	test_tick &&
+	git commit -m"add-a-b-same-diff-mode-B" &&
+	git tag "add-a-b-same-diff-mode-B" HEAD &&
+	git merge-tree initial add-a-b-same-diff-mode-A add-a-b-same-diff-mode-B >actual &&
+	cat >expected <<EXPECTED &&
+added in both
+  our    100644 $(git rev-parse add-a-b-same-diff-mode-A:ONE) ONE
+  their  100755 $(git rev-parse add-a-b-same-diff-mode-B:ONE) ONE
+EXPECTED
+
+	test_cmp expected actual
+'
+
 test_expect_success 'file add A, B (different)' '
 	git reset --hard initial &&
 	test_commit "add-a-b-diff-A" "ONE" "AAA" &&
@@ -61,6 +80,31 @@ EXPECTED
 	test_cmp expected actual
 '
 
+test_expect_success 'file add A, B (different and different mode)' '
+	git reset --hard initial &&
+	test_commit "add-a-b-diff-diff-mode-A" "ONE" "AAA" &&
+	git reset --hard initial &&
+	echo BBB >ONE &&
+	test_chmod +x ONE &&
+	test_tick &&
+	git commit -m"add-a-b-diff-diff-mode-B" &&
+	git tag "add-a-b-diff-diff-mode-B" &&
+	git merge-tree initial add-a-b-diff-diff-mode-A add-a-b-diff-diff-mode-B >actual &&
+	cat >expected <<EXPECTED &&
+added in both
+  our    100644 $(git rev-parse add-a-b-diff-diff-mode-A:ONE) ONE
+  their  100755 $(git rev-parse add-a-b-diff-diff-mode-B:ONE) ONE
+@@ -1 +1,5 @@
++<<<<<<< .our
+ AAA
++=======
++BBB
++>>>>>>> .their
+EXPECTED
+
+	test_cmp expected actual
+'
+
 test_expect_success 'file change A, !B' '
 	git reset --hard initial &&
 	test_commit "change-a-not-b" "initial-file" "BBB" &&
-- 
2.31.0.256.gf0ddda3145

