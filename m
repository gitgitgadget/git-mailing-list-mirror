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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38089C43616
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DBC461056
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbhCaTK3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 15:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbhCaTJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 15:09:57 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F25C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:09:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c8so20713186wrq.11
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7LtorDWUDKegu6Ab8ldHlK+Suz0Y4wqFJraInqx4TXs=;
        b=Te5w71mD9/AUZ+JgXIXyDxANUVUdW/VcMMl6YRHvFTBthPkTzsbAbgH9G0rKB8iYov
         Myj5uOETeAl4SwGEes7qsLFmodgKV8tR3aIAvX3pPON62HDDH9lqrx5n11x26n3Ul+RK
         gqsb3J8N+NoUYVl6vf0QxkgVm1iNFX8OuPuh37ARHOtuuqmaELNb1FoC6UGnlJdB99FG
         gX0bWIthKQPH651Ai4aMVdc7vdapd8gVwi2rgKDAQVU41sVfAaKpg5aFNTw4MVaplFQf
         2V6fiDmR4kc1pmYAc+AFGBIb7Wv0E3ffE4+BxKwjn31yIUTsGCltkRR3s/fN1jxlZorQ
         SiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7LtorDWUDKegu6Ab8ldHlK+Suz0Y4wqFJraInqx4TXs=;
        b=BgX6jMk7DcgzPZy/tZvDAr5o9Py59Li7LQzCiChePKIThT21KapXviIg41aHFtJrvf
         ctNpAQaYz51A9gUiauziZV4v+/pY6SkVrpgecJwUSHGCcyPEENKdRW/m6Ht/hl5ZrVxX
         AaRT88qzMjLtBgyQyRoWLzkwjtpOrXNaXWc3vMvL59bLxHDnGZuWoXdt8FJAuicunRsS
         cAlEQIOu+9HYYa0Wsv9p/SDwJw3RPtTJZ0jgwnjkg7Xz94shr+C5Uz96e7mUOHGQYS/D
         yVpz7eNdj7yWuOYo1OC9p/ScYU0rbSpLsttlXcL0XXvhZIYL2pQyIwvycZ3fC9W5WgUg
         Pu5Q==
X-Gm-Message-State: AOAM531IdVkFqqWcdXoq+AiySq6heKwzV5SYp8GVoRbMSsEwLEEHsmUi
        w+N4nqmClMYgBzH/BNlYTAzwjmh88bMTfQ==
X-Google-Smtp-Source: ABdhPJzJqsFd9G+pq8YojEmDb8TT1tU+evD6KQLa/lflLI/O1dbdt/cTFj0zuhtcOE7hjO/qUIEd+Q==
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr5532489wrm.413.1617217795934;
        Wed, 31 Mar 2021 12:09:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l8sm6019268wrx.83.2021.03.31.12.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 12:09:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 07/18] merge-tree tests: test for the mode comparison in same_entry()
Date:   Wed, 31 Mar 2021 21:09:35 +0200
Message-Id: <patch-07.19-3367850559b-20210331T190531Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.474.g72d45d12706
In-Reply-To: <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
References: <87o8fcqrg8.fsf@evledraar.gmail.com> <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
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
2.31.1.474.g72d45d12706

