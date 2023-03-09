Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B75C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 06:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCIGkb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 01:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjCIGkX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 01:40:23 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0FA3C79B
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 22:40:17 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id s12so973856qtq.11
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 22:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678344010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR1GD1S/7c+WGoebS1W6OwMBDpCWWBwpAcvnCX/mXzA=;
        b=SOhBIkxprTIIFb0Q5W6tlng7uQVa/kwlm/vcQ8m9GD+Xy5xIzddf65fieLEmyS8GcV
         3FzGn1WvSPTOfziKjY126usxhIJcCGLQ9VG7hO6UvkyioE9Y7UeopfmRzCGhJPaNUysS
         2LEe6Mm08QtTsdRDxrzfG9JwHy/Hg0DeB2cD+woYkl1aKZFe6yG33FqSO80tcQXB+YE7
         jHCB4hQzWQxtlnAEHdPvoiodpejE/ttcdKpp1FnLHKuc5HsjqLL2xEjGybBXCVag1dm2
         pPufpcbXCh+jdHdG56ZUAKaPAwYuSd+EWBGpo1KoUObGj96RTdAzQUO6E8KAY162huVD
         65yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678344010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PR1GD1S/7c+WGoebS1W6OwMBDpCWWBwpAcvnCX/mXzA=;
        b=sxxdj99a5dCH0HXz5JTM6ecCM9R7zmqRjDI5SoTxz2ml9PgQXiBWc8HuQJsUI+TMJT
         c+PW9BJetz1MOzqyrN+BedYovErmao5CzvAEBAVv2JqFsxZ6WOAkebzzNdOPhkvfbTxY
         8aYpEgf7aGkI6z31fsfZdfkJlmTwkAwXTLaCW59K1cWAoZIVlJIJB2ZhXhDQVWoGSPiD
         0layF0Ehd4KIIYOUaWB5XKuPLeKTbt72OUa0M/H/So4Z85EQCKCOXxcHr6ZEsCMZwfKD
         kM/5QkzVUSOSntaaVDjpTBvwSCZv5jGaOMRIIFkE3YarS/9DZIAbOKThyTlb4nvHe+zm
         vndA==
X-Gm-Message-State: AO0yUKWxep59PYzO9/a3/zWlv7Lmi/PcWDVFlSo8ONY2Xq1dEwi+fyGa
        +G6sVg/22HgG37kIOBP01qR4795QHuM=
X-Google-Smtp-Source: AK7set88XV+Zix2SaKLcCZrryzTUWGCCYPEUrdkoVUFgKS8Sn+fYc+OTQgn4U3YZXss+M8NBMGAVvg==
X-Received: by 2002:a05:622a:15c1:b0:3b9:b1eb:ad38 with SMTP id d1-20020a05622a15c100b003b9b1ebad38mr33848591qty.50.1678344010676;
        Wed, 08 Mar 2023 22:40:10 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id v25-20020ac873d9000000b003c033b23a9asm5834970qtp.12.2023.03.08.22.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 22:40:10 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, gitster@pobox.com,
        vdye@github.com, derrickstolee@github.com
Subject: [PATCH v4 1/2] t1092: add tests for `git diff-files`
Date:   Thu,  9 Mar 2023 01:39:51 -0500
Message-Id: <20230309063952.42362-2-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230309063952.42362-1-cheskaqiqi@gmail.com>
References: <20230309013314.119128-1-cheskaqiqi@gmail.com>
 <20230309063952.42362-1-cheskaqiqi@gmail.com>
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
 t/t1092-sparse-checkout-compatibility.sh | 39 ++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 801919009e..18d3b4f313 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2055,4 +2055,43 @@ test_expect_success 'grep sparse directory within submodules' '
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
+	test_all_match git diff-files  &&
+	test_all_match git diff-files deep/a 
+'
+
+test_expect_success 'diff-files with pathspec outside sparse definition' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>"$1"
+	EOF
+
+	# add file to the index but outside of cone
+	run_on_sparse mkdir newdirectory &&
+	run_on_sparse ../edit-contents newdirectory/testfile &&
+	test_sparse_match git add --sparse newdirectory/testfile &&
+
+	# file present on-disk without modifications
+	test_sparse_match git diff-files &&
+	test_must_be_empty sparse-checkout-out &&
+	test_must_be_empty sparse-index-out &&
+	test_sparse_match git diff-files newdirectory/testfile &&
+	test_must_be_empty sparse-checkout-out &&
+	test_must_be_empty sparse-index-out &&
+
+	# file present on-disk with modifications
+	run_on_sparse ../edit-contents newdirectory/testfile &&
+	test_sparse_match git diff-files &&
+	test_sparse_match git diff-files newdirectory/testfile 
+'
+
 test_done
-- 
2.39.0

