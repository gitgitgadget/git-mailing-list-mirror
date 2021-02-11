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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2A3C433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F2D464DE9
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhBKTt1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 14:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbhBKTsd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 14:48:33 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9E8C061356
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:47:25 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l18so4025571pji.3
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nNJRwLOcEvrOVGiaQx/Ydlqpt9SLFaOr70gDT0alteM=;
        b=XIcSVzF7xN39Xaf+YLV0WvjlSKbOLjc8ENJE86gVhpn2evm76TmYDoPlomdIFkl2QR
         +mpfhoJhFIzzOw685zltg0q5AhtUtCcyJ8IIuZR1wS2xik10YkYa7rz/mgp9aCjbg8Mf
         XbZqYmVCSid5SnrXZMyY7TIobjsKhThyVsEsgxujRxXKreSJwO3l/SHJKUGBeiyivyxH
         J5+6OuLnbTU9f/ZTGdMhpQ9JqGtdhoYpSqujMSMWNAgQsAhU9wxY2ZbSmp9q4QxNfE9D
         Pkn5hhDne2ODnqRYoWw6KgXpKAKiFKKbvEIKg+zguXUXjrWknlQcPl4HvB5lBi4Gte02
         801w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nNJRwLOcEvrOVGiaQx/Ydlqpt9SLFaOr70gDT0alteM=;
        b=qcZDRAZ470oet2jPLCU3lh/1y2/fmZE4K15SeTlb4+7Z3fIzyVEwE/C4oqox1bBsQs
         7DwQ61uBaZgbt/3ABc6H0oa9vZeM7x626QeA0bPKE8Bp6NxGUptcz2HYae6BFuarSxxU
         JuIJLNZp6Pq2pGrXEGXut6WPcqbNVYHobTMh/+hLnnckhbNKy1Yd6Y7nyF6bcjd/Bf0G
         qbJoj43CI2N90ElzRZm69KsgFcND1FiAX7FJ0FW4yuynuv3uaCFbcx7sVyp6yEQ6pZBY
         n7BI2D2cRwlD6cToo4I/74CIdZ8OO2Cz6kFD/TTIsPneLhMO1NpGlT/US9ifQLzLcZc+
         uzVA==
X-Gm-Message-State: AOAM532I16db+YS30aDQ9Jhd3MTLFHWNqjvQiBituL75UVJaCmmMEn8u
        KZ9y6pe+xexb4Gvy6vKhkUFS/P4Zusi0bA==
X-Google-Smtp-Source: ABdhPJwRDMib6NMkEUxWvD95PIRt0T+kaTHyGo4HMgNTRMGFxtYx2UZioPp54GEihoLeoQak1TTg/w==
X-Received: by 2002:a17:90a:f302:: with SMTP id ca2mr5421367pjb.233.1613072844665;
        Thu, 11 Feb 2021 11:47:24 -0800 (PST)
Received: from localhost.localdomain ([47.8.36.172])
        by smtp.gmail.com with ESMTPSA id a141sm6524778pfa.189.2021.02.11.11.47.23
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 11:47:24 -0800 (PST)
From:   Shubham Verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 06/10] t7001: avoid using `cd` outside of subshells
Date:   Fri, 12 Feb 2021 01:17:00 +0530
Message-Id: <20210211194704.28913-7-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211194704.28913-1-shubhunic@gmail.com>
References: <20210211194704.28913-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid using `cd` outside of subshells since, if the test fails,
there is no guarantee that the current working directory is the
expected one, which may cause subsequent tests to run in the wrong
directory.

While at it, make some other tests more concise by replacing
simple subshells with `git -C`.

Signed-off-by: Shubham Verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 43 +++++++++++--------------------------------
 1 file changed, 11 insertions(+), 32 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 2e49e9af81..6412c4f882 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -11,12 +11,12 @@ test_expect_success 'prepare reference tree' '
 '
 
 test_expect_success 'moving the file out of subdirectory' '
-	cd path0 && git mv COPYING ../path1/COPYING
+	git -C path0 mv COPYING ../path1/COPYING
 '
 
 # in path0 currently
 test_expect_success 'commiting the change' '
-	cd .. && git commit -m move-out -a
+	git commit -m move-out -a
 '
 
 test_expect_success 'checking the commit' '
@@ -25,12 +25,12 @@ test_expect_success 'checking the commit' '
 '
 
 test_expect_success 'moving the file back into subdirectory' '
-	cd path0 && git mv ../path1/COPYING COPYING
+	git -C path0 mv ../path1/COPYING COPYING
 '
 
 # in path0 currently
 test_expect_success 'commiting the change' '
-	cd .. && git commit -m move-in -a
+	git commit -m move-in -a
 '
 
 test_expect_success 'checking the commit' '
@@ -328,10 +328,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and no .gitm
 	git mv sub mod/sub &&
 	! test -e sub &&
 	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
-	(
-		cd mod/sub &&
-		git status
-	) &&
+	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
 '
@@ -351,10 +348,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and .gitmodu
 	git mv sub mod/sub &&
 	! test -e sub &&
 	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
-	(
-		cd mod/sub &&
-		git status
-	) &&
+	git -C mod/sub status &&
 	echo mod/sub >expected &&
 	git config -f .gitmodules submodule.sub.path >actual &&
 	test_cmp expected actual &&
@@ -368,16 +362,10 @@ test_expect_success 'git mv moves a submodule with gitfile' '
 	git submodule update &&
 	entry="$(git ls-files --stage sub | cut -f 1)" &&
 	mkdir mod &&
-	(
-		cd mod &&
-		git mv ../sub/ .
-	) &&
+	git -C mod mv ../sub/ . &&
 	! test -e sub &&
 	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
-	(
-		cd mod/sub &&
-		git status
-	) &&
+	git -C mod/sub status &&
 	echo mod/sub >expected &&
 	git config -f .gitmodules submodule.sub.path >actual &&
 	test_cmp expected actual &&
@@ -396,10 +384,7 @@ test_expect_success 'mv does not complain when no .gitmodules file is found' '
 	test_must_be_empty actual.err &&
 	! test -e sub &&
 	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
-	(
-		cd mod/sub &&
-		git status
-	) &&
+	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
 '
@@ -420,10 +405,7 @@ test_expect_success 'mv will error out on a modified .gitmodules file unless sta
 	test_must_be_empty actual.err &&
 	! test -e sub &&
 	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
-	(
-		cd mod/sub &&
-		git status
-	) &&
+	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
 '
@@ -441,10 +423,7 @@ test_expect_success 'mv issues a warning when section is not found in .gitmodule
 	test_i18ncmp expect.err actual.err &&
 	! test -e sub &&
 	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
-	(
-		cd mod/sub &&
-		git status
-	) &&
+	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
 '
-- 
2.25.1

