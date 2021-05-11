Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC45C43460
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9EFB61919
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhEKSfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 14:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbhEKSfW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 14:35:22 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A15FC061763
        for <git@vger.kernel.org>; Tue, 11 May 2021 11:34:15 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y124-20020a1c32820000b029010c93864955so125991wmy.5
        for <git@vger.kernel.org>; Tue, 11 May 2021 11:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/W8yKM0Iad+GJsfgHty7FstnK4TOTYBb4J7fdM1ZrAQ=;
        b=ZUP9buW3WKRjS9+RvSMA9P0Kb3Dztlf4HGC0m5Vnf85YarZW/oe4q/sTrUe6uwLx/Z
         vmL4aX8v8b+l6/jKqbTMap+ZgSNFAPDkfrB7EcAZPJuJXMeY6woQUzjKRXXubXAYamSS
         Bg+/gNy6m9j3A6AHUiTz5x6JwgDbtcnzZzprjDcQsEig9w6o27hAJXX3c/qH+oSyQ7hM
         R0YyfENSEIFa6/vPxma89JrXZ1KgMijfWhRSyLzRrUGYeXo5wuzx2j0tNe2rO+3YEwqd
         w019TVu6AFt78t125eu1JFBLvGfu6h5L0p9QYS/7ayV/cfL+NZNnFZ+c3abH+nxf3/XI
         mmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/W8yKM0Iad+GJsfgHty7FstnK4TOTYBb4J7fdM1ZrAQ=;
        b=p/4G2xjFD4v10tufVs28AAiigkyKDNG2D6p605js1Revr9qrH+9VGUdOzw0mbg5uwi
         v/r1Yrm7z9G4C36N5mjV8b7O/q973mqeMRgTW2Pu7/wCqKdQbeqHO7zEtghiNhLhapMx
         K5BNnc/wMI72YN1STcSUf9aUjgrHPFEEXRU++I6m2gC9+WXRTAw2Vng09sv+MYUAHuei
         /avtZfM4nBDG41L6VnMv4cydskjg6WxYfaBNU6xtc7Oykcefg9wZ7BAvx9/SbuN+FgOs
         7W1/wEyysnJIh5MFCfSwWf19K3r3mPziR491r4yEG2dbMYTBy/Ggu5DQqVBqII0K8EqD
         NQEw==
X-Gm-Message-State: AOAM533Lw4oi9ZhFoS0grudFYKMb7UDSqjBvnIiEpFvYgPFEkLbyrMcV
        kchiOwqqopEJMXebeOSQBM09AvsMTEQ=
X-Google-Smtp-Source: ABdhPJzsEIdvJ+A32y9vXL3TYGwey3FF29JCZ8HzoVo2iKGuxPcC2mC2IiWtaesrqTC8eCwu+AWLvw==
X-Received: by 2002:a7b:c312:: with SMTP id k18mr34443255wmj.89.1620758054287;
        Tue, 11 May 2021 11:34:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm32175138wrg.34.2021.05.11.11.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:34:13 -0700 (PDT)
Message-Id: <5eb019327b57e710de976301ae3ec7a022645a95.1620758049.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
References: <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
        <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 May 2021 18:34:05 +0000
Subject: [PATCH v4 5/8] t3001, t7300: add testcase showcasing missed directory
 traversal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In the last commit, we added a testcase showing that the directory
traversal machinery sometimes traverses into directories unnecessarily.
Here we show that there are cases where it does the opposite: it does
not traverse into directories, despite those directories having
important files that need to be flagged.

Add a testcase showing that `git ls-files -o -i --directory` can omit
some of the files it should be listing, and another showing that `git
clean -fX` can fail to clean out some of the expected files.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3001-ls-files-others-exclude.sh |  5 +++++
 t/t7300-clean.sh                   | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 1ec7cb57c7a8..ac05d1a17931 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -292,6 +292,11 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_failure 'ls-files with "**" patterns and --directory' '
+	# Expectation same as previous test
+	git ls-files --directory -o -i --exclude "**/a.1" >actual &&
+	test_cmp expect actual
+'
 
 test_expect_success 'ls-files with "**" patterns and no slashes' '
 	git ls-files -o -i --exclude "one**a.1" >actual &&
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 07e8ba2d4b85..34c08c325407 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -769,4 +769,23 @@ test_expect_failure 'avoid traversing into ignored directories' '
 	test_cmp trace.expect trace.relevant
 '
 
+test_expect_failure 'traverse into directories that may have ignored entries' '
+	test_when_finished rm -f output &&
+	test_create_repo need-to-traverse-into-hierarchy &&
+	(
+		cd need-to-traverse-into-hierarchy &&
+		mkdir -p modules/foobar/src/generated &&
+		> modules/foobar/src/generated/code.c &&
+		> modules/foobar/Makefile &&
+		echo "/modules/**/src/generated/" >.gitignore &&
+
+		git clean -fX modules/foobar >../output &&
+
+		grep Removing ../output &&
+
+		test_path_is_missing modules/foobar/src/generated/code.c &&
+		test_path_is_file modules/foobar/Makefile
+	)
+'
+
 test_done
-- 
gitgitgadget

