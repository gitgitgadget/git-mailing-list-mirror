Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F2CC388F9
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 19:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFBAA206E9
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 19:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pbfn/vVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgJaTqJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Oct 2020 15:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgJaTqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Oct 2020 15:46:09 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627EBC0617A6
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 12:46:07 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n18so10070340wrs.5
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 12:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=w8nUu7BRu2aWbJhnGf+2WSKb3qUph8o2g10+K0DHJSw=;
        b=Pbfn/vVtCW7C4/IPk6krqsIz5rvp5k1DH3EzyMN5DfN7LsMbeIQzgm4+xF7GM05eYB
         DNIRKr0sALoxO+er1LEz/K/1m0kWqM9LbPBMMUQcYCxLKI1B5VnV2DewqPsZO/1JYr12
         tSYDyhquNHXnF0oLe+0FJKVEA4Zj5FM2jNIggNiJ+x9o+qXM+nbXypa4AYk8hbYheZUK
         Y4rXBdXr0JVxFMsy0ogSW+6rNrcqpkbtvXfQ9E1OVm9rKN3F1FjuYy5aYHpLQrvSuOyJ
         wSNOPSadXieLWkIxAFIxZFa7zA4SIXrY+UieeEcWtlbhw1F/ajauyMygxR3LtbvuwGOG
         86LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=w8nUu7BRu2aWbJhnGf+2WSKb3qUph8o2g10+K0DHJSw=;
        b=THQdDZieuPbirZFOX7MtnmlHr4ZWqvSfIvJ5R7BGuLVOK/WY+yHAiGXnYyTCUWh1C6
         x5C401VygM3FOfbp8pLzF8D2lp0IlWjAPlHcfPS21oo9gu1D4NPfmgycfy42d8e/QnR0
         21tZZLezH9eET0t74cA94ODHFviS7JoY5yk1Ef+GULbwXMQhzB7uwDPT2cau1RCADyEw
         I+xgbSFqFwlSTMPx0IZ3G9lxt8h5VzbpEtkmCCixJerO+DBCSpljJybkLlYAmcjg35HF
         YwdbMQEvj+uNo5XnL3c118xFd+aVmq+quOv+n3LPfnAogrBZ2h7vLlz+VIoY86+5PRYB
         97jQ==
X-Gm-Message-State: AOAM530SIId8/JSRACGxspBFFV3BXRpWU8fEa4BGTYgiXRLBmzy8KX77
        Gg1OvW1DwT1a6NKID198Al5xKRXRwSc=
X-Google-Smtp-Source: ABdhPJx/KJoY//7DTi5l/NJL5usSO9Xe5tU3lKyc+Oh1WfVQy9greV7kjTbywEf3b3/Nm2UpVLTrbA==
X-Received: by 2002:a5d:67ca:: with SMTP id n10mr10768585wrw.209.1604173566041;
        Sat, 31 Oct 2020 12:46:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m12sm14660948wrs.92.2020.10.31.12.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 12:46:05 -0700 (PDT)
Message-Id: <9b1c7eb0b4a007c4820aefeb221374887c8d9f8f.1604173563.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.760.v2.git.1604173563.gitgitgadget@gmail.com>
References: <pull.760.git.1603839487.gitgitgadget@gmail.com>
        <pull.760.v2.git.1604173563.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 31 Oct 2020 19:46:00 +0000
Subject: [PATCH v2 1/4] t5411: start using the default branch name "main"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This is a straight-forward search-and-replace in the test script;
However, this is not yet complete because it requires many more
replacements in `t/t5411/`, too many for a single patch (the Git mailing
list rejects mails larger than 100kB). For that reason, we disable this
test script temporarily via the `PREPARE_FOR_MAIN_BRANCH` prereq.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5411-proc-receive-hook.sh | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
index 746487286f..6da6f597a5 100755
--- a/t/t5411-proc-receive-hook.sh
+++ b/t/t5411-proc-receive-hook.sh
@@ -5,13 +5,21 @@
 
 test_description='Test proc-receive hook'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
+test_have_prereq PREPARE_FOR_MAIN_BRANCH || {
+	test_skip="In transit for the default branch name 'main'"
+	test_done
+}
+
 . "$TEST_DIRECTORY"/t5411/common-functions.sh
 
 setup_upstream_and_workbench () {
-	# Refs of upstream : master(A)
-	# Refs of workbench: master(A)  tags/v123
+	# Refs of upstream : main(A)
+	# Refs of workbench: main(A)  tags/v123
 	test_expect_success "setup upstream and workbench" '
 		rm -rf upstream.git &&
 		rm -rf workbench &&
@@ -25,10 +33,10 @@ setup_upstream_and_workbench () {
 			git config core.abbrev 7 &&
 			git tag -m "v123" v123 $A &&
 			git remote add origin ../upstream.git &&
-			git push origin master &&
-			git update-ref refs/heads/master $A $B &&
+			git push origin main &&
+			git update-ref refs/heads/main $A $B &&
 			git -C ../upstream.git update-ref \
-				refs/heads/master $A $B
+				refs/heads/main $A $B
 		) &&
 		TAG=$(git -C workbench rev-parse v123) &&
 
@@ -99,8 +107,8 @@ start_httpd
 # Re-initialize the upstream repository and local workbench.
 setup_upstream_and_workbench
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
 test_expect_success "setup for HTTP protocol" '
 	git -C upstream.git config http.receivepack true &&
 	upstream="$HTTPD_DOCUMENT_ROOT_PATH/upstream.git" &&
-- 
gitgitgadget

