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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AEEC433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A898B64FDC
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhCKAPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 19:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhCKAPX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 19:15:23 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC57C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:15:20 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id g25so240896wmh.0
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zhFO0ZB8WC/jTUS2lHSbDcZtffpsKBae66rUyYDpTzc=;
        b=M0w7zdDiWAiIKoC62hvHIHj8vsa3I7HwpX1tMapZUIfwAg3s+GheQieuNOQXbDEL8/
         Ci4tHeaXXyLBWRyisHwnzcaRCcm7lEDNR8xgBnTGbYtzgMV0Gv4Biu1gENdOmEszuzlZ
         FTcEq3ht+wjnxpB0t64ncCQ5n/1Dx31KByfxWX2pFosYYWpewnh6MTLj5RhrHp/GImym
         ErzBBkqC+61G2QZJFR+Vh3YzIgCJPQfibZ9lb/xEPJWgozZ51c+sAOgJhotMmg0VRJsh
         SrhgEHYHlC6c96a9Vh2R2YRVZysZlHTZFMlXJbIfwfC9lL4PVXDFBlOtxh1B/Q3XB/6+
         O+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zhFO0ZB8WC/jTUS2lHSbDcZtffpsKBae66rUyYDpTzc=;
        b=HyaO28HZRfp7+Am5SPW2qNXK1zkTWkEom1SWjO9JiLScxk3uY8qY4vFbGm99+2Choc
         VZ8bJh+XMyPuhWjO0XsKr4vLEZ5NGTPYZ6mIA8JGVTW6LeJEbFW90g3hrM6AJQZcEPig
         x3GeVTGFaUF+LPrqm3xh4YCSFZHK66TY1wspwfTQx5g5gb41Hl/4MduKjjJZXIV5/sSV
         FSvcUl3LnuEsHkUBSX2G7W2QmO5j1xvkGpdL/v6dGmdtb3dE9LoZNhjNHU3NvyxkXtgc
         rSEUwOlgtYxTTZ4nL66EHrKmL7twvx6+n3Ut99IpUGFPSuoaDrBrtebQxw/iBLhXhrw5
         s7vQ==
X-Gm-Message-State: AOAM531VKvWLDfVL9b5YFJ1u/dzFzdG/em6vM3kDeID+d0Hvxw41GVcM
        RnLX/DohmLnKSirungbJo4Zy34p8JAjYGA==
X-Google-Smtp-Source: ABdhPJxTmR4M0g0uBkjPB7sClcXcwl5eJZ6AqxPP2qv+iEbAGZr5fPyVgOH8fFLwKK393ldkR+lYiw==
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr5512153wmj.122.1615421718797;
        Wed, 10 Mar 2021 16:15:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s84sm1026447wme.11.2021.03.10.16.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:15:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/4] shortlog tests: rewrite to get rid of --abbrev=35 hardcoding
Date:   Thu, 11 Mar 2021 01:14:46 +0100
Message-Id: <20210311001447.28254-4-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc1.213.gbfdb770ff55
In-Reply-To: <YEj82fOf+F4xJC8S@coredump.intra.peff.net>
References: <YEj82fOf+F4xJC8S@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rewrite much of the test logic introduced in 600372497c (shortlog:
Document and test --format option, 2010-05-03), this allows us to get
rid of the now-unused $_x35 variable in test-lib.sh

There was a minimal migration of this test to SHA-256 in
2ece6ad281 (t: switch $_x40 to $OID_REGEX, 2018-05-13), but actually
we can just get rid of all the assumptions about hashing here, and
make this easier to understand and maintain while we're at it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4201-shortlog.sh | 92 +++++++++++++++++++++++++--------------------
 t/test-lib.sh       |  5 +--
 2 files changed, 54 insertions(+), 43 deletions(-)

diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 3095b1b2ff..3ef17c06e4 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -19,82 +19,94 @@ test_expect_success 'setup' '
 	commit=$(printf "%s\n" "Test" "" | git commit-tree "$tree") &&
 	git update-ref HEAD "$commit" &&
 
+	echo "This is a very, very long first line for the commit message to see if it is wrapped correctly" >message &&
+
+	sed "s/i/1234/g" <message >tmp &&
+	tr 1234 "\360\235\204\236" <tmp >message.2 &&
+
+	sed "s/i/1234/g" <message >tmp &&
+	tr 1234 "\370\235\204\236" <tmp >message.3 &&
+
+	echo "a								12	34	56	78" >message.4 &&
+	echo "Commit by someone else" >message.5 &&
+
 	echo 2 >a1 &&
-	git commit --quiet -m "This is a very, very long first line for the commit message to see if it is wrapped correctly" a1 &&
+	git commit --quiet -F message a1 &&
 
 	# test if the wrapping is still valid
 	# when replacing all is by treble clefs.
 	echo 3 >a1 &&
-	git commit --quiet -m "$(
-		echo "This is a very, very long first line for the commit message to see if it is wrapped correctly" |
-		sed "s/i/1234/g" |
-		tr 1234 "\360\235\204\236")" a1 &&
+	git commit --quiet -F message.2 a1 &&
 
 	# now fsck up the utf8
 	git config i18n.commitencoding non-utf-8 &&
 	echo 4 >a1 &&
-	git commit --quiet -m "$(
-		echo "This is a very, very long first line for the commit message to see if it is wrapped correctly" |
-		sed "s/i/1234/g" |
-		tr 1234 "\370\235\204\236")" a1 &&
+	git commit --quiet -F message.3 a1 &&
 
 	echo 5 >a1 &&
-	git commit --quiet -m "a								12	34	56	78" a1 &&
+	git commit --quiet -F message.4 a1 &&
 
 	echo 6 >a1 &&
-	git commit --quiet -m "Commit by someone else" \
+	git commit --quiet -F message.5  \
 		--author="Someone else <not!me>" a1 &&
 
-	cat >expect.template <<-\EOF
+	cat >expect.default <<-EOF
 	A U Thor (5):
-	      SUBJECT
-	      SUBJECT
-	      SUBJECT
-	      SUBJECT
-	      SUBJECT
+	      Test
+	      $(cat message)
+	      $(cat message.2)
+	      $(cat message.3)
+	      $(cat message.4)
 
 	Someone else (1):
-	      SUBJECT
+	      $(cat message.5)
 
 	EOF
 '
 
-fuzz() {
-	file=$1 &&
-	sed "
-			s/$OID_REGEX/OBJECT_NAME/g
-			s/$_x35/OBJID/g
-			s/^ \{6\}[CTa].*/      SUBJECT/g
-			s/^ \{8\}[^ ].*/        CONTINUATION/g
-		" <"$file" >"$file.fuzzy" &&
-	sed "/CONTINUATION/ d" <"$file.fuzzy"
-}
-
 test_expect_success 'default output format' '
 	git shortlog HEAD >log &&
-	fuzz log >log.predictable &&
-	test_cmp expect.template log.predictable
+	test_cmp expect.default log
 '
 
 test_expect_success 'pretty format' '
-	sed s/SUBJECT/OBJECT_NAME/ expect.template >expect &&
+	cat >expect <<-EOF &&
+	A U Thor (5):
+	      $(git rev-parse HEAD~5)
+	      $(git rev-parse HEAD~4)
+	      $(git rev-parse HEAD~3)
+	      $(git rev-parse HEAD~2)
+	      $(git rev-parse HEAD~1)
+
+	Someone else (1):
+	      $(git rev-parse HEAD~0)
+
+	EOF
 	git shortlog --format="%H" HEAD >log &&
-	fuzz log >log.predictable &&
-	test_cmp expect log.predictable
+	test_cmp expect log
 '
 
 test_expect_success '--abbrev' '
-	sed s/SUBJECT/OBJID/ expect.template >expect &&
+	cut -c 1-41 <expect >expect.abbrev &&
 	git shortlog --format="%h" --abbrev=35 HEAD >log &&
-	fuzz log >log.predictable &&
-	test_cmp expect log.predictable
+	test_cmp expect.abbrev log
 '
 
 test_expect_success 'output from user-defined format is re-wrapped' '
-	sed "s/SUBJECT/two lines/" expect.template >expect &&
+	cat >expect <<-EOF &&
+	A U Thor (5):
+	      two lines
+	      two lines
+	      two lines
+	      two lines
+	      two lines
+
+	Someone else (1):
+	      two lines
+
+	EOF
 	git shortlog --format="two%nlines" HEAD >log &&
-	fuzz log >log.predictable &&
-	test_cmp expect log.predictable
+	test_cmp expect log
 '
 
 test_expect_success !MINGW 'shortlog wrapping' '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5f2ad2fd81..4d5ba558d3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -511,7 +511,7 @@ SQ=\'
 # when case-folding filenames
 u200c=$(printf '\342\200\214')
 
-export _x05 _x35 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID OID_REGEX
+export _x05 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID OID_REGEX
 
 # Each test should start with something like this, after copyright notices:
 #
@@ -1381,9 +1381,8 @@ then
 fi
 
 # Convenience
-# A regexp to match 5 and 35 hexdigits
+# A regexp to match 5 hexdigits
 _x05='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-_x35="$_x05$_x05$_x05$_x05$_x05$_x05$_x05"
 
 test_oid_init
 
-- 
2.31.0.rc1.213.gbfdb770ff55

