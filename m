Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEE2C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 16:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794082464E
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 16:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foRtLCie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfLFQIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:08:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46134 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfLFQIe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 11:08:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so8277248wrl.13
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 08:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=GfEaOtzUHDGbmxdQOAOP0/euqYz6dr2IJX2UdXmg+lM=;
        b=foRtLCiecT3syd8XZrW5elvPTVi712TEcOEFOKXsvTagu+OAoN/AQG2Et9wP+qg4Pg
         QRfuFf6/mT75/WXCMloUAFUxIw5FiB/ydtwSLSGx0LshqDsEyN5ZJVV122ZScfXs15vy
         9CvMUalHhBNXhY3L9oGHqIWanmtPM93kTrsfRkMWuDdrzR0QFcMGUctpyshBgSm46cc/
         +NK5OxxMl8E3MkbFgsZ/6qI4BOIVu9aFVm9VgOkbeV5NK9M8eijah/AFlHwctUsUGex3
         7cuW9Uc7Bhfb+1NUOke0YCEBCGLSzloLTfVEc79puX3ExuZu0cVz391Mlsd2uThiOvYH
         yRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=GfEaOtzUHDGbmxdQOAOP0/euqYz6dr2IJX2UdXmg+lM=;
        b=K68eAARUa4WsHpc8dEnwnZV+YJg51vN0ZsIf21clhZeIMeC9Xnk1H0Mo5k9UV9CfIk
         YaLjcEmjty0CvAS+EsHuwcUkng0VyAdhhz7fJ4TvoWdkCQlvNkO4fItgU+DtZSYEK24E
         eX1a9aYfeEYDAgALPrhZoXnQLyNj+G2ZxyehMHJ879Cj7DUBOT/Ot/vOTI9J7MvyiW9g
         Vr92slGbmqgyFJh70gPnrccKB5B/BbxBm9/T1qLDZLXbCNm8dkREDyBOXLLSMm30/zHh
         R6+Qdifl44qq0g6Q1N07B/u/4emV2W5EQaulPs06GZOCqnNyLEu65Lu90nttz6ATV2IU
         h+ag==
X-Gm-Message-State: APjAAAUMgcfrsSRyiWE3jysW15l8nVLlixMRTSqrrKsNp1RH340JQulD
        zUVtWUUD+y+gvnec8v1jnnQBrnG1
X-Google-Smtp-Source: APXvYqxuNX68hlEJfAnVE9iaHOHSlM50d49Jwz8oAqHI5TShWBT7rQvcKHm5sdgKbknXv88o4e4brQ==
X-Received: by 2002:a5d:690e:: with SMTP id t14mr14997762wru.65.1575648511064;
        Fri, 06 Dec 2019 08:08:31 -0800 (PST)
Received: from localhost.localdomain (host-92-22-0-192.as13285.net. [92.22.0.192])
        by smtp.gmail.com with ESMTPSA id q15sm16649799wrr.11.2019.12.06.08.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 08:08:30 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 1/9] t3404: use test_cmp_rev
Date:   Fri,  6 Dec 2019 16:06:06 +0000
Message-Id: <20191206160614.631724-2-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191206160614.631724-1-phillip.wood123@gmail.com>
References: <pull.417.git.1571787022.gitgitgadget@gmail.com>
 <20191206160614.631724-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

There are a number of places where we compare two revisions with
    test $(git rev-parse rev1) = $(git rev-parse rev2)
when these fail there's no indication what has gone wrong and you need
to be running with `-x` to see where the test has failed. Lets use
test_cmp_rev instead.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3404-rebase-interactive.sh | 38 +++++++++++++++++------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index c573c99069..d8a05fd439 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -191,7 +191,7 @@ test_expect_success 'no changes are a nop' '
 	git checkout branch2 &&
 	git rebase -i F &&
 	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch2" &&
-	test $(git rev-parse I) = $(git rev-parse HEAD)
+	test_cmp_rev I HEAD
 '
 
 test_expect_success 'test the [branch] option' '
@@ -200,16 +200,16 @@ test_expect_success 'test the [branch] option' '
 	git commit -m "stop here" &&
 	git rebase -i F branch2 &&
 	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch2" &&
-	test $(git rev-parse I) = $(git rev-parse branch2) &&
-	test $(git rev-parse I) = $(git rev-parse HEAD)
+	test_cmp_rev I branch2 &&
+	test_cmp_rev I HEAD
 '
 
 test_expect_success 'test --onto <branch>' '
 	git checkout -b test-onto branch2 &&
 	git rebase -i --onto branch1 F &&
 	test "$(git symbolic-ref -q HEAD)" = "refs/heads/test-onto" &&
-	test $(git rev-parse HEAD^) = $(git rev-parse branch1) &&
-	test $(git rev-parse I) = $(git rev-parse branch2)
+	test_cmp_rev HEAD^ branch1 &&
+	test_cmp_rev I branch2
 '
 
 test_expect_success 'rebase on top of a non-conflicting commit' '
@@ -218,12 +218,12 @@ test_expect_success 'rebase on top of a non-conflicting commit' '
 	git rebase -i branch2 &&
 	test file6 = $(git diff --name-only original-branch1) &&
 	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch1" &&
-	test $(git rev-parse I) = $(git rev-parse branch2) &&
-	test $(git rev-parse I) = $(git rev-parse HEAD~2)
+	test_cmp_rev I branch2 &&
+	test_cmp_rev I HEAD~2
 '
 
 test_expect_success 'reflog for the branch shows state before rebase' '
-	test $(git rev-parse branch1@{1}) = $(git rev-parse original-branch1)
+	test_cmp_rev branch1@{1} original-branch1
 '
 
 test_expect_success 'reflog for the branch shows correct finish message' '
@@ -280,7 +280,7 @@ test_expect_success 'show conflicted patch' '
 
 test_expect_success 'abort' '
 	git rebase --abort &&
-	test $(git rev-parse new-branch1) = $(git rev-parse HEAD) &&
+	test_cmp_rev new-branch1 HEAD &&
 	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch1" &&
 	test_path_is_missing .git/rebase-merge
 '
@@ -323,7 +323,7 @@ test_expect_success 'retain authorship w/ conflicts' '
 	echo resolved >conflict &&
 	git add conflict &&
 	git rebase --continue &&
-	test $(git rev-parse conflict-a^0) = $(git rev-parse HEAD^) &&
+	test_cmp_rev conflict-a^0 HEAD^ &&
 	git show >out &&
 	grep AttributeMe out
 '
@@ -340,7 +340,7 @@ test_expect_success 'squash' '
 			git rebase -i --onto master HEAD~2
 	) &&
 	test B = $(cat file7) &&
-	test $(git rev-parse HEAD^) = $(git rev-parse master)
+	test_cmp_rev HEAD^ master
 '
 
 test_expect_success 'retain authorship when squashing' '
@@ -399,9 +399,9 @@ test_expect_success REBASE_P 'preserve merges with -p' '
 	git update-index --refresh &&
 	git diff-files --quiet &&
 	git diff-index --quiet --cached HEAD -- &&
-	test $(git rev-parse HEAD~6) = $(git rev-parse branch1) &&
-	test $(git rev-parse HEAD~4^2) = $(git rev-parse to-be-preserved) &&
-	test $(git rev-parse HEAD^^2^) = $(git rev-parse HEAD^^^) &&
+	test_cmp_rev HEAD~6 branch1 &&
+	test_cmp_rev HEAD~4^2 to-be-preserved &&
+	test_cmp_rev HEAD^^2^ HEAD^^^ &&
 	test $(git show HEAD~5:file1) = B &&
 	test $(git show HEAD~3:file1) = C &&
 	test $(git show HEAD:file1) = E &&
@@ -433,7 +433,7 @@ test_expect_success '--continue tries to commit' '
 		git add file1 &&
 		FAKE_COMMIT_MESSAGE="chouette!" git rebase --continue
 	) &&
-	test $(git rev-parse HEAD^) = $(git rev-parse new-branch1) &&
+	test_cmp_rev HEAD^ new-branch1 &&
 	git show HEAD | grep chouette
 '
 
@@ -740,7 +740,7 @@ test_expect_success 'do "noop" when there is nothing to cherry-pick' '
 		--author="Somebody else <somebody@else.com>" &&
 	test $(git rev-parse branch3) != $(git rev-parse branch4) &&
 	git rebase -i branch3 &&
-	test $(git rev-parse branch3) = $(git rev-parse branch4)
+	test_cmp_rev branch3 branch4
 
 '
 
@@ -799,7 +799,7 @@ test_expect_success 'rebase -i continue with unstaged submodule' '
 	test_must_fail git rebase -i submodule-base &&
 	git reset &&
 	git rebase --continue &&
-	test $(git rev-parse submodule-base) = $(git rev-parse HEAD)
+	test_cmp_rev submodule-base HEAD
 '
 
 test_expect_success 'avoid unnecessary reset' '
@@ -822,7 +822,7 @@ test_expect_success 'reword' '
 			git rebase -i A &&
 		git show HEAD | grep "E changed" &&
 		test $(git rev-parse master) != $(git rev-parse HEAD) &&
-		test $(git rev-parse master^) = $(git rev-parse HEAD^) &&
+		test_cmp_rev master^ HEAD^ &&
 		FAKE_LINES="1 2 reword 3 4" FAKE_COMMIT_MESSAGE="D changed" \
 			git rebase -i A &&
 		git show HEAD^ | grep "D changed" &&
@@ -886,7 +886,7 @@ test_expect_success 'always cherry-pick with --no-ff' '
 		git diff HEAD~$p original-no-ff-branch~$p > out &&
 		test_must_be_empty out
 	done &&
-	test $(git rev-parse HEAD~3) = $(git rev-parse original-no-ff-branch~3) &&
+	test_cmp_rev HEAD~3 original-no-ff-branch~3 &&
 	git diff HEAD~3 original-no-ff-branch~3 > out &&
 	test_must_be_empty out
 '
-- 
2.24.0

