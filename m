Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888EFC2D0CE
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E8921582
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cw9caz8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfL0Nrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:47:48 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:43395 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfL0Nro (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 08:47:44 -0500
Received: by mail-qv1-f67.google.com with SMTP id p2so10043698qvo.10
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 05:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PawHWGrxbMZYN9kc0TxDmBtdHl4h3CO7sjQEZdlsvLA=;
        b=Cw9caz8G+MpcBfaIEVSK0fCo8O6mPwZOpTeDDQu+irjmqqQzwkPCApkwaL38sRTm+j
         0kbbd98cbR28NQAGl1UPBd0jsQ5GTjCzEyL0x3CifmFHqUn7U5JQ5t/M4aMlG5wlFwIB
         rYcLopagu+hxLz5YlaIYdo+ZoLJ82KLCljMOQ0zlQV/4t3swLXmDXiCosV8nHaKTOWEn
         5To1jyjS1RPjCnjgZ50z0Ck7eincpZRfM6x9J/rOvWnTYwtb/6ZmUYaIGFc5R47OeyAK
         rLY2SNn3grVTLDx8ILbrBjU9/X0ldQBoqhZpIR1YYD0JatvRSFrvQGu/GHrIGXz6i85j
         XMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PawHWGrxbMZYN9kc0TxDmBtdHl4h3CO7sjQEZdlsvLA=;
        b=O+uUztUyKrkoe9GJ1Y27HDbufALE7yI5J/oeAIowloBnkwfZdosOHiQIFDm8WBontT
         uLDyVqFgVYJbO09KCScoPB/QE0ZLIR9hLacRduQl+JqHF4NUkeOvsW8i1C3GF3cJG8wR
         d/M8mMDRuJGxDINUiGDcY6b0VbqOLWZX1CXeaw9fw3f2qqc6B8buCGxI8anhwTGNOiqU
         BqpKtg69+/LltCkaTY1VxEPbrnR9J2pEQyGIpIrT3Kr8ARRYaZPwhZSnDJ9ZRvBurOVi
         3AyNo7zShxMD+yys4ZnglcFjmL+lgCsN+IDwluAIaXyWjCOSwPJByaa5QrwK1F8FCJhP
         w+jQ==
X-Gm-Message-State: APjAAAV4+ECS5SddjvLA//Qd4Jp2MQpt1PoIncncxUMZbq2AwHqgoVt2
        u5GQJoKHbX07wr24KDG1MlJ3T7xo
X-Google-Smtp-Source: APXvYqyPPiqlrh+UZjQI1ni8rq+t63NXK5PfzHNq0UV0j5TI/fwae4AQg4fjDeNReIFKcK/dMbtK8w==
X-Received: by 2002:a0c:e1cd:: with SMTP id v13mr38113971qvl.115.1577454463390;
        Fri, 27 Dec 2019 05:47:43 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id d9sm10510184qth.34.2019.12.27.05.47.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 05:47:43 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 09/16] t3415: stop losing return codes of git commands
Date:   Fri, 27 Dec 2019 08:47:18 -0500
Message-Id: <baf7ea00484eb7c324074e713178af2121fcd7f2.1577454401.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577454401.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a command is in a non-assignment subshell, the return code will be
lost in favour of the surrounding command's. Rewrite instances of this
such that the return code of git commands is no longer lost.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3415-rebase-autosquash.sh | 113 +++++++++++++++++++++++++----------
 1 file changed, 82 insertions(+), 31 deletions(-)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 22d218698e..b0add36f82 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -37,8 +37,12 @@ test_auto_fixup () {
 	git log --oneline >actual &&
 	test_line_count = 3 actual &&
 	git diff --exit-code $1 &&
-	test 1 = "$(git cat-file blob HEAD^:file1)" &&
-	test 1 = $(git cat-file commit HEAD^ | grep first | wc -l)
+	echo 1 >expect &&
+	git cat-file blob HEAD^:file1 >actual &&
+	test_cmp expect actual &&
+	git cat-file commit HEAD^ >commit &&
+	grep first commit >actual &&
+	test_line_count = 1 actual
 }
 
 test_expect_success 'auto fixup (option)' '
@@ -66,8 +70,12 @@ test_auto_squash () {
 	git log --oneline >actual &&
 	test_line_count = 3 actual &&
 	git diff --exit-code $1 &&
-	test 1 = "$(git cat-file blob HEAD^:file1)" &&
-	test 2 = $(git cat-file commit HEAD^ | grep first | wc -l)
+	echo 1 >expect &&
+	git cat-file blob HEAD^:file1 >actual &&
+	test_cmp expect actual &&
+	git cat-file commit HEAD^ >commit &&
+	grep first commit >actual &&
+	test_line_count = 2 actual
 }
 
 test_expect_success 'auto squash (option)' '
@@ -94,7 +102,8 @@ test_expect_success 'misspelled auto squash' '
 	git log --oneline >actual &&
 	test_line_count = 4 actual &&
 	git diff --exit-code final-missquash &&
-	test 0 = $(git rev-list final-missquash...HEAD | wc -l)
+	git rev-list final-missquash...HEAD >list &&
+	test_must_be_empty list
 '
 
 test_expect_success 'auto squash that matches 2 commits' '
@@ -113,9 +122,15 @@ test_expect_success 'auto squash that matches 2 commits' '
 	git log --oneline >actual &&
 	test_line_count = 4 actual &&
 	git diff --exit-code final-multisquash &&
-	test 1 = "$(git cat-file blob HEAD^^:file1)" &&
-	test 2 = $(git cat-file commit HEAD^^ | grep first | wc -l) &&
-	test 1 = $(git cat-file commit HEAD | grep first | wc -l)
+	echo 1 >expect &&
+	git cat-file blob HEAD^^:file1 >actual &&
+	test_cmp expect actual &&
+	git cat-file commit HEAD^^ >commit &&
+	grep first commit >actual &&
+	test_line_count = 2 actual &&
+	git cat-file commit HEAD >commit &&
+	grep first commit >actual &&
+	test_line_count = 1 actual
 '
 
 test_expect_success 'auto squash that matches a commit after the squash' '
@@ -134,25 +149,38 @@ test_expect_success 'auto squash that matches a commit after the squash' '
 	git log --oneline >actual &&
 	test_line_count = 5 actual &&
 	git diff --exit-code final-presquash &&
-	test 0 = "$(git cat-file blob HEAD^^:file1)" &&
-	test 1 = "$(git cat-file blob HEAD^:file1)" &&
-	test 1 = $(git cat-file commit HEAD | grep third | wc -l) &&
-	test 1 = $(git cat-file commit HEAD^ | grep third | wc -l)
+	echo 0 >expect &&
+	git cat-file blob HEAD^^:file1 >actual &&
+	test_cmp expect actual &&
+	echo 1 >expect &&
+	git cat-file blob HEAD^:file1 >actual &&
+	test_cmp expect actual &&
+	git cat-file commit HEAD >commit &&
+	grep third commit >actual &&
+	test_line_count = 1 actual &&
+	git cat-file commit HEAD^ >commit &&
+	grep third commit >actual &&
+	test_line_count = 1 actual
 '
 test_expect_success 'auto squash that matches a sha1' '
 	git reset --hard base &&
 	echo 1 >file1 &&
 	git add -u &&
 	test_tick &&
-	git commit -m "squash! $(git rev-parse --short HEAD^)" &&
+	oid=$(git rev-parse --short HEAD^) &&
+	git commit -m "squash! $oid" &&
 	git tag final-shasquash &&
 	test_tick &&
 	git rebase --autosquash -i HEAD^^^ &&
 	git log --oneline >actual &&
 	test_line_count = 3 actual &&
 	git diff --exit-code final-shasquash &&
-	test 1 = "$(git cat-file blob HEAD^:file1)" &&
-	test 1 = $(git cat-file commit HEAD^ | grep squash | wc -l)
+	echo 1 >expect &&
+	git cat-file blob HEAD^:file1 >actual &&
+	test_cmp expect actual &&
+	git cat-file commit HEAD^ >commit &&
+	grep squash commit >actual &&
+	test_line_count = 1 actual
 '
 
 test_expect_success 'auto squash that matches longer sha1' '
@@ -160,15 +188,20 @@ test_expect_success 'auto squash that matches longer sha1' '
 	echo 1 >file1 &&
 	git add -u &&
 	test_tick &&
-	git commit -m "squash! $(git rev-parse --short=11 HEAD^)" &&
+	oid=$(git rev-parse --short=11 HEAD^) &&
+	git commit -m "squash! $oid" &&
 	git tag final-longshasquash &&
 	test_tick &&
 	git rebase --autosquash -i HEAD^^^ &&
 	git log --oneline >actual &&
 	test_line_count = 3 actual &&
 	git diff --exit-code final-longshasquash &&
-	test 1 = "$(git cat-file blob HEAD^:file1)" &&
-	test 1 = $(git cat-file commit HEAD^ | grep squash | wc -l)
+	echo 1 >expect &&
+	git cat-file blob HEAD^:file1 >actual &&
+	test_cmp expect actual &&
+	git cat-file commit HEAD^ >commit &&
+	grep squash commit >actual &&
+	test_line_count = 1 actual
 '
 
 test_auto_commit_flags () {
@@ -183,8 +216,12 @@ test_auto_commit_flags () {
 	git log --oneline >actual &&
 	test_line_count = 3 actual &&
 	git diff --exit-code final-commit-$1 &&
-	test 1 = "$(git cat-file blob HEAD^:file1)" &&
-	test $2 = $(git cat-file commit HEAD^ | grep first | wc -l)
+	echo 1 >expect &&
+	git cat-file blob HEAD^:file1 >actual &&
+	test_cmp expect actual &&
+	git cat-file commit HEAD^ >commit &&
+	grep first commit >actual &&
+	test_line_count = $2 actual
 }
 
 test_expect_success 'use commit --fixup' '
@@ -210,11 +247,15 @@ test_auto_fixup_fixup () {
 	(
 		set_cat_todo_editor &&
 		test_must_fail git rebase --autosquash -i HEAD^^^^ >actual &&
+		head=$(git rev-parse --short HEAD) &&
+		parent1=$(git rev-parse --short HEAD^) &&
+		parent2=$(git rev-parse --short HEAD^^) &&
+		parent3=$(git rev-parse --short HEAD^^^) &&
 		cat >expected <<-EOF &&
-		pick $(git rev-parse --short HEAD^^^) first commit
-		$1 $(git rev-parse --short HEAD^) $1! first
-		$1 $(git rev-parse --short HEAD) $1! $2! first
-		pick $(git rev-parse --short HEAD^^) second commit
+		pick $parent3 first commit
+		$1 $parent1 $1! first
+		$1 $head $1! $2! first
+		pick $parent2 second commit
 		EOF
 		test_cmp expected actual
 	) &&
@@ -222,13 +263,17 @@ test_auto_fixup_fixup () {
 	git log --oneline >actual &&
 	test_line_count = 3 actual
 	git diff --exit-code "final-$1-$2" &&
-	test 2 = "$(git cat-file blob HEAD^:file1)" &&
+	echo 2 >expect &&
+	git cat-file blob HEAD^:file1 >actual &&
+	test_cmp expect actual &&
+	git cat-file commit HEAD^ >commit &&
+	grep first commit >actual &&
 	if test "$1" = "fixup"
 	then
-		test 1 = $(git cat-file commit HEAD^ | grep first | wc -l)
+		test_line_count = 1 actual
 	elif test "$1" = "squash"
 	then
-		test 3 = $(git cat-file commit HEAD^ | grep first | wc -l)
+		test_line_count = 3 actual
 	else
 		false
 	fi
@@ -256,19 +301,25 @@ test_expect_success C_LOCALE_OUTPUT 'autosquash with custom inst format' '
 	echo 2 >file1 &&
 	git add -u &&
 	test_tick &&
-	git commit -m "squash! $(git rev-parse --short HEAD^)" &&
+	oid=$(git rev-parse --short HEAD^) &&
+	git commit -m "squash! $oid" &&
 	echo 1 >file1 &&
 	git add -u &&
 	test_tick &&
-	git commit -m "squash! $(git log -n 1 --format=%s HEAD~2)" &&
+	subject=$(git log -n 1 --format=%s HEAD~2) &&
+	git commit -m "squash! $subject" &&
 	git tag final-squash-instFmt &&
 	test_tick &&
 	git rebase --autosquash -i HEAD~4 &&
 	git log --oneline >actual &&
 	test_line_count = 3 actual &&
 	git diff --exit-code final-squash-instFmt &&
-	test 1 = "$(git cat-file blob HEAD^:file1)" &&
-	test 2 = $(git cat-file commit HEAD^ | grep squash | wc -l)
+	echo 1 >expect &&
+	git cat-file blob HEAD^:file1 >actual &&
+	test_cmp expect actual &&
+	git cat-file commit HEAD^ >commit &&
+	grep squash commit >actual &&
+	test_line_count = 2 actual
 '
 
 test_expect_success 'autosquash with empty custom instructionFormat' '
-- 
2.24.1.810.g65a2f617f4

