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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5374AC433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 07:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19E8A2312D
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 07:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbhASHqx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 02:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbhASHpI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 02:45:08 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4E5C061575
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 23:44:09 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id w14so2691741pfi.2
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 23:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ekyRZqns07H69nAsWq1SU2pdkQ2ZGhCFZlcii/r6lio=;
        b=AfDIAxIJ+DrQay15KKhMT3gwm5jzfqn2V43j0uZIkXPdugr8Wg79gF5DsjFKRTgBBa
         lp/6k3MBD2+Aw8RllgYojnlMb32o+cNpMMd6kEwvcEDt2WUx6jOhIKtAsR+G0AtN92gG
         uY3x15yPRivACAZbAZYjHvFmjTdC6T5liwdfFxRNxs7CsJBzwC7O4I1EBCP1pEJ6+0Pr
         BrX+18lFrt1CnrMvl06OBNpEnhQTOBLQXXfIB0x/9GZ5z32JaAmrlWADfTycMwkfRTr8
         bk77uda/2wv8xuOxFBm0NbqKT4Tf8IKSdxLn4HhUNOQcy8rrZ7q02LuchUR8VTvn7Hoz
         WAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ekyRZqns07H69nAsWq1SU2pdkQ2ZGhCFZlcii/r6lio=;
        b=p9s8GazrgHAl46CfQJD3HPbVk4yJr00Dn6XB8uot0VfTwmbIyZq6vpdriya9vjr5RW
         TktihfgNQqcSF30ww7Mi5Stdl/1pulWcL0Tv+aBw4+DOJ3qx8ixr0tl1wqFY3I1vUUMf
         I0xGDi5/Gk8QMehAyk1qPaNGiVlecCjWrOYobK70FX2MzK/7bBp2MIFwOzF+AbxM1v9c
         JTAcEodJST2FWrH/t+o3RoMQ0EzEIWYe+ivWgFnfbjefPRH85quNrx+c8iwVg+Gm1acF
         Qb1LBzT3tMnaQIPWeSQZ6RqBofC2b1h9iwk97FXNlGQRV+BBF/LqHc+hFIwK94828UMB
         gUNQ==
X-Gm-Message-State: AOAM530ACeVfdthr7r15t+AC7H5jG+JcUa7wj9132aFn3ucSyZHGav0G
        ACJy/JU8mb6vqZQsTOxZ+VAHc4OvVPTN3g==
X-Google-Smtp-Source: ABdhPJxgUwSvuYfQrafeXKvL2/0ZkScobzu6fzYMQ9jfSEu6vG7D4iy1IbYbMpIJhnQgWqUbcTMyQg==
X-Received: by 2002:a63:4444:: with SMTP id t4mr2562245pgk.329.1611042247898;
        Mon, 18 Jan 2021 23:44:07 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d0e:58a:55d6:8648:6f7a:9f93])
        by smtp.googlemail.com with ESMTPSA id x1sm19201525pgj.37.2021.01.18.23.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 23:44:07 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     chriscool@tuxfamily.org, phillip.wood@dunelm.org.uk,
        me@ttaylorr.com, gitster@pobox.com,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v2 3/9] rebase -i: comment out squash!/fixup! subjects from squash message
Date:   Tue, 19 Jan 2021 13:10:58 +0530
Message-Id: <20210119074102.21598-4-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210108092345.2178-1-charvi077@gmail.com>
References: <20210108092345.2178-1-charvi077@gmail.com>
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
 sequencer.c                  | 25 ++++++++++++++++++++++++-
 t/t3415-rebase-autosquash.sh | 30 ++++++++++++++++--------------
 t/t3900-i18n-commit.sh       |  4 ----
 3 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 08cce40834..9acb9c333e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1718,15 +1718,38 @@ static int is_pick_or_similar(enum todo_command command)
 	}
 }
 
+static size_t subject_length(const char *body)
+{
+	size_t i, len = 0;
+	char c;
+	int blank_line = 1;
+	for (i = 0, c = body[i]; c; c = body[++i]) {
+		if (c == '\n') {
+			if (blank_line)
+				return len;
+			len = i + 1;
+			blank_line = 1;
+		} else if (!isspace(c)) {
+			blank_line = 0;
+		}
+	}
+	return blank_line ? len : i;
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
index 7bab6000dc..551dc06bc3 100755
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
+	grep -v "squash" commit &&
+	grep "extra para" commit >actual &&
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
+	grep -v "squash" commit &&
+	grep "extra para" commit >actual &&
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
+	grep -v "squash" commit &&
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

