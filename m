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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1A1C433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 225C064F65
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239602AbhBDTHc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 14:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239603AbhBDTGl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 14:06:41 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28ACC06178C
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 11:06:00 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id i7so2767416pgc.8
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 11:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EfYYnHwUIihEh7v3AmkOo7Bl1PLcpbzVNEik165bR84=;
        b=Tz8Qt1vZwy025OMRlR3DuwazDbjqN9g1fdyy/6mmdDBL3iaQwuInCZ3H0HlwQ3CZR+
         podE6X5qXi8kalLP6rkmE1Xn2uviGfrTrff8s+jkNjYbqauC9MwbPjop7O1owC/GTU9u
         J2rR/UwvHjX4CUyjSOwbGfUVWnDIQEe4L3gqf+jeLl7T59HMsApWDdga0B97fiHOjYA1
         1N7UVP69uYwRiImNtb+q/dR2hbP9QI3GlNY0b1bwrXEpO1Ov373/ci9Z3cuxGx2tp715
         c1RAGXa6wGZleZk82tM/GJ4ZhjM8B3AIdvbz77Kwl/SYaFeHW+EYt1+kFSTBYqCIPU8c
         cAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EfYYnHwUIihEh7v3AmkOo7Bl1PLcpbzVNEik165bR84=;
        b=tBLVd9nzdlMU3ubmLE/nQ0SWBA1wK4pI6Tw9M557D+GsEO51wqw6+E590ejmK2VkxT
         bbobgowBxRb7LcDZjToS4V4ORcFl0K4VkpNjPJlzsuLIWTEQaHsfzWBUnWPN+Ik46GKP
         Kt2W0U/VmMPcfG+/cbqKhYOg42aUcvWASXmhoUDmXPVHqfFHDyszhlCCRDmcHOmDTwNB
         bU7qnaL9xj47Lv9AcDm009YBFK+/fBKkGnzxr+feRjldpVNnIBMwUmQ7YnZuavQlVF1s
         YNGwcXMVXG4a7ZdZP9KJWQd1tw2maPXBVmghx1PHaf0q1sGTAusEqIRCUnPRPDU50TR3
         EEbw==
X-Gm-Message-State: AOAM532LSD8xIYt8CVATaOdu2CgaCXf+jQ3ou+1Zmpk/V3gcpl4xaWvp
        6ZfFmsIwl/cLU6J4k2LlghDqJQHlB4DqUw==
X-Google-Smtp-Source: ABdhPJxgbeqeoN+p8viBb7olM3s2itHaHsm7jiHyNsll7uJCbCBRBI3gsI4cxD/aVsl9hFr+eWSrKw==
X-Received: by 2002:a65:6450:: with SMTP id s16mr412773pgv.71.1612465560282;
        Thu, 04 Feb 2021 11:06:00 -0800 (PST)
Received: from localhost.localdomain ([2405:204:332c:6caa:c21:291b:12a6:463f])
        by smtp.googlemail.com with ESMTPSA id 9sm6729524pfo.1.2021.02.04.11.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:05:59 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v5 3/8] rebase -i: comment out squash!/fixup! subjects from squash message
Date:   Fri,  5 Feb 2021 00:35:02 +0530
Message-Id: <20210204190507.26487-4-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210204190507.26487-1-charvi077@gmail.com>
References: <20210129182050.26143-1-charvi077@gmail.com>
 <20210204190507.26487-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When squashing commit messages the squash!/fixup! subjects are not of
interest so comment them out to stop them becoming part of the final
message.

This change breaks a bunch of --autosquash tests which rely on the
"squash! <subject>" line appearing in the final commit message. This is
addressed by adding a second line to the commit message of the "squash!
..." commits and testing for that.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Reviewed-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 sequencer.c                  | 21 ++++++++++++++++++++-
 t/t3415-rebase-autosquash.sh | 30 ++++++++++++++++--------------
 t/t3900-i18n-commit.sh       |  4 ----
 3 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 08cce40834..034149f24d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1718,15 +1718,34 @@ static int is_pick_or_similar(enum todo_command command)
 	}
 }
 
+static size_t subject_length(const char *body)
+{
+	const char *p = body;
+	while (*p) {
+		const char *next = skip_blank_lines(p);
+		if (next != p)
+			break;
+		p = strchrnul(p, '\n');
+		if (*p)
+			p++;
+	}
+	return p - body;
+}
+
 static void append_squash_message(struct strbuf *buf, const char *body,
 				  struct replay_opts *opts)
 {
+	size_t commented_len = 0;
+
 	unlink(rebase_path_fixup_msg());
+	if (starts_with(body, "squash!") || starts_with(body, "fixup!"))
+		commented_len = subject_length(body);
 	strbuf_addf(buf, "\n%c ", comment_line_char);
 	strbuf_addf(buf, _("This is the commit message #%d:"),
 		    ++opts->current_fixup_count + 1);
 	strbuf_addstr(buf, "\n\n");
-	strbuf_addstr(buf, body);
+	strbuf_add_commented_lines(buf, body, commented_len);
+	strbuf_addstr(buf, body + commented_len);
 }
 
 static int update_squash_messages(struct repository *r,
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index e7087befd4..78cc2260cc 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -84,8 +84,7 @@ test_auto_squash () {
 	echo 1 >file1 &&
 	git add -u &&
 	test_tick &&
-	git commit -m "squash! first" &&
-
+	git commit -m "squash! first" -m "extra para for first" &&
 	git tag $1 &&
 	test_tick &&
 	git rebase $2 -i HEAD^^^ &&
@@ -142,7 +141,7 @@ test_expect_success 'auto squash that matches 2 commits' '
 	echo 1 >file1 &&
 	git add -u &&
 	test_tick &&
-	git commit -m "squash! first" &&
+	git commit -m "squash! first" -m "extra para for first" &&
 	git tag final-multisquash &&
 	test_tick &&
 	git rebase --autosquash -i HEAD~4 &&
@@ -195,7 +194,7 @@ test_expect_success 'auto squash that matches a sha1' '
 	git add -u &&
 	test_tick &&
 	oid=$(git rev-parse --short HEAD^) &&
-	git commit -m "squash! $oid" &&
+	git commit -m "squash! $oid" -m "extra para" &&
 	git tag final-shasquash &&
 	test_tick &&
 	git rebase --autosquash -i HEAD^^^ &&
@@ -206,7 +205,8 @@ test_expect_success 'auto squash that matches a sha1' '
 	git cat-file blob HEAD^:file1 >actual &&
 	test_cmp expect actual &&
 	git cat-file commit HEAD^ >commit &&
-	grep squash commit >actual &&
+	! grep "squash" commit &&
+	grep "^extra para" commit >actual &&
 	test_line_count = 1 actual
 '
 
@@ -216,7 +216,7 @@ test_expect_success 'auto squash that matches longer sha1' '
 	git add -u &&
 	test_tick &&
 	oid=$(git rev-parse --short=11 HEAD^) &&
-	git commit -m "squash! $oid" &&
+	git commit -m "squash! $oid" -m "extra para" &&
 	git tag final-longshasquash &&
 	test_tick &&
 	git rebase --autosquash -i HEAD^^^ &&
@@ -227,7 +227,8 @@ test_expect_success 'auto squash that matches longer sha1' '
 	git cat-file blob HEAD^:file1 >actual &&
 	test_cmp expect actual &&
 	git cat-file commit HEAD^ >commit &&
-	grep squash commit >actual &&
+	! grep "squash" commit &&
+	grep "^extra para" commit >actual &&
 	test_line_count = 1 actual
 '
 
@@ -236,7 +237,7 @@ test_auto_commit_flags () {
 	echo 1 >file1 &&
 	git add -u &&
 	test_tick &&
-	git commit --$1 first-commit &&
+	git commit --$1 first-commit -m "extra para for first" &&
 	git tag final-commit-$1 &&
 	test_tick &&
 	git rebase --autosquash -i HEAD^^^ &&
@@ -264,11 +265,11 @@ test_auto_fixup_fixup () {
 	echo 1 >file1 &&
 	git add -u &&
 	test_tick &&
-	git commit -m "$1! first" &&
+	git commit -m "$1! first" -m "extra para for first" &&
 	echo 2 >file1 &&
 	git add -u &&
 	test_tick &&
-	git commit -m "$1! $2! first" &&
+	git commit -m "$1! $2! first" -m "second extra para for first" &&
 	git tag "final-$1-$2" &&
 	test_tick &&
 	(
@@ -329,12 +330,12 @@ test_expect_success C_LOCALE_OUTPUT 'autosquash with custom inst format' '
 	git add -u &&
 	test_tick &&
 	oid=$(git rev-parse --short HEAD^) &&
-	git commit -m "squash! $oid" &&
+	git commit -m "squash! $oid" -m "extra para for first" &&
 	echo 1 >file1 &&
 	git add -u &&
 	test_tick &&
 	subject=$(git log -n 1 --format=%s HEAD~2) &&
-	git commit -m "squash! $subject" &&
+	git commit -m "squash! $subject" -m "second extra para for first" &&
 	git tag final-squash-instFmt &&
 	test_tick &&
 	git rebase --autosquash -i HEAD~4 &&
@@ -345,8 +346,9 @@ test_expect_success C_LOCALE_OUTPUT 'autosquash with custom inst format' '
 	git cat-file blob HEAD^:file1 >actual &&
 	test_cmp expect actual &&
 	git cat-file commit HEAD^ >commit &&
-	grep squash commit >actual &&
-	test_line_count = 2 actual
+	! grep "squash" commit &&
+	grep first commit >actual &&
+	test_line_count = 3 actual
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
2.29.0.rc1

