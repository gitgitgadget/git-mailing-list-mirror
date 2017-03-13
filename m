Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ED0E201C2
	for <e@80x24.org>; Mon, 13 Mar 2017 06:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751036AbdCMGwN (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 02:52:13 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36593 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdCMGwL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 02:52:11 -0400
Received: by mail-pg0-f66.google.com with SMTP id 25so17175010pgy.3
        for <git@vger.kernel.org>; Sun, 12 Mar 2017 23:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kfuHMLV2ulDQyyDlv5UNAGwH4/zhT8upp1Cc3jRbA/Y=;
        b=lJhzoFZU/YQqqf6VbdXecR7ZQx4FSEYccQCV5s8dDJsvpzvzH2Zq9ad1CmM2LQ7x53
         LiWdUqLDWqiee/3PtGXS9WSq9kzHfrBWxZ1aQO6ajE1rNOc6OTiEoQ4vE/uy0EKpgYdT
         tEarVo7aXwi79UdUSuECjALq0lokc3rBWS0U9A1VmVk+LuSseKV6UMQIMIpRgmqf9SxI
         p+pw+5nnXOMSLcNCWWXOt0qwzyddoJJOP96bhYEl68oBt3YaFa/ZK7ZvBc7tFf7btKLX
         vsVWut7uWYCiFIi7x9wGZQ31CA3G1PEayYdubyHBi9UkeUVwr0QKxDbBxYXm1ehlV+v5
         Cchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kfuHMLV2ulDQyyDlv5UNAGwH4/zhT8upp1Cc3jRbA/Y=;
        b=q/rFoD1bf0mRB4BesRxCzSAF1jjoxpFxjl4D3+CDyPSPrlUtfA1MCYMysHn7TQ0dtU
         EUAMd0blVRG3MHdqBOKpilU5/n02Sfek62Fh2xLFVcNBlxZEhAZtMQH8qnU1I+dJrDPz
         F/2k2+3JFS5FzvjECfNFy2Oz+xT0Ky8BGiFJpl9aj7rhcAb7UQqNtBodabIIaP8iMG86
         asjTRic8s6o89gFtttD8zyx9khXep/RQQTVPkalIC4aR0mFplTW0aydWQzBXUnBMgHt/
         z0ElRvV62HR/8igNMOvEEPtwoKEtonVUMHt7JXCKi30yAUOZOtGL05EhOu/8BIGTuXqQ
         KkdA==
X-Gm-Message-State: AMke39k21pVFAXBORLnfD1DSCsrWVxrmrDniGyquLniDxww51a0m9BfeOkwiLUe7+1vvdg==
X-Received: by 10.84.232.131 with SMTP id i3mr46207792plk.172.1489387930229;
        Sun, 12 Mar 2017 23:52:10 -0700 (PDT)
Received: from localhost.localdomain ([47.11.2.204])
        by smtp.gmail.com with ESMTPSA id x63sm31400402pgb.30.2017.03.12.23.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Mar 2017 23:52:09 -0700 (PDT)
From:   Prathamesh <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, jdl@jdl.com,
        Prathamesh <pc44800@gmail.com>
Subject: [PATCH v3] t2027: avoid using pipes
Date:   Mon, 13 Mar 2017 12:21:48 +0530
Message-Id: <20170313065148.10707-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <58c63e10.5585620a.a224d.11cd@mx.google.com>
References: <58c63e10.5585620a.a224d.11cd@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whenever a git command is present in the upstream of a pipe, its failure
gets masked by piping and hence it should be avoided for testing the
upstream git command. By writing out the output of the git command to
a file, we can test the exit codes of both the commands as a failure exit
code in any command is able to stop the && chain.

Signed-off-by: Prathamesh <pc44800@gmail.com>
---
Changed sendemail.name configuration of the .gitconfig file with a single
name, and also included the leftover files of each test to be removed by
test_when_finished if the test is passed successfully.

 t/t2027-worktree-list.sh | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
index 848da5f36..720063bf0 100755
--- a/t/t2027-worktree-list.sh
+++ b/t/t2027-worktree-list.sh
@@ -20,7 +20,7 @@ test_expect_success 'rev-parse --git-common-dir on main worktree' '
 
 test_expect_success 'rev-parse --git-path objects linked worktree' '
 	echo "$(git rev-parse --show-toplevel)/.git/objects" >expect &&
-	test_when_finished "rm -rf linked-tree && git worktree prune" &&
+	test_when_finished "rm -rf linked-tree actual expect && git worktree prune" &&
 	git worktree add --detach linked-tree master &&
 	git -C linked-tree rev-parse --git-path objects >actual &&
 	test_cmp expect actual
@@ -28,19 +28,21 @@ test_expect_success 'rev-parse --git-path objects linked worktree' '
 
 test_expect_success '"list" all worktrees from main' '
 	echo "$(git rev-parse --show-toplevel) $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
-	test_when_finished "rm -rf here && git worktree prune" &&
+	test_when_finished "rm -rf here out actual expect && git worktree prune" &&
 	git worktree add --detach here master &&
 	echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git worktree list | sed "s/  */ /g" >actual &&
+	git worktree list >out &&
+	sed "s/  */ /g" <out >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success '"list" all worktrees from linked' '
 	echo "$(git rev-parse --show-toplevel) $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
-	test_when_finished "rm -rf here && git worktree prune" &&
+	test_when_finished "rm -rf here out actual expect && git worktree prune" &&
 	git worktree add --detach here master &&
 	echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git -C here worktree list | sed "s/  */ /g" >actual &&
+	git -C here worktree list >out &&
+	sed "s/  */ /g" <out >actual &&
 	test_cmp expect actual
 '
 
@@ -49,7 +51,7 @@ test_expect_success '"list" all worktrees --porcelain' '
 	echo "HEAD $(git rev-parse HEAD)" >>expect &&
 	echo "branch $(git symbolic-ref HEAD)" >>expect &&
 	echo >>expect &&
-	test_when_finished "rm -rf here && git worktree prune" &&
+	test_when_finished "rm -rf here actual expect && git worktree prune" &&
 	git worktree add --detach here master &&
 	echo "worktree $(git -C here rev-parse --show-toplevel)" >>expect &&
 	echo "HEAD $(git rev-parse HEAD)" >>expect &&
@@ -69,16 +71,17 @@ test_expect_success 'bare repo setup' '
 '
 
 test_expect_success '"list" all worktrees from bare main' '
-	test_when_finished "rm -rf there && git -C bare1 worktree prune" &&
+	test_when_finished "rm -rf there out actual expect && git -C bare1 worktree prune" &&
 	git -C bare1 worktree add --detach ../there master &&
 	echo "$(pwd)/bare1 (bare)" >expect &&
 	echo "$(git -C there rev-parse --show-toplevel) $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git -C bare1 worktree list | sed "s/  */ /g" >actual &&
+	git -C bare1 worktree list >out &&
+	sed "s/  */ /g" <out >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success '"list" all worktrees --porcelain from bare main' '
-	test_when_finished "rm -rf there && git -C bare1 worktree prune" &&
+	test_when_finished "rm -rf there actual expect && git -C bare1 worktree prune" &&
 	git -C bare1 worktree add --detach ../there master &&
 	echo "worktree $(pwd)/bare1" >expect &&
 	echo "bare" >>expect &&
@@ -92,11 +95,12 @@ test_expect_success '"list" all worktrees --porcelain from bare main' '
 '
 
 test_expect_success '"list" all worktrees from linked with a bare main' '
-	test_when_finished "rm -rf there && git -C bare1 worktree prune" &&
+	test_when_finished "rm -rf there out actual expect && git -C bare1 worktree prune" &&
 	git -C bare1 worktree add --detach ../there master &&
 	echo "$(pwd)/bare1 (bare)" >expect &&
 	echo "$(git -C there rev-parse --show-toplevel) $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git -C there worktree list | sed "s/  */ /g" >actual &&
+	git -C there worktree list >out &&
+	sed "s/  */ /g" <out >actual &&
 	test_cmp expect actual
 '
 
@@ -118,9 +122,11 @@ test_expect_success 'broken main worktree still at the top' '
 		cd linked &&
 		echo "worktree $(pwd)" >expected &&
 		echo "ref: .broken" >../.git/HEAD &&
-		git worktree list --porcelain | head -n 3 >actual &&
+		git worktree list --porcelain >out &&
+		head -n 3 out >actual &&
 		test_cmp ../expected actual &&
-		git worktree list | head -n 1 >actual.2 &&
+		git worktree list >out &&
+		head -n 1 out >actual.2 &&
 		grep -F "(error)" actual.2
 	)
 '
@@ -134,7 +140,8 @@ test_expect_success 'linked worktrees are sorted' '
 		test_commit new &&
 		git worktree add ../first &&
 		git worktree add ../second &&
-		git worktree list --porcelain | grep ^worktree >actual
+		git worktree list --porcelain >out &&
+		grep ^worktree out >actual
 	) &&
 	cat >expected <<-EOF &&
 	worktree $(pwd)/sorted/main
-- 
2.11.0

