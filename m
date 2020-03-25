Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038F5C1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD69620714
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTkyVvJa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgCYFzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:55:23 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38003 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgCYFzV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 01:55:21 -0400
Received: by mail-qk1-f196.google.com with SMTP id h14so1462513qke.5
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 22:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NeDa5CkTvwIL8TKIeIyXKu2s+ih1b5I0bD+BmpyqDok=;
        b=WTkyVvJau6fiOoeaHBk4IpOgd+ieOoioELiz9tEbjrC6V5sTv6ZLncYaRWRZZmft/e
         TZMg9/A/0M1lwtxCMrNkh+YkNTO2GvB4OMe2aD8Kp2x4OTfsfHG2rwybH/aNpFcOGRqW
         YhTb6EuY1fKf+07gqQrAAFCIgbXMj3yJmhR4mhMKXMgAzJzYIiPI+u4PecODm6/de82Z
         ItCkpfs5Vc8X56yFybM9NGrwfziLG8FvfsN3zIkG+t5OrCKWPl+afGdSrMd39B9EYwxS
         5pfZpgfwp/eNZ2Czu48yE7zTjuYYF15Q/V0fAIxMwwMxnu/Y95+H+M7JxyLDkDtFZxZb
         FmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NeDa5CkTvwIL8TKIeIyXKu2s+ih1b5I0bD+BmpyqDok=;
        b=bF/N69dGfvYdRgicOIeAJsSBc46wBJuqk5EWnrchzcZmi1MseFdjyqRGAEWGKdif/R
         +BrCSO4tFN/1xPvDUrF/TSKTPHqrfeb+YoYxCxoFNKDXwjQGdQSfL5D4rvdO5+7Y8eLN
         DdICFT0kVRMEVqMD7ko1qqSwyxvr9JFe8pruoD0hXJSrsRV7eqOV6eh2F6A5toTbTK1h
         PpLVbfBgDfb23gVFPqquwgoyJ8kMzbxIXZfJcaTSQeDc9R/+m2rqVSk4JvZp+ZEAajl1
         vwkZee3LiIjstWRf6S9tSvtDzmQk/0Iw4fGqGN2AhmnQ0IAXxAyjXUlDjobDyoTKRRq9
         VKSg==
X-Gm-Message-State: ANhLgQ3K2TpT7Jx+qQlxg/rjkMAPN/nQhtjQfKMmWZx+fgruJ8Ix8F7T
        AiLi0RMi1ObFMYpaprFFnKiSEbuy
X-Google-Smtp-Source: ADFU+vuwZadCLPDw7VcrDa6cLve249RSd+BbpzA77wqcu1zozejNQ7JpWq+Ykrf+Fta8sXRntBYRDg==
X-Received: by 2002:a37:bec5:: with SMTP id o188mr1401165qkf.165.1585115719668;
        Tue, 24 Mar 2020 22:55:19 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id k15sm17168712qta.74.2020.03.24.22.55.18
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 22:55:19 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 7/8] t5612: stop losing return codes of git commands
Date:   Wed, 25 Mar 2020 01:54:54 -0400
Message-Id: <b490ccace0eb93b0f6d71f71e015afebcc9c9a51.1585115341.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1585115341.git.liu.denton@gmail.com>
References: <cover.1585115341.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a pipe, only the return code of the last command is used. Thus, all
other commands will have their return codes masked. Rewrite pipes so
that there are no git commands upstream so that their failure is
reported.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5612-clone-refspec.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
index 28373e715a..e3b436d8ae 100755
--- a/t/t5612-clone-refspec.sh
+++ b/t/t5612-clone-refspec.sh
@@ -71,9 +71,9 @@ test_expect_success 'by default all branches will be kept updated' '
 	(
 		cd dir_all &&
 		git fetch &&
-		git for-each-ref refs/remotes/origin |
+		git for-each-ref refs/remotes/origin >refs &&
 		sed -e "/HEAD$/d" \
-		    -e "s|/remotes/origin/|/heads/|" >../actual
+		    -e "s|/remotes/origin/|/heads/|" refs >../actual
 	) &&
 	# follow both master and side
 	git for-each-ref refs/heads >expect &&
@@ -104,9 +104,9 @@ test_expect_success '--single-branch while HEAD pointing at master' '
 	(
 		cd dir_master &&
 		git fetch --force &&
-		git for-each-ref refs/remotes/origin |
+		git for-each-ref refs/remotes/origin >refs &&
 		sed -e "/HEAD$/d" \
-		    -e "s|/remotes/origin/|/heads/|" >../actual
+		    -e "s|/remotes/origin/|/heads/|" refs >../actual
 	) &&
 	# only follow master
 	git for-each-ref refs/heads/master >expect &&
@@ -126,9 +126,9 @@ test_expect_success '--single-branch while HEAD pointing at master and --no-tags
 	(
 		cd dir_master_no_tags &&
 		git fetch &&
-		git for-each-ref refs/remotes/origin |
+		git for-each-ref refs/remotes/origin >refs &&
 		sed -e "/HEAD$/d" \
-		    -e "s|/remotes/origin/|/heads/|" >../actual
+		    -e "s|/remotes/origin/|/heads/|" refs >../actual
 	) &&
 	# only follow master
 	git for-each-ref refs/heads/master >expect &&
@@ -156,9 +156,9 @@ test_expect_success '--single-branch while HEAD pointing at side' '
 	(
 		cd dir_side &&
 		git fetch &&
-		git for-each-ref refs/remotes/origin |
+		git for-each-ref refs/remotes/origin >refs &&
 		sed -e "/HEAD$/d" \
-		    -e "s|/remotes/origin/|/heads/|" >../actual
+		    -e "s|/remotes/origin/|/heads/|" refs >../actual
 	) &&
 	# only follow side
 	git for-each-ref refs/heads/side >expect &&
@@ -169,9 +169,9 @@ test_expect_success '--single-branch with explicit --branch side' '
 	(
 		cd dir_side2 &&
 		git fetch &&
-		git for-each-ref refs/remotes/origin |
+		git for-each-ref refs/remotes/origin >refs &&
 		sed -e "/HEAD$/d" \
-		    -e "s|/remotes/origin/|/heads/|" >../actual
+		    -e "s|/remotes/origin/|/heads/|" refs >../actual
 	) &&
 	# only follow side
 	git for-each-ref refs/heads/side >expect &&
@@ -223,9 +223,9 @@ test_expect_success '--single-branch with detached' '
 	(
 		cd dir_detached &&
 		git fetch &&
-		git for-each-ref refs/remotes/origin |
+		git for-each-ref refs/remotes/origin >refs &&
 		sed -e "/HEAD$/d" \
-		    -e "s|/remotes/origin/|/heads/|" >../actual
+		    -e "s|/remotes/origin/|/heads/|" refs >../actual
 	) &&
 	# nothing
 	test_must_be_empty actual
-- 
2.25.0.114.g5b0ca878e0

