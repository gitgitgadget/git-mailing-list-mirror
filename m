Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8FFC43466
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 08:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ACE920EDD
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 08:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="IHni+6vn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgITItE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 04:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgITItE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 04:49:04 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00526C061755
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 01:49:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id m6so9694180wrn.0
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 01:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NRldjGFWlJYiiqdvSpadIjei05jerk6x7kzYdFDK9EI=;
        b=IHni+6vnaA7QVw1mB0raPqgXXCK2XMnuLMg6wtsxlp+p/VCAsEygtN8UZ8wteWe1NW
         Vc61O9xl3fUoqpWtPHwAYzxXFr0PLWLX7Udzp3FnFAVVoufwZY4D/T9HENcoTIUhpxZ4
         p077pi6WucbrINAi4h7D9/7WhHSTsHqdqJsS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NRldjGFWlJYiiqdvSpadIjei05jerk6x7kzYdFDK9EI=;
        b=c58maJwF+M0NpR4Jv2PTaJLWY6Fg7qTrwI+DMtr99ldw9Aw7dSIJrrwT875sOJkK/A
         XhIyPx8rYnTQ8tS4eUuMzJFZDcmN9UADmWT6nP2rpSYbTTu3dfilTEXX9AD/yOnH12u5
         ATYiPWqBkZSIP5Rox7bNfJPvJY7lDYqMJUOtgmyqbuYjZie330HOZOa5ghgiDXpweEi7
         sS633KG19xwKSwZ4t9psG64IXZ1jgvyMb3Br2kfUKEeFqktwexhx578s7w8X3bcjoL34
         t1WUbaigXpoUxtsRhGX1uvkDON4ocVZdMDsSln1CjpMf6tyJCN/atMLY80eRAD4a1ZNk
         WsaA==
X-Gm-Message-State: AOAM530xYVu526faBU6D267LiUuQm6xq1RjoQ6jo9JbESZnGAfLl4FtY
        o5F7Z2w9xdg79SWXjUD/Z4D/J2LfmNC0nw==
X-Google-Smtp-Source: ABdhPJyOF4khM2xjY+oIhJEaA6Pf8zY9soXpdZXtErsPuFN11PacTPnUK+ZAQlkPiQsBi4JvTMXg1g==
X-Received: by 2002:a5d:5306:: with SMTP id e6mr48222468wrv.156.1600591742551;
        Sun, 20 Sep 2020 01:49:02 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc149478-cmbg20-2-0-cust747.5-4.cable.virginm.net. [86.16.90.236])
        by smtp.gmail.com with ESMTPSA id 11sm13437567wmi.14.2020.09.20.01.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 01:49:02 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     "Liu Xuhui (Jackson)" <Xuhui.Liu@amd.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv3 1/2] git-p4: demonstrate `unshelve` bug
Date:   Sun, 20 Sep 2020 09:49:08 +0100
Message-Id: <20200920084909.17794-2-luke@diamand.org>
X-Mailer: git-send-email 2.28.0.762.g324f61785e
In-Reply-To: <20200920084909.17794-1-luke@diamand.org>
References: <20200920084909.17794-1-luke@diamand.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git-p4 unshelve` uses HEAD^$n to find the parent commit, which
fails if there is an additional commit. Augment the tests to demonstrate
this problem.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9832-unshelve.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
index e9276c48f4..c08234bea0 100755
--- a/t/t9832-unshelve.sh
+++ b/t/t9832-unshelve.sh
@@ -29,8 +29,11 @@ test_expect_success 'init depot' '
 	)
 '
 
+# Create an initial clone, with a commit unrelated to the P4 change
+# on HEAD
 test_expect_success 'initial clone' '
-	git p4 clone --dest="$git" //depot/@all
+	git p4 clone --dest="$git" //depot/@all &&
+	test_commit -C "$git" "unrelated"
 '
 
 test_expect_success 'create shelved changelist' '
@@ -77,7 +80,7 @@ EOF
 	)
 '
 
-test_expect_success 'update shelved changelist and re-unshelve' '
+test_expect_failure 'update shelved changelist and re-unshelve' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$cli" &&
-- 
2.28.0.762.g324f61785e

