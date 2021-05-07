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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530C8C43461
	for <git@archiver.kernel.org>; Fri,  7 May 2021 04:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3044D613E3
	for <git@archiver.kernel.org>; Fri,  7 May 2021 04:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhEGEGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 00:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhEGEGD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 00:06:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1154C061763
        for <git@vger.kernel.org>; Thu,  6 May 2021 21:05:03 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id s8so7681903wrw.10
        for <git@vger.kernel.org>; Thu, 06 May 2021 21:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/8i2rA0Y8K4hQ70lLLGfR6UfKhpltRjIYWd7MBEBp4s=;
        b=Jy6rWGW8k7K9NAXUhxmXUjiRuuzXvRg9/O/SenRyFJ1ScqLn1LgeR4VDcD18u8gKwm
         Y8qINneiud2lR1PUtGIz/NcFSIMyspCiDuakZjucpDI4ru80Z2uULehE2NNku7F4lihY
         6Ojhf4aO/3KEXeG8dYvXf7AjSJH7cGDibjv8uaMyAPf59w+GPHhr1Pmt0gJlKHNUSMsP
         2DSSjYa0O0AFNicZY+yog85fcynGSdhJDV1Fcidq/e/Hlhgy2NoHLlrTkGdG1FyOKeJY
         /Xaextzhps3SQDkM21/aK7DOZSf/5oKfeZG68ROvpvgeIjOHyCDkvN088Q/dxWsF7vk9
         2jhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/8i2rA0Y8K4hQ70lLLGfR6UfKhpltRjIYWd7MBEBp4s=;
        b=PWjR9lu2hyxYneg1h4nrCXxypyepfWqsoSYHV/5xPgKFW2uHw5tQJNxTO8wZYbawah
         Md8qg2Qu6YkO5Fsh0kskycihbOu6nHnaQz048UA9BLygJXL0sm7fSVWoTE3Ubd0TQlPM
         IGt98BVngQEjxMI6NdD0w1cB5K+f0n50d4GxeDqJ/269f8bVMbGAHF2+1yzLRENyMso/
         TR0UJWHIhtKQnLBER4HJ2TFsFVq+cJHUMvb25eVoInYWlfZc79cZu5ET5fbSuXV6S3FX
         /3VUqsOL5nrcgUFBBS+w6gXG5Lf7G2BOZfVyuc52Pypx9EDqwTNYDPf9OV2PDOSVGkhL
         eY0g==
X-Gm-Message-State: AOAM533Y37ZkVVKn+1GIJBFQnOCPtt7rKXDoETDV5lEa77Er8Z50jQdf
        UCWgY/20wsb6lk+5lprfSvtIXEGYWqE=
X-Google-Smtp-Source: ABdhPJzz7quWZ6BkhEIL+f2NznzfSQt2dfTijevSYbMv0TGnaVnsQ+Hf7AbANG7IEMaGt0G8qTWnDw==
X-Received: by 2002:adf:e811:: with SMTP id o17mr9563023wrm.71.1620360302731;
        Thu, 06 May 2021 21:05:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e18sm7574630wrc.85.2021.05.06.21.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 21:05:02 -0700 (PDT)
Message-Id: <aa3a41e26eca0d3c9668b91ea9f1cc8f8faccdea.1620360300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 07 May 2021 04:04:57 +0000
Subject: [PATCH 2/5] t3001, t7300: add testcase showcasing missed directory
 traversal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
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
index 5f1dc397c11e..337f9af1d74b 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -786,4 +786,23 @@ test_expect_failure 'avoid traversing into ignored directories' '
 	)
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

