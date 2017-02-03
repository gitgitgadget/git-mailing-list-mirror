Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D6311F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 02:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbdBCCye (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:54:34 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33273 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbdBCCy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:54:29 -0500
Received: by mail-wm0-f66.google.com with SMTP id v77so1211177wmv.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PVN8m00goDFJQ/ymoNQipFibhbQP3+EOaSA/5DDYZT4=;
        b=mjZopGbxvEmKpWki8Vf35k6Y2y1TrhnIqdIQUtP+HWwMasR9pajLP4OjtjvL6/vJBt
         Vfza5FUQL4krj0mvKN95uxPo218n9BJSP1/xVlPf/nuOYn83i7jZB+5gvHfnpCRWaePR
         g1IFIi+UDaB4P66ik27ED7Ia1JZVyv7aalcyyD19g9O9kFQeru43Oli4xQyRb9UBZpXq
         ccWCDJx4hOIqS4ooYRusfuFLK4Ha/0jd79P9de22Z4FxuLSXDO5yMo72R2PSjJBDIqpZ
         +7+aY9C/7VM6sdCe14SpFsG7cyd1+iINzzoujlAU9QBS05JQ1Ho6gDQVT8vY8KrrR5jX
         y8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PVN8m00goDFJQ/ymoNQipFibhbQP3+EOaSA/5DDYZT4=;
        b=ZeTsIBdzpNl69zONzxOBR8NFcKKCpTx7LLTlc1VeM5NHWSJFL9r7P6iO5uBtxYbUAO
         iDOq45G52dMrW35Z5JtGXZVyT1mn3JqBYPRSywJfbz+8fgqr2eP/CFw5lX67ge+Cx6jD
         XftqC4r06lm+iSvO/sZPJE5lvuncaMUp6iswwnYqM3mbW212FwonBRaDjQy1T+bOs9y2
         LCtM4NDVyrE/njhK5dF387ehhO2Kob+dATC98TuJ9Pzztvj8FUzrE++aVda0aUyx/L/E
         12Px2sFAzzjy+rCJIYyiZ4LG+1maRFXC49UIcTeohIhl9QaAF5wHWqaStSe8WothWenV
         UdHg==
X-Gm-Message-State: AIkVDXLdLyzeBMQyEZh5cwqHoF8Q/xP77iMn7IJHgx+Uo2/5vd4g+0h5jt8lWkFaaPJLUg==
X-Received: by 10.223.136.206 with SMTP id g14mr9582036wrg.52.1486090468096;
        Thu, 02 Feb 2017 18:54:28 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id c133sm652291wmd.13.2017.02.02.18.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:54:27 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 04/12] completion: support excluding full refs
Date:   Fri,  3 Feb 2017 03:53:57 +0100
Message-Id: <20170203025405.8242-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203025405.8242-1-szeder.dev@gmail.com>
References: <20170203025405.8242-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 49416ad22 (completion: support excluding refs, 2016-08-24) made
possible to complete short refs with a '^' prefix.

Extend the support to full refs to make completing '^refs/...' work.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash |  8 ++++----
 t/t9902-completion.sh                  | 31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 67a03cfd4..63e803154 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -387,6 +387,10 @@ __git_refs ()
 	fi
 
 	if [ "$list_refs_from" = path ]; then
+		if [[ "$cur_" == ^* ]]; then
+			pfx="^"
+			cur_=${cur_#^}
+		fi
 		case "$cur_" in
 		refs|refs/*)
 			format="refname"
@@ -394,10 +398,6 @@ __git_refs ()
 			track=""
 			;;
 		*)
-			if [[ "$cur_" == ^* ]]; then
-				pfx="^"
-				cur_=${cur_#^}
-			fi
 			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD; do
 				if [ -e "$dir/$i" ]; then echo $pfx$i; fi
 			done
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 8fe748839..7b42a686c 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -806,6 +806,37 @@ test_expect_success '__git_refs - after --opt= - full refs' '
 	test_cmp expected "$actual"
 '
 
+test_expect_success '__git refs - exluding refs' '
+	cat >expected <<-EOF &&
+	^HEAD
+	^master
+	^matching-branch
+	^other/branch-in-other
+	^other/master-in-other
+	^matching-tag
+	EOF
+	(
+		cur=^ &&
+		__git_refs >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git refs - exluding full refs' '
+	cat >expected <<-EOF &&
+	^refs/heads/master
+	^refs/heads/matching-branch
+	^refs/remotes/other/branch-in-other
+	^refs/remotes/other/master-in-other
+	^refs/tags/matching-tag
+	EOF
+	(
+		cur=^refs/ &&
+		__git_refs >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
 test_expect_success '__git_complete_refs - simple' '
 	sed -e "s/Z$//g" >expected <<-EOF &&
 	HEAD Z
-- 
2.11.0.555.g967c1bcb3

