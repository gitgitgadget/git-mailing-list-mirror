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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58591C433E9
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 19:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33B1664DDF
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 19:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhB1Tzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 14:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbhB1TzT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 14:55:19 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DADC06178A
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 11:54:39 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id bd6so4687927edb.10
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 11:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pjFe3QdOtwb/OwE8dpDtk4LnogIZYZv+dp9OOvzGCao=;
        b=BFBUizHvkG9E8g6+oMH6+ZK5JVOx09DJfpXt6hqWLvOP97+qOjhoEllJ5EJthNQA7v
         NV8UU67aTSqb5wxgntv0b0eH2qTbVKAvSO/YY3+Pq4TJfGMY5aSxFow8M8q7334bzS/j
         YSrNewa4+9Vvw4HI/DN9saJ1IxwmiTl3UjwZBnUI8ihehRyTHxlWe5GKXlBT2HSpjv/7
         cMru4RUqwo/XwBIwfJMo8DCGXtb8JRweQf7yG3kbNn9fCQUkSSyfRxlA7wmYpTXUN+QI
         u8c796s/iX7foXVondIvbwDw+wiLnK0r9UCMJXvA5id6CY+Ts54k7Kf4pvd6CaFsa+ZF
         HyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pjFe3QdOtwb/OwE8dpDtk4LnogIZYZv+dp9OOvzGCao=;
        b=isyx0X926k2DXscYC/sIn81sM/9aEKxTopR/Su3AQc1OhBkm0qW/n2rOwEjs/u+lsF
         lesXhCBmgsiq6CjcL+QTM5KYzIDbSrUOE2IIuwVsFaAF4nDLHZS/qdFsGWCVH4ZL1ToY
         1UF3dPBm4YzvJZCeH3/Rc6ZQX1dTp27tPVChPEJbBLTvPKJjIQc/pq12BQoNapasA4kI
         jxrcV2/46N4m3sJ4vXw36tLLC/hpietHpxxibYtRXXQQQws5R2LRWb1+hFo+pXS2DxBC
         3ABvuQGEUmtD2STAJciVBzthqXgTv2BClgUV6uF/tPDXA7jRQHhBW9npCASqyNyni4RS
         gMyg==
X-Gm-Message-State: AOAM531HY6NTHG7HzyqpDhBwmsJMTBd7sn05qLTRcU5//WTA1sFsQASv
        JDQw2V2OZy+s/pjTKyLfo9hWG4P05kwi8Q==
X-Google-Smtp-Source: ABdhPJxkluLBGdnH/2SCKLgL0BXXpZqOWD0a6OOvJSUE7srPgixDB+mSzBNsITtVmd61ASDZD50H1Q==
X-Received: by 2002:aa7:c3c7:: with SMTP id l7mr13308213edr.207.1614542077488;
        Sun, 28 Feb 2021 11:54:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm11295554ejl.1.2021.02.28.11.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 11:54:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/10] test-lib functions: add an --annotated-tag option to "test_commit"
Date:   Sun, 28 Feb 2021 20:54:08 +0100
Message-Id: <20210228195414.21372-5-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.116.g45ec00aa00
In-Reply-To: <20200223125102.6697-1-benno@bmevers.de>
References: <20200223125102.6697-1-benno@bmevers.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an --annotated-tag option to test_commit. The tag will share the
same message as the commit, and we'll call test_tick before creating
it (unless --notick) is provided.

There's quite a few tests that could be simplified with this
construct. I've picked one to convert in this change as a
demonstration.

The placement of --annotated-tag after "notick" in the case of the
documentation, and then after "no_tag" in the case of the code is
slightly inconsistent. It's to evade a merge conflict with two other
commits adding a --printf option, and another one adding documentation
for --no-tag.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1403-show-ref.sh     |  6 ++----
 t/test-lib-functions.sh | 18 +++++++++++++++++-
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 6ce62f878c..7c873033e9 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -7,11 +7,9 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 test_expect_success setup '
-	test_commit A &&
-	git tag -f -a -m "annotated A" A &&
+	test_commit --annotated-tag A &&
 	git checkout -b side &&
-	test_commit B &&
-	git tag -f -a -m "annotated B" B &&
+	test_commit --annotated-tag B &&
 	git checkout main &&
 	test_commit C &&
 	git branch B A^0
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6348e8d733..c6cdabf53e 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -171,6 +171,10 @@ debug () {
 #	Run all git commands in directory <dir>
 #   --notick
 #	Do not call test_tick before making a commit
+#   --annotated-tag
+#	Create an annotated tag with "-a -m <message>". Calls
+#	test_tick between making the commit and tag unless --notick is
+#	given.
 #   --append
 #	Use "echo >>" instead of "echo >" when writing "<contents>" to
 #	"<file>"
@@ -191,6 +195,7 @@ test_commit () {
 	signoff= &&
 	indir= &&
 	no_tag= &&
+	annotated_tag= &&
 	while test $# != 0
 	do
 		case "$1" in
@@ -220,6 +225,9 @@ test_commit () {
 		--no-tag)
 			no_tag=yes
 			;;
+		--annotated-tag)
+			annotated_tag=yes
+			;;
 		*)
 			break
 			;;
@@ -244,7 +252,15 @@ test_commit () {
 	    $signoff -m "$1" &&
 	if test -z "$no_tag"
 	then
-		git ${indir:+ -C "$indir"} tag "${4:-$1}"
+		if test -n "$annotated_tag"
+		then
+			if test -z "$notick"
+			then
+				test_tick
+			fi &&
+			test_tick
+		fi &&
+		git ${indir:+ -C "$indir"} tag ${annotated_tag:+ -a -m "$1"} "${4:-$1}"
 	fi
 }
 
-- 
2.31.0.rc0.116.g45ec00aa00

