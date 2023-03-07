Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A57C678DB
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 06:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjCGGpj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 01:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCGGpg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 01:45:36 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E2864A90
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 22:45:35 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id cf14so13362492qtb.10
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 22:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678171535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgVoanw/+v39j+sy3oPGO1zc8GbPNUKjVogyHFC0Gro=;
        b=h8JQv8JgV1dp7T6yNwuYauixFby8r704T7P95QSiDp+h9sT3FadpgmqZATcpaEWAKd
         gXuV3MBAZvl+KdeVTwy87SgESeqnswo/7Bon4u6CaawHRqVYO9f9RmS6EhDOGAbJ5rCA
         6drC8QlSrAkz7B36XtRWQvX0ZQRiF40Z6gRkQmk5pDUsDNazoQYypoMpCAZpAFKtNeK4
         3Jp4GDnWL2gfvz08CJu31K7JhzeRrddgzWI9LIYssB4Xz81rG8yrvcQ/IjdcZ3LR9wdp
         S7tyhHsM0yy2XNdnjFjLXDfdWPky8m9OVWfKCZc85kI7ALTdzg9w6Yw4ItcARJ3U2MkI
         PSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678171535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgVoanw/+v39j+sy3oPGO1zc8GbPNUKjVogyHFC0Gro=;
        b=Tx0B7MpVUIVX72HsKaLffQpSgOZSJ7hliC32Rc7govH2j3jyg4DCaH/m/sKkPlluGP
         +9uc1BzTInLG/LkfvFojZg5aYQOF6eZgNF9/BDsVvO3yEQFwqhR3dBMcFv9VP2+azIfX
         DCH18msLAmV6KuPG9OI4HhvIQzmgQnUHywpiE9xwv2MkSWG5Pw3zBTcvwFTaE8DZcMOq
         ZjUh9JIsZa4qoAi82Sw+K1jxe9M2a+ckUA0idNkzTfTmHNiPBVteK2iTPe84GVZBpKdD
         lqQX5FLFEKVOX4yhW+OOXkXxZsWCDpU6xG/ep1OlJtO/4h7OAe9aiM/dkRRaOv9e1wBi
         OkgQ==
X-Gm-Message-State: AO0yUKXS3rfSQ1vV+ZI2JTS494po0G+TWjB4rOVX5cgwZOylR10ztRIZ
        8eq1sgu4SpYmNAZoD0TiEuRPgIoIFL8=
X-Google-Smtp-Source: AK7set8Xpt5b52Jp40Sq3cjgtooFuFvqCAz7yLmn7/EK7n/irzN49nAJN/hHT8HTN/TcTdAeimuNHw==
X-Received: by 2002:a05:622a:4c6:b0:3bf:b9d8:d064 with SMTP id q6-20020a05622a04c600b003bfb9d8d064mr20413882qtx.23.1678171535207;
        Mon, 06 Mar 2023 22:45:35 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id r13-20020a05622a034d00b0039cc0fbdb61sm9452864qtw.53.2023.03.06.22.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 22:45:34 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        derrickstolee@github.com
Subject: [PATCH v2 1/2] t1092: add tests for `git diff-files`
Date:   Tue,  7 Mar 2023 01:45:05 -0500
Message-Id: <20230307064506.76663-2-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230307064506.76663-1-cheskaqiqi@gmail.com>
References: <20230307064506.76663-1-cheskaqiqi@gmail.com>
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
the sparse-checkout cone, create a 'newdirectory/testfile' and
add it to the index, while leaving it outside of
the sparse-checkout definition.Test 'newdirectory/testfile'
being present on-disk without modifications, then change content inside
'newdirectory/testfile' in order to test 'newdirectory/testfile'
being present on-disk with modifications.

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 38 ++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 801919009e..9382428352 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2055,4 +2055,42 @@ test_expect_success 'grep sparse directory within submodules' '
 	test_cmp actual expect
 '
 
+test_expect_success 'diff-files with pathspec inside sparse definition' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	run_on_all ../edit-contents deep/a &&
+
+	test_all_match git diff-files  &&
+	test_all_match git diff-files deep/a &&
+	test_all_match git diff-files --find-object=HEAD:a
+'
+
+test_expect_success 'diff-files with pathspec outside sparse definition' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	#add file to the index but outside of cone
+	run_on_sparse mkdir newdirectory &&
+	run_on_sparse ../edit-contents newdirectory/testfile &&
+	test_sparse_match git add --sparse newdirectory/testfile &&
+
+	#file present on-disk without modifications
+	test_sparse_match git diff-files &&
+	test_sparse_match git diff-files newdirectory/testfile &&
+	test_sparse_match test_must_fail git diff-files --find-object=HEAD:testfile &&
+
+	#file present on-disk with modifications
+	run_on_sparse ../edit-contents newdirectory/testfile &&
+	test_sparse_match git diff-files &&
+	test_sparse_match git diff-files newdirectory/testfile &&
+	test_sparse_match test_must_fail git diff-files --find-object=HEAD:testfile
+'
+
 test_done
-- 
2.39.0

