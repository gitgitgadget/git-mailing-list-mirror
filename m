Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DA2C433E1
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 318AD2076C
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjgZhtSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgHJW32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgHJW30 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 18:29:26 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221E4C061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 15:29:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r4so9622884wrx.9
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 15:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xKuJGgSfiy3dx+s9AVZCYCTr2e5m53uc2WX+DfrFmcU=;
        b=OjgZhtSmihE8Vr1ORo5buBQP+MolWvfs2pxCKXgEUbj9p+5ciIZtn9IVj9RoWA8OEj
         4hvgfuIa4GHD5IhCnskLdUwC4DwWH96WqQTpUAw2dhGzJOUkurDnqAkDV7n6Z2b5otWM
         r7bar/wGWW/slL9eDkeqMcsozWrCxmjl5mL2xmtt575teJMMp3Q/KWIXV6k+B5WECrue
         vd3L7qjtwQQLDkwrtPAy/kDtqjxCVNfy0Xz+ExkGY6c3WS9wkVFhGT3+ZdZNytJDf70s
         hobRM/VuadhJmNxLybTVjEZ575PFjtZ57+VCn5EeO9TlW4wx1pv7UTffHfWecveqBH3S
         rlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xKuJGgSfiy3dx+s9AVZCYCTr2e5m53uc2WX+DfrFmcU=;
        b=JdzG/61wXs1Y3nOpJFrwqwhQ4/vBjtiJflfUNmdX/c5oT7H8JZiKJ2kmtHDR5sH+kE
         QjQxbei5tJ/hYA2B173fgLp6PDeKUKEyEg9p7lpuDrzt7p00GCIwPS2AlJYQ5wdAggNw
         c+6TwRFBBMV87S18NFgiQx38UhfpRHMMcAi23wjb722oUXy6se8HJothyuOkCreec3RP
         I1yPrmSmlqGgDvrlHuOULV/33XcThuWiffrc9pDY0e6CgGdwXvNZyep3xXTeFZIUYWrQ
         WC6F6WqVPiqiAF1l9rFSaqFUkqxdLKVFsGFh8zcH6l7ZqNVvLvYbQdkMk2qO+fCLimQl
         lwXg==
X-Gm-Message-State: AOAM533E9X3nRQTEDQBa8NEoyt/xxowho8dT6gyezxD4QdmnseYT+Q0D
        iU+B55Wj7R5jpeMTIPOo/U7K5Mub
X-Google-Smtp-Source: ABdhPJy5Q60O+TrnawVdDFQ0E7kKwWWuR4Y9S5eWDXzAEdGffI6tmdm5SIrzx3PeadfHnTuNYSpupw==
X-Received: by 2002:adf:f511:: with SMTP id q17mr3237262wro.414.1597098564576;
        Mon, 10 Aug 2020 15:29:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t13sm22666435wru.65.2020.08.10.15.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 15:29:24 -0700 (PDT)
Message-Id: <78df85aee5ff84293912632f48951718cff3dee8.1597098559.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.827.v3.git.git.1597098559.gitgitgadget@gmail.com>
References: <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
        <pull.827.v3.git.git.1597098559.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Aug 2020 22:29:12 +0000
Subject: [PATCH v3 04/11] t6416, t6422: fix incorrect untracked file count
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Apparently I don't know how to count untracked files, and since the
tests in question were marked as test_expect_failure, no one ever
noticed it until now.  Correct the count, as these tests clearly create
three untracked files ('out', 'err', and 'file_count').

(I believe this problem arose because earlier incarnations counted lines
via a pipe to 'wc -l'.  Reviewers asked that it be replaced by writing
the output to a file and using test_line_count, but when the temporary
output was added to a separate file, the count of untracked files should
have increased.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6416-recursive-corner-cases.sh    | 2 +-
 t/t6422-merge-rename-corner-cases.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
index b3bf462617..d272b418e4 100755
--- a/t/t6416-recursive-corner-cases.sh
+++ b/t/t6416-recursive-corner-cases.sh
@@ -1144,7 +1144,7 @@ test_expect_failure 'check symlink add/add' '
 		test_must_fail git merge -s recursive E^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 2 out &&
+		test_line_count = 3 out &&
 		git ls-files -u >out &&
 		test_line_count = 2 out &&
 		git ls-files -o >out &&
diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index 7da75c1736..c8ee033ad9 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -899,7 +899,7 @@ test_expect_failure 'rad-check: rename/add/delete conflict' '
 		git ls-files -u >file_count &&
 		test_line_count = 2 file_count &&
 		git ls-files -o >file_count &&
-		test_line_count = 2 file_count &&
+		test_line_count = 3 file_count &&
 
 		git rev-parse >actual \
 			:2:bar :3:bar &&
@@ -967,7 +967,7 @@ test_expect_failure 'rrdd-check: rename/rename(2to1)/delete/delete conflict' '
 		git ls-files -u >file_count &&
 		test_line_count = 2 file_count &&
 		git ls-files -o >file_count &&
-		test_line_count = 2 file_count &&
+		test_line_count = 3 file_count &&
 
 		git rev-parse >actual \
 			:2:baz :3:baz &&
-- 
gitgitgadget

