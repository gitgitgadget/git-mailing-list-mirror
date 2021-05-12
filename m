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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65320C43140
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47EB361166
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239396AbhELRo3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 13:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347757AbhELR3j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 13:29:39 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D4EC0613ED
        for <git@vger.kernel.org>; Wed, 12 May 2021 10:28:30 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v12so24413271wrq.6
        for <git@vger.kernel.org>; Wed, 12 May 2021 10:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/W8yKM0Iad+GJsfgHty7FstnK4TOTYBb4J7fdM1ZrAQ=;
        b=GI/cp9VTG1mzOgvT9lqsTRYZsORQvpSAu7I7uveWpFMvkJr3uCAAPvvZlgDzs0MjJj
         hiXXEC+hNm7+qPrzvq97Upan3pBEsCGzcG6P3e58gk7VpvRxrO3JmFb/+UiOFsTFjXKC
         5LVzTe/kasTYPv+CvN35uTcShyQwvduAwhIDX1Y5pNo2MedVtcXBANd8eDMfDhb/YgDy
         yYp5T8WGHrNRrSEHO0o8ikKMt9ImYtzpT33Q2vsTMHCArm48Lx577AX9aRaxhheRV2aI
         +vfCAhQYuyQoBHFC7hdijNyWeNjuOEtKnD0Ch0coxl/X5ouGkIoGojTHy6uatWY6yi1P
         zWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/W8yKM0Iad+GJsfgHty7FstnK4TOTYBb4J7fdM1ZrAQ=;
        b=HzLJ7kBHTxOc524RLQfcEenSa/7uzhO8QkYQSblJ9i3I1a5bU1I+5kkLboBasgSY74
         ga2liyX5lEf066PhK0IFk49K5ppA2JIGjnF59S7HBuPtjHBiSCequTSYGY3LUhxOknnn
         vY5rNRyfeWVrKtj2yxMEq//r357iqBOaaNi2Bhg/2SU8BH8cicpytO0vqqKgb0CjTiB3
         QOyxHWfEQBWf6Carj6xxeesbJBTqvOCMjGgSfDTycEGw+0SRgLGUC+jouC85CwIs9cxC
         Z6HEk0QlidE2SNpDvTicxMtWQHkImSOAk5bxO9K6veUtU7g5A8YFZcZAlTZ4UWa7P2gK
         jmIA==
X-Gm-Message-State: AOAM5302mJ1HhV9dLtVp5Q+tMHpBd+qoX69Gli5CS+YQvjveckTpqa34
        kfTJzC+EN6+azhtJsk3MVATioSv5EfY=
X-Google-Smtp-Source: ABdhPJz+/7cxPLvwfosuOUCJcJusrpHIoQ/zOnjwQBR+Rce3vCtvKVfG1byq8Y+K7Y2K9B8ZtjX7jg==
X-Received: by 2002:a5d:50c1:: with SMTP id f1mr8593377wrt.168.1620840509588;
        Wed, 12 May 2021 10:28:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm315674wro.23.2021.05.12.10.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:28:29 -0700 (PDT)
Message-Id: <b014ccbbaf3e4bbee310ac19c09e467d6cea2cef.1620840502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
References: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
        <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 May 2021 17:28:18 +0000
Subject: [PATCH v5 5/9] t3001, t7300: add testcase showcasing missed directory
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

