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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48F1C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 841C364DF0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhBPMBj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhBPL7f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 06:59:35 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C033FC06178A
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:18 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o15so8890465wmq.5
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pf1Bd1loO6yUPDldmWX/2q7DzCCL5EVVJ46nEGQrk7E=;
        b=bT0Ier7+l9DHFqECTkuI7QjHx3wgtu6lB7bC9OrZ+zMKoPirLXT5jcQpcHrwHRpp5a
         476gBu7+OfNXaN1y8xV0Ho6a1rN4zZqrhO+A0ZPsgeN0k6Q/m5l+sUbZWWP7dbLwZZHT
         Uuup1ETpHeTKv/bV5gG43Oe0L1iPCQU6OrN5/oOe8NCzOels6A5+HjQGDLM0pLFsyGpa
         akM87SchB+8TYfHg/zFgW3xsu3zO6x16I6gT2yiVGo2gIe99DxNOoSBGUCjl3js2FsKR
         PTVAAUB6/oTOh+T5ztUoaBIV19Ikit8/prrPsfmbR6cFcG2Vp56wXKu/qvuK4xIXI76A
         +6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pf1Bd1loO6yUPDldmWX/2q7DzCCL5EVVJ46nEGQrk7E=;
        b=UGPzb/7pWcxDfCJRVvop5U4quOFT1L01wFUGkgl3IEvHgn+raMG5UP0efmvRB68uPQ
         xR3RLqIWxJtYyGVH/kNHain0EWUDGXofNKfS8UObuvtCYm3P4CetsiBSLyibgcCeWbj8
         TIhcgNd69wymHLpTHWl/1NYY8R/tYI6JXipkh8yQb5jSmIJOPf+YwJu/js00BmKqGu//
         WMuDsILTgEMcnRWh/iKeTWAGHbOY9rUFcjCN4Z/Cc/MFgeK4iT73FU1OeBkEy8tMLnTq
         XumwtOP4kHhfiI1KJ1IL8TF1RKDVUFmjAYV+1HLIDBbEd7WhAKR3NO9bTHKttVopYfZN
         7jsQ==
X-Gm-Message-State: AOAM531jAxEQgkJFKS+F1lZeVduR96IHD71mZd6zwBcJ4quJE0Q3uzi9
        3R5zsgRrP1n2z/AyAHjWSQZ8NQgNPRVSHA==
X-Google-Smtp-Source: ABdhPJxuIvxNq94PVvT/4Ut0unPpr/s9jXoYSFzk3XQCk3Vt3ohEJfXNOmifkEunfGFMdZkZ7/ZthA==
X-Received: by 2002:a05:600c:20f:: with SMTP id 15mr3120777wmi.148.1613476697285;
        Tue, 16 Feb 2021 03:58:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b2sm27968246wrv.73.2021.02.16.03.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:58:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/22] pickaxe tests: refactor to use test_commit --append --printf
Date:   Tue, 16 Feb 2021 12:57:44 +0100
Message-Id: <20210216115801.4773-6-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor existing tests added in e0e7cb8080c (log -G: ignore binary
files, 2018-12-14) to use the --append option I added in
3373518cc8b (test-lib functions: add an --append option to
test_commit, 2021-01-12) and the --printf option added in a preceding
commit.

See also f5d79bf7dd6 (tests: refactor a few tests to use "test_commit
--append", 2021-01-12) for prior similar refactoring.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4209-log-pickaxe.sh | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 5d06f5f45ea..298b25265f4 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -107,37 +107,35 @@ test_expect_success 'log -S --no-textconv (missing textconv tool)' '
 '
 
 test_expect_success 'setup log -[GS] binary & --text' '
-	git checkout --orphan GS-binary-and-text &&
-	git read-tree --empty &&
-	printf "a\na\0a\n" >data.bin &&
-	git add data.bin &&
-	git commit -m "create binary file" data.bin &&
-	printf "a\na\0a\n" >>data.bin &&
-	git commit -m "modify binary file" data.bin &&
-	git rm data.bin &&
-	git commit -m "delete binary file" data.bin &&
-	git log >full-log
+	test_create_repo GS-bin-txt &&
+	test_commit -C GS-bin-txt --append --printf A data.bin "a\na\0a\n" &&
+	test_commit -C GS-bin-txt --append --printf B data.bin "a\na\0a\n" &&
+	test_commit -C GS-bin-txt C data.bin "" &&
+	git -C GS-bin-txt log >full-log
 '
 
 test_expect_success 'log -G ignores binary files' '
-	git log -Ga >log &&
+	git -C GS-bin-txt log -Ga >log &&
 	test_must_be_empty log
 '
 
 test_expect_success 'log -G looks into binary files with -a' '
-	git log -a -Ga >log &&
+	git -C GS-bin-txt log -a -Ga >log &&
 	test_cmp log full-log
 '
 
 test_expect_success 'log -G looks into binary files with textconv filter' '
-	test_when_finished "rm .gitattributes" &&
-	echo "* diff=bin" >.gitattributes &&
-	git -c diff.bin.textconv=cat log -Ga >log &&
+	test_when_finished "rm GS-bin-txt/.gitattributes" &&
+	(
+		cd GS-bin-txt &&
+		echo "* diff=bin" >.gitattributes &&
+		git -c diff.bin.textconv=cat log -Ga >../log
+	) &&
 	test_cmp log full-log
 '
 
 test_expect_success 'log -S looks into binary files' '
-	git log -Sa >log &&
+	git -C GS-bin-txt log -Sa >log &&
 	test_cmp log full-log
 '
 
-- 
2.30.0.284.gd98b1dd5eaa7

