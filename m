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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA533C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 07:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9070160EBD
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 07:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbhHKHrE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 03:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbhHKHrB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 03:47:01 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85CDC061798
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 00:46:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g12-20020a17090a7d0cb0290178f80de3d8so3222106pjl.2
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 00:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VMPAfgNh7mmObjOtD1LIaT0xCF7jbENSGkzmhzhqN1w=;
        b=QQVvnu8e/siML4LRoYLf8PHCValvG+iZeEtzmHifev/egMQ8LCcAI/ndJaHsPOlUXF
         2hMgX7NDl2LWBqgKjcDztCD+KBj14IL2fvNrkO+Q8TaPAoGVIPifuS1qhGDDqho2KfIR
         BVJV12DdwH5zqgX9/V4yvxt5dUV8/qAjRwIbXg5bYjk/wsI/EbNOSa+J0iWvFOwI6dHF
         89a8zGDIBI8u0q3FkDMgqFD7oun+uzYQ+3Qjx85DCqv5m19uB9wu3ulgpbzauK8tvQOG
         x308HLA3x5lJ8qWhNfgCUA5s5lfEijSqLNbYe86uocq4nmWMddMg5fDyeuX/ws5ttA19
         c2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VMPAfgNh7mmObjOtD1LIaT0xCF7jbENSGkzmhzhqN1w=;
        b=rgof+V9Et9xs4f3Aw6lvvn25FmsyZKaRZQIbQetrnHpgYnCuDYHduEl4/5iZYzOMTP
         x7PdHjz2dsZ/12OilkhyetUGVDbhdhi3+XiSDkTvQzpQQ5x311UUxgtsqqo1L9x5mkgl
         FFOlg6obRbhPl+smRxlBd1GXKTWnDA6WZ77PwWNrWDvou03DbPCiNkvp7n/Vh7u4QlU4
         AGrpRYjGNcvs/3MVvUMbQ0SF2p9MnSRChFLe0qu7SbxTmVPOUMpqw1MyEPtvcqytj113
         Qiz6Otipop6JiaYLFDOGJCOOi5HrepT+MsCbWcdN00mpckyRp1krsVcsZt061ZWytbDA
         6TCQ==
X-Gm-Message-State: AOAM532u5kuTONgMBNXa42M7x/Fe7aNbs/twgyqfTfznzRPA/DfUvEr1
        sxpSjegoLdNQ0CS3oBShGl0=
X-Google-Smtp-Source: ABdhPJxYt/NW/ecQbeIUH4fLbGef4spEBUnrG4O9KCkgyys0IgoHvXryRMgvTJ2KvjjHxJMfrUolFg==
X-Received: by 2002:aa7:90d4:0:b029:3b3:2746:5449 with SMTP id k20-20020aa790d40000b02903b327465449mr33157369pfk.81.1628667997414;
        Wed, 11 Aug 2021 00:46:37 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id u13sm26179672pfi.51.2021.08.11.00.46.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Aug 2021 00:46:37 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: [PATCH v4 6/7] t5702: replace with "test_when_finished" for cleanup
Date:   Wed, 11 Aug 2021 15:45:53 +0800
Message-Id: <f3b1cba7e102b3132f04b27be48e532da7d448c9.1628666093.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.449.gb2aa5456a8.dirty
In-Reply-To: <cover.1628666093.git.dyroneteng@gmail.com>
References: <cover.1628666093.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 t/t5702-protocol-v2.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 2e1243ca40..e6314b53b0 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -753,7 +753,7 @@ test_expect_success 'ls-remote with v2 http sends only one POST' '
 '
 
 test_expect_success 'push with http:// and a config of v2 does not request v2' '
-	test_when_finished "rm -f log" &&
+	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH/http_parent\" http_child log" &&
 	# Till v2 for push is designed, make sure that if a client has
 	# protocol.version configured to use v2, that the client instead falls
 	# back and uses v0.
@@ -776,7 +776,7 @@ test_expect_success 'push with http:// and a config of v2 does not request v2' '
 '
 
 test_expect_success 'when server sends "ready", expect DELIM' '
-	rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" http_child &&
+	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH/http_parent\" http_child" &&
 
 	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" one &&
@@ -796,7 +796,7 @@ test_expect_success 'when server sends "ready", expect DELIM' '
 '
 
 test_expect_success 'when server does not send "ready", expect FLUSH' '
-	rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" http_child log &&
+	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH/http_parent\" http_child log" &&
 
 	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" one &&
@@ -834,7 +834,7 @@ configure_exclusion () {
 
 test_expect_success 'part of packfile response provided as URI' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -883,7 +883,7 @@ test_expect_success 'part of packfile response provided as URI' '
 
 test_expect_success 'packfile URIs with fetch instead of clone' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -904,7 +904,7 @@ test_expect_success 'packfile URIs with fetch instead of clone' '
 
 test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -935,7 +935,7 @@ test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 
 test_expect_success 'packfile-uri with transfer.fsckobjects' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -959,7 +959,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects' '
 
 test_expect_success 'packfile-uri with transfer.fsckobjects fails on bad object' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -989,7 +989,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails on bad object'
 
 test_expect_success 'packfile-uri with transfer.fsckobjects succeeds when .gitmodules is separate from tree' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child &&
+	test_when_finished "rm -rf \"$P\" http_child" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -1015,7 +1015,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects succeeds when .gitmo
 
 test_expect_success 'packfile-uri with transfer.fsckobjects fails when .gitmodules separate from tree is invalid' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child err &&
+	test_when_finished "rm -rf \"$P\" http_child err" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -1038,4 +1038,4 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails when .gitmodul
 # DO NOT add non-httpd-specific tests here, because the last part of this
 # test script is only executed when httpd is available and enabled.
 
-test_done
+test_done
\ No newline at end of file
-- 
2.31.1.449.gb2aa5456a8.dirty

