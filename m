Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B96C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 14:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED64206B6
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 14:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5XkOf76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfKUOGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:06:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40568 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfKUOGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 09:06:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id y5so3829679wmi.5
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 06:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RzgA8GwIwOHmRdOM+XgX2vU6HZxxLzu3FJhnsiataUg=;
        b=e5XkOf76LJhhOj5Zd6oOujXw4lE1wMcvaQgj3bPO6HCUL5mjd6LN8y1gFe/TcVlORL
         +yOi4OeTnRFRR83w2fL4NObwQ88lI/iHPE2YL7V0KItDdSbxMHBlu9pl+FaxN5CE8uWp
         MKwNFZrvoQFmUaYwmTp4F++oSaXIaw0Kni6fwVy6Ger/oUUSapFx8dPNCWb02CVOddJd
         5rElBmYgzb6FZJiEDUsfNgDuE41jlkBWoz24Lu70vPv0zOqkmCT4IJ31EQBwYpes870o
         43grp+X8UVjM1HWdcKXGDjTs4ixHuCVJ0/cM2tj369FcxoS+xe1BGQZ0f9bhDzijYOe+
         7Q6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RzgA8GwIwOHmRdOM+XgX2vU6HZxxLzu3FJhnsiataUg=;
        b=SMMYR9rPy4rbVCDFM4Lno/Te6x5dI8WG/1NkH5+HM/SDRLi/hysixeGuDKkOggRrUq
         qabMz7uRAzV2jdLay1omudbWze3JNsbe2qbvQDNzJLl8820nL1YMBXYmeXANXiselO2r
         5pJxN6iZ/d6HFAhnKspIykOPQNgRPQO7D1KKsmV0JTRfCcts1w+LsEj0y73Io0S6ySum
         8UzfWfI/3/EZQ5jMbZ1lndN6A1Q+5IrXWQe8V0u5ILHeNPj9jo72sV+Th4s3bq+K6omc
         tQWLAipazCe9F/BKgvgPZWNXPeCVXErgeCNvZAOAOBXe1f8wSDkq8hf3OmLvMvgG0b+I
         HDNQ==
X-Gm-Message-State: APjAAAVhLXCyEnryVc5Z4+/OBVxLpVbVb3xAjKMIPih6Kyk3qQGD0LNU
        +8pPmHARIVWd8OtCn+l3lCGRivDR
X-Google-Smtp-Source: APXvYqwcwqmYBuO6jTa6i+gR2dIUiEHdr1xER72tdWeoOyWPV/OYFqUK9AbWdrwuT0M4A1up2f7L7w==
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr10119663wmj.28.1574345183159;
        Thu, 21 Nov 2019 06:06:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15sm3690492wrx.78.2019.11.21.06.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 06:06:22 -0800 (PST)
Message-Id: <7d34c0ff805b8637b23d0ef0045370dfc931a3af.1574345181.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.467.git.1574345181.gitgitgadget@gmail.com>
References: <pull.467.git.1574345181.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 14:06:21 +0000
Subject: [PATCH 1/1] sequencer: fix empty commit check when amending
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This fixes a regression introduced in 356ee4659b ("sequencer: try to
commit without forking 'git commit'", 2017-11-24). When amending a
commit try_to_commit() was using the wrong parent when checking if the
commit would be empty. When amending we need to check against HEAD^ not
HEAD.

t3403 may not seem like the natural home for the new tests but a further
patch series will improve the advice printed by `git commit`. That
series will mutate these tests to check that the advice includes
suggesting `rebase --skip` to skip the fixup that would empty the
commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c            | 24 +++++++++++++++++++-----
 t/t3403-rebase-skip.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index da2decbd3a..4c8938ae46 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1351,11 +1351,25 @@ static int try_to_commit(struct repository *r,
 		goto out;
 	}
 
-	if (!(flags & ALLOW_EMPTY) && oideq(current_head ?
-					    get_commit_tree_oid(current_head) :
-					    the_hash_algo->empty_tree, &tree)) {
-		res = 1; /* run 'git commit' to display error message */
-		goto out;
+	if (!(flags & ALLOW_EMPTY)) {
+		struct commit *first_parent = current_head;
+
+		if (flags & AMEND_MSG) {
+			if (current_head->parents) {
+				first_parent = current_head->parents->item;
+				if (repo_parse_commit(r, first_parent)) {
+					res = error(_("could not parse HEAD commit"));
+					goto out;
+				}
+			} else {
+				first_parent = NULL;
+			}
+		}
+		if (oideq(first_parent ? get_commit_tree_oid(first_parent) :
+					 the_hash_algo->empty_tree, &tree)) {
+			res = 1; /* run 'git commit' to display error message */
+			goto out;
+		}
 	}
 
 	if (find_hook("prepare-commit-msg")) {
diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index 1f5122b632..ee8a8dba52 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -7,6 +7,8 @@ test_description='git rebase --merge --skip tests'
 
 . ./test-lib.sh
 
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
 # we assume the default git am -3 --skip strategy is tested independently
 # and always works :)
 
@@ -20,6 +22,13 @@ test_expect_success setup '
 	git commit -a -m "hello world" &&
 	echo goodbye >> hello &&
 	git commit -a -m "goodbye" &&
+	git tag goodbye &&
+
+	git checkout --detach &&
+	git checkout HEAD^ . &&
+	test_tick &&
+	git commit -m reverted-goodbye &&
+	git tag reverted-goodbye &&
 
 	git checkout -f skip-reference &&
 	echo moo > hello &&
@@ -76,4 +85,27 @@ test_expect_success 'moved back to branch correctly' '
 
 test_debug 'gitk --all & sleep 1'
 
+test_expect_success 'fixup that empties commit fails' '
+	test_when_finished "git rebase --abort" &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="1 fixup 2" git rebase -i \
+			goodbye^ reverted-goodbye
+	)
+'
+
+test_expect_success 'squash that empties commit fails' '
+	test_when_finished "git rebase --abort" &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="1 squash 2" git rebase -i \
+			goodbye^ reverted-goodbye
+	)
+'
+
+# Must be the last test in this file
+test_expect_success '$EDITOR and friends are unchanged' '
+	test_editor_unchanged
+'
+
 test_done
-- 
gitgitgadget
