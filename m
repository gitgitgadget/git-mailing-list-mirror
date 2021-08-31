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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D48CC4320E
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70A4B60FED
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbhHaNgy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237314AbhHaNgw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 09:36:52 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E32C06179A
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:35:54 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k20-20020a05600c0b5400b002e87ad6956eso2591394wmr.1
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OH+vHxqj/oGTZ7r4j8345oYcOc9T9YF/lETqg3Q34ro=;
        b=Hn8eAokQuuPsUqZj9UfH9pzp02CdESprcJjHvV06CkT7ZKhEd7ZAiEZh/gGNaoqDEv
         WZDGR9rxAgIWov6a6y0MtLtjPwcbEcPLwRKzdhHvtMwCy6stONtHe6b55r+trJY8o25/
         yIB8c/gdrXOmIfKLXvMNSLG8yRIcl7AgWRk27Oh1QWITSbTosikVQH+E8qI5MtNlnM4z
         WT74eRaFr+dcgy2ZDtsOgcUdqBPsmGBV09P/knGdCYoWHd6XiduwfGBb+UEUshEBmNc0
         d55TqxAZcgbTjhKys0IVynJRFRgUNtP6QmCypHyWH8gfnbKTL/nLzTjH1f7E4sbBgegA
         nvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OH+vHxqj/oGTZ7r4j8345oYcOc9T9YF/lETqg3Q34ro=;
        b=uLCucTwYlJ3u8sGmVQILCBlySIbTmVincVoBxfF63kVJqsCCmq8wNrYEZRigptrSNN
         itAaxgz+JfU5IzBUmK1dLTrMdRPzA6QUcub6tRtaekpurMr3JXQN6lrhIsBNu3LtsMUL
         6baQTzQls/69sc6XPx5Dzx7DoIHxX5+r5B6L/fG9t3vVk4rrSUgzGfzx1yom2wBrmMC9
         44CYLcb67kRQtvylehCod5NO821uzhHcW5q6T/0S89HoKZZVUQ36S9ItoHjbZgCTKJ4l
         G3sV1B5GNOsMtVasl+OaQftGQvIMAs7LDXb6No3f+XmvkUzm8wTwsLLC49rznN2h7kwE
         S/Rg==
X-Gm-Message-State: AOAM533xl/WOTFo7dtbdo+LytHspaHj9qR/T7FgT6FL54q+dXXxlO4Nz
        qu2b0dzSg9cxLDKmq7ZxpEWB5SnP7T//Zg==
X-Google-Smtp-Source: ABdhPJygRLSNK8RnGeG8D5pPfOhryecrZkbfZr9Knb9O1xFhVmCCCRBnpHmCDL8ZwJRDDF/gT6Zs7w==
X-Received: by 2002:a7b:c316:: with SMTP id k22mr4259846wmj.56.1630416952884;
        Tue, 31 Aug 2021 06:35:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u27sm19073451wru.2.2021.08.31.06.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:35:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/8] tests: annotate t002*.sh with TEST_PASSES_SANITIZE_LEAK=true
Date:   Tue, 31 Aug 2021 15:35:40 +0200
Message-Id: <patch-v3-6.8-2599016c4e7-20210831T132607Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.805.g739b16c2189
In-Reply-To: <cover-v3-0.8-00000000000-20210831T132607Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20210831T132607Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Annotate the t002*.sh tests that pass under SANITIZE=leak, these tests
now pass under GIT_TEST_PASSING_SANITIZE_LEAK=true. We skip
t0020-crlf.sh, t0021-conversion.sh, t0023-crlf-am.sh and
t0028-working-tree-encoding.sh due to outstanding memory leaks.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0022-crlf-rename.sh       | 1 +
 t/t0024-crlf-archive.sh      | 1 +
 t/t0025-crlf-renormalize.sh  | 1 +
 t/t0026-eol-config.sh        | 1 +
 t/t0029-core-unsetenvvars.sh | 1 +
 5 files changed, 5 insertions(+)

diff --git a/t/t0022-crlf-rename.sh b/t/t0022-crlf-rename.sh
index 7af3fbcc7b9..d8ae0879bdb 100755
--- a/t/t0022-crlf-rename.sh
+++ b/t/t0022-crlf-rename.sh
@@ -2,6 +2,7 @@
 
 test_description='ignore CR in CRLF sequence while computing similiarity'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index 4e9fa3cd684..95913032524 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -2,6 +2,7 @@
 
 test_description='respect crlf in git archive'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t0025-crlf-renormalize.sh b/t/t0025-crlf-renormalize.sh
index e13363ade5c..88cbdc5ed3a 100755
--- a/t/t0025-crlf-renormalize.sh
+++ b/t/t0025-crlf-renormalize.sh
@@ -2,6 +2,7 @@
 
 test_description='CRLF renormalization'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t0026-eol-config.sh b/t/t0026-eol-config.sh
index c5203e232c8..3be010e2f12 100755
--- a/t/t0026-eol-config.sh
+++ b/t/t0026-eol-config.sh
@@ -2,6 +2,7 @@
 
 test_description='CRLF conversion'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 has_cr() {
diff --git a/t/t0029-core-unsetenvvars.sh b/t/t0029-core-unsetenvvars.sh
index 24ce46a6ea1..87566900c2b 100755
--- a/t/t0029-core-unsetenvvars.sh
+++ b/t/t0029-core-unsetenvvars.sh
@@ -2,6 +2,7 @@
 
 test_description='test the Windows-only core.unsetenvvars setting'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 if ! test_have_prereq MINGW
-- 
2.33.0.805.g739b16c2189

