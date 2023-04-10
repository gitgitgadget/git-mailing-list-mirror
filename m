Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A74C77B71
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 09:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjDJJJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 05:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjDJJJP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 05:09:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99964EDF
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 02:08:55 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id eo6-20020a05600c82c600b003ee5157346cso3951149wmb.1
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 02:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681117734;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KyFxtkzBL0DRrO2IANbdTm4OB0I414ZkSlaluqQ4zs4=;
        b=XzTFWl08zDifAh8pvsmXde0ygeXP11uaQl9FFLTTKfTKVrHYsRN+wowRQyuCA9SHcV
         FRLiGsrPS6uN+9CHFz7CtlF+nYtZ2pFoY42O3+VqbmWCTAbS41ZACotuqwUVAHdVh64+
         XtKP19WtirCeIJQ60n/TozjK4KsPhI/ep7BolhcitUM5LFdw0mtP6d+9m0FWj6JqD5Hh
         tnlo9irmrzmUVwLgRdpD9MEJTo/F4kweVME5k0P3B2sQFPFDEkCf6op/AYey+vlxbRpc
         HtERGbvPOMBOirtcGedWsD5os+P6B8junMNLtpLLhHJaTQSuK5awki5u3RxEQJQbbhJL
         0TEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681117734;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KyFxtkzBL0DRrO2IANbdTm4OB0I414ZkSlaluqQ4zs4=;
        b=l11PkmgxE+046ApEGFJTztYPF4Nli6BqTsDK6ImFa+2n1Jqvu7L1REEEeen4/St0gv
         FNeJjN3k4rRdu7rkBFDt9wR3E+/v2/hQfAgLcyIhHpa4q2LRsWIe+d+sG0qP0YLGFE16
         ZlbD+Y72PUlOiAX1rMt0Xp6D9WCgskJH2hzKYqFD0tCLYhUxtWoSPSNhIMaYjApkIzL+
         JYc5RXXxQSJH8piHp3WXD8sxD4+dzJzTT22S2lYpbO2VfKTzOYAx13Oh1omf1iudNb7w
         o07sE3NgdZe5tg5I0Ky62X44kU6bhQ9KLo3yj31uVX9tJuQAMHb3hkHpuyHzXil/od9n
         6ADw==
X-Gm-Message-State: AAQBX9fXJO0py+YWm5wcEmnZdNJP2PptYLAoZx0h25cL+GqhPZQ5BoFj
        YJ5zkeizXI0Y89ZUaHAk8SoIsME8L5o=
X-Google-Smtp-Source: AKy350bUuL9mquX9JO4Z4hzF32ZYqSKzNx1zRUJEEr8wUnektkBDv1xhpN9cvUJ+cfUL+DHIlTPIyw==
X-Received: by 2002:a7b:c7d4:0:b0:3ef:68d5:9573 with SMTP id z20-20020a7bc7d4000000b003ef68d59573mr6941292wmk.19.1681117733997;
        Mon, 10 Apr 2023 02:08:53 -0700 (PDT)
Received: from localhost.localdomain ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c154800b003f034c76e85sm17232568wmg.38.2023.04.10.02.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 02:08:53 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 5/5] rebase: remove a couple of redundant strategy tests
Date:   Mon, 10 Apr 2023 10:08:31 +0100
Message-Id: <7de1aa1016bb22448f10d912b62ebd984779be19.1681117706.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.40.0.672.gbd2d2ac924
In-Reply-To: <cover.1681117706.git.phillip.wood@dunelm.org.uk>
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk> <cover.1681117706.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Remove a test in t3402 that has been redundant ever since 80ff47957b
(rebase: remember strategy and strategy options, 2011-02-06).  That
commit added a new test, the first part of which (as noted in the old
commit message) duplicated an existing test.

Also remove a test t3418 that has been redundant since the merge backend
was removed in 68aa495b59 (rebase: implement --merge via the interactive
machinery, 2018-12-11), since it now tests the same code paths as the
preceding test.

Helped-by: Elijah Newren <newren@gmail.com>
Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3402-rebase-merge.sh    | 21 ---------------------
 t/t3418-rebase-continue.sh | 32 --------------------------------
 2 files changed, 53 deletions(-)

diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index 7e46f4ca85..79b0640c00 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -131,27 +131,6 @@ test_expect_success 'picking rebase' '
 	esac
 '
 
-test_expect_success 'rebase -s funny -Xopt' '
-	test_when_finished "rm -fr test-bin funny.was.run" &&
-	mkdir test-bin &&
-	cat >test-bin/git-merge-funny <<-EOF &&
-	#!$SHELL_PATH
-	case "\$1" in --opt) ;; *) exit 2 ;; esac
-	shift &&
-	>funny.was.run &&
-	exec git merge-recursive "\$@"
-	EOF
-	chmod +x test-bin/git-merge-funny &&
-	git reset --hard &&
-	git checkout -b test-funny main^ &&
-	test_commit funny &&
-	(
-		PATH=./test-bin:$PATH &&
-		git rebase -s funny -Xopt main
-	) &&
-	test -f funny.was.run
-'
-
 test_expect_success 'rebase --skip works with two conflicts in a row' '
 	git checkout second-side  &&
 	tr "[A-Z]" "[a-z]" <newfile >tmp &&
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 42c3954125..2d0789e554 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -97,38 +97,6 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
 	test_cmp expect actual
 '
 
-test_expect_success 'rebase -i --continue handles merge strategy and options' '
-	rm -fr .git/rebase-* &&
-	git reset --hard commit-new-file-F2-on-topic-branch &&
-	test_commit "commit-new-file-F3-on-topic-branch-for-dash-i" F3 32 &&
-	test_when_finished "rm -fr test-bin funny.was.run funny.args" &&
-	mkdir test-bin &&
-	cat >test-bin/git-merge-funny <<-EOF &&
-	#!$SHELL_PATH
-	echo "\$@" >>funny.args
-	case "\$1" in --opt) ;; *) exit 2 ;; esac
-	case "\$2" in --foo) ;; *) exit 2 ;; esac
-	case "\$4" in --) ;; *) exit 2 ;; esac
-	shift 2 &&
-	>funny.was.run &&
-	exec git merge-recursive "\$@"
-	EOF
-	chmod +x test-bin/git-merge-funny &&
-	(
-		PATH=./test-bin:$PATH &&
-		test_must_fail git rebase -i -s funny -Xopt -Xfoo main topic
-	) &&
-	test -f funny.was.run &&
-	rm funny.was.run &&
-	echo "Resolved" >F2 &&
-	git add F2 &&
-	(
-		PATH=./test-bin:$PATH &&
-		git rebase --continue
-	) &&
-	test -f funny.was.run
-'
-
 test_expect_success 'rebase -r passes merge strategy options correctly' '
 	rm -fr .git/rebase-* &&
 	git reset --hard commit-new-file-F3-on-topic-branch &&
-- 
2.40.0.672.gbd2d2ac924

