Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D074C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264EA20772
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rpex6BKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgDAERw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 00:17:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37734 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgDAERw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 00:17:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so28965820wrm.4
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 21:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+Uu/OtliCz0GRSMvQPnzFAlv72hkiZN2b+6iy+13o7w=;
        b=Rpex6BKbOC2EYGIj2pfooucV70W3x/Z9ybVQUASDK/VsmPsxba90RXtqESSk21lnHr
         9CXHn+2zU5LVoHqYTMGnGvYxRYqiLfaZH+NkS9QLfTskM7pRrXj95y9dqTjOHd8f95L3
         kFaj3mxW1yBUemmpL/7zXBF2UFJfX/pfuR6PmkVzKmVBhvks7iBsqVLaPEQb+ISi2SFO
         pK5qHpVpRsnvKDhg65H8gTnUoRjmqAx3JEccoLu4QFKqcAhecKyGWX5LHHW2kBuZAQtE
         vpkQm5m+0Epn4ZwC31agFe66dOXSKJnbqwJXL1qeul1D7D7myVbGi5OftvueZXe8gmJz
         shGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+Uu/OtliCz0GRSMvQPnzFAlv72hkiZN2b+6iy+13o7w=;
        b=P+MUXbhkNwa2XazsdbaC37epn+vvCKwpFAKYYP+MhfeoTry+BDs40hr3BIyCw9ApdQ
         7vivOkvZ2b3bEcYFEBZhY6PsITi76ogGc3DNaeOCUT4gOs7eunPqHTVDVdUopZqWq/SH
         nlAx+opd9Z4gw2Q11p0AAakTG+v9sFg4+jKvvwy+zT8R8lBFyNt1JHQfhBOGfioNEXy4
         nT0c6qQpzPzc4Z6xCeJ4+M4SVbJF1bpDWGZ32fZ/KsNQAE3fD3SR4wwSkJuo5QxoqfVW
         +YJqz95Il1Qm9x1yOqIBQlgtssuPAo++3HYhkj8VykRghtmlLOlSKa+tiKFBaUwYZ/Ge
         Ql/g==
X-Gm-Message-State: ANhLgQ2oNQKQoBYWTIQ4a04pZJUyIiALi9zuPCc3YMY7PSRyUOS7t92c
        +rICpPbxnc8Y+CAoSf3dXdo+7iGe
X-Google-Smtp-Source: ADFU+vs7xqb4kd71SGIljdwnzAFpfakm5BM2h0/hu1vB8psiQqjNNkdCSUnxxzRNUFFMtX2wiYU3ew==
X-Received: by 2002:a05:6000:1212:: with SMTP id e18mr25555245wrx.0.1585714670205;
        Tue, 31 Mar 2020 21:17:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2sm1250004wro.25.2020.03.31.21.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 21:17:49 -0700 (PDT)
Message-Id: <88e9d5d5dbd86123a8af274b44d4d6c4992f37f8.1585714667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
References: <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
        <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 04:17:36 +0000
Subject: [PATCH v5 02/12] t3000: add more testcases testing a variety of
 ls-files issues
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This adds seven new ls-files tests.  While currently all seven test
pass, my earlier rounds of restructuring dir.c to replace an exponential
algorithm with a linear one passed all the tests in the testsuite but
failed six of these seven new tests.  Add these tests to increase our
case coverage.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3000-ls-files-others.sh | 121 +++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index 0aefadacb05..ffdfb16f580 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -91,4 +91,125 @@ test_expect_success SYMLINKS 'ls-files --others with symlinked submodule' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup nested pathspec search' '
+	test_create_repo nested &&
+	(
+		cd nested &&
+
+		mkdir -p partially_tracked/untracked_dir &&
+		> partially_tracked/content &&
+		> partially_tracked/untracked_dir/file &&
+
+		mkdir -p untracked/deep &&
+		> untracked/deep/path &&
+		> untracked/deep/foo.c &&
+
+		git add partially_tracked/content
+	)
+'
+
+test_expect_success 'ls-files -o --directory with single deep dir pathspec' '
+	(
+		cd nested &&
+
+		git ls-files -o --directory untracked/deep/ >actual &&
+
+		cat <<-EOF >expect &&
+		untracked/deep/
+		EOF
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'ls-files -o --directory with multiple dir pathspecs' '
+	(
+		cd nested &&
+
+		git ls-files -o --directory partially_tracked/ untracked/ >actual &&
+
+		cat <<-EOF >expect &&
+		partially_tracked/untracked_dir/
+		untracked/
+		EOF
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'ls-files -o --directory with mix dir/file pathspecs' '
+	(
+		cd nested &&
+
+		git ls-files -o --directory partially_tracked/ untracked/deep/path >actual &&
+
+		cat <<-EOF >expect &&
+		partially_tracked/untracked_dir/
+		untracked/deep/path
+		EOF
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'ls-files --o --directory with glob filetype match' '
+	(
+		cd nested &&
+
+		# globs kinda defeat --directory, but only for that pathspec
+		git ls-files --others --directory partially_tracked "untracked/*.c" >actual &&
+
+		cat <<-EOF >expect &&
+		partially_tracked/untracked_dir/
+		untracked/deep/foo.c
+		EOF
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'ls-files --o --directory with mix of tracked states' '
+	(
+		cd nested &&
+
+		# globs kinda defeat --directory, but only for that pathspec
+		git ls-files --others --directory partially_tracked/ "untracked/?*" >actual &&
+
+		cat <<-EOF >expect &&
+		partially_tracked/untracked_dir/
+		untracked/deep/
+		EOF
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'ls-files --o --directory with glob filetype match only' '
+	(
+		cd nested &&
+
+		git ls-files --others --directory "untracked/*.c" >actual &&
+
+		cat <<-EOF >expect &&
+		untracked/deep/foo.c
+		EOF
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'ls-files --o --directory to get immediate paths under one dir only' '
+	(
+		cd nested &&
+
+		git ls-files --others --directory "untracked/?*" >actual &&
+
+		cat <<-EOF >expect &&
+		untracked/deep/
+		EOF
+
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
gitgitgadget

