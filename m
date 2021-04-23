Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE46C43460
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1D32613F6
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbhDWHWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 03:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241133AbhDWHWH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 03:22:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3986C061756
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:21:30 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u17so72499666ejk.2
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aCONEBz4ThHDEi5xs1FaYtvLf0qUdL8F0aToP62cN5Q=;
        b=GrftDUqy/8tV1EweREgS0P+o/oz70+yH+uunqt9Gd0vHO2aaLrDhwaIw0rYDWU+lmW
         HUucA5tXvaJdJsFNNqUbg7M/KLBU9x/nv1mdK8Qi4WLW90B+pB8q9MbUkF9so4VsRTgo
         zdTzCMcUeRXytlv6JgU6AAedTrShaaBBXWXVZZRKnvjWCJ6XdHz6K7WA/Ltc3ZA4Vyz7
         035iSkbyZSr4mdOTnbFjFTPhApQ3glXJP79IbQf1cMICOakzSXWl93y8GQ8HsojOp2ZP
         JWko6UZOP4iU+v9Nbqd+Jhc1M9Csz8htwTUotGo0holbspdWGUiZjjRXnP1rBRu2yHMZ
         dMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aCONEBz4ThHDEi5xs1FaYtvLf0qUdL8F0aToP62cN5Q=;
        b=cgQKa7Vdw5It4n1WjEvtEuCcyK/SI1aUw2C1e2v0wHckQx5AgjIU1hcdZ8+y1CQnQp
         FPusSRn5lVH1DmYn1FY1mabWtjGgRdjdvp3jclanq8bBnZlmRNOMzzoHQuButvwyPbM8
         oLyaYEesXfdJCOPnAOXEQWrI8UqSLrHVQV/Zk5i2YmcZIydGogtSvbBmmOeyDpTwbUOR
         TAShCuPlFnGWZlDm0nEygBMtze5WE5Ygnbevk1thH2+Fm1ouBDZt2cYfG6rahdP57l/u
         bNIijlojWFYqQcrT0u0xckr1rDMRhpvrhKRO/vcJxQV+YtWUjcAg4AUWelOIggDMMgJ0
         QiLg==
X-Gm-Message-State: AOAM532+vAAMR6DOFZmmf//ZlBC8zRWhSkYcL+wIj/3RuB9Jk3xEqOGQ
        kJoJmeDGwmNozMoK17P6dZxhQfnB/ACvHQ==
X-Google-Smtp-Source: ABdhPJxGi8AX25mm0p4CT9jv7eM/EDnQssVYrLF41iNeqL46DnId8eAHcc4TFgIc/6Rj194sFSjwZg==
X-Received: by 2002:a17:906:7c9:: with SMTP id m9mr2818667ejc.54.1619162489345;
        Fri, 23 Apr 2021 00:21:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e5sm3328892ejq.85.2021.04.23.00.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 00:21:28 -0700 (PDT)
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
Subject: [PATCH v5 08/11] submodule tests: use symbolic-ref --short to discover branch name
Date:   Fri, 23 Apr 2021 09:21:12 +0200
Message-Id: <patch-08.11-7fb8849ce66-20210423T072006Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.737.g98b508eba36
In-Reply-To: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com> <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
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
index 4b714e93083..f7c7df0ca42 100644
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
2.31.1.737.g98b508eba36

