Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699B7C433E2
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 19:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27624208C7
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 19:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YODxLM2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgIMTcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 15:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgIMTb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 15:31:58 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F79BC06174A
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 12:31:57 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id p15so7358462qvk.5
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 12:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lbhW87v1kDJqhf/IDKE1qK3DxUpDUYZWsvgqgsYAhbE=;
        b=YODxLM2lR3sKYvukDWIcm7vXdZFDuxxYuIGqd037LuT8KKGut/xGDAsHOIUhMvgmE7
         q+UJpxvT3KCvmLfszaeqM1AXtsXIxxdwmxmVTacG7B/Z36OhuDveRdAIjN/KYDkHgxpY
         OzHQDs6CpAFXiKmQ0Pp/S37K+ZXfPZ0DwAyqV1bx71TTQQQ8+HeFgLKy/YPyAPqJRkk1
         0W1+cME/ENis45n9gWZRZfjXEPttM/KF0ruZtTzWs6gx5UnIomhR6A3DhiOMvUarqkWk
         AvEhOEPes51I05ddVyeOxMXJw3iW7txanld1o6WcrQwuwu5w0Q8DOGHjo+fUo/pyyZPZ
         ghfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lbhW87v1kDJqhf/IDKE1qK3DxUpDUYZWsvgqgsYAhbE=;
        b=DWGECoNRLktP5LxhVSbhCPJOhbU7jL735h+NhleM2f9MjdQURJIM+EPeIjzgNbL4y7
         wLPFpzqqlKodIRjmVVuM1AGeottJOf7T1thZemXq7kR9DHRdH4fkqnge+QDZLxM/AZwi
         0tPTCPnMFpjeNVeb3pQUR++qE1zx9uduP//+0ae9bi04Ad+Bwdw7wT/EX1kcYXMj0xp3
         jbftQiX6Vif2ayfClzyCqVtlz4ts/SRoTy2x+WwbNP5rFbMN1qb03VSD/8dH+GDaHw/c
         yKXRComJ++53eFOiMJtDqmlqFLKH+yIbt10QUOq7BGwqk2vUXogfpr+FeftMce8ttT6/
         r+Og==
X-Gm-Message-State: AOAM532auItvfplGo2iqIxBi3wZ7gmaNzplJa7Ak2eGk3rBzCiDiVfOx
        3wD1U6M0wdY8kVzobjN6t2ApOgQ6DazWAUdF
X-Google-Smtp-Source: ABdhPJyCKbxaS+spQ+nvlTLisKpGMIqi/YgPkfQY0B8GnOxINy1h55lcQvA0TwuBjjZIHwIwfOMMCg==
X-Received: by 2002:ad4:43e5:: with SMTP id f5mr10044519qvu.12.1600025514686;
        Sun, 13 Sep 2020 12:31:54 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id e13sm11523924qtr.85.2020.09.13.12.31.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Sep 2020 12:31:54 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH v3 1/3] t3201: test multiple branch filter combinations
Date:   Sun, 13 Sep 2020 15:31:38 -0400
Message-Id: <20200913193140.66906-2-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200913193140.66906-1-alipman88@gmail.com>
References: <20200911185754.64173-3-alipman88@gmail.com>
 <20200913193140.66906-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests covering the behavior of passing multiple contains/no-contains
filters to git branch, e.g.:

$ git branch --contains feature_a --contains feature_b
$ git branch --no-contains feature_a --no-contains feature_b

When passed more than one contains (or no-contains) filter, the tips of
the branches returned must be reachable from any of the contains commits
and from none of the no-contains commits.

This logic is useful to describe prior to enabling multiple
merged/no-merged filters, so that future tests will demonstrate
consistent behavior between merged/no-merged and contains/no-contains
filters.

Signed-off-by: Aaron Lipman <alipman88@gmail.com>
---
 t/t3201-branch-contains.sh | 44 ++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 40251c9f8f..cd205b5560 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -200,15 +200,51 @@ test_expect_success 'branch --merged with --verbose' '
 	test_i18ncmp expect actual
 '
 
-test_expect_success 'branch --contains combined with --no-contains' '
-	git branch --contains zzz --no-contains topic >actual &&
+# The next series of tests covers multiple filter combinations
+test_expect_success 'set up repo for multiple filter combination tests' '
+	git checkout master &&
+	git branch | grep -v master | xargs git branch -D &&
+	git checkout -b feature_a master &&
+	>feature_a &&
+	git add feature_a &&
+	git commit -m "add feature a" &&
+	git checkout -b feature_b master &&
+	>feature_b &&
+	git add feature_b &&
+	git commit -m "add feature b"
+'
+
+test_expect_success 'multiple branch --contains' '
+	git checkout -b next master &&
+	git merge feature_a &&
+	git branch --contains feature_a --contains feature_b >actual &&
+	cat >expect <<-\EOF &&
+	  feature_a
+	  feature_b
+	* next
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'multiple branch --no-contains' '
+	git branch --no-contains feature_a --no-contains feature_b >actual &&
 	cat >expect <<-\EOF &&
 	  master
-	  side
-	  zzz
 	EOF
 	test_cmp expect actual
+'
 
+test_expect_success 'branch --contains combined with --no-contains' '
+	git checkout master &&
+	git merge feature_a &&
+	git checkout next &&
+	git merge feature_b &&
+	git branch --contains feature_a --no-contains feature_b >actual &&
+	cat >expect <<-\EOF &&
+	  feature_a
+	  master
+	EOF
+	test_cmp expect actual
 '
 
 test_done
-- 
2.24.3 (Apple Git-128)

