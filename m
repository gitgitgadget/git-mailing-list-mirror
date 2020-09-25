Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FAFC4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6158F21D42
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlUNImOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgIYRDj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgIYRDj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 13:03:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374A2C0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:03:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d9so3778350pfd.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WYXuXMUjnhpaXIhYGz0f9JkrG27ddz5CLizov1s0QdY=;
        b=HlUNImOkCxR+KzU2QW9qW6rNblqeavxXBAyft0vD6Z+hVD2tlb+qrCkgllTdenpeTa
         Pi+558yCaub97Kf4Gjbj9PAGEpRNPdOLCdav2RaL4xh9S0iavXwc3nqOIWCgSZh/iRzc
         oTjVCVc49GxIp6YHI6bHPnXgyRd4QPLELM+AqXNCZieF1iG1TlZfmKqtOyDPwNK+x1DR
         +weD7lyqtYDm7WbZyYuVQxoWvI28sHuP0L8poSRxX8yU7lkz2jmWBOsCIv42mfFGHfC8
         hGki0Myeqno8FUPe1TmljS92CJQARuQXwZxGH6kiX8pUCgM8r14KflA/w9hr7fw4N5FJ
         KovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WYXuXMUjnhpaXIhYGz0f9JkrG27ddz5CLizov1s0QdY=;
        b=ALXAqFi8ADs2ac5ZyW+swpwGncD3kfuu+ZScwctPcPKDoOLufRuJn8RgyTZ/gY/Fyv
         sNbx5tTMPxbrpvZ+2fG56NMUI9sI70XjThzmBMh9RJAPOf2dGJ5+Sq9lRB+nV8NdILF2
         IBVb5Rx+ypGB3oeYfG7gqVpP68wyZSU6lx+hMThaFAp6twxbBEjLumn/ZbLThqlMdDQW
         v7JpWOVWQJndeaGlmSnSXvb4kfVnoKDe1C+aPaxMnB+7sKwW1Yu9ij36ccnpRo9WY3Jp
         YMXQXfpwJuM4NVR3RNkHSVkcwRSbpx2IoQ/9MPdxZQKlYxHQ0+9OyrnbtPQYebW56eHI
         x7Vw==
X-Gm-Message-State: AOAM533d2aDFHGwf2HkSZj3wWdekn9Uok2W+mYZ4hpba1/x21zTNqY8U
        Z8pH6EBjR7fjguDx1LjD4P/hrpnThoMvpA==
X-Google-Smtp-Source: ABdhPJwxs+L1ZoKc47vHQlqzampkUvrZ9XqrmCgQV20eco4PasMGAv8+jCRMuTlLvJAaI2p58ZQf/Q==
X-Received: by 2002:a62:1dc1:0:b029:13e:d13d:a051 with SMTP id d184-20020a621dc10000b029013ed13da051mr193854pfd.23.1601053418321;
        Fri, 25 Sep 2020 10:03:38 -0700 (PDT)
Received: from localhost.localdomain ([47.9.163.48])
        by smtp.gmail.com with ESMTPSA id k27sm2822467pgm.29.2020.09.25.10.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 10:03:37 -0700 (PDT)
From:   shubham verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Cc:     Shubham Verma <shubhunic@gmail.com>
Subject: [PATCH 10/11] t7001: use `test` rather than `[`
Date:   Fri, 25 Sep 2020 22:32:55 +0530
Message-Id: <20200925170256.11490-11-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925170256.11490-1-shubhunic@gmail.com>
References: <20200925170256.11490-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Shubham Verma <shubhunic@gmail.com>

According to Documentation/CodingGuidelines, we should use "test"
rather than "[ ... ]" in shell scripts, so let's replace the
"[ ... ]" with "test" in the t7001 test script.

Signed-off-by: shubham verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 30714a8200..7bb4a7b759 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -236,10 +236,10 @@ test_expect_success 'git mv should not change sha1 of moved cache entry' '
 	git add dirty &&
 	entry="$(git ls-files --stage dirty | cut -f 1)" &&
 	git mv dirty dirty2 &&
-	[ "$entry" = "$(git ls-files --stage dirty2 | cut -f 1)" ] &&
+	test "$entry" = "$(git ls-files --stage dirty2 | cut -f 1)" &&
 	echo 2 >dirty2 &&
 	git mv dirty2 dirty &&
-	[ "$entry" = "$(git ls-files --stage dirty | cut -f 1)" ]
+	test "$entry" = "$(git ls-files --stage dirty | cut -f 1)"
 '
 
 rm -f dirty dirty2
@@ -326,7 +326,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and no .gitm
 	mkdir mod &&
 	git mv sub mod/sub &&
 	! test -e sub &&
-	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
+	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
@@ -346,7 +346,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and .gitmodu
 	mkdir mod &&
 	git mv sub mod/sub &&
 	! test -e sub &&
-	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
+	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	echo mod/sub >expected &&
 	git config -f .gitmodules submodule.sub.path >actual &&
@@ -363,7 +363,7 @@ test_expect_success 'git mv moves a submodule with gitfile' '
 	mkdir mod &&
 	git -C mod mv ../sub/ . &&
 	! test -e sub &&
-	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
+	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	echo mod/sub >expected &&
 	git config -f .gitmodules submodule.sub.path >actual &&
@@ -382,7 +382,7 @@ test_expect_success 'mv does not complain when no .gitmodules file is found' '
 	git mv sub mod/sub 2>actual.err &&
 	test_must_be_empty actual.err &&
 	! test -e sub &&
-	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
+	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
@@ -403,7 +403,7 @@ test_expect_success 'mv will error out on a modified .gitmodules file unless sta
 	git mv sub mod/sub 2>actual.err &&
 	test_must_be_empty actual.err &&
 	! test -e sub &&
-	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
+	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
@@ -421,7 +421,7 @@ test_expect_success 'mv issues a warning when section is not found in .gitmodule
 	git mv sub mod/sub 2>actual.err &&
 	test_i18ncmp expect.err actual.err &&
 	! test -e sub &&
-	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
+	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
-- 
2.25.1

