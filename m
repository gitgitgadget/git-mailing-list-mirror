Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA39EC432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F55720658
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tqQZiMqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfKVTnJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:43:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42097 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfKVTnI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 14:43:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id a15so9993607wrf.9
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 11:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tPC+K6F/Lb44MPh2LLDjUCQCcFfnX1XvPWCyAUMkVuY=;
        b=tqQZiMqrCly9H78OfuvLvfB0VtK0NyUKB4xmSJ9S6uBMpYBL7yDcENJqkAgsYwDMOl
         iMsLX6t/7K5jhhtalh+53pm3MkgPJ3RgZZxjhrUY42rUrV442RISHfSL1G/tJjRqNGB+
         eS+nsUz0+QYNG3wX9lftzaV42iPTrbOrju3kP8ma+z+htuYjEzp94VWcY1H1k/R4oxJT
         kgbj4vzBdnihkgSiJpiETMB07qzAiNHlVp0t3dywLTOa3ix/BmFtWo4o74ktkA0IAj43
         pm0XNhQrw9tz9fIYpMebx/S5BP+xp6PskQrJNVOjAvYenHhoJYJMT4ZraQ4oGvgYnMLu
         wIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tPC+K6F/Lb44MPh2LLDjUCQCcFfnX1XvPWCyAUMkVuY=;
        b=E49bOwU0B+7pggoTqVfsnzKxSkyGOKW2TuFTAUITlT+TeeaKxC9J6E0E2a9HaOsIqK
         fzQISWhPHeLVV/OqsItguKlqGr95Cjo/+j8cHZHN1n9W8S3AdGyfvt2deQwnjNFwuF+R
         QmAMZIR9nBD68vDfQXnTk7FYyyZ1huUvkW2G6dEtoy2Cvhr5KJtVZHQUv3hD9wfi/VZU
         F9YB/jkY61j6s5K2nyC90WCMLoZVkYR+Hm+aOVJfS1mbpF7O+zMAXWyfjNMLG9n29gfR
         WXT+t5IpeTU717SLMEnZts3YLMuBUICBrO511t8AxCKgbWQVT0dHa6sZWrk8GmgYh8zR
         +ScA==
X-Gm-Message-State: APjAAAXN8M/qupq8pdendSzVf1mdS35L2pLhzCUK7f6YFfqGQEqeW8vt
        Qi0cCkiUzHIv/SsQadCwMcqoEQp3
X-Google-Smtp-Source: APXvYqz2f0XQ6ohuLikLwTJw9aK71vUdrNBrwHWOjQQm5MFgkD+9wLObVuyDX8kAajQA9x8jZFlSaA==
X-Received: by 2002:adf:9e92:: with SMTP id a18mr19202705wrf.34.1574451785932;
        Fri, 22 Nov 2019 11:43:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm8866444wrn.21.2019.11.22.11.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 11:43:05 -0800 (PST)
Message-Id: <037f2b2975e06847443aef46939e3c712053dedf.1574451783.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.467.v2.git.1574451783.gitgitgadget@gmail.com>
References: <pull.467.git.1574345181.gitgitgadget@gmail.com>
        <pull.467.v2.git.1574451783.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Nov 2019 19:43:03 +0000
Subject: [PATCH v2 1/1] sequencer: fix empty commit check when amending
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
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
 sequencer.c            | 26 +++++++++++++++++++++-----
 t/t3403-rebase-skip.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index da2decbd3a..f4f81cbddc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1351,11 +1351,27 @@ static int try_to_commit(struct repository *r,
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
+		if (oideq(first_parent
+			  ? get_commit_tree_oid(first_parent)
+			  : the_hash_algo->empty_tree,
+			  &tree)) {
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
