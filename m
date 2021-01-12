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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DA4C433E6
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8019F2312A
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438038AbhALVhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436851AbhALUTP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:19:15 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5792FC0617A3
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:22 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id w5so3821460wrm.11
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tzpO8spHMX0Zxlaxn+pDX+gQCynmj/1QgUVN7enLepo=;
        b=MnjzQbcLBtkfuEebmV7xP6PVhxyFqdr/uw0U5sSb6wlZrUQfFTy2KjIdVZzOrD0+Qb
         v9rkeahbBCIYrk4SpCyImmoySLRGWqaJeAgXplsbMKUnmkv3v3Pcuak6L5RXu4Y3F7kU
         NkEkXym2f8TcScZ+dNFmS/9+x5MXkMCxDHKksrhijNeTasxBzV69K9ZwOaS6Bw+FAY9g
         drIj3fTe4SmNpbXJ+5epXvw/u5T4gsHyhvPQElOLChZMgXBPWd0on/6EwE3z0Mui4Iz0
         RsLoDwJ9yRBGcj1QGLW4+EZr9GmDJuypzQp/6i9TbRWabZmlX1EhxCdSuBZZotIkxsOv
         qdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzpO8spHMX0Zxlaxn+pDX+gQCynmj/1QgUVN7enLepo=;
        b=C8zPz9jk9DYQLVjeiBTiuL7c1A3008otpyxw9nFNeKyocoGFnaCCpHfSk+IAxy19Vj
         +69jIlWDqhRp0EAihBavpX3b8RProuyh0ZkaSTf6Go8ehhUvc59pr+DPhPHXJ3ipn6Cq
         4az96OA8i99VuPwFVi9H0Eg87I1DxemTpOWj2nygof++kfoBToBy8oO8K9x7Q54lTLSq
         x+LkCzYAo50kJ6DI9+KACFW19FVQK6mdj4beTpTKFHq9tCNlHBoTis+GDwusnTSdlUDN
         HW8TA7M0qwScEOrxgGf8Vy/rJqdj9etN5EVexut4OvRSvLFJXQN38xGNwTk6Vh3hkAY8
         E7fg==
X-Gm-Message-State: AOAM532bAtAYe9rWbW2Sf5IYunSriLsbn6bmC07uPvjjo5mGzkob9d9+
        rB2WzMt5SmVPPlIXk74CgNyGbhaIYq5yHw==
X-Google-Smtp-Source: ABdhPJzyGO6KqAcCdqzoebfZfWl5HQdxkRAjKJflwWj2IVT8mu2UR3GvP8f2hI59gxJrnda+w18U+g==
X-Received: by 2002:adf:e590:: with SMTP id l16mr554152wrm.294.1610482700859;
        Tue, 12 Jan 2021 12:18:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm7095374wrb.92.2021.01.12.12.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:18:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/22] mailmap tests: use our preferred whitespace syntax
Date:   Tue, 12 Jan 2021 21:17:49 +0100
Message-Id: <20210112201806.13284-6-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
References: <20210105130359.21139-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change these tests to use the preferred whitespace around ">",
"<<-EOF" etc. This is an initial step in larger and more meaningful
refactoring of the file, which makes a subsequent commit easier to
read.

I'm not changing the whitespace of "echo <str> > file" patterns to
"echo <str> >file" because all of those will be changed to here-docs
in a subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4203-mailmap.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 586c3a86b1..034a78aba1 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -13,7 +13,7 @@ fuzz_blame () {
 }
 
 test_expect_success setup '
-	cat >contacts <<- EOF &&
+	cat >contacts <<-EOF &&
 	$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
 	nick1 <bugs@company.xx>
 	EOF
@@ -33,7 +33,7 @@ test_expect_success 'check-mailmap no arguments' '
 '
 
 test_expect_success 'check-mailmap arguments' '
-	cat >expect <<- EOF &&
+	cat >expect <<-EOF &&
 	$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
 	nick1 <bugs@company.xx>
 	EOF
@@ -44,7 +44,7 @@ test_expect_success 'check-mailmap arguments' '
 '
 
 test_expect_success 'check-mailmap --stdin' '
-	cat >expect <<- EOF &&
+	cat >expect <<-EOF &&
 	$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
 	nick1 <bugs@company.xx>
 	EOF
@@ -195,10 +195,10 @@ test_expect_success 'No mailmap files, but configured' '
 test_expect_success 'setup mailmap blob tests' '
 	git checkout -b map &&
 	test_when_finished "git checkout master" &&
-	cat >just-bugs <<- EOF &&
+	cat >just-bugs <<-\EOF &&
 	Blob Guy <bugs@company.xx>
 	EOF
-	cat >both <<- EOF &&
+	cat >both <<-EOF &&
 	Blob Guy <$GIT_AUTHOR_EMAIL>
 	Blob Guy <bugs@company.xx>
 	EOF
@@ -471,7 +471,7 @@ test_expect_success 'Log output with log.mailmap' '
 '
 
 test_expect_success 'log.mailmap=false disables mailmap' '
-	cat >expect <<- EOF &&
+	cat >expect <<-EOF &&
 	Author: CTO <cto@coompany.xx>
 	Author: claus <me@company.xx>
 	Author: santa <me@company.xx>
@@ -480,12 +480,12 @@ test_expect_success 'log.mailmap=false disables mailmap' '
 	Author: nick1 <bugs@company.xx>
 	Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
 	EOF
-	git -c log.mailmap=False log | grep Author > actual &&
+	git -c log.mailmap=False log | grep Author >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success '--no-use-mailmap disables mailmap' '
-	cat >expect <<- EOF &&
+	cat >expect <<-EOF &&
 	Author: CTO <cto@coompany.xx>
 	Author: claus <me@company.xx>
 	Author: santa <me@company.xx>
-- 
2.29.2.222.g5d2a92d10f8

