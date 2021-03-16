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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4761CC43331
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2233165113
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbhCPPxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhCPPwu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:52:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39E3C061756
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:52:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id g8so10384908wmd.4
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T2L0S2igmKi6FvEX0L358Snc+OKCCR/yehnzxL1/Mr4=;
        b=ocwMKuVHRsJjky3vylCZGakKAvgKULh8NIkkVk2o6RXrvly0u4kgTCGQsnCB3OcjNZ
         RkEVPQNO+pj1HiCBHIB4QKBatZtDFT4HJrtYytUhthKrQeRs7j800PCdSY4niMijJSmX
         Vk12CqSHfpqIly7esuf+Du9tDnulQuqwDEaKWBRyO0ymWSmXSrmdF6FnpEJDAUoEdsrA
         4GvW1w4wLdRtXB+gTSlXIf05gL+mB+ySD8OMGwokImyAAAS8dSREeM6Bccd69ZqurN3E
         5pX825ykF73uHRxevAAQvJVyJZK6WF886O99aVx88G8tqqfIgcE/g/5H9XQlICqodk7g
         a7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T2L0S2igmKi6FvEX0L358Snc+OKCCR/yehnzxL1/Mr4=;
        b=bNepLjpzfVLIBrAJYVvZxLJY1HldkXR+tkVdz3sGEQDRTEK/l7uI0YPgfzI1C7+Yud
         MU2dG4PXtVGKQjlBpwhkkhFES/rdYXU3qb+O5x/RmhmioePmwfpukxhjiJQ7J23nqrZA
         mL5avCG55A6/g6RDDd+hij9LxOuFmdnVUHW5UzeK80f7Zgq+k5/QZA5M2gK+1+OpuNf+
         4VxiiDeSUEbGVnY+rJPQwclwZw/KCT/4JYLHDY6DnIPLV+U0ijsSdpR+S7MtlON8Rxkm
         6cOknkVkXr6lVYTf0ustgmVBclihKUcYb2YIOZUrnjW3rRxcDkLAlHSFBn36LRB4ESj1
         TVwg==
X-Gm-Message-State: AOAM5333vMQ2fNrHiZiBqz3GV85f/Mh9044btEzqhEF2EYcsT7q0eL7r
        N19FoHV7lsDhGxTN0K97t4rs81RmklDD4Q==
X-Google-Smtp-Source: ABdhPJxYvyUjrPyaUghd3TE2WdnnS76N+ARxPAE9jY97K3BtVKlznSGwyqcqq7e8Rz2oPOMbQVF5QQ==
X-Received: by 2002:a1c:400b:: with SMTP id n11mr253382wma.167.1615909968388;
        Tue, 16 Mar 2021 08:52:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i11sm22224228wro.53.2021.03.16.08.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:52:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/9] ls-files tests: add meaningful --with-tree tests
Date:   Tue, 16 Mar 2021 16:52:36 +0100
Message-Id: <20210316155244.28328-2-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210315234344.28427-1-avarab@gmail.com>
References: <20210315234344.28427-1-avarab@gmail.com>
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
index 52ed665fcd..b257c792a4 100755
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
2.31.0.256.gf0ddda3145

