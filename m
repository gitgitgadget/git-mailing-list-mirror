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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3986C433E9
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B862664FD3
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhCKAPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 19:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhCKAPX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 19:15:23 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EDAC061761
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:15:21 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j2so25294393wrx.9
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v3f3ewtkdTxKLMNir4voAbCAxVdfnbhEOyj9olsiy10=;
        b=D80McD54jr6hZrbfVH7wn1lgGF+HEROWtxFt8pO4PgLPBQa74097klbWVx6AcKKT2O
         J54QiM+88/NQopA+6dEqibUidanJpmA2C279wQwuNi2MKxsF8oK+NZ6ff9vbSINU1Hig
         KlrVNlu2i80Hu1shceVRZ41RkKkL03E0DLA5sdhMQq9TaMLeB6lQSfQzpJAfuh9fSPI5
         247kI1QPipD64+P0Ntzt/RHs5YmWneGTDU4aSwVhyRywe1yQuep63ECALyU6nYcU7lGY
         Kf4naO6L7rj/2JGzSdbJWDRYjzl1yYZTWPhj7M9O+2E2W46gWmjRCavvtPMPU0T6LgIl
         7cQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3f3ewtkdTxKLMNir4voAbCAxVdfnbhEOyj9olsiy10=;
        b=e8NFSOSbhkAsiZ0mdnr81t5yvG0aIlcOYTEmz2OalcFUNFz7Gi+PwT1XgM9nDbRxZ/
         anUzETnt3dF2kNoypldYggeB898TV9eaUrf80qo4uYlZeqOUU1/IdHFoWIMOW7EzMQn4
         gZaNb6xzUkDGxnH8dGEYiACGZYzVibOuEctToTGkgSeWrh/IAzKUZlpY48iLgcRAecwT
         5IiUtU8ljdnCB1PuB7KK5cA+7dmj1Ls46aZV1iRAvIXgGwECqgZfFesW5kGHqCMdAW2S
         qR4xLbh96tF4vK0DP49hY/fqlfPPTrS4IiXXJmhMqF2mc2IFNxUtXJNILBo0DCZf26LP
         urDw==
X-Gm-Message-State: AOAM532Uyelup4kogWMXIJQXOy+ooMz5Hc64KG+fkL36F3V+4PpaXoJp
        qmhKTYFk6hCwMWm+ajGtMNL6yLtd+P/xGA==
X-Google-Smtp-Source: ABdhPJzWf8hFuDfuReBPgEbNxQFw+vjowy8xnG8fA5hJaj2LjZwEIoHAR3P9nzdpyZgds9M6ocem1A==
X-Received: by 2002:adf:8562:: with SMTP id 89mr5935203wrh.101.1615421719855;
        Wed, 10 Mar 2021 16:15:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s84sm1026447wme.11.2021.03.10.16.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:15:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/4] tests: get rid of $_x05 from the test suite
Date:   Thu, 11 Mar 2021 01:14:47 +0100
Message-Id: <20210311001447.28254-5-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc1.213.gbfdb770ff55
In-Reply-To: <YEj82fOf+F4xJC8S@coredump.intra.peff.net>
References: <YEj82fOf+F4xJC8S@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the last users of the $_x05 variable from the tests. It turns
out that all of these tests can be rewritten unambiguously to simply
use [0-9a-f]* instead.

In the case of the tree matching we're relying on there being a <TAB>
after the SHA (but a space between the modes and type), then in some
of the other tests here that an abbreviated SHA is at the start of the
line, etc.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3101-ls-tree-dirname.sh          |  2 +-
 t/t3508-cherry-pick-many-commits.sh |  4 ++--
 t/t6006-rev-list-format.sh          | 12 +++++++-----
 t/t7600-merge.sh                    |  4 ++--
 t/test-lib.sh                       |  6 +-----
 5 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
index 12bf31022a..110ebf7d52 100755
--- a/t/t3101-ls-tree-dirname.sh
+++ b/t/t3101-ls-tree-dirname.sh
@@ -187,7 +187,7 @@ EOF
 
 test_expect_success 'ls-tree --abbrev=5' '
 	git ls-tree --abbrev=5 $tree >current &&
-	sed -e "s/ $_x05[0-9a-f]*	/ X	/" <current >check &&
+	sed -e "s/ [0-9a-f]*	/ X	/" <current >check &&
 	cat >expected <<\EOF &&
 100644 blob X	1.txt
 100644 blob X	2.txt
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index e8375d1c97..1bf867d139 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -84,7 +84,7 @@ test_expect_success 'output to keep user entertained during multi-pick' '
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick first..fourth >actual &&
-	sed -e "s/$_x05[0-9a-f][0-9a-f]/OBJID/" <actual >actual.fuzzy &&
+	sed -e "s/ [0-9a-f]*\\]/ OBJID]/" <actual >actual.fuzzy &&
 	test_line_count -ge 3 actual.fuzzy &&
 	test_cmp expected actual.fuzzy
 '
@@ -122,7 +122,7 @@ test_expect_success 'output during multi-pick indicates merge strategy' '
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick --strategy resolve first..fourth >actual &&
-	sed -e "s/$_x05[0-9a-f][0-9a-f]/OBJID/" <actual >actual.fuzzy &&
+	sed -e "s/ [0-9a-f]*\\]/ OBJID]/" <actual >actual.fuzzy &&
 	test_cmp expected actual.fuzzy
 '
 
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 35a2f62392..ec65081e17 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -453,16 +453,18 @@ test_expect_success 'add SP before non-empty (2)' '
 '
 
 test_expect_success '--abbrev' '
-	echo SHORT SHORT SHORT >expect2 &&
 	echo LONG LONG LONG >expect3 &&
 	git log -1 --format="%h %h %h" HEAD >actual1 &&
 	git log -1 --abbrev=5 --format="%h %h %h" HEAD >actual2 &&
 	git log -1 --abbrev=5 --format="%H %H %H" HEAD >actual3 &&
-	sed -e "s/$OID_REGEX/LONG/g" -e "s/$_x05/SHORT/g" <actual2 >fuzzy2 &&
-	sed -e "s/$OID_REGEX/LONG/g" -e "s/$_x05/SHORT/g" <actual3 >fuzzy3 &&
-	test_cmp expect2 fuzzy2 &&
+	sed -e "s/$OID_REGEX/LONG/g" <actual3 >fuzzy3 &&
+	test_file_size actual2 >expect &&
+	# 3*5 SHAs + 3 separating spaces
+	echo 18 >actual &&
+	test_cmp expect actual &&
 	test_cmp expect3 fuzzy3 &&
-	! test_cmp actual1 actual2
+	! test_cmp actual1 actual2 &&
+	! test_cmp actual2 actual3
 '
 
 test_expect_success '%H is not affected by --abbrev-commit' '
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 1cbc9715a8..fec5a7b2dd 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -189,7 +189,7 @@ test_expect_success 'merge c0 with c1' '
 	verify_head "$c1" &&
 
 	git reflog -1 >reflog.actual &&
-	sed "s/$_x05[0-9a-f]*/OBJID/g" reflog.actual >reflog.fuzzy &&
+	sed "s/^[0-9a-f]*/OBJID/" <reflog.actual >reflog.fuzzy &&
 	test_cmp reflog.expected reflog.fuzzy
 '
 
@@ -220,7 +220,7 @@ test_expect_success 'merge from unborn branch' '
 	verify_head "$c1" &&
 
 	git reflog -1 >reflog.actual &&
-	sed "s/$_x05[0-9a-f][0-9a-f]/OBJID/g" reflog.actual >reflog.fuzzy &&
+	sed "s/^[0-9a-f]*/OBJID/g" reflog.actual >reflog.fuzzy &&
 	test_cmp reflog.expected reflog.fuzzy
 '
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4d5ba558d3..aeb4b2da1c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -511,7 +511,7 @@ SQ=\'
 # when case-folding filenames
 u200c=$(printf '\342\200\214')
 
-export _x05 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID OID_REGEX
+export LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID OID_REGEX
 
 # Each test should start with something like this, after copyright notices:
 #
@@ -1380,10 +1380,6 @@ then
 	fi
 fi
 
-# Convenience
-# A regexp to match 5 hexdigits
-_x05='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-
 test_oid_init
 
 ZERO_OID=$(test_oid zero)
-- 
2.31.0.rc1.213.gbfdb770ff55

