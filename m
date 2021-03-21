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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882BDC433F8
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E2FB601FE
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhCUACT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhCUABj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:39 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5413AC061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e9so12850721wrw.10
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HACxaxtHfGPxTSK08wlnRVodGigvTfDuatPabd5wGhU=;
        b=R0bHZ3md/okMJ9jLNgkYGwg73Kobvl1zkg2+Mf4rA6ObHI4sLO7Q20m02+nEJmpsAW
         +UAZP/BA1LkWNXJNRDTrhQ/wI+T7RefOu2yIgkW8msg0uQpgx1d8O843vX776fM31izI
         hUcufa78BPaVEf1KUy745iRcOJSXK/WCGcVoEM5LBgo1upIT3pemprGN6AeWxliF40Go
         wAtApQAHzmyDUTKAhI/s/N10oa+hBhlyIqKUtyQBZSlJXaG2cxKFmkMl7QB7wpBnq1eT
         wgmt+0aMZ8BXpC4BLGvJBqWTL9c4mbsCnTfLOfwReQWDVWujtndSYuFHsYL/YyuQhmDB
         n90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HACxaxtHfGPxTSK08wlnRVodGigvTfDuatPabd5wGhU=;
        b=pQspDLxRPhjiBgB0Ra7yCeYEZ6oSUCwNaInn9oztU+7E9xSFPNA/EcEQtDo7HAiQEU
         aA2orTLkluMjgzuYs/u6bV1TaX8UTEV6OY2TRY0MRHsKOTL7sygCa5B66JOxVx+kYc6j
         uznkQxq/2pLfZthJiGlf9jCU6i4OF5U9uK8jkDOWI4UNh7GmvMGzA3WEMr7OzOdO6A82
         cp9WVOLMwJyjjngcH/XpBzV50RVj7kW0jjgt2R5aPboU+OkgZCLty4wDMbXOHvM+8JsU
         jGeYW4oICOk4CEUHB0VCSir9kEMmQmgrJeS3hPtE9uyZI/eN9/5fSgj35+fFy5kbPilI
         9OPg==
X-Gm-Message-State: AOAM5334mD53yGGqKtbdl5MgxFEY5DCvGjkpryAtnAKZoPhkrj96rDgG
        uwAZpk6keOZP5y+Ry2Z6L7sSpXhwPYxI8A==
X-Google-Smtp-Source: ABdhPJygqAGKHp4J08HuoZ51fd6ys/xK7qH4x9AJF8oO/hZUzjYskNb4bkvp3PK8f4ZnaFys82eEfA==
X-Received: by 2002:adf:fd48:: with SMTP id h8mr11261112wrs.229.1616284897898;
        Sat, 20 Mar 2021 17:01:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:37 -0700 (PDT)
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
Subject: [PATCH v4 15/29] merge-tree tests: test for the mode comparison in same_entry()
Date:   Sun, 21 Mar 2021 01:00:48 +0100
Message-Id: <592fecb7abc55ff17eed6b3bcc58a6d9991a337e.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
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
2.31.0.286.gc175f2cb894

