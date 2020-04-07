Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D880C2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FB22078C
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="My95FJLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgDGOLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:11:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44503 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbgDGOLw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:11:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id c15so4028297wro.11
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=YTPmkXXKu3eQXT65FkSjQR/8jU5yX7tIjPl49Vxl9Bk=;
        b=My95FJLNVCzTuLFfg1ZjWblWYvExJtzssnmtLpV6EwPFDicYXwLWRYzfURY3KtJeKx
         WKGl9hswclsH/yVomx1jsLieZBYzBNzoibETIYfCu2bTrMgpha2eX7/XVbQGwReCPlKu
         BwSwpFtlj3PIZ4zaoEGQKx4BX/QhtrxlAbuB63l8F+iSp7WriaG86Z8uEjxtjC1PS6Mf
         9AOCjXMVnSFtu4pLwDmCat6C36KfP36UbMB0bgiiW3Ior0VmMGh1MoJx3x6LegVzxWPy
         nDWrjmepTmaSzJdUVBRLtV1aISQir6dwM7UIxFDR/BgfPGEIuFln1HZ3Tx6PHKKZepUk
         vfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=YTPmkXXKu3eQXT65FkSjQR/8jU5yX7tIjPl49Vxl9Bk=;
        b=B8RPDq+/JaR1xutH35paWIAVf05ytVVN2a8EngYyCCOzt+2HczTaXXxnv7buJvTNrC
         5JU6W9xeLlDZ6TwY3YnGjYhgK1+yPynb9dJGP1mq7JI+8hOx5j75jmpbTWkrYiT5arfp
         o3y84Ezod8/WJ7UWMVnf0HE0Lf9mL9DyL+bPCNRMc93mdplbPpa/BXW7eziTDeqdFED5
         LM9pxRMhHdVnN6WTFK+qzwd22vmH9g8Ulbv0PdDdoz1Q8w/oEKzl+pkTI77192RHiGck
         t15gODume1f9L7YesELntDRaioCyp2ZJ/qP01St7E1QW0ehDRPJk+glUSACnCHzp1SwR
         Vpjg==
X-Gm-Message-State: AGi0PuYKQXHM8UXfMjUAoDKdn1kjrqZ3Tlv8l4N1zIadVZK7h+7heD9q
        ObSswKDwmtwlO++H1jnT+56JqwFn
X-Google-Smtp-Source: APiQypKv0M3xRPLmc4wN4y/hcue+OWmScJHVIYms2nWBewLvbMKjrdCi4pU95YiEkNLMMsk/+ABUcw==
X-Received: by 2002:adf:8322:: with SMTP id 31mr2995714wrd.1.1586268710250;
        Tue, 07 Apr 2020 07:11:50 -0700 (PDT)
Received: from localhost.localdomain (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id v16sm2492693wml.30.2020.04.07.07.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:11:49 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/6] t3433: remove loops from tests
Date:   Tue,  7 Apr 2020 15:11:21 +0100
Message-Id: <20200407141125.30872-3-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407141125.30872-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Looping inside a test is asking for trouble as we only detect any
failure on the last iteration. Instead get all the dates at once which
is also more efficient. Note the previous code accidentally compared the
diffs as well as the dates this is fixed as well.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3433-rebase-options-compatibility.sh | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
index 5166f158dd..2b4d75f1ef 100755
--- a/t/t3433-rebase-options-compatibility.sh
+++ b/t/t3433-rebase-options-compatibility.sh
@@ -90,13 +90,9 @@ test_expect_success '--committer-date-is-author-date works with rebase -r' '
 	git checkout side &&
 	git merge --no-ff commit3 &&
 	git rebase -r --root --committer-date-is-author-date &&
-	git rev-list HEAD >rev_list &&
-	while read HASH
-	do
-		git show $HASH --pretty="format:%ai" >authortime
-		git show $HASH --pretty="format:%ci" >committertime
-		test_cmp authortime committertime
-	done <rev_list
+	git log --pretty="format:%ai" >authortime &&
+	git log --pretty="format:%ci" >committertime &&
+	test_cmp authortime committertime
 '
 
 # Checking for +0000 in author time is enough since default
@@ -120,12 +116,8 @@ test_expect_success '--ignore-date works with rebase -r' '
 	git checkout side &&
 	git merge --no-ff commit3 &&
 	git rebase -r --root --ignore-date &&
-	git rev-list HEAD >rev_list &&
-	while read HASH
-	do
-		git show $HASH --pretty="format:%ai" >authortime
-		grep "+0000" authortime
-	done <rev_list
+	git log --pretty=%ai >authortime &&
+	! grep -v "+0000" authortime
 '
 
 test_done
-- 
2.26.0

