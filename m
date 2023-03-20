Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A567C6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 20:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjCTUz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 16:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCTUzV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 16:55:21 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045EB1286C
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:55:00 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id j6so7160454ilr.7
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679345699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYmlBXY1omZk8OGUlXCcXhCQjZOf0FO/8SyhsWWntQI=;
        b=iq4Qo7eu0ni0f7GV7NFn122xE5T38Tt7MbzDYa3FRMt5jfy5cBR1jrTzZDGL2oj+3H
         LiHagvaJDNTKwfC+GWdhp0OhQHlhscR+o7HGaP4FvqlP30dPccCSFXfsUg4VLibyT5uf
         2x7WeLWh5efGmTzRpHUo15A3AqgLPOGf7nnDsgNhISEF4ose5gyI1fbRBGdxISx5jB7M
         QuT7jWQoT9SD63LhQ210pRMGax3JKdhGCk6ptY7y2ZFbXm4ES8tL3vrXPvAwYAzFEu65
         DgqmWNnmjVhXaBk3Fs+5ConzYvHQedNJSXVtjZFo3poQ8YBIKJuurI7RUEyQFzoZzEvK
         0n1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679345699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYmlBXY1omZk8OGUlXCcXhCQjZOf0FO/8SyhsWWntQI=;
        b=lPoZjoRiFFhFtYLgp3uyboBNfYbHRua0GuaBZav3gu4g4OhRj3hWdaWWTnaK9RFFDy
         U88CO221CFAyZvxTi/aTGDSgUDW1yPE+AtVV6g1iraKTCV3gc4N16J7L4+DsjCUTQeAQ
         d8RDGSlVCUCEJWiE8rV6qs/8rcsR89QU/TIElEaySxeK0meCVAXjC8V/QkflwefJPlIi
         9NSHgVGd0cx8oLv09B/BFruPJLjhbZCVCCIDWGVeHy6ZuZzBaAKnkbSUI7sTNuTGxXTI
         hTPDvDAS3Kge7mq0o2ZgcEleK4jfim4B7vZzazZBo7HiMr0UxI29Eje5brU0QHqRQTAP
         wxYg==
X-Gm-Message-State: AO0yUKWjDlD4I5iPT5zDOB8mlL8HbKr3PUBNzjwuhzsaq6hZGhNP9Xyb
        eSyHJKbW5cixGHPe3xGeyZ+c56xwa94=
X-Google-Smtp-Source: AK7set9buuqNFZIoA8NrqXMC7n1bbNGD9GJhOJ50/pFUgsmB+VCyVZL1q/AQxbI8aycLRnO9oMkhKg==
X-Received: by 2002:a92:ce07:0:b0:324:7d63:8622 with SMTP id b7-20020a92ce07000000b003247d638622mr26026ilo.2.1679345699001;
        Mon, 20 Mar 2023 13:54:59 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id a16-20020a056e020e1000b00323058c173csm3045610ilk.59.2023.03.20.13.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:54:58 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v6 1/2] t1092: add tests for `git diff-files`
Date:   Mon, 20 Mar 2023 16:52:40 -0400
Message-Id: <20230320205241.105476-2-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230320205241.105476-1-cheskaqiqi@gmail.com>
References: <20230310050021.123769-1-cheskaqiqi@gmail.com>
 <20230320205241.105476-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before integrating the 'git diff-files' builtin
with the sparse index feature, add tests to
t1092-sparse-checkout-compatibility.sh to ensure it currently works
with sparse-checkout and will still work with sparse index
after that integration.

When adding tests against a sparse-checkout
definition, we test two modes: all changes are
within the sparse-checkout cone and some changes are outside
the sparse-checkout cone.

In order to have staged changes outside of
the sparse-checkout cone, make a directory called 'folder1' and
copy `a` into 'folder1/a'. 'folder1/a' is identical to `a` in the base
commit. These make 'folder1/a' in the index, while leaving it outside of
the sparse-checkout definition. Test 'folder1/a'being present on-disk
without modifications, then change content inside 'folder1/a' in order
to test 'folder1/a' being present on-disk with modifications.

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 42 ++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 801919009e..c1329e2f16 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2055,4 +2055,46 @@ test_expect_success 'grep sparse directory within submodules' '
 	test_cmp actual expect
 '
 
+test_expect_success 'diff-files with pathspec inside sparse definition' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>"$1"
+	EOF
+
+	run_on_all ../edit-contents deep/a &&
+
+	test_all_match git diff-files &&
+
+	test_all_match git diff-files deep/a && 
+
+	# test wildcard
+	test_all_match git diff-files deep/*
+'
+
+test_expect_failure 'diff-files with pathspec outside sparse definition' '
+	init_repos &&
+
+	test_sparse_match test_must_fail git diff-files folder2/a &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>"$1"
+	EOF
+
+	# Add file to the index but outside of cone for sparse-checkout cases.
+	# Add file to the index without sparse-checkout cases to ensure all have 
+	# same output.
+	run_on_all mkdir folder1 &&
+	run_on_all cp a folder1/a &&
+
+	# file present on-disk without modifications
+	test_all_match git diff-files &&
+	test_all_match git diff-files folder1/a &&
+
+	# file present on-disk with modifications
+	run_on_all ../edit-contents folder1/a &&
+	test_all_match git diff-files &&
+	test_all_match git diff-files folder1/a
+'
+
 test_done
-- 
2.39.0

