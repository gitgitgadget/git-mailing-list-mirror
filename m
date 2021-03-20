Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBACCC433DB
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 22:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B4AB61933
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 22:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhCTWij (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 18:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhCTWiO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 18:38:14 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182BFC061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 15:38:14 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e18so12775834wrt.6
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 15:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TfFpH1APGTzYe8SIfVB0K/XBicQpKKy1S9SsREAlGvc=;
        b=k/+2Rauxy9JQJbusqkYusXL+7uCVKBPXQmHbY30gITZ2u4NbPrAOMtaHGhDRVvC8Ly
         gy4CZcgiOwAV52GxcVd4MfrbhFxgCwGa3KdxK1pP5kCjPK1yHx3fW6dnzhcGsken2R/d
         L+WptzmijIgvqco0KLkeYtnOLf82y++hvv1YQi1SzR3QpRonYNJdezjOZ2Yu3EBriFRl
         egY2HPnV4/KtjD/JCvRik47+UOwQ4LkdWkuJJtFis4rCZKeOVbc3ae4tligrwHdNw5ly
         Znnv7z3ILVrdzNcAq0rsJ44EnQ7kvtndJz8ZRrtnbXfKU5oqZ9RWcEGWmMLg9uBhwsRu
         yzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TfFpH1APGTzYe8SIfVB0K/XBicQpKKy1S9SsREAlGvc=;
        b=BHRWGZQE+94pi3Wd46s3Lwdp0zH2CzMAXdDQSl6UGFH90iajQj1hUBgLXTL0IqNrkY
         JVxZlWP3S1s5u47v9psgvueL93SzKL5OODmkxbj3DQ6m05n2yRCY9Q9U50FlCI2P2UEf
         DkZbX51gVd30lwKQ0sRdZiRXFF/BiXeuV8ybdeD0W0zdzrBuoEwCSK6PWo8qv9HEhJrE
         jzDwYOQHkLAzeIsObzPCIkhVFH/RMxtyezosF7+ivRMedvSzP6uB/BxXhZWIDHvbpwXc
         Ddh+gV5k1fPsmHaBygjU/QEltwpyFreFZGHa+lwQbAzHZGeJ3j09m9UExmL1EbkWXdI5
         +E7w==
X-Gm-Message-State: AOAM532WLfQmtr0sCHUpIRPcw/9eNDjN+z7m+DuWZRUDTuXKCG4n9eYv
        pb8ChoUx1enM1L4GB8qPUzptLlWwCEUqPg==
X-Google-Smtp-Source: ABdhPJzmpzQA/rB1tjtjKWHSrVEAHRJwRiyp9uvevWrl7sHxZOJsr5bH5c8C2x7yulXhzhqiX3PIhg==
X-Received: by 2002:adf:fbce:: with SMTP id d14mr10697512wrs.44.1616279892562;
        Sat, 20 Mar 2021 15:38:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v2sm21472697wmj.1.2021.03.20.15.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 15:38:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 2/8] ls-files tests: add meaningful --with-tree tests
Date:   Sat, 20 Mar 2021 23:37:45 +0100
Message-Id: <f37d7705cf091def00ab94b1be6d6daecc220229.1616279653.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.286.gc175f2cb894
In-Reply-To: <cover.1616279653.git.avarab@gmail.com>
References: <xmqqpmzxy939.fsf@gitster.g> <cover.1616279653.git.avarab@gmail.com>
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
2.31.0.286.gc175f2cb894

