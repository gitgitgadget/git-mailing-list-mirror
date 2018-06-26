Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A40611F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932245AbeFZHce (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:32:34 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:44544 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932103AbeFZHbH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:31:07 -0400
Received: by mail-io0-f195.google.com with SMTP id g7-v6so14979896ioh.11
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wKpjg6+oxr7/5uwMPbye0asbVDV6wZCccIJPSJMS52o=;
        b=ReHkpj7E2D491YUuVdZIzmDn/Rr5R1cHDf5vbThswHPRacg7DQ6oMGosnqDEZTys8F
         soDsIjtxR9y9JrQZF4431bHpnTn6jFCmIBeERh21KbfwXm0BY187lPWoHU9a3rLUGE7I
         kxIyT0MGTFTlNoaa8TWcWh+mgOsFDn0kVVqoDEDBoI9gyw5qPC9JmPu5p2LXdFslOZoB
         46RHO1B8rOsTIwZx3qgQWTNn7FaYFwCwRUuO/xtj/Enfxs2Rg0cLZGKyUEN7GNj2cZr9
         duxKXT2UY7CcS6jqlHdfMQIKAkvR7cvHPpFdhqNNTDBx1axOewvn+UeNwBAKv5xSv1uu
         uRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=wKpjg6+oxr7/5uwMPbye0asbVDV6wZCccIJPSJMS52o=;
        b=JUjFbxiysoITxhpsTQeWqft7DAfSuUrGo9fEI8Z+lyBg5yGjsyeZ1YrhUbuByGWKvO
         +KPoqFa8arb9M6T3WdaSxlRssj2QRa1sLaICcVOI3HkrAlTRd9a7jYL+wbtLBMNJhgF5
         htfMRv6GGQJp/E8fiHSMh9og9nw2CnzKzAwFTjYiiuJoInoV1ATvmvd+BPeLbEdOiuiI
         7CgMuMR61qQx3xzccIC4mt/yPkocmY0oXu+o+CRe+AJCtmM7BMLnYRrXmOgGkgFfbtPy
         arLjgQwgc9Fuk3m78rJ+96oYQGpSbIzvzXByOPti5aaYFAZ7yCvwnk3Y5lPcKbseqmr6
         DwTg==
X-Gm-Message-State: APt69E1jAr7YuWzid89O1eMpCDXIm8ROr1zqG4NrZU05G7xfYcyaaBHA
        /+1Tw/QHSQ/ZsAeW67Q5Bl7Rog==
X-Google-Smtp-Source: AAOMgpcS01vTdBnh8lBAebGcu7hQmzNtOUXbKF7GeQtYmjAFNddbxfL1mtaAixnhYofRnB3JzB5ijQ==
X-Received: by 2002:a6b:dd0b:: with SMTP id f11-v6mr284026ioc.173.1529998266601;
        Tue, 26 Jun 2018 00:31:06 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.31.05
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:31:06 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 17/29] t: use test_must_fail() instead of checking exit code manually
Date:   Tue, 26 Jun 2018 03:29:49 -0400
Message-Id: <20180626073001.6555-18-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests intentionally break the &&-chain to manually check the exit
code of invoked commands which they expect to fail, and invert that
local expected failure into a successful exit code for the test overall.
Such manual exit code manipulation predates the invention of
test_must_fail().

An upcoming change will teach --chain-lint to check the &&-chain inside
subshells. This sort of manual exit code checking will trip up
--chain-lint due to the intentional break in the &&-chain. Therefore,
replace the manual exit code management with test_must_fail() and a
normal &&-chain.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t5405-send-pack-rewind.sh |  3 +--
 t/t9814-git-p4-rename.sh    | 16 ++--------------
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/t/t5405-send-pack-rewind.sh b/t/t5405-send-pack-rewind.sh
index 4bda18a662..235fb7686a 100755
--- a/t/t5405-send-pack-rewind.sh
+++ b/t/t5405-send-pack-rewind.sh
@@ -25,8 +25,7 @@ test_expect_success 'non forced push should die not segfault' '
 
 	(
 		cd another &&
-		git push .. master:master
-		test $? = 1
+		test_must_fail git push .. master:master
 	)
 
 '
diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index e7e0268e98..80aac5ab16 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -12,20 +12,8 @@ test_expect_success 'start p4d' '
 test_expect_success 'p4 help unknown returns 1' '
 	(
 		cd "$cli" &&
-		(
-			p4 help client >errs 2>&1
-			echo $? >retval
-		)
-		echo 0 >expected &&
-		test_cmp expected retval &&
-		rm retval &&
-		(
-			p4 help nosuchcommand >errs 2>&1
-			echo $? >retval
-		)
-		echo 1 >expected &&
-		test_cmp expected retval &&
-		rm retval
+		p4 help client &&
+		test_must_fail p4 help nosuchcommand
 	)
 '
 
-- 
2.18.0.419.gfe4b301394

