Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CFAE1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 00:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbeHMDKQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Aug 2018 23:10:16 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38949 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbeHMDKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Aug 2018 23:10:16 -0400
Received: by mail-ed1-f65.google.com with SMTP id h4-v6so7383666edi.6
        for <git@vger.kernel.org>; Sun, 12 Aug 2018 17:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=noNmuHXgPPi3l8s16Z8zkSCpiC5E/Wsf4azXiAS8PVw=;
        b=h3N/qrgD6u1bZudjRD7UuTtYHXr4NA60rsPoUhFzNKkOnhvDsfWdvNlFMFioRIJRwe
         k9LHg0dBB+EYTYbkSS2MijYYt72ARBSUIUir2oia4LQF87/hrPQfwxTfeQs7w3O05yMy
         REWo9LJQdAH9r/loBUE5iST6zfvOCv2F2TyLNIpZqPo0gjhjZfNGxECv4WOScK5Xesj1
         pOaxy+njPBG+DbQMRLWEn8nKMUZO8AMzuHOfYJGqeTja9NoKb0xROjNUCqpH4TnmulMM
         44vNXhb7x8OgXXzyYMxY9uymuB14S/WPre3r8QzCb+exTYUM2/ZRxK16yKxpWfQVK7Po
         LlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=noNmuHXgPPi3l8s16Z8zkSCpiC5E/Wsf4azXiAS8PVw=;
        b=hTq1sWGKDDF5JeeJtNvTyjTtt39q3I2ySjdyaz5UuB7a+ZYpQj7UPsNuYA5x+zseTk
         ALJMWkk85bOIrDpsalyZ13vGEZNmu2qAKBYV7qNS0+f3ZGzskPVrnDF/U+W0FRbQcoGn
         I6lP8gNg0oJnFm3eJdYEUp+iGhw61m/BPW5S9ugz91bt7oh9sSDS9JdVierX2j7JczC9
         XXlmchla6wIpUpK2B9ce5z18WOJ5UPrXJw8+P6vDkUS+KzHomDbIHvxlRZoS5Pu3NaHw
         wibn/xebNIfBFKykBH8XcCNy1VTbu2F2KuwkxzVl/GTgkWlWXCTR2ymNco7ec0XA7T+6
         z3NA==
X-Gm-Message-State: AOUpUlHD/gn6o//s7X1YPvsMxsOACiX1R32LYByQWTi9Nrjn12E6Swf2
        jhel9iq4TBus8MREfYXSQow=
X-Google-Smtp-Source: AA+uWPw891Z+vjJu5KvlS5Q2U4lQoud3hTLde1Y7qDE1UUnY68iTCwsOUFYoBYv4vaBEwqEMHvhCLw==
X-Received: by 2002:a50:93c5:: with SMTP id o63-v6mr19666500eda.154.1534120228481;
        Sun, 12 Aug 2018 17:30:28 -0700 (PDT)
Received: from localhost.localdomain (x590c5679.dyn.telefonica.de. [89.12.86.121])
        by smtp.gmail.com with ESMTPSA id n10-v6sm6087299edr.59.2018.08.12.17.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Aug 2018 17:30:27 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t5318: avoid unnecessary command substitutions
Date:   Mon, 13 Aug 2018 02:30:10 +0200
Message-Id: <20180813003010.17610-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
In-Reply-To: <b2f5b69806c4c4a4009267701245aee4cabd2cf1.1531348540.git.jonathantanmy@google.com>
References: <b2f5b69806c4c4a4009267701245aee4cabd2cf1.1531348540.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two tests added in dade47c06c (commit-graph: add repo arg to graph
readers, 2018-07-11) prepare the contents of 'expect' files by
'echo'ing the results of command substitutions.  That's unncessary,
avoid them by directly saving the output of the commands executed in
those command substitutions.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5318-commit-graph.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 1c148ebf21..3c1ffad491 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -444,25 +444,27 @@ test_expect_success 'setup non-the_repository tests' '
 test_expect_success 'parse_commit_in_graph works for non-the_repository' '
 	test-tool repository parse_commit_in_graph \
 		repo/.git repo "$(git -C repo rev-parse two)" >actual &&
-	echo $(git -C repo log --pretty="%ct" -1) \
-		$(git -C repo rev-parse one) >expect &&
+	{
+		git -C repo log --pretty=format:"%ct " -1 &&
+		git -C repo rev-parse one
+	} >expect &&
 	test_cmp expect actual &&
 
 	test-tool repository parse_commit_in_graph \
 		repo/.git repo "$(git -C repo rev-parse one)" >actual &&
-	echo $(git -C repo log --pretty="%ct" -1 one) >expect &&
+	git -C repo log --pretty="%ct" -1 one >expect &&
 	test_cmp expect actual
 '
 
 test_expect_success 'get_commit_tree_in_graph works for non-the_repository' '
 	test-tool repository get_commit_tree_in_graph \
 		repo/.git repo "$(git -C repo rev-parse two)" >actual &&
-	echo $(git -C repo rev-parse two^{tree}) >expect &&
+	git -C repo rev-parse two^{tree} >expect &&
 	test_cmp expect actual &&
 
 	test-tool repository get_commit_tree_in_graph \
 		repo/.git repo "$(git -C repo rev-parse one)" >actual &&
-	echo $(git -C repo rev-parse one^{tree}) >expect &&
+	git -C repo rev-parse one^{tree} >expect &&
 	test_cmp expect actual
 '
 
-- 
2.18.0.408.g42635c01bc

