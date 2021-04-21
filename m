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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C8FC433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D9C56143B
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbhDUKQK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239125AbhDUKQB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 06:16:01 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84EFC06138B
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:15:27 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n127so10069727wmb.5
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aZFLV6cjJVrzpiDse88WDFXQ1dp2J9LpFJVonXZn3NY=;
        b=DAV/okfujzm6rJlzy8otOiULYll6VwK7twUH6F9J00unk2fmuP2Ibmsobi9DmCPfXI
         VvGI0Fhgd1HmBrTO9LhLEJY3aeBZP95bzGh0uuyMFZaVz0oKcTXQFPaM0QXxlqZQjm85
         ZXXaR9VmErrjpCl6OAEMKqNURtXC0FkF5nKkFn8ULInQJPerycSUcrfCMWYvDREeSWhh
         uPEBvShBEnNcAjzZGVFiUoDOAUyw8JR1C9KBi7jZ1gvTluSES5ou+7uoITgF+PU7Lyka
         NgP6ZyQK7sH2Tj/irsalE6jDG61bRi7O+zRukkSMIU9kv6n2nOw6upJoQHcRdKGCv7m1
         aWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aZFLV6cjJVrzpiDse88WDFXQ1dp2J9LpFJVonXZn3NY=;
        b=hJpo4PJDJ7FK6gtU44uF60Jn4+7FHi3VrI67VVwN07LdSeNw4WM/XYsmlezdjdIZUm
         PlZZkJFORtp1Iw8pBQRp9kVRtw5YNQCcCuLBCdP+qpAdkD36IR+2Exfcojizr6HzcuVE
         BHB1V77UokdtelblPmg0ZGDxHbLC3r+kV00LTbNRXznB2oQOaw+GA/Lz8466ZRkBOeaF
         LJvCYvhYD4btcNeWDr12DgepXS1iwoxiU9eLDV8gjcVBGmrM+WQoRYX/I6xFQyH97W6P
         UoQoyEID5CoZMPsUN82ymw0CxcI5ziGIv5MywIVLvk6lH+eXk6rTJUM9/bSWejh5LnMM
         BW3Q==
X-Gm-Message-State: AOAM530utpUw81Vq97jaHf4Bu3hXrZ2bHvmZmqLLFeeFtm6kEBRGwLa7
        AZt+C5DkmmE65h9cSJeYPef6Jw4ZWuRY/A==
X-Google-Smtp-Source: ABdhPJw8r8G5jttErDxvQhRa9/n3gnkCKsVyxNXKaOVQQIMVEROoSy+ZO2kcVUPE6UjUZ87J5AJDXg==
X-Received: by 2002:a05:600c:d4:: with SMTP id u20mr9074736wmm.164.1619000126193;
        Wed, 21 Apr 2021 03:15:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i9sm1843084wmg.2.2021.04.21.03.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 03:15:25 -0700 (PDT)
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
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 08/11] submodule tests: use symbolic-ref --short to discover branch name
Date:   Wed, 21 Apr 2021 12:15:13 +0200
Message-Id: <patch-08.11-5d437f53ec-20210421T101156Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.721.gbeb6a21927
In-Reply-To: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
References: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com> <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a use of $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME added in
704fed9ea22 (tests: start moving to a different default main branch
name, 2020-10-23) to simply discover the initial branch name of a
repository set up in this function with "symbolic-ref --short".

That's something done in another test in 704fed9ea22, so doing it like
this seems like an omission, or rather an overly eager
search/replacement instead of fixing the test logic.

There are only three uses of the GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
variable in the test suite, this gets rid of one of those.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-submodule-update.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 4b714e9308..f7c7df0ca4 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -63,6 +63,7 @@ create_lib_submodule_repo () {
 	git init submodule_update_repo &&
 	(
 		cd submodule_update_repo &&
+		branch=$(git symbolic-ref --short HEAD) &&
 		echo "expect" >>.gitignore &&
 		echo "actual" >>.gitignore &&
 		echo "x" >file1 &&
@@ -144,7 +145,7 @@ create_lib_submodule_repo () {
 		git checkout -b valid_sub1 &&
 		git revert HEAD &&
 
-		git checkout "${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}"
+		git checkout "$branch"
 	)
 }
 
-- 
2.31.1.721.gbeb6a21927

