Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5758C33CA5
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DAE2075A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzIdWLXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbgAGExj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:53:39 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38569 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbgAGExh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 23:53:37 -0500
Received: by mail-qk1-f194.google.com with SMTP id k6so41621223qki.5
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 20:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=58u2/7L7YkNqYjYqFJfE5sJpBL3Xh/U2MtboribzNkg=;
        b=YzIdWLXV8bRW/vLfC9JKWKMclVA21oX1OPFw//A4VyAoIlI22GsyndKfi3c5Ac07MG
         Ng02O7kYl2PC69hlZG7Wr1zEOsO06VvCRgrrUlT+Hh/NP7G7vo5bIhQ0Ns0XMHgX54SJ
         WjmdxoNU8HbIaVK/X02VO/FC2y3YxQWKgll9vaLE9MAgacZ9zJsBarYGfs2Z6hsipf4e
         4aQ+ZD/nHlDKxk1SAQE8E6EGts7dL7Beb8ppPE1qYLr2oZlkFAX8VT62xjbMT9NduRM8
         Cqyt9iYKudufFfpz8nwv8su7RETQ4Cw5wWavLPjgPR+T4Q80jC/17nfNhRqKghZkFDVl
         BwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=58u2/7L7YkNqYjYqFJfE5sJpBL3Xh/U2MtboribzNkg=;
        b=bhqYC6RnfHUsfihW+7Q6VTihTCs1nqhzk4ScwJ5gY7MBDkCJW0yIc0dwDtsVVOvaK9
         JGE2B2EXYXAg/UJvPPTrJEJrRFKAHOMFlPEk1ebMdD7ZERnkFYiOl1/648F7hccSZREm
         xzd/yLZOE71skJoNSkP859pAX54ZDLhg4akJE0LKj0DyO0GWP1AM15LSXFVjdBDa1Og3
         6tc/hu64Uce1s8BltqbTOSFqJzHCo6foeRCURlsrZbR/o006feQb7nDEYv0ga9Hg6NEP
         W5BLuPABzNrKPBEkIg/wxlK58KKp3PMxvhAscLYrdV8SkjW046ThbvWMbcOfsHKmzrfl
         Zzow==
X-Gm-Message-State: APjAAAURzb/n9esSFmq7+Hi7MbUUJLNCTZZQujpCMS6FKRPrUzQZNtUh
        TyipUA4CJ0jQomJgi9RtZKWY/6v4
X-Google-Smtp-Source: APXvYqzRNxiDmgaWPpiqkS3A25rlktXPTIQTq4wCtvN+whr99YfBWuu8euVv4WaLjzuLN31NImvu1w==
X-Received: by 2002:a05:620a:150e:: with SMTP id i14mr84299666qkk.273.1578372816020;
        Mon, 06 Jan 2020 20:53:36 -0800 (PST)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id t2sm21663893qkc.31.2020.01.06.20.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 20:53:35 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/16] t3415: stop losing return codes of git commands
Date:   Mon,  6 Jan 2020 23:53:07 -0500
Message-Id: <32d2051b319449205b18048c800b906b675460f4.1578372682.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.180.g49a268d3eb
In-Reply-To: <cover.1578372682.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com> <cover.1578372682.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix invocations of git commands so their exit codes are not lost
within non-assignment command substitutions.

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
2.25.0.rc1.180.g49a268d3eb

