Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5884C6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 16:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjCVQSv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 12:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCVQSp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 12:18:45 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC344229
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:18:37 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id s1so4210008ild.6
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679501916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shIfNMYTcTevhJNijnWjuk99N5vM7RXgRpkLvBQsGwc=;
        b=G5wa2inEPbeCOjcFcQwATE+4XzeUaJORI2SZkk+8C8n5OsVhVv/fPa4ZztUVsuIgX1
         c2WyO4iUgb3swboS4x3pUEWXRzXiJDoPqINvyv3qxM5dji50pRmxbV7+iqQRMFEHcWhV
         EMiS/oxxv2jBdAcH+VlA8/J1kl79McU1Hl++Nh9ZTwsSq8lHNxShffJryjYbmSIQ1AIN
         DhQxyqqd9YtMNmajleLIaef4y9lfd+5vlZ29XDPCskdv2VdmIr1JBseiWZAKcCB83yhz
         JSJ49Xxz+22pTaX/LaUF6RPC4rKa4rHy7zQrR5Xm/WGDdFkPNhUeCnx7Puvmvy7MNKMH
         FOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679501916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shIfNMYTcTevhJNijnWjuk99N5vM7RXgRpkLvBQsGwc=;
        b=j6nqJboV0xbQfc3oJ7n66tq2bd20fCipalNvTKuR8+IQZo3lAiy7oMS6C8jz6lkV3U
         05nrO1i6n+Nx0/fk62D6iTC/FVCtVh15il06gwTnB6lnxcrN0dqgI9uK8/jNL4OKcUKZ
         nDX1FqEr6rVRwi3xKvbmFM8PAF6h7dfWsZINusCcHipbTEoVUCSrKXFBIUICPTUIhpOI
         2scwQqxsrGaI5CsWjV9RtZZzyvKvz2nNDihq34TD/YxG8PfNPSedAMBycG2oxlosUvlh
         PJj7o5X2UbjTtRb70MpeboxtqV8Jxp7Kt22Y2nhGkcysEuWkaJxQ9ajuaQikA1D4IV7M
         IQyA==
X-Gm-Message-State: AO0yUKUdLNP6ztj8ZTiDBUKljue+cqZEolk27ul82mJO+PUV3jzPGqMe
        Q5eXEUh0fou3Pl4JO1PJkfZpE+vcrWU=
X-Google-Smtp-Source: AK7set+laG8sNnw/P+fCfHct6rxnhU8uZnXhlNYTWhc08ROSRZGvUkDBc1LLHmKDHa2eDLJvoJMHtQ==
X-Received: by 2002:a92:730a:0:b0:319:23c7:5553 with SMTP id o10-20020a92730a000000b0031923c75553mr4474096ilc.32.1679501916093;
        Wed, 22 Mar 2023 09:18:36 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id q18-20020a056e02107200b0032304e1814bsm4460129ilj.40.2023.03.22.09.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:18:35 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v7 1/2] t1092: add tests for `git diff-files`
Date:   Wed, 22 Mar 2023 12:18:19 -0400
Message-Id: <20230322161820.3609-2-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230322161820.3609-1-cheskaqiqi@gmail.com>
References: <20230320205241.105476-1-cheskaqiqi@gmail.com>
 <20230322161820.3609-1-cheskaqiqi@gmail.com>
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
index 801919009e..d23041e27a 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2055,4 +2055,50 @@ test_expect_success 'grep sparse directory within submodules' '
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

