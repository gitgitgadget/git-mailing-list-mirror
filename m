Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C411C433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 18:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345767AbiAKSGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 13:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350366AbiAKSF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 13:05:57 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DDFC061751
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 10:05:12 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id k30so16947274wrd.9
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 10:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6m2WCFlbDEH3Qi6Apwp4WNApLrFFTqGiR5cvu5IYYvw=;
        b=XsmDeWfc/cmj/QEVRrLEjNOO1SIAr4bQ44aU1xmx70LheHDimJ5tSZ4RxWm3JxxVbd
         gyTyb4dcDVIC1rl9KqcoAscG5kG9pEBL3M1OXZnMZ2raIKNoEHhxN6Lzdkk6H1me5D2d
         7bFCgZ4k4lCl8XSDeK4lWAf8k7vnXdbFu8pHxJ1Qo/6TNs1i8a4zpbLK8tUKP7ZFTU6i
         4HEOZ8HwEds3n+viz8UdypkMiPGbTRMf4gY2cZBp+eSKBMpitFXGqIoVVgyRB+QVIfti
         djy4F0pFurD/M39FqMcZuHxvdRphXglHf9rRdQVrYAprBZC7g88YsyN2LUsGYwhcEYZi
         Q8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6m2WCFlbDEH3Qi6Apwp4WNApLrFFTqGiR5cvu5IYYvw=;
        b=P3LJYuAQvDKVZvQegJSza8LLF70cv0Ou/O5jZX+u1Gthi25cztgg6in5w6XeEirWHs
         txcyoJOievlYo2kogyzjfAoAhKpH2ANL/wQRWAzE8YlvXYJeZ4+cTbO+QYAYjYOyxWou
         u/Nm/+4g2jd8JtaLIC5US6aiNapBIu2COOUqz027JDur1bf+MmX8CFKdT07595smVgnr
         S4EcnIQN1ksMcazW6SXVZxB+3aR5KJGN2D8OLxzyF69Zp1GZh+4X3xIa9gATL8g3qmRp
         LO64fUvs3p94dmsw9mxhU4M6o3As3dhHRrjWlZCcMYXF1jwImA5+Tipf4hqeHAG8R0TW
         HPSg==
X-Gm-Message-State: AOAM5337HwHlswz17F8DqVx458oDcUo4GrwbIKnuNeO4rnCVG1aiMvtm
        RORUwb8b682FQUdJjxfy1O7yAwTeAeY=
X-Google-Smtp-Source: ABdhPJwwIgHIRcHKZF+jYRwyPki+gm0QSk0Oxegg4628L3ui7zQejglfPgcUVAoGR7KqH5xvD2s/Cg==
X-Received: by 2002:a5d:50c7:: with SMTP id f7mr2853690wrt.494.1641924308934;
        Tue, 11 Jan 2022 10:05:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b13sm10124662wrh.32.2022.01.11.10.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 10:05:08 -0800 (PST)
Message-Id: <eefb6ab4c61460d21dca3877b83a0e6c2852c43c.1641924306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1109.v2.git.1641924306.gitgitgadget@gmail.com>
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
        <pull.1109.v2.git.1641924306.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Jan 2022 18:04:58 +0000
Subject: [PATCH v2 1/9] reset: fix validation in sparse index test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Update t1092 test 'reset with pathspecs outside sparse definition' to verify
index contents. The use of `rev-parse` verifies the contents of HEAD, not
the index, providing no real validation of the reset results. Conversely,
`ls-files` reports the contents of the index (OIDs, flags, filenames), which
are then compared across checkouts to ensure compatible index states.

Fixes 741a2c9ffa (reset: expand test coverage for sparse checkouts,
2021-09-27).

Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 49f70a65692..d5167e7ed69 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -596,13 +596,11 @@ test_expect_success 'reset with pathspecs outside sparse definition' '
 
 	test_sparse_match git reset update-folder1 -- folder1 &&
 	git -C full-checkout reset update-folder1 -- folder1 &&
-	test_sparse_match git status --porcelain=v2 &&
-	test_all_match git rev-parse HEAD:folder1 &&
+	test_all_match git ls-files -s -- folder1 &&
 
 	test_sparse_match git reset update-folder2 -- folder2/a &&
 	git -C full-checkout reset update-folder2 -- folder2/a &&
-	test_sparse_match git status --porcelain=v2 &&
-	test_all_match git rev-parse HEAD:folder2/a
+	test_all_match git ls-files -s -- folder2/a
 '
 
 test_expect_success 'reset with wildcard pathspec' '
-- 
gitgitgadget

