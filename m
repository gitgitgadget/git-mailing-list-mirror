Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36760C433FE
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 23:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AADD60C4B
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 23:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhJNXj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 19:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbhJNXj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 19:39:26 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3730C061753
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 16:37:20 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k7so23016324wrd.13
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 16:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kXmkAGzaxfYRFaeHg7jduXjEuORrryzMVt+gSAozDo0=;
        b=G6a1k2cK51TboduwNgMRk2erOjwW6tHyhzIWxVJyO7CZPHY4VY/J5TaA4oyL0QbWhB
         JVQfR1kC2ohawxfQ2cTtxqlLcdp3T8uN0ciW79psrO6sP/F9LMIkD3xJ8iTqWszYhtDj
         NLj7Sxexffrt99CY9mKil4z72NB/bupNUGa3zOZk93tEDRvwK0C6P6NfD9NJmIuObCk5
         CFawoq6O9JOScHmRIr63qqZvhgcIkyfSaOxHHD5Ht5hUmC37xFfp11jfK9i1YfRlgsPL
         zw3yej6UDo8j06JFRQROmMeIvMoNNQdYa1p5zLWMctTSMEE58ho6L0SD7XVNQLdu6FUV
         hr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kXmkAGzaxfYRFaeHg7jduXjEuORrryzMVt+gSAozDo0=;
        b=Q1odcCMJ925Sa1+teq7IcDqxvWoBpDPgKVBi+frZ1v+kXvbE9u3YnYL039NvW70M9B
         yFTFn0E6sfkuHA4amCiM8eSEmF3DANeE4SQN+EWuZwunrLUrOPq5vK5a8V+0xrWzyu/G
         QvUxr2oGhub4Ketdgbk1b1RLzhwlaj499R0TigqH3FYG807gQq69uFkA0UD7HZI+4tMb
         kr0T3W1oKaH3PxU9FBv8hYEk3AlghF1srHPQJIvopIvlVPTuLrvj7xR1utsENBK1WCe5
         Ra3QggvzL40Jy90JJ46wDwvYwVQhKBtNT93c5bRyVjaGUbMQtkiteBQReXxXwDZ6oSPI
         /O7w==
X-Gm-Message-State: AOAM533ci4J5PgSvvkMtXrU8ADwROJQhDjqcXKGAzSseGEU06nJ26qjo
        0olHqMQLyABWuZDaqyWDBG8D5pgy92bkmg==
X-Google-Smtp-Source: ABdhPJzcG0inY5DTKo3OJKh7RG3FWf7rtUPS7RVR9V73fV8HJnmuSq0GViA4PwUDuNCwv+6MVhGQmA==
X-Received: by 2002:adf:9b8a:: with SMTP id d10mr9759100wrc.151.1634254639163;
        Thu, 14 Oct 2021 16:37:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g16sm3547658wrs.90.2021.10.14.16.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 16:37:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] commit-graph tests: fix another graph_git_two_modes() helper
Date:   Fri, 15 Oct 2021 01:37:15 +0200
Message-Id: <patch-2.3-d6934031882-20211014T233343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-0.3-00000000000-20211014T233343Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20211014T233343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 135a7123755 (commit-graph: add --split option to builtin,
2019-06-18) this function was copy/pasted to the split commit-graph
tests, as in the preceding commit we need to fix this to use
&&-chaining, so it won't be hiding errors.

Unlike its sister function in "t5318-commit-graph.sh", which we got
lucky with, this one was hiding a real test failure. A tests added in
c523035cbd8 (commit-graph: allow cross-alternate chains, 2019-06-18)
has never worked as intended. Unlike most other graph_git_behavior
uses in this file it clones the repository into a sub-directory, so
we'll need to refer to "commits/6" as "origin/commits/6".

It's not easy to simply move the "graph_git_behavior" to the test
above it, since it itself spawns a "test_expect_success". Let's
instead add support to "graph_git_behavior()" and
"graph_git_two_modes()" to pass a "-C" argument to git.

We also need to add a "test -d fork" here, because otherwise we'll
fail on e.g.:

    GIT_SKIP_TESTS=t5324.13 ./t5324-split-commit-graph.sh

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5324-split-commit-graph.sh | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 587226ed103..847b8097109 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -55,8 +55,8 @@ test_expect_success 'create commits and write commit-graph' '
 '
 
 graph_git_two_modes() {
-	git -c core.commitGraph=true $1 >output
-	git -c core.commitGraph=false $1 >expect
+	git ${2:+ -C "$2"} -c core.commitGraph=true $1 >output &&
+	git ${2:+ -C "$2"} -c core.commitGraph=false $1 >expect &&
 	test_cmp expect output
 }
 
@@ -64,12 +64,13 @@ graph_git_behavior() {
 	MSG=$1
 	BRANCH=$2
 	COMPARE=$3
+	DIR=$4
 	test_expect_success "check normal git operations: $MSG" '
-		graph_git_two_modes "log --oneline $BRANCH" &&
-		graph_git_two_modes "log --topo-order $BRANCH" &&
-		graph_git_two_modes "log --graph $COMPARE..$BRANCH" &&
-		graph_git_two_modes "branch -vv" &&
-		graph_git_two_modes "merge-base -a $BRANCH $COMPARE"
+		graph_git_two_modes "log --oneline $BRANCH" "$DIR" &&
+		graph_git_two_modes "log --topo-order $BRANCH" "$DIR" &&
+		graph_git_two_modes "log --graph $COMPARE..$BRANCH" "$DIR" &&
+		graph_git_two_modes "branch -vv" "$DIR" &&
+		graph_git_two_modes "merge-base -a $BRANCH $COMPARE" "$DIR"
 	'
 }
 
@@ -187,7 +188,10 @@ test_expect_success 'create fork and chain across alternate' '
 	)
 '
 
-graph_git_behavior 'alternate: commit 13 vs 6' commits/13 commits/6
+if test -d fork
+then
+	graph_git_behavior 'alternate: commit 13 vs 6' commits/13 origin/commits/6 "fork"
+fi
 
 test_expect_success 'test merge stragety constants' '
 	git clone . merge-2 &&
-- 
2.33.1.1338.g20da966911a

