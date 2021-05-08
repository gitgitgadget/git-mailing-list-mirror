Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABFBC433ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 19:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F079613DD
	for <git@archiver.kernel.org>; Sat,  8 May 2021 19:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhEHUAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 16:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhEHUAO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 16:00:14 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D66C061574
        for <git@vger.kernel.org>; Sat,  8 May 2021 12:59:12 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id b11-20020a7bc24b0000b0290148da0694ffso8943261wmj.2
        for <git@vger.kernel.org>; Sat, 08 May 2021 12:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FcvYj/0NhHKLtpTAsYPf5K0U/h63ZzfMQ7TJJTRKLdY=;
        b=l/JSdqsZGDgp/377EYtzoj9npbYhBrUcIywWDOm8YAsFtCfBH02wwkHunx+PE0KIlQ
         N+A2dtS9HJvXDy8hgY3vzMfslCYag1jBOagq6LUsy0tqQ4mr9dmXhX7vk4Pb9bHajDNT
         SjurkE018tFhDHeZnWCaPjxNY6oFQ2eFVKMPwwFYREUkcnA4REBPvMOJWZ83FvKN53Ee
         Fob/ZJksIjSVHlwBEvBV1T8KWQDnMBUJZD1AJw0cv02m2OlmF/Bc/V2TSDTuk997lOdQ
         rVb+on+iP63nQJzTfwmwOZ6ruaolNUtFrgXy+i2t4PxRi90Vd44mI0tr67/jsHmPYzW/
         0HjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FcvYj/0NhHKLtpTAsYPf5K0U/h63ZzfMQ7TJJTRKLdY=;
        b=fDDadAimBDAgeY92sEPGTFRjYNp/UITt/kNYkE+WPvmOaF8y91neHGjLfI6PSNRHVS
         xhUq6qpnNAWhSdhXkm/47iART4/jt+RLMMXoazbPUo2xGuA/opF5Ww8bRbzKynExyxIa
         vFMdHh9Y1aPIP2UB3xNf5jgupHlxl3R0dOg/lHiIxzL6uY8TLMOYFZxtb/PX8BRHYrXf
         YUullce2m7lozYXnSeomUmSqZZIOqv6zD77GwTbSdJoJyWYjeTGQV22Gwdyciwtlqvts
         RN/uv5KHi+3QbIiMWa724Rw3iMkhL2jiWdW4lzbgK2rWP0x/H7IbWIRbpHr9jiqQgNzc
         ge8Q==
X-Gm-Message-State: AOAM531+WTo128rfNlLPAJnjmnYIgY2deSwRWmVuJZc8nE+GPHTLeTpu
        P+QwV9iRw8+xZB3bH4n5/WmMFJcVrL8=
X-Google-Smtp-Source: ABdhPJymtHJZ9FL3tB4YAXTGKpv9T1oUcaT0tU+GhkmXPYQxYzddNki9YPSsxdGtHJGH5ss2SYmORg==
X-Received: by 2002:a7b:c24a:: with SMTP id b10mr28699978wmj.157.1620503951116;
        Sat, 08 May 2021 12:59:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i14sm14658521wmb.33.2021.05.08.12.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 12:59:10 -0700 (PDT)
Message-Id: <73b03a1e8e05fd4e1952c8f4b0bb7b8519a77862.1620503945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
References: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
        <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 May 2021 19:59:01 +0000
Subject: [PATCH v3 5/8] t3001, t7300: add testcase showcasing missed directory
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
index b7c9898fac5b..74d395838708 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -768,4 +768,23 @@ test_expect_failure 'avoid traversing into ignored directories' '
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

