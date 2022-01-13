Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DE8C433FE
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 16:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbiAMQnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 11:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiAMQny (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 11:43:54 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E44C061574
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 08:43:54 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id k18so11154303wrg.11
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 08:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S1PaJJPg2o30UCucYg9eejKkU83zrUc2phIaz5eaHU4=;
        b=HyXSJq5i06FayjGPQUMfmsfo7fEX7Jw3GWiRPBZle51N+r6he42OSHDEFWuwZXqRrP
         FfJTSABXarjAV2ljJeT9S87oNlPOqGlqGKOM8ZGM+Xe7FGLF92IrSdseSrVCBMVrdrk1
         /KUjffD9Ax9hAl2Zc1WJVQDCTbwU4NWXwupUh0xI3paUR1PJn4QJ30FBz1fgLfo3ogpH
         pBZcwto+MPSEFqgrgDHugd0BTvdWvRzHGjG7cFSvgTnY3ktJ6TpX7ETPzD0ZrPbiE8/X
         zddhwuA6UEgyt11Jkyz8Hw2hYVVaWTM3CByj81IniHvRJXn6FtfGGg0CDnYXAWZo49uS
         Pbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S1PaJJPg2o30UCucYg9eejKkU83zrUc2phIaz5eaHU4=;
        b=txDNbFxKdx6mlYtbLuiB13OicE13WHK5BOlWiFWa0Yy5fsDsU/FilBsm8O6XoCgjCx
         c/IJ7/7c0T8qCM3rcE00akkFJS7L18OwU4AqzxS9foFLOMf7T9oijAgdVOLprQ4X+CCh
         7Qn9li45iIukeFmDjNWi499WCz4Z9r07vSqyMVI7jQr9Yl0OHR/ErD6rwZbSM3fAcmJw
         BTYDVPhc/QErDXXdMmrBEFmBr9O3xmztS1jEu24WjzNVnAYnfAluI0QueeFti7r3BsiO
         i6OCboOI1eYDZJxk4Y14qrEDZ/UsPfG8+OunDoXnuzuYEI1D/W+eK+QZJgrgAZjjj56Y
         vKvw==
X-Gm-Message-State: AOAM533WAFbHUMV9NV+OXRWDDRMumfGEM9FUMI3jJ6C2h3FJkm+3I127
        s0JZarE/nDZqUmh0zJEh0H/CI9ygt20=
X-Google-Smtp-Source: ABdhPJxzF3lGw6ZjIkpQNAuxP6LknL2g47dxCKEEm2DxT4hp2Plh0gGlZTEHj3eH04f7PcVcDmLXvg==
X-Received: by 2002:adf:fac8:: with SMTP id a8mr690122wrs.140.1642092232809;
        Thu, 13 Jan 2022 08:43:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a6sm2968385wrq.22.2022.01.13.08.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 08:43:52 -0800 (PST)
Message-Id: <c553d558c2f154efbed9c14fd5abce52bf5ab247.1642092230.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
References: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Jan 2022 16:43:46 +0000
Subject: [PATCH 1/5] t1011: add testcase demonstrating accidental loss of user
 modifications
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

If a user has a file with local modifications that is not marked as
SKIP_WORKTREE, but the sparsity patterns are such that it should be
marked that way, and the user then invokes a command like

   * git checkout -q HEAD^

or

   * git read-tree -mu HEAD^

Then the file will be deleted along with all the users' modifications.
Add a testcase demonstrating this problem.

Note: This bug only triggers if something other than 'HEAD' is given;
if the commands above had specified 'HEAD', then the users' file would
be left alone.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t1011-read-tree-sparse-checkout.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index 24092c09a95..1b2395b8a82 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -187,6 +187,27 @@ test_expect_success 'read-tree updates worktree, absent case' '
 	test ! -f init.t
 '
 
+test_expect_success 'read-tree will not throw away dirty changes, non-sparse' '
+	echo "/*" >.git/info/sparse-checkout &&
+	read_tree_u_must_succeed -m -u HEAD &&
+
+	echo dirty >init.t &&
+	read_tree_u_must_fail -m -u HEAD^ &&
+	test_path_is_file init.t &&
+	grep -q dirty init.t
+'
+
+test_expect_failure 'read-tree will not throw away dirty changes, sparse' '
+	echo "/*" >.git/info/sparse-checkout &&
+	read_tree_u_must_succeed -m -u HEAD &&
+
+	echo dirty >init.t &&
+	echo sub/added >.git/info/sparse-checkout &&
+	read_tree_u_must_fail -m -u HEAD^ &&
+	test_path_is_file init.t &&
+	grep -q dirty init.t
+'
+
 test_expect_success 'read-tree updates worktree, dirty case' '
 	echo sub/added >.git/info/sparse-checkout &&
 	git checkout -f top &&
-- 
gitgitgadget

