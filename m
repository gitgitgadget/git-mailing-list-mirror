Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F2AC43468
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 07:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13980222BB
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 07:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="D0aCVqeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgITHsh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 03:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgITHsg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 03:48:36 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30575C0613CE
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 00:48:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so9614340wrm.2
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 00:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a3+8o+Pkv86RatJxIg7b5qzWe8Nyaje1rGtKQffx7SE=;
        b=D0aCVqeStepHE27wA0fbTKrNMeX/RyIRRG6OhdbcXYKrVa+hRAVaF7dAiOzQmK5lLs
         IK4QD1ahv3WcmdkwLNeHBjzpd+XZBWKIb9zAdXve+NngcRsFWirphqOsjBn8+JrBVK2A
         VK1PJEZ+SCpdKU443e4rK203Lx9Ten40XyOa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a3+8o+Pkv86RatJxIg7b5qzWe8Nyaje1rGtKQffx7SE=;
        b=Esofjn0itW0nhJGpWwrbcKpKDAilCUHrKs2eFtgqWVUMi7OXb4YkGbyujfMr0RSAaM
         4H0btsOiBReW5griiShD+KN44jN3luC1ybqgPgXmHCujhgd5Q5khEVAdpuU89A2WepNj
         9CuIzo4f91/DCJt6x4dsikjJTIvvZu12jB1uDQbbKb7YIi9Yvg//qJTti91uWdODc3q7
         Zvk9iiCK6h9aMzCK1nR0v5h7Ykhqe2BWF1bF64A/soD18uFl+XNdAgm7TGeY2CwP34tH
         vqvn6w/ng410+H4PotMJimJH3odQGL+JVREJqLjHc/anxD0629rOrh8BYjkRvhUcD0df
         SnuQ==
X-Gm-Message-State: AOAM533tV+jNw0cNsv7vgikqQ7NPDL3c6UdLuL10GpEbX7mNzp9xDGv2
        oJYFuPzbRsIavu+2cOEE9XNBIzFWjufiyQ==
X-Google-Smtp-Source: ABdhPJw95zpJc4ZgunC3d+4J2hKFS1CZtqbwOlJnwlgpe3TTC/pk8kfJsgIXOHMedI0R+n1v6GJjbw==
X-Received: by 2002:adf:e304:: with SMTP id b4mr44879655wrj.141.1600588114673;
        Sun, 20 Sep 2020 00:48:34 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc149478-cmbg20-2-0-cust747.5-4.cable.virginm.net. [86.16.90.236])
        by smtp.gmail.com with ESMTPSA id u17sm15140329wri.45.2020.09.20.00.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 00:48:34 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     "Liu Xuhui (Jackson)" <Xuhui.Liu@amd.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 1/2] git-p4: demonstrate `unshelve` bug
Date:   Sun, 20 Sep 2020 08:48:40 +0100
Message-Id: <20200920074841.17043-2-luke@diamand.org>
X-Mailer: git-send-email 2.28.0.762.g324f61785e
In-Reply-To: <20200920074841.17043-1-luke@diamand.org>
References: <20200920074841.17043-1-luke@diamand.org>
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
index e9276c48f4..feda4499dd 100755
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
+    test_commit -C "$git" "unrelated"
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
2.20.1.390.gb5101f9297

