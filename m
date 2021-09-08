Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF56C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C1B461154
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348638AbhIHJuf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 05:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348506AbhIHJue (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 05:50:34 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD20FC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 02:49:26 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t18so2415614wrb.0
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EKgIYMV65+pF8SWCbofzmd9DTdcc/w9+US6Qm8arifo=;
        b=p0m5JRRvBWNSsjgw4lLoIvzOSwIR28AZL2oQVRTGF1YmFurmfCF/YbPHXdBldwVl8N
         1WiiZpuwsn7pwBhbuM4WW9JztqykzJB0MmWOmyFSAiv9JuAP9LSL0+zpe9RjL7WuMquB
         A/HDGU+tPP0nQra97pDBoTMscZk30owhKnZNUQ6qCgWxeNjtpB+PiuFA7GxXuNUCRTju
         +OgsOuUi8ObOg6+8V8d0qW1OAsAD7wgOG/7bAcowUbpMSiQX7KS/BWjucXYUD2Yyh78J
         eFmHJVBKWh7qwK5B3YL8NEFq4a3N3dNYE+fB4LvRfDuuMIBwJWlkzrL1lN7aCfnTWhYl
         hr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EKgIYMV65+pF8SWCbofzmd9DTdcc/w9+US6Qm8arifo=;
        b=t3W4T91PcXf6mAaq9OKxsRUF55Y4Pe2co8dAs1cu3f5b4tBCzpnXGytiCWqHjHVy9H
         qhKWebnNpgiEq7MYDeG1Jghrjmkg2OcoW4CgOSaTbhJlKRzkD73qVV5dRxwRG7vxiWdJ
         aaiBrQzsqc+BkusUV2RQaHQCVh4jB8hqkQ1ceGWMNwBfuM2Ll3RbXB/fmpjw5oJW10qi
         r9AqTj2bkynl2b2v5PbSlkaGs9m+wyqCaZsiT2g3BjkRUfzgfplKdfI08h9SCunssWsV
         G7nvDjMOWA9T5de3Kbv84C38glj+76sqRC2Qy8nWOmTijgBQsSxwujl/pjDB/sdXW6YP
         hLwg==
X-Gm-Message-State: AOAM531OSGmvX424bY51mJRZOX1StOSfMTZ2OkKK/0uJhIbQ11k0KkyD
        /Fd5pvTLMXOIv9qj5MqOSOXHq0x6V8Y=
X-Google-Smtp-Source: ABdhPJzUdu9WBrsRB/M2CNZz3jF1kCLaV4OfpT2LjPXB7nCiwY0Z6+yhtYmrzbUusTLmtAgHN0ue5w==
X-Received: by 2002:a5d:4245:: with SMTP id s5mr3082984wrr.237.1631094565280;
        Wed, 08 Sep 2021 02:49:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c13sm1605322wru.73.2021.09.08.02.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 02:49:25 -0700 (PDT)
Message-Id: <79b6dec910ecc9ceb61d03e3bbd9919ce457d78e.1631094563.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 09:49:13 +0000
Subject: [PATCH 02/11] t3407: use test_commit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Simplify the setup by using test_commit. Note that this replaces the
branch "pre-rebase" with a tag of the same name. "pre-rebase" is only
used as a fixed reference point so it makes sense to use a tag rather
than a branch.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3407-rebase-abort.sh | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index c747bd31d76..0ad21966bc5 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -8,22 +8,15 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 test_expect_success setup '
-	echo a > a &&
-	git add a &&
-	git commit -m a &&
+	test_commit a a a &&
 	git branch to-rebase &&
 
-	echo b > a &&
-	git commit -a -m b &&
-	echo c > a &&
-	git commit -a -m c &&
+	test_commit b a b &&
+	test_commit c a c &&
 
 	git checkout to-rebase &&
-	echo d > a &&
-	git commit -a -m "merge should fail on this" &&
-	echo e > a &&
-	git commit -a -m "merge should fail on this, too" &&
-	git branch pre-rebase
+	test_commit "merge should fail on this" a d d &&
+	test_commit "merge should fail on this, too" a e pre-rebase
 '
 
 testrebase() {
-- 
gitgitgadget

