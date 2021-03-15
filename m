Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73311C433DB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 23:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B4464F66
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 23:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbhCOXoG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 19:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbhCOXoC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 19:44:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A385C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 16:44:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x13so6540614wrs.9
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 16:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B8D6QlA6gi65CQ1lINVl7wQVALJlg6X9BFgNzB+nMWE=;
        b=bHWC11gd+o0WmxQEHK2LDzYe5rBXefgCVqkBHp8zFRXG7rRDes5ff7igh7Ng01uh51
         Lz63mO0M3UxxaCEuA4wepFnt/ivdB2mG0HhEH4IBEsW4ishFrOxOiPxBC0oUjReepHcJ
         Pzao8mUt2pFCfvz6pybYwHSV4dnJ3Ar5wWoHImtdRpDCDnqo0kLbc56UcK2VNZaSYMsz
         JBHxormRQkrGsGnDS/1fheuspPAMAJqyocnoCi5x13ErKxefrB7oakZVnQm2DF8YejEA
         qHDcIcPLJCXeei/B04q/OMf8lJFaPrRVPlYugXWTffp4u5cZPttxcLoELnGpCzxXgHIW
         f6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B8D6QlA6gi65CQ1lINVl7wQVALJlg6X9BFgNzB+nMWE=;
        b=VGDMz+A+BNC3x4WqIoWeINBfhmI/VEKnJuM5NwJeiMaSchRpzdoIr+EWeZpbe4pgX9
         bzGXQXMbon6G5mkaqVLURobZwIVloJXy/mSRTZByosmtv/3wo6Zd3dxUwXtntMuAI7dl
         /QXsO9jGtZfmlBYhNRRDoUtvP01QJTPxdsJJ27WLn9FIr4NYK2WQU7bc2adN/J8Hnxee
         k+VQadeNKbalEqTl50ywldMjZF3PPMShKjuo8mAK6Zr0M+DWLautGtPX99ldnZPQfoIA
         x2ApG5JsNXBqgEZbn/m9SrQoANFQxbT/6o3YriMn1X7LoVHRX2ph4MU41IBtAeTJJNKW
         5JZA==
X-Gm-Message-State: AOAM530hND3iCTZexl7UsZzyK7jS1rvYbT6NQPrOntE3ivVpL3TT7OOM
        9YvMUuvLQLdypW9aptNlCkwSf9/tHUE=
X-Google-Smtp-Source: ABdhPJy7/9GrJrohAavJeCxKyjAA4Gqwbrr1nN41ddWkT807vIb+ZFc1+fOVaZUZOS7pacAWfwfcEQ==
X-Received: by 2002:adf:80e7:: with SMTP id 94mr1868021wrl.5.1615851841098;
        Mon, 15 Mar 2021 16:44:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z7sm20417268wrt.70.2021.03.15.16.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 16:44:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/9] ls-files tests: add meaningful --with-tree tests
Date:   Tue, 16 Mar 2021 00:43:36 +0100
Message-Id: <20210315234344.28427-2-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for "ls-files --with-tree". There was effectively no
coverage for any normal usage of this command, only the tests added in
54e1abce90e (Add test case for ls-files --with-tree, 2007-10-03) for
an obscure bug.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3060-ls-files-with-tree.sh | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/t/t3060-ls-files-with-tree.sh b/t/t3060-ls-files-with-tree.sh
index 52ed665fcd2..b257c792a46 100755
--- a/t/t3060-ls-files-with-tree.sh
+++ b/t/t3060-ls-files-with-tree.sh
@@ -47,6 +47,12 @@ test_expect_success setup '
 	git add .
 '
 
+test_expect_success 'usage' '
+	test_expect_code 128 git ls-files --with-tree=HEAD -u &&
+	test_expect_code 128 git ls-files --with-tree=HEAD -s &&
+	test_expect_code 128 git ls-files --recurse-submodules --with-tree=HEAD
+'
+
 test_expect_success 'git ls-files --with-tree should succeed from subdir' '
 	# We have to run from a sub-directory to trigger prune_path
 	# Then we finally get to run our --with-tree test
@@ -60,4 +66,39 @@ test_expect_success \
     'git ls-files --with-tree should add entries from named tree.' \
     'test_cmp expected output'
 
+test_expect_success 'no duplicates in --with-tree output' '
+	git ls-files --with-tree=HEAD >actual &&
+	sort -u actual >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'setup: output in a conflict' '
+	test_create_repo conflict &&
+	test_commit -C conflict BASE file &&
+	test_commit -C conflict A file foo &&
+	git -C conflict reset --hard BASE &&
+	test_commit -C conflict B file bar
+'
+
+test_expect_success 'output in a conflict' '
+	test_must_fail git -C conflict merge A B &&
+	cat >expected <<-\EOF &&
+	file
+	file
+	file
+	file
+	EOF
+	git -C conflict ls-files --with-tree=HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'output with removed .git/index' '
+	cat >expected <<-\EOF &&
+	file
+	EOF
+	rm conflict/.git/index &&
+	git -C conflict ls-files --with-tree=HEAD >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.31.0.rc2.211.g1d0b8788b3

