Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3214202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 19:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933164AbdCIS6A (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 13:58:00 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34107 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933158AbdCIS54 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 13:57:56 -0500
Received: by mail-pg0-f65.google.com with SMTP id b5so7704668pgg.1
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 10:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zS6uJCknMwf/Qtr7QzXrPVIX/d35aK12WMzzASq5KBk=;
        b=o79HW3dIsRdy/D1zk2wx+mJ8A4xvPp7xRWjb90QuxNRuCaKu9za254r7Q/2Y5NbmTl
         zkJW83pn4B52fH9L60jkvnHuAf1FeseQ7rQ9uPDLjCTK6QbygxMxrWijjW5xirnGL+n4
         0vozg33FSi9I1VaVNL9AX+TVG20LDF2T/PquBVJqErxXQ41/c6QuuOjUMGF4LJo2phl9
         G03UipoW76JWhAPmBwMQeSm8DpZ3vEhMT5bnU9tYrjv5PVzqFExQnG7TyRNHHyFiQbIi
         Dhp8POXBnPdPfOBirlKY0THa35lpG6RTQ9gA5R8WMiA2zEfzwcUKHCOnCrJ7SUQ4VIfx
         Iw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zS6uJCknMwf/Qtr7QzXrPVIX/d35aK12WMzzASq5KBk=;
        b=lKkf2kluDJxwFkGLl5b7CA10LaglYKhnWDHY8X9MBhcHOSr060jinZ0f8ltv022EPw
         CviOiYHzHMzGQysoq1pMW+aGasz8SW8LXrRwwgkVzBYP7KFkpgV3oqSbZr8QXsoyXGCX
         QpTL/SJaHKAefLDLU4CKZ5ADituW0AOBcedgoI3XG3bM37sGDdhyVzYw1jorA+S2LV/D
         jAJBKGWiFaKvOPDsDQ/QaN5QCl9OYx91H+BpDASVFpiBm6Hg7c86YAPFibYZ8ut4PgxL
         54CDiNbg0+iGHP6nK6t/jYzNcMaP9g2Q9ZICfc5EnNpu/JoC8R1FDpdnlR84p68shnCI
         6hrw==
X-Gm-Message-State: AMke39m4EshPHsAWOBehmwCOmwQ6CnvVgILMo18Eorf2JuoadknKvpYssLBA6n852+PAEw==
X-Received: by 10.99.156.2 with SMTP id f2mr15731388pge.189.1489085865203;
        Thu, 09 Mar 2017 10:57:45 -0800 (PST)
Received: from localhost.localdomain ([47.11.13.12])
        by smtp.gmail.com with ESMTPSA id 80sm13915944pfy.67.2017.03.09.10.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 10:57:44 -0800 (PST)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, jdl@jdl.com,
        Prathamesh <pc44800@gmail.com>
Subject: [PATCH] t2027: avoid using pipes
Date:   Fri, 10 Mar 2017 00:33:10 +0530
Message-Id: <20170309190310.30589-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Prathamesh <pc44800@gmail.com>

Whenever a git command is present in the upstream of a pipe, its failure
gets masked by piping and hence it should be avoided for testing the
upstream git command. By writing out the output of the git command to
a file, we can test the exit codes of both the commands as a failure exit
code in any command is able to stop the && chain.

Signed-off-by: Prathamesh <pc44800@gmail.com>
---
 t/t2027-worktree-list.sh | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
index 848da5f36..d8b3907e0 100755
--- a/t/t2027-worktree-list.sh
+++ b/t/t2027-worktree-list.sh
@@ -31,7 +31,8 @@ test_expect_success '"list" all worktrees from main' '
 	test_when_finished "rm -rf here && git worktree prune" &&
 	git worktree add --detach here master &&
 	echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git worktree list | sed "s/  */ /g" >actual &&
+	git worktree list >out &&
+	sed "s/  */ /g" <out >actual &&
 	test_cmp expect actual
 '
 
@@ -40,7 +41,8 @@ test_expect_success '"list" all worktrees from linked' '
 	test_when_finished "rm -rf here && git worktree prune" &&
 	git worktree add --detach here master &&
 	echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git -C here worktree list | sed "s/  */ /g" >actual &&
+	git -C here worktree list >out &&
+	sed "s/  */ /g" <out >actual &&
 	test_cmp expect actual
 '
 
@@ -73,7 +75,8 @@ test_expect_success '"list" all worktrees from bare main' '
 	git -C bare1 worktree add --detach ../there master &&
 	echo "$(pwd)/bare1 (bare)" >expect &&
 	echo "$(git -C there rev-parse --show-toplevel) $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git -C bare1 worktree list | sed "s/  */ /g" >actual &&
+	git -C bare1 worktree list >out &&
+	sed "s/  */ /g" <out >actual &&
 	test_cmp expect actual
 '
 
@@ -96,7 +99,8 @@ test_expect_success '"list" all worktrees from linked with a bare main' '
 	git -C bare1 worktree add --detach ../there master &&
 	echo "$(pwd)/bare1 (bare)" >expect &&
 	echo "$(git -C there rev-parse --show-toplevel) $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git -C there worktree list | sed "s/  */ /g" >actual &&
+	git -C there worktree list >out &&
+	sed "s/  */ /g" <out >actual &&
 	test_cmp expect actual
 '
 
@@ -118,9 +122,9 @@ test_expect_success 'broken main worktree still at the top' '
 		cd linked &&
 		echo "worktree $(pwd)" >expected &&
 		echo "ref: .broken" >../.git/HEAD &&
-		git worktree list --porcelain | head -n 3 >actual &&
+		git worktree list --porcelain >out && head -n 3 out >actual &&
 		test_cmp ../expected actual &&
-		git worktree list | head -n 1 >actual.2 &&
+		git worktree list >out && head -n 1 out >actual.2 &&
 		grep -F "(error)" actual.2
 	)
 '
@@ -134,7 +138,7 @@ test_expect_success 'linked worktrees are sorted' '
 		test_commit new &&
 		git worktree add ../first &&
 		git worktree add ../second &&
-		git worktree list --porcelain | grep ^worktree >actual
+		git worktree list --porcelain >out && grep ^worktree out >actual
 	) &&
 	cat >expected <<-EOF &&
 	worktree $(pwd)/sorted/main
-- 
2.11.0

