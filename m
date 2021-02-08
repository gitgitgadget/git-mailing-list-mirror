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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14EBC433E0
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80BBD64E85
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbhBHT3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbhBHT2w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 14:28:52 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC63BC061788
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 11:28:12 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id g15so10883387pgu.9
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 11:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ssa390ymAfxXuaSIGNMNAjVXTI4wKHsyg7HVhfpv7Ac=;
        b=rltkU4mxD6lRPmNjc9K293z2oA66Vs1KtSFTXrQ94Qg5nHH6tXykkg+flIaHFajyLz
         LktDHXT1BiBaV+WEst1eGCN+RwKn0Ub0cyUZPVCXnfZA1o3jv1DopBzEBoCMDwyEpuwH
         sMK1FSrJYXzD0Gx27F6H399DnXgseG3MpwA14zvbOr7eIF+inGlv3VJrohpbWsa27PyG
         hSo+WHRs7vX52ir6vmDwcgXbNJvKxDT4+CAMvYUGKm8EVEHT1TYPy4qWiQxgmpScXGZ+
         EsZyh/R3SpY/Oj8mrKxJHBVGeawarvqbB9nwHycJnQEYfHAtppuuaBibsgH+OHgZ8p+a
         2emg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ssa390ymAfxXuaSIGNMNAjVXTI4wKHsyg7HVhfpv7Ac=;
        b=o2z9bJ4Gv/ODJN+sKZTEKOltpLpDP8+8VycvuT1nSgeR290GTYhS+5XuKRP+gxlgDB
         pXbdzQd4ZUHrNH6kwUjdg3eQcFl+Kuu0+5cfP5Ek70BQPJN0whUP9Av/+5INRxqwJXFD
         x19BtR7EqDxVy6ZJRSKuVUBtvKRx9rI4V5v8wNnHEsz9flR/RqMqacfk0fsCw91bY5gv
         Z0rz0219NRjpqTOMZBaS0EqRgg/fYp2SUdjS/7xPG8BxbUgs/rhUzysbrVNo42o4mgRU
         9faRT0UalMbFZGo9e/Ha1n2p5FmUd4OmotM9+AsQ5tRvr6BU7GLu+SuwwR3Pq0MzvYCd
         9Drg==
X-Gm-Message-State: AOAM5300ZhltI3Zu2Mc+BGRCCoqrglM347CcXtB4a7WcBXniFpi8nGPl
        M/zIFMHChb12Su+XVXZqRziPEL5tRPm1Lw==
X-Google-Smtp-Source: ABdhPJwscqi/YwsoY1rimKb3Q+oL81VfVzmtSA44A2ltXiV9nUFTc55G1t9rfgyvuRvR94iFFdDZVA==
X-Received: by 2002:a62:7a0b:0:b029:1de:7e70:955d with SMTP id v11-20020a627a0b0000b02901de7e70955dmr4331835pfc.49.1612812492154;
        Mon, 08 Feb 2021 11:28:12 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2e07:af0b:91c3:5a1c:9f2d:b1e6])
        by smtp.googlemail.com with ESMTPSA id a141sm19765444pfa.189.2021.02.08.11.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:28:11 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 06/11] t/t3437: remove the dependency of 'expected-message' file from tests
Date:   Tue,  9 Feb 2021 00:55:25 +0530
Message-Id: <20210208192528.21399-7-charvi077@gmail.com>
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
index 3de899f68a..242770a3ec 100755
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
 	FAKE_LINES="1 fixup-C 2" git rebase -i A &&
 	test_cmp_rev HEAD^ A &&
 	test_cmp_rev HEAD^{tree} A1^{tree} &&
@@ -145,13 +144,14 @@ test_expect_success 'fixup -C removes amend! from message' '
 test_expect_success 'fixup -C with conflicts gives correct message' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout --detach A1 &&
+	git log -1 --pretty=format:%b >expected-message &&
+	test_write_lines "" "edited" >>expected-message &&
 	test_must_fail env FAKE_LINES="1 fixup-C 2" git rebase -i conflicts &&
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

