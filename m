Return-Path: <SRS0=iBdC=IG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090FEC433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 02:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C101465150
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 02:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbhCHCWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Mar 2021 21:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhCHCWC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Mar 2021 21:22:02 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6024CC06174A
        for <git@vger.kernel.org>; Sun,  7 Mar 2021 18:22:02 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id p7so5753420eju.6
        for <git@vger.kernel.org>; Sun, 07 Mar 2021 18:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m8AtD/G4xOuMJU6iYSH3t8WcGTzqlmvZCddThxePKwM=;
        b=hVnNu1rhMZ+GP0cSyt/wFJ6urF9Z73OS89BiidCR/TffpDmDYXGYy1G/XKKLVkPrWQ
         CevPCB5rvZIJJWIaa9VmqUXPB56lNL1KeR9sZ1dlFryruPb48RrqCCZGSjdX7mQN89O4
         a78wU1dMegXysN4X8WnnAUKSmLy1fdlOMTJEmZhQHkxoR7ujI+bO6kqCbu0SS/ZvjYwk
         iqir+NhldvczvFfluunqY8AuWEjzETz0iB54R8cCAbvLJJ+Map/TEfSNSkqsvH6vjLWH
         JHmamTzLzRidaTCpeXDPFJbpfK21+aHJZc7mi5LUah2UWaO/d6tVPT5lte+FTOv/w0Oc
         8f2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m8AtD/G4xOuMJU6iYSH3t8WcGTzqlmvZCddThxePKwM=;
        b=fVzwfbJ1ngCCYVseR+jis3uteANIo8cPSE6s+RMErM+nA9xuO/J3S8FbVMzec6dMRJ
         UoFRmhEu3ZGzMGP8kDK8i2gToHhgs/0fA3KDX0wSHTRAGjdoAkqQHry/BSG+TFrw5wmP
         bZa9hwpeMljmG7ISilIq4tQb6fKGLhR8uarrZfAL1pGS5KCg/SB5VO3b71oSZNoxpx6R
         lxmBa2Gnrvwnca+HII5iINBMbkLEwIFbcjxYbHP6XktSRAxt8wdNaDFix7UYzxx08w5o
         /o5FOxFxOoAGdpJ4oRrLdORVbZ6hE80xYvOLbnB4Yghmr6XxAITS+93H2vIi2HCVwGyk
         ntwA==
X-Gm-Message-State: AOAM531op7rokFePsy1DtbMv4N2YDQ8MhkqkecwGAAdjObzliE3iF3Ai
        +b/1K5mf0KNwaqIf45aT2eh9HGaKf+G2Aw==
X-Google-Smtp-Source: ABdhPJxaigkUNINsl2RxhR82nmTcv7cB6EfysuhDVmC0ovrZboEYFAhTCON7NmFAtDrdbn4rmp3ORw==
X-Received: by 2002:a17:906:33d9:: with SMTP id w25mr13450923eja.413.1615170120865;
        Sun, 07 Mar 2021 18:22:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id dg26sm6264995edb.88.2021.03.07.18.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 18:22:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/6] ls-files tests: add meaningful --with-tree tests
Date:   Mon,  8 Mar 2021 03:21:33 +0100
Message-Id: <20210308022138.28166-2-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210306193458.20633-1-avarab@gmail.com>
References: <20210306193458.20633-1-avarab@gmail.com>
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
2.31.0.rc0.126.g04f22c5b82

