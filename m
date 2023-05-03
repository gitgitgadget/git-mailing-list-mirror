Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47873C7EE22
	for <git@archiver.kernel.org>; Wed,  3 May 2023 21:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjECV4T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 17:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjECV4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 17:56:16 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9577D8B
        for <git@vger.kernel.org>; Wed,  3 May 2023 14:56:08 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3318bd82810so135875ab.1
        for <git@vger.kernel.org>; Wed, 03 May 2023 14:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683150967; x=1685742967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gPVmLi9DFS+rAtOkGMyEu6xxF0dGy/cHo4htRU/g+0=;
        b=fvhWY+u2wfnD+Xk3+Jv7mcuOEC37oXlmLtodfgDMHl9sS2Ugl+Eenog593mvzzFOil
         lA/c+8GKdhokXwYWKNplrqp/xKiX+OJVNQHT0FNynDbh0jB0V5+OHoPRUUN8/aNcPLt8
         tESSwnfUOLReNrgs50e/NHKFT8JsDQ2qeX5rhDX9n5cvCvZOKnMMq7DJx4T6VG715zNb
         NSfNVrvsizfAREjQ5YtcNxX0Q6IHPLiE+NgtW94xnfkdOZJcZwxa/o7TbAs2NYcxNyoc
         Z6WCMOImDXOOA1OPi9i4wgY4Iu/IwSZo2dH/nVYMMFRHH4g3sZHk8OJO/yefXx2jgLli
         t1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683150967; x=1685742967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gPVmLi9DFS+rAtOkGMyEu6xxF0dGy/cHo4htRU/g+0=;
        b=LDoVmuxLWBTj7twPD++TuvixkcJ9kUF5nsxJx7VzQvAMp+V9ubLSIVjOS5ukdf4oyQ
         CGMSbtRCgYdPmbZ+uHuVhxXFdgcDaIFyiwfmTFt0BO+HPmwiUvfxB8wTZdL+ndxxjZaz
         ItfEaDITSWxTWDn1783gjdL+LEt0ftbEA7Z5RXoIE0vIy/ol+DwLCZTxItDSjh+zdafV
         hpbLx3ff2wgXd1Dpag3QNMT2kxWmQAZG6H6JOGfaOnLSpRZcwZAJi5AkRN528ZjxnbL2
         0XkO/gQm6Bsf0beYB7fJNzLr6GvCz2caIgyJErTCLi8HGrSfxutSVeX5tKciX2fR0a52
         7QVw==
X-Gm-Message-State: AC+VfDzVdMGUO8UpyDsI4hycrvBxAa7t74FrdPnJ7h0GhBECjy4nP6Ua
        r2BHKlpXQV0v+Zb+FQWemSawJd+28cAhpQ==
X-Google-Smtp-Source: ACHHUZ6mS7mjNQho/qKZNbOIep47OkgMYJ4kna+1JBERv2X5ckaylEivpDy/APRzJSSgKj4MYnVAXQ==
X-Received: by 2002:a92:d68b:0:b0:331:5340:6525 with SMTP id p11-20020a92d68b000000b0033153406525mr3110459iln.3.1683150967234;
        Wed, 03 May 2023 14:56:07 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id p13-20020a02290d000000b00411af6e8091sm210419jap.66.2023.05.03.14.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 14:56:06 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v10 1/2] t1092: add tests for `git diff-files`
Date:   Wed,  3 May 2023 17:55:48 -0400
Message-Id: <20230503215549.511999-2-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230503215549.511999-1-cheskaqiqi@gmail.com>
References: <20230502172335.478312-1-cheskaqiqi@gmail.com>
 <20230503215549.511999-1-cheskaqiqi@gmail.com>
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
index 0c784813f1..eddae7ee08 100755
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
+	# Add file to the index but outside of cone for sparse-checkout cases.
+	# Add file to the index without sparse-checkout cases to ensure all have
+	# same output.
+	run_on_all mkdir -p folder1 &&
+	run_on_all cp a folder1/a &&
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

