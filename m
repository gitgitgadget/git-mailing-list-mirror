Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4FDC77B76
	for <git@archiver.kernel.org>; Sun, 23 Apr 2023 01:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjDWBIC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 21:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjDWBHy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 21:07:54 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F3D2680
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 18:07:48 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-32a62613a69so7563575ab.2
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 18:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682212067; x=1684804067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WS1C69dV2c+3wT88dF+arsxIkemHYVfkcJixhtDOVY8=;
        b=ROpsa869iEU2gYO0l2LQ+ylldyHipV6Sa/8PMIXzZGIrL2DWQ2cxk8YSEbPCDN9HTu
         htqpcGA8dbRq0v/V1Sf54saKH15rYGVf/7Nhvi6YSbMo50TKYV2ofkUFGgn5rCN8xdMC
         U4ImjL+ZUpItWnapHXVCdubL/Z9O0TkP/0MFxD1ZPkLcepoHBJYI9JSBuWmTsY8bp0/Y
         o5Moft5Ly4z9gUxXSgJzodyG5SOkS2uVS72vopOIb2x4S7PgX9nxTB1sEfKbMS/BOgcX
         iytRaenvTFHvRI8qJtueryRMX52NxgfPzfpyzd9fupMoWtAgPXb1GfmU+Xx56Bh3ok8r
         1Y5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682212067; x=1684804067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WS1C69dV2c+3wT88dF+arsxIkemHYVfkcJixhtDOVY8=;
        b=hIsbEDt+XHLgHmkhSkc3+ljjzV/0OFqUHWNdK5clCdfXlnpr95VYC07QqgAQjQsUhm
         hlWXd6rcvaqGJ4oTIatLzMMRJFf3KAFQY4lxx/H44Wn6dKVgghgtEW4khEPZOL46JQWS
         AGQhrq4GFGBjDVv2DgnwaZTLRLpV2irsYsHXISkBOrzY6PgetwQ3rVUf9DpFEKeN8S1J
         gYZaonDUXI+OZCzP197F3epQI8006g6KZALoviaeHkbGEcd3eiHSnoZyyJtA1rSjnAPJ
         siYxKzDLTR0tG/ktGk4PLRk6hMHtjyqCvZjTtTPbsV9yZ3uS7o6roeiwuolzONjh8xM8
         9xRw==
X-Gm-Message-State: AAQBX9cCrmrHp1q7luV7pP/UoBGKEHu1GQvunrrS9/qimJRuzuCSBWGK
        dUaePCZWNQR9WNzp0HED5xf+P9DWwMbN6A==
X-Google-Smtp-Source: AKy350bdEdO5QVnDyY8mIXWWzsKwfQZr3hOog5LkEoz1m21wVQI6USTz53gTTaLgT7aX6CBy/f5p9Q==
X-Received: by 2002:a92:d3c6:0:b0:32b:2146:f0a4 with SMTP id c6-20020a92d3c6000000b0032b2146f0a4mr2556033ilh.20.1682212067618;
        Sat, 22 Apr 2023 18:07:47 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id z1-20020a92d6c1000000b0032e28db67dcsm669819ilp.84.2023.04.22.18.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 18:07:47 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v8 1/2] t1092: add tests for `git diff-files`
Date:   Sat, 22 Apr 2023 21:07:20 -0400
Message-Id: <20230423010721.1402736-2-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230423010721.1402736-1-cheskaqiqi@gmail.com>
References: <20230322161820.3609-1-cheskaqiqi@gmail.com>
 <20230423010721.1402736-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before integrating the 'git diff-files' builtin with the sparse index
feature, add tests to t1092-sparse-checkout-compatibility.sh to ensure
it currently works with sparse-checkout and will still work with sparse
index after that integration.

When adding tests against a sparse-checkout definition, we test two
modes: all changes are within the sparse-checkout cone and some changes
are outside the sparse-checkout cone.

In order to have staged changes outside of the sparse-checkout cone,
make a directory called 'folder1' and copy `a` into 'folder1/a'.
'folder1/a' is identical to `a` in the base commit. These make
'folder1/a' in the index, while leaving it outside of the
sparse-checkout definition. Test 'folder1/a'being present on-disk
without modifications, then change content inside 'folder1/a' in order
to test 'folder1/a' being present on-disk with modifications.

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 46 ++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 0c784813f1..3c140103c5 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2108,4 +2108,50 @@ test_expect_success 'sparse-index is not expanded: write-tree' '
 	ensure_not_expanded write-tree
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
+	test_all_match git diff-files "deep/*"
+'
+
+test_expect_success 'diff-files with pathspec outside sparse definition' '
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
+	run_on_all mkdir -p folder1 &&
+	run_on_all cp a folder1/a &&
+
+	# file present on-disk without modifications
+	# use `--stat` to ignore file creation time differences in
+	# unrefreshed index
+	test_all_match git diff-files --stat &&
+	test_all_match git diff-files --stat folder1/a &&
+	test_all_match git diff-files --stat "folder*/a" &&
+
+	# file present on-disk with modifications
+	run_on_all ../edit-contents folder1/a &&
+	test_all_match git diff-files &&
+	test_all_match git diff-files folder1/a &&
+	test_all_match git diff-files "folder*/a" 
+'
+
 test_done
-- 
2.39.0

