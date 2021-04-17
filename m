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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FBBC43462
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DBC5611C2
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbhDQMyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 08:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbhDQMyH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 08:54:07 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E813AC061574
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:53:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id y124-20020a1c32820000b029010c93864955so17919292wmy.5
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LChcT7Uwc/39YWoOriTs+BnxhimiiByHzRMjWHyluOY=;
        b=gNJzSs8Zmb9/fGGBug1L3D3qi7eO5lRXIGed0jUxhsVo3WbUPb8rxm7feeHqyEWS08
         ajAfLs/JgkWgWvpjGq7F8rPzu7m/rp0Acr187G3biKyZ4q+Twoqz6drRe0QL17yXdmaP
         1ZbSqw1UutZe3OULa5eYi+fwvZxVztnhJPeic7uAESRPnGaHZXs0N4chaV/FVpEVg433
         z+zOp2RPPmzP6aH0AiljogbHnvY1xHi+NbBYlFh8WUwIlVctBzZ5UKDrU69MerjsPvRE
         X4+AbfKrrdWCr01n8RDI1gg8DNdUMzQs8yQpdRTNC9EqMMs9JOyfB+Ixpx+2kXBYqS57
         zuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LChcT7Uwc/39YWoOriTs+BnxhimiiByHzRMjWHyluOY=;
        b=Bnvcl58epAJUczuZROW5UXhVs4jCQca01aLvEgEerCxGLjpngpvVmpP2YzJ52cJCiA
         wAQHRWXbf23olBHxhKtQ6qnq3gKfSnALy0hHD1M78Fd001SmwadjtbgEtP8i2GJwX6pZ
         4l9z6H9ohMZGcdJerl7oAG6eTQPlcUIx2oi97xaTgIIgQ+KzX1V2xiqud+7UKohut6c/
         +1bxBj+HY1NpiWrzdzH19RfY8UlXp+IcDRIYCcc8lFOHACb3lLaglw0vxfOL3Fcr07GU
         CxcRpqt6aQ+3YCYtRf08KgckQLcerXuV9Xa4r5kHFFukuXMWApTDVDIDEOcjGvSMBsjP
         7Ltg==
X-Gm-Message-State: AOAM532yUNKxCQV+T0iPUr6Hx+05c2xA353plpk++OCgwcsYdhtwPmjc
        U3rhGyo7aCN91mgrSnTZANiUU2LicIDdZA==
X-Google-Smtp-Source: ABdhPJxQlrtAFkxcXEJjvLWLPAYaJP/I1ys2C6Ud9cWM/UcLYNpQlwMgVLbF5LpwSZkMzRBLhIiOdA==
X-Received: by 2002:a1c:5454:: with SMTP id p20mr12925542wmi.187.1618664019391;
        Sat, 17 Apr 2021 05:53:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4sm11594529wme.14.2021.04.17.05.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 05:53:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/12] test-lib-functions: reword "test_commit --append" docs
Date:   Sat, 17 Apr 2021 14:52:37 +0200
Message-Id: <patch-04.12-9313d35bf86-20210417T124424Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.722.g788886f50a2
In-Reply-To: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com> <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reword the documentation for "test_commit --append" added in my
3373518cc8 (test-lib functions: add an --append option to test_commit,
2021-01-12).

A follow-up commit will make the "echo" part of this configurable, and
in any case saying "echo >>" rather than ">>" was redundant.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6348e8d7339..d169fb2f597 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -172,8 +172,7 @@ debug () {
 #   --notick
 #	Do not call test_tick before making a commit
 #   --append
-#	Use "echo >>" instead of "echo >" when writing "<contents>" to
-#	"<file>"
+#	Use ">>" instead of ">" when writing "<contents>" to "<file>"
 #   --signoff
 #	Invoke "git commit" with --signoff
 #   --author <author>
-- 
2.31.1.722.g788886f50a2

