Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EF4C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 07:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344962AbiCUHfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 03:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344958AbiCUHfl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 03:35:41 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55319AA02F
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:34:17 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so9674259pjb.5
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xdahYEsNby27wbywjbp5s109PyZ4kfrEEAWM0hAma2k=;
        b=fcd7FoWJyzQ+/XG4GS8HVFnYyGiIa4VXNGP20T7I0RGq2MmoZmh/c4WrpE/PaCLd7A
         A/JnWW3wSsKxGQX0lJhvSfk7SC+H8IDa9wTvOKv71qTwMo0wBXtQo3wt1lWZdHa+gCct
         jqn8M59jQ4CQ5uUL3G/8242xHLmh8JsILIlWNbXVwMNY+s5VX2vaIJ2AfN3mhciBM1aR
         XOEQF14p+OHl75RAdbS24GtiVSl7WsaJsFzXWXVWXR+qUEE3sPsEzcM4T5Oom4oWocY/
         LiBbUNbkiD2TUOXDOYmoWL4l1kQ+jb3Z6fMIctk/4Me3N6iLcD9NV/QhddS3Pz2KPHvP
         dJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xdahYEsNby27wbywjbp5s109PyZ4kfrEEAWM0hAma2k=;
        b=AF3/lFNowWoyh+c/ptHJ8NM6eRXBrVK9MR573uA8/p5WoxFfVBGwFaXcXkG5mrrruz
         t58AR5wyQkJCo7gHL9zmJaoQPY8bBZnP67tE2B/oocXreZEpf1XGvpf6fVk4m6mTU4DV
         ZoYWcVFVAG8cQnuDk67vcF+kqJ7reDL2L0mn4zrf5rQBpZ+izMMAqxvjrWXro3puLgpW
         6JnlxaNcQWRr83PRal5+OcoU4GIoJfp/lWc9SNoFALaDTvGJfKMb7onSBM8vB3m6xOCD
         qezjx6xD8Dg1zE+vislCiA++8i0VSVYVDg1r7wIgbEWQYKfkWEUjJnhXOP4DSBMBnZbw
         b4Fw==
X-Gm-Message-State: AOAM531MULgjsXQPysGAWYaSnfP8msNsbI2Rw5QBoaonEnRJyBMUAN/X
        r0UBpFfbZS/bhNc4TatOujM=
X-Google-Smtp-Source: ABdhPJzO/sLhx7xIRXcfKxvwr+ATCsQ1Swk4Duw5CSFyqIhB3EGznq3FIAvnxN3cThL4llrn7uugvQ==
X-Received: by 2002:a17:903:1c2:b0:154:5edf:56d3 with SMTP id e2-20020a17090301c200b001545edf56d3mr3133439plh.10.1647848056786;
        Mon, 21 Mar 2022 00:34:16 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.46])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090ad20600b001b8d01566ccsm18914422pju.8.2022.03.21.00.34.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2022 00:34:16 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v13 13/16] ls-tree tests: add tests for --name-status
Date:   Mon, 21 Mar 2022 15:33:27 +0800
Message-Id: <a5c73de057255cf1cfcf4695db2ae8870108da91.1647846935.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.406.g2e0e55130e
In-Reply-To: <cover.1647846935.git.dyroneteng@gmail.com>
References: <cover.1647846935.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

The --name-status synonym for --name-only added in
c639a5548a5 (ls-tree: --name-only, 2005-12-01) had no tests, let's
make sure it works the same way as its sibling.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 t/t3101-ls-tree-dirname.sh | 55 ++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
index 05fde64225..217006d1bf 100755
--- a/t/t3101-ls-tree-dirname.sh
+++ b/t/t3101-ls-tree-dirname.sh
@@ -201,31 +201,34 @@ EOF
 	test_cmp expected check
 '
 
-test_expect_success 'ls-tree --name-only' '
-	git ls-tree --name-only $tree >current &&
-	cat >expected <<\EOF &&
-1.txt
-2.txt
-path0
-path1
-path2
-path3
-EOF
-	test_output
-'
-
-test_expect_success 'ls-tree --name-only -r' '
-	git ls-tree --name-only -r $tree >current &&
-	cat >expected <<\EOF &&
-1.txt
-2.txt
-path0/a/b/c/1.txt
-path1/b/c/1.txt
-path2/1.txt
-path3/1.txt
-path3/2.txt
-EOF
-	test_output
-'
+for opt in --name-only --name-status
+do
+	test_expect_success "ls-tree $opt" '
+		git ls-tree $opt $tree >current &&
+		cat >expected <<-\EOF &&
+		1.txt
+		2.txt
+		path0
+		path1
+		path2
+		path3
+		EOF
+		test_output
+	'
+
+	test_expect_success "ls-tree $opt -r" '
+		git ls-tree $opt -r $tree >current &&
+		cat >expected <<-\EOF &&
+		1.txt
+		2.txt
+		path0/a/b/c/1.txt
+		path1/b/c/1.txt
+		path2/1.txt
+		path3/1.txt
+		path3/2.txt
+		EOF
+		test_output
+	'
+done
 
 test_done
-- 
2.34.1.406.g2e0e55130e

