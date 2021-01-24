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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47801C433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1814522D57
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbhAXRHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 12:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbhAXRHE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 12:07:04 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80B2C06174A
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 09:06:23 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id j21so1527913pls.7
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 09:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WFSvJI4HWdlqPsuyHfJaHF6gCnCek3dG5CYQpyo/Mc0=;
        b=WJ69N8y9qTeeeCngsygB5ULxaazNNQB47/i55zbwXdCXeQN3zuhoNYOMoKFYhNfMJv
         E9hVY6hgtrIHYuGxAv3n0TqvDP9dvbS6RrKF2n9+1cV9jgpg63cnFtodRqKVPUqUDgQ9
         PIDu540lxIjztgVucFTcE3XABp1qEgFKRRoavPy6csdkg38HOQlsc7OPsXoPziqUy2m9
         X/PkuOGRRtZLIlxD+V3HB0urC8yXWSQbWQCPng66X6jUavV9WhzkUlX0iCSP1wFE6wvq
         Lc4AILOoMdGBmImYXYfTYIylTIRyVa3owV6hFqs6eWGmwyI/wY1b2I2bGIHdqeFlvoKK
         t0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WFSvJI4HWdlqPsuyHfJaHF6gCnCek3dG5CYQpyo/Mc0=;
        b=VEuPMpem6mLhuXECB1G1ri9FsS4g+Y4eSj9Aj+8w3tHZqNOkiRev6WkKUp6LCXrbZq
         cucRC6sPdgioFMUKE6mrNU+T09gWrc4GRH4ethNWdy4euHFId7Y3Cna4A2XehR3N0Tda
         fr0HldN2cmrEHTwOG/XfYGpQ4uvFlmayhE0tnI112IDAkrfqxBMfZXt9E1MLf0w1ZjIf
         Q/6LtX4E4fLGKaw6UHnKPZGv+RlCY333Yx8Glu0yrJFd3LIiqUfmxzEtV7DMXXGunV+8
         +XhVUuwrBvIZggdjcpmst8+I8Tvd1tvrpXcjGuHRo7XHDM8eeVGo/EPT+A5BQmPHVlSx
         8I1w==
X-Gm-Message-State: AOAM530LYFEOSYhQ0hP9C4K8wZXSfRcL0n8mi9nKMbhrd3Op+/X4B2+B
        HSBrnesIPJ5QCzNy7pAzFXXTcIQ2ME0hdA==
X-Google-Smtp-Source: ABdhPJxkiootP5gSiCcCrQ7E8Si5HtwQgZbOPZVsCCOIl0tJz8h8grSwsoaMrkFomMkW0MuD+d3dZQ==
X-Received: by 2002:a17:90a:4314:: with SMTP id q20mr9387988pjg.87.1611507983218;
        Sun, 24 Jan 2021 09:06:23 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d0e:58a:f516:739c:ea0e:a6ba])
        by smtp.googlemail.com with ESMTPSA id r30sm16283308pjg.43.2021.01.24.09.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 09:06:22 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        marcnarc@xiplink.com, phillip.wood123@gmail.com,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v3 3/9] rebase -i: comment out squash!/fixup! subjects from squash message
Date:   Sun, 24 Jan 2021 22:34:01 +0530
Message-Id: <20210124170405.30583-4-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210124170405.30583-1-charvi077@gmail.com>
References: <20210119074102.21598-1-charvi077@gmail.com>
 <20210124170405.30583-1-charvi077@gmail.com>
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
index 7bab6000dc..a512335527 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -81,8 +81,7 @@ test_auto_squash () {
 	echo 1 >file1 &&
 	git add -u &&
 	test_tick &&
-	git commit -m "squash! first" &&
-
+	git commit -m "squash! first" -m "extra para for first" &&
 	git tag $1 &&
 	test_tick &&
 	git rebase $2 -i HEAD^^^ &&
@@ -139,7 +138,7 @@ test_expect_success 'auto squash that matches 2 commits' '
 	echo 1 >file1 &&
 	git add -u &&
 	test_tick &&
-	git commit -m "squash! first" &&
+	git commit -m "squash! first" -m "extra para for first" &&
 	git tag final-multisquash &&
 	test_tick &&
 	git rebase --autosquash -i HEAD~4 &&
@@ -192,7 +191,7 @@ test_expect_success 'auto squash that matches a sha1' '
 	git add -u &&
 	test_tick &&
 	oid=$(git rev-parse --short HEAD^) &&
-	git commit -m "squash! $oid" &&
+	git commit -m "squash! $oid" -m "extra para" &&
 	git tag final-shasquash &&
 	test_tick &&
 	git rebase --autosquash -i HEAD^^^ &&
@@ -203,7 +202,8 @@ test_expect_success 'auto squash that matches a sha1' '
 	git cat-file blob HEAD^:file1 >actual &&
 	test_cmp expect actual &&
 	git cat-file commit HEAD^ >commit &&
-	grep squash commit >actual &&
+	! grep -v "squash" commit &&
+	grep "^extra para" commit >actual &&
 	test_line_count = 1 actual
 '
 
@@ -213,7 +213,7 @@ test_expect_success 'auto squash that matches longer sha1' '
 	git add -u &&
 	test_tick &&
 	oid=$(git rev-parse --short=11 HEAD^) &&
-	git commit -m "squash! $oid" &&
+	git commit -m "squash! $oid" -m "extra para" &&
 	git tag final-longshasquash &&
 	test_tick &&
 	git rebase --autosquash -i HEAD^^^ &&
@@ -224,7 +224,8 @@ test_expect_success 'auto squash that matches longer sha1' '
 	git cat-file blob HEAD^:file1 >actual &&
 	test_cmp expect actual &&
 	git cat-file commit HEAD^ >commit &&
-	grep squash commit >actual &&
+	! grep -v "squash" commit &&
+	grep "^extra para" commit >actual &&
 	test_line_count = 1 actual
 '
 
@@ -233,7 +234,7 @@ test_auto_commit_flags () {
 	echo 1 >file1 &&
 	git add -u &&
 	test_tick &&
-	git commit --$1 first-commit &&
+	git commit --$1 first-commit -m "extra para for first" &&
 	git tag final-commit-$1 &&
 	test_tick &&
 	git rebase --autosquash -i HEAD^^^ &&
@@ -261,11 +262,11 @@ test_auto_fixup_fixup () {
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
@@ -326,12 +327,12 @@ test_expect_success C_LOCALE_OUTPUT 'autosquash with custom inst format' '
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
@@ -342,8 +343,9 @@ test_expect_success C_LOCALE_OUTPUT 'autosquash with custom inst format' '
 	git cat-file blob HEAD^:file1 >actual &&
 	test_cmp expect actual &&
 	git cat-file commit HEAD^ >commit &&
-	grep squash commit >actual &&
-	test_line_count = 2 actual
+	! grep -v "squash" commit &&
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

