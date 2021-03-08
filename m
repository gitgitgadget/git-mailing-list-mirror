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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C51C43603
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2929265237
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhCHPHu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhCHPHW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:22 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35538C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:22 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l12so11812717wry.2
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I3LnH92Sz39Uu8wL08QqyaMqZLcFfLakiQuSWxmp7l0=;
        b=HbSgXUYLPPmJez/rcAs7mitup2oNSLpPbva7bGCEyibziLwYvV+cf0xD8x2KX5O6BV
         kRJFRvCn+EzndI4fdXzA2G3OyVmacOA1mAMyElHxzQjQkbwb6oUSegf+ZYIpwGbhDH9e
         2ggMnYxu4uo7XYowKwBMk2Ji2rNC3wbfw+4Q7m/9rm9ZnDdOMtqAGRXd5mljELmjB2wl
         l0Xh2iRz4qrQliKiGrSOHstpoJSHqZYJPv3Mmpvk2WpIEEScICoC6O8EsLzJcDedPR7N
         KJLFPJX/890loSbpkU93qjs1SRjFQPNPuHYcHgQK3oQzIV8rbW9tO5ZHnfOTczSi8jMH
         9Ehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I3LnH92Sz39Uu8wL08QqyaMqZLcFfLakiQuSWxmp7l0=;
        b=gA9HjvjFVrSZyrPUbdfIU0UOKLLbXdHqQXP0N7ppiZgD9xqbcpq5OyAEQ0wF36K74O
         gVHPFaa4DLJA/EOXzzpYpP/XMs2x4MWqtDMpdx2JtsjJn7MZTANeHFKy6CqXPq+heaYQ
         IdK3Xp5M4jP4qvGdTSjUuFaz2SZt64MtZLyIGqYFq469bMxjjEKyxe8d0o00H/1BpEs3
         Cz10AxluuMsRwGaXqvZz43Y/n5FsYwrU4KasP0czFXw/hiqEB+WIKSWQK4i9+vABUqBH
         DQfufbC0QtQGeg32pLbouCfhZ+lZud+KSoGqJPADslLe0QGZb1Wgdw6HZrs5EfJ0Py/7
         sllA==
X-Gm-Message-State: AOAM533rwR47/SG5Cwui/4LATyprcW868GqOQYI/2W4DErcHd0wvgACL
        5S9BZv/UxLO7bZPMgkcsAf0wYL5jp2kDFA==
X-Google-Smtp-Source: ABdhPJzsvffD+Q+PcO3LGtIdA+m3qlLFYMe9SSuBS0fX64Id3p4emssT/eqkmzyoBOAo9NIeOqQSqA==
X-Received: by 2002:adf:e482:: with SMTP id i2mr23374412wrm.392.1615216040756;
        Mon, 08 Mar 2021 07:07:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:20 -0800 (PST)
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
Subject: [PATCH 15/30] merge-tree tests: test for the mode comparison in same_entry()
Date:   Mon,  8 Mar 2021 16:06:35 +0100
Message-Id: <20210308150650.18626-16-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
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
index e59601e5fe9..f783d784d02 100755
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
2.31.0.rc0.126.g04f22c5b82

