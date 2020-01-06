Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1750C33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 16:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E2620707
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 16:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7k1nZru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgAFQEO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:04:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37060 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgAFQEO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 11:04:14 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so37600453wru.4
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 08:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jma8v+s+xX0hlG9fzlxq93FHPHNBQYklWmcQ4EiR8pQ=;
        b=m7k1nZrucKwTEd6sWK0Fbxox12JPVZTN6lUDev9sdQ1UHoOSMoLmqSxzXZ6LjuKVRQ
         Wp2fOaNpUz19sYjBGIGzRg6U9dfviKeoedUyPD8y0dV30reOlJ2F+JVB2pkTBiA0YKpI
         KL4322HKZRpIKDcJPwrk3Iywwoq8pLN471EG9Wucf6eAiQmpzv6InGDMezaoHVh6h6ZQ
         Yg2m/A3ZBmAh5M1R8yQcjLeRdm/Dt68NXKeTsI165sbHQlG6jnGE2CnHSv8yZudK/0RL
         5qbepmbciJdCSnBlQj2XGlmKvT1MikGM+CthhbMr8If7noT2AfvGQkbPcG1Ikf1vN0eE
         bjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jma8v+s+xX0hlG9fzlxq93FHPHNBQYklWmcQ4EiR8pQ=;
        b=VA3nImGwHM6t3HJFtTTRTBBEUK24OnRj61wYHD5BZEyRnICeuMWk+95/0uUOxymPXf
         UqOi4kbXmTUuaz8WifMFv1QX57r95Sz5Tkwgro/CdURuhqUd3zxTmk5vt2TeO8r13eZe
         9tA00Bvu45YHXHVCQNziWAbX0hAKyAWZWCzBjyEuFvO0+JVkg3Vq4YTzsjlvNmw2E/Yn
         zF9/pMkasNA3arzHHQxEROUd3BXJARNM3Jg1oGlfnkDTOAAvydQ2pxXp9D1S4xojmXJN
         PVv/gqX+49cxVPmEJ1uGsFV/kPWYFipwASyuEtCidT9nfbokkekqNSnkxQtKmhdyx9L6
         gUcQ==
X-Gm-Message-State: APjAAAX+dHqenWMAivpUFMkaMEgLC38C8Iq/F2cdeCfyXhAHMtE4akr+
        vYbHSey9Ysck1ZG+XBBMVSP61J7a
X-Google-Smtp-Source: APXvYqw2t78+XRLi2L6EI9oTW4Ns0m+uMRG+WXH+K9MtTe/jrq76CFgYSvMZdXuyt3NNTKltOVG6CQ==
X-Received: by 2002:adf:f581:: with SMTP id f1mr106405361wro.264.1578326651094;
        Mon, 06 Jan 2020 08:04:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o129sm23257183wmb.1.2020.01.06.08.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 08:04:10 -0800 (PST)
Message-Id: <b262a9d099b882339e9cb930b0a09fd5fe6734b0.1578326648.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.511.git.1578326648.gitgitgadget@gmail.com>
References: <pull.511.git.1578326648.gitgitgadget@gmail.com>
From:   "Michael Rappazzo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Jan 2020 16:04:08 +0000
Subject: [PATCH 1/1] sequencer: comment out the 'squash!' line
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Rappazzo <rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael Rappazzo <rappazzo@gmail.com>

When performing a squash commit, the commit comments are combined into a
single commit.  Since the subject line of the squash commit is used to
identify the squash-to target commit, it cannot offer any useful
contribution to the new commit message.  Therefore, the squash commit
subject line it commented out from the combined message (much like a
fixup commit's full comment).

The body of a squash commit may contain additional content to add to the
commit message, so this part of the squash commit message is retained.

Since this change what the expected post-rebase commit comment would look
like, related test expectations are adjusted to reflect the the new
expectation.  A new test is added for the new expectation.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 sequencer.c                   |  1 +
 t/t3404-rebase-interactive.sh |  4 +---
 t/t3415-rebase-autosquash.sh  | 36 +++++++++++++++++++++++++++--------
 t/t3900-i18n-commit.sh        |  4 ----
 4 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 763ccbbc45..e5602686d7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1756,6 +1756,7 @@ static int update_squash_messages(struct repository *r,
 		strbuf_addf(&buf, _("This is the commit message #%d:"),
 			    ++opts->current_fixup_count + 1);
 		strbuf_addstr(&buf, "\n\n");
+		strbuf_addf(&buf, "%c ", comment_line_char);
 		strbuf_addstr(&buf, body);
 	} else if (command == TODO_FIXUP) {
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ae6e55ce79..57d178d431 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -513,8 +513,6 @@ test_expect_success C_LOCALE_OUTPUT 'squash and fixup generate correct log messa
 	cat >expect-squash-fixup <<-\EOF &&
 	B
 
-	D
-
 	ONCE
 	EOF
 	git checkout -b squash-fixup E &&
@@ -1325,7 +1323,7 @@ test_expect_success 'rebase -i commits that overwrite untracked files (squash)'
 	test_cmp_rev HEAD F &&
 	rm file6 &&
 	git rebase --continue &&
-	test $(git cat-file commit HEAD | sed -ne \$p) = I &&
+	test $(git cat-file commit HEAD | sed -ne \$p) = F &&
 	git reset --hard original-branch2
 '
 
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 22d218698e..51c5a94aea 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -59,7 +59,6 @@ test_auto_squash () {
 	git add -u &&
 	test_tick &&
 	git commit -m "squash! first" &&
-
 	git tag $1 &&
 	test_tick &&
 	git rebase $2 -i HEAD^^^ &&
@@ -67,7 +66,7 @@ test_auto_squash () {
 	test_line_count = 3 actual &&
 	git diff --exit-code $1 &&
 	test 1 = "$(git cat-file blob HEAD^:file1)" &&
-	test 2 = $(git cat-file commit HEAD^ | grep first | wc -l)
+	test 1 = $(git cat-file commit HEAD^ | grep first | wc -l)
 }
 
 test_expect_success 'auto squash (option)' '
@@ -82,6 +81,27 @@ test_expect_success 'auto squash (config)' '
 	test_must_fail test_auto_squash final-squash-config-false
 '
 
+test_expect_success 'auto squash includes squash body but not squash directive' '
+	git reset --hard base &&
+	echo 1 >file1 &&
+	git add -u &&
+	test_tick &&
+	git commit -m "squash! first
+
+Additional Body" &&
+	git tag squash-with-body &&
+	test_tick &&
+	git rebase --autosquash -i HEAD^^^ &&
+	git log --oneline >actual &&
+	git log --oneline --format="%s%n%b" >actual-full &&
+	test_line_count = 3 actual &&
+	git diff --exit-code squash-with-body &&
+	test 1 = "$(git cat-file blob HEAD^:file1)" &&
+	test 1 = $(git cat-file commit HEAD^ | grep first | wc -l) &&
+	test 0 = $(grep squash actual-full | wc -l) &&
+	test 1 = $(grep Additional actual-full | wc -l)
+'
+
 test_expect_success 'misspelled auto squash' '
 	git reset --hard base &&
 	echo 1 >file1 &&
@@ -114,7 +134,7 @@ test_expect_success 'auto squash that matches 2 commits' '
 	test_line_count = 4 actual &&
 	git diff --exit-code final-multisquash &&
 	test 1 = "$(git cat-file blob HEAD^^:file1)" &&
-	test 2 = $(git cat-file commit HEAD^^ | grep first | wc -l) &&
+	test 1 = $(git cat-file commit HEAD^^ | grep first | wc -l) &&
 	test 1 = $(git cat-file commit HEAD | grep first | wc -l)
 '
 
@@ -152,7 +172,7 @@ test_expect_success 'auto squash that matches a sha1' '
 	test_line_count = 3 actual &&
 	git diff --exit-code final-shasquash &&
 	test 1 = "$(git cat-file blob HEAD^:file1)" &&
-	test 1 = $(git cat-file commit HEAD^ | grep squash | wc -l)
+	test 0 = $(git cat-file commit HEAD^ | grep squash | wc -l)
 '
 
 test_expect_success 'auto squash that matches longer sha1' '
@@ -168,7 +188,7 @@ test_expect_success 'auto squash that matches longer sha1' '
 	test_line_count = 3 actual &&
 	git diff --exit-code final-longshasquash &&
 	test 1 = "$(git cat-file blob HEAD^:file1)" &&
-	test 1 = $(git cat-file commit HEAD^ | grep squash | wc -l)
+	test 0 = $(git cat-file commit HEAD^ | grep squash | wc -l)
 '
 
 test_auto_commit_flags () {
@@ -192,7 +212,7 @@ test_expect_success 'use commit --fixup' '
 '
 
 test_expect_success 'use commit --squash' '
-	test_auto_commit_flags squash 2
+	test_auto_commit_flags squash 1
 '
 
 test_auto_fixup_fixup () {
@@ -228,7 +248,7 @@ test_auto_fixup_fixup () {
 		test 1 = $(git cat-file commit HEAD^ | grep first | wc -l)
 	elif test "$1" = "squash"
 	then
-		test 3 = $(git cat-file commit HEAD^ | grep first | wc -l)
+		test 1 = $(git cat-file commit HEAD^ | grep first | wc -l)
 	else
 		false
 	fi
@@ -268,7 +288,7 @@ test_expect_success C_LOCALE_OUTPUT 'autosquash with custom inst format' '
 	test_line_count = 3 actual &&
 	git diff --exit-code final-squash-instFmt &&
 	test 1 = "$(git cat-file blob HEAD^:file1)" &&
-	test 2 = $(git cat-file commit HEAD^ | grep squash | wc -l)
+	test 0 = $(git cat-file commit HEAD^ | grep squash | wc -l)
 '
 
 test_expect_success 'autosquash with empty custom instructionFormat' '
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index d277a9f4b7..bfab245eb3 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -226,10 +226,6 @@ test_commit_autosquash_multi_encoding () {
 		git rev-list HEAD >actual &&
 		test_line_count = 3 actual &&
 		iconv -f $old -t UTF-8 "$TEST_DIRECTORY"/t3900/$msg >expect &&
-		if test $flag = squash; then
-			subject="$(head -1 expect)" &&
-			printf "\nsquash! %s\n" "$subject" >>expect
-		fi &&
 		git cat-file commit HEAD^ >raw &&
 		(sed "1,/^$/d" raw | iconv -f $new -t utf-8) >actual &&
 		test_cmp expect actual
-- 
gitgitgadget
