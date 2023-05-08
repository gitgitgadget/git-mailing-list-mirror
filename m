Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC6BC77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 18:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjEHSrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 14:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjEHSrK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 14:47:10 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0961059FC
        for <git@vger.kernel.org>; Mon,  8 May 2023 11:47:09 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3ef59098519so23097491cf.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 11:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683571628; x=1686163628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBqlFsdKn2Zfp9YMSjFe95pQbQoSQcdul3SShBDnhxc=;
        b=n9lECWIXLDYP3Z27suyHC3yYm/L4ecMwz0t1oceco+oeVIA3np/d4LVe7awefBp4l+
         2qlqvqtHxGEHKlyMfqF0eIQ/5Y3VR+BBcdarynO5R0smiNqesCSvWAMN90+jUI2RK7qG
         RA/V3z9parEQnKrvhOZkFoQoEgo2wdJ99gWV13y4eLInwKog+K2NpmBzXe/K5sBK9eQx
         V0JB6cShMQQzO161NoOoGSIL2PcEV9nsvzg0yr98iAeyQbvpihgIaRvEDC7oMwFm1JZc
         REWOcq8JafXP3I34E3LnyWZ+EH67b22831vQMtGWzhR3qNFHGzt+P3DOsgb49hhGVsL6
         uveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683571628; x=1686163628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBqlFsdKn2Zfp9YMSjFe95pQbQoSQcdul3SShBDnhxc=;
        b=ljPYIFRbZ+TXZAaWdsIzT3f/wreNDpEyTrdQZB/BgqnHfrEpU15sgOH6pXG1srgTKp
         k8nopDcpAyQFb5oRSi9bAWOIV/xSadIMY1v/WjYS4Hld88Q1DJMtLCftkvtQvYKQLZK+
         qQIJd51YbZnzE8rrcuAo1YsCoXQxQuhte8ItyLJdBPYC9AS1ztm5QatW69zNs2Y821MS
         G5AX5XvH0zZfG7zynA6RKFBWvvP3+wiXd0dw+U2ii24ri2d7haqMdOp+4Y50oYNTQS8Q
         zNgpPnmL8PxDIsEpkaBwVimgThqTBkQM1IYZfciQrGspZFW/wCucPMfd/HubiPNe/beQ
         ycjw==
X-Gm-Message-State: AC+VfDwPpYHiu8oRcl9o3E1aaVLqGm6RjZNYBawcE+DRBzWMoo+iMgfG
        u5dLBnozNu1feaFrOFHSdsCYArH+t8IvyQ==
X-Google-Smtp-Source: ACHHUZ4coD+aShcztAiZ1bYGmheNtMVvQzATz381ex+Athdbgj4weVPrKc/2qWgc3U1zlPNQIZsvQg==
X-Received: by 2002:a05:622a:308:b0:3f2:421:4de5 with SMTP id q8-20020a05622a030800b003f204214de5mr16367850qtw.26.1683571627752;
        Mon, 08 May 2023 11:47:07 -0700 (PDT)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id q29-20020ac8411d000000b003f1f26bbb50sm1900982qtl.35.2023.05.08.11.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 11:47:07 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v11 1/2] t1092: add tests for `git diff-files`
Date:   Mon,  8 May 2023 14:46:51 -0400
Message-Id: <20230508184652.4283-2-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230508184652.4283-1-cheskaqiqi@gmail.com>
References: <20230503215549.511999-1-cheskaqiqi@gmail.com>
 <20230508184652.4283-1-cheskaqiqi@gmail.com>
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
sparse-checkout definition. Change content inside 'folder1/a' in order
to test 'folder1/a' being present on-disk with modifications.

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 39 ++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 0c784813f1..efc709afa5 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2108,4 +2108,43 @@ test_expect_success 'sparse-index is not expanded: write-tree' '
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
+	test_sparse_match git diff-files -- folder2/a &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>"$1"
+	EOF
+
+	# The directory "folder1" is outside the cone of interest
+	# and may not exist in the sparse checkout repositories.
+	# Create it as needed, add file "folder1/a" there with
+	# contents that is different from the staged version.
+	run_on_all mkdir -p folder1 &&
+	run_on_all cp a folder1/a &&
+
+	run_on_all ../edit-contents folder1/a &&
+	test_all_match git diff-files &&
+	test_all_match git diff-files -- folder1/a &&
+	test_all_match git diff-files -- "folder*/a"
+'
+
 test_done
-- 
2.39.0

