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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32915C433EF
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 02:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3BF061100
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 02:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbhISCWi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 22:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbhISCWi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 22:22:38 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DBCC061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 19:21:13 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id y144so30560790qkb.6
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 19:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gQS+t9Oz+LzdS7IK0+mxMT7KxOYyVsjwZfVa3/hS818=;
        b=TSp7QXKdY9gkwDD78YiqMs/UiyvrJrbf/HCVkh8+dmWQ84K6dYCcXZG6vTS8u6xcwX
         Rb3FzQWhTqemDYehlt5y29PC/AppQcoV2Mw5YsS1TOpT1LSHOnbCNGjSYTT+x79X2vuT
         AlEtnIA/gVdY9v/wCiny+OrbWV79/+eGgP43J7rOelrr1niQ478OPqQcA5r8l+iQJZHa
         flY2pN+CGH1HJ6PKmGAHpHl/JsqzVuya782jdAtQiM70Hkv9B0+xVENOLdgXddaTad8D
         PdkMFyO9zCMQNYzVSG4QLBNStfpblGAlCnyBFbxDD4LoUlogBMU1KaI0TJ3vpcBvYyBF
         sf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gQS+t9Oz+LzdS7IK0+mxMT7KxOYyVsjwZfVa3/hS818=;
        b=pJ+dDsGUeLvcSPzkH+Sf/fbviVnWbXxVBNaTN272or1zkEbR5GFyUo/sK5ifY9n9Cg
         R0jfYrxW6AnEYvkBoZFMyHqwzyjrbkd4WYasykGd2gtWKKAjm93GYtXg1z2+0nACPgtL
         xTHi3UclQuRmSf2hPyVP6kyz9Nc7Uo+lzvCGGr1UiCfEiAI9p9MvQCnnzGTA2UN/boU0
         rF8Kua/pWecxF4vZJbZiDIHcmmey8yhYI5oyr2YUtCune4mLBl91la6fZW0Bn8ngpzfU
         KNXY3/2ueP2IEuiC0f7aggF6+dzNtyN4r4PO4fNrOnPhDHPOrVwTAG09zpzofoPfSH2c
         W4RA==
X-Gm-Message-State: AOAM531UHCAUiREnHwrdkoxlTzqnbT7tGWclZjGjuvst2Sbk9rg69tkr
        d70KT1+vLfDzIMUgQjqn2T0=
X-Google-Smtp-Source: ABdhPJxEKdo2vmXnrsAqTDPVmroffEsc8jXFQ6oKOrOtJNBDM97Nb9pDQEFWG1EFh6SVt7voY7FZKA==
X-Received: by 2002:a37:91c7:: with SMTP id t190mr17756682qkd.282.1632018072718;
        Sat, 18 Sep 2021 19:21:12 -0700 (PDT)
Received: from sarawiggum.attlocal.net ([2600:1700:5d80:a320:4412:822d:c222:aea8])
        by smtp.gmail.com with ESMTPSA id z12sm3447255qtj.76.2021.09.18.19.21.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Sep 2021 19:21:12 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 4/4] difftool: fix symlink-file writing in dir-diff mode
Date:   Sat, 18 Sep 2021 19:21:10 -0700
Message-Id: <20210919022110.7543-1-davvid@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210919020235.98799-1-davvid@gmail.com>
References: <20210919020235.98799-1-davvid@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The difftool dir-diff mode handles symlinks by replacing them with their
readlink(2) values. This allows diff tools to see changes to symlinks
as if they were regular text diffs with the old and new path values.
This is analogous to what "git diff" displays when symlinks change.

The temporary diff directories that are created initially contain
symlinks because they get checked-out using a temporary index that
retains the original symlinks as checked-in to the repository.

A bug was introduced when difftool was rewritten in C that made
difftool write the readlink(2) contents into the pointed-to file rather
than the symlink itself. The write was going through the symlink and
writing to its target rather than writing to the symlink path itself.

Replace symlinks with raw text files by unlinking the symlink path
before writing the readlink(2) content into them.

When 18ec800512eb0634a0bf5e86b36ed156fbee73f3 added handling for
modified symlinks this bug got recorded in the test suite. The tests
included the pointed-to symlink target paths. These paths were being
reported because difftool was erroneously writing to them, but they
should have never been reported nor written.

Correct the modified-symlinks test cases by removing the target files
from the expected output.

Add a test to ensure that symlinks are written with the readlink(2)
values and that the target files contain their original content.

Reported-by: Alan Blotz <work@blotz.org>
Helped-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Sorry for the patch noise. This supersedes v2 as well.

Changes since v1:
- Removed a spurious newline after the new test.
- Updated test comments to fix a "branch-init" typo.
- Updated test comments to clarify the purpose of the "cat" tools.
- No functional changes.

 builtin/difftool.c  |  2 ++
 t/t7800-difftool.sh | 69 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 2014a2bb9e..4cf454eca4 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -562,11 +562,13 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		if (*entry->left) {
 			add_path(&ldir, ldir_len, entry->path);
 			ensure_leading_directories(ldir.buf);
+			unlink(ldir.buf);
 			write_file(ldir.buf, "%s", entry->left);
 		}
 		if (*entry->right) {
 			add_path(&rdir, rdir_len, entry->path);
 			ensure_leading_directories(rdir.buf);
+			unlink(rdir.buf);
 			write_file(rdir.buf, "%s", entry->right);
 		}
 	}
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 3863afcaac..f58114b900 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -683,7 +683,6 @@ test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
 	rm c &&
 	ln -s d c &&
 	cat >expect <<-EOF &&
-		b
 		c
 
 		c
@@ -719,7 +718,6 @@ test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
 	# Deleted symlinks
 	rm -f c &&
 	cat >expect <<-EOF &&
-		b
 		c
 
 	EOF
@@ -732,6 +730,73 @@ test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
 	test_cmp expect actual
 '
 
+test_expect_success SYMLINKS 'difftool --dir-diff writes symlinks as raw text' '
+	# Start out on a branch called "branch-init".
+	git init -b branch-init symlink-files &&
+	test_when_finished rm -rf symlink-files &&
+	(
+		cd ./symlink-files &&
+
+		# This test ensures that symlinks are written as raw text.
+		# The "cat" tools output link and file contents.
+		git config difftool.cat-left-link.cmd "cat \"\$LOCAL/link\"" &&
+		git config difftool.cat-left-a.cmd "cat \"\$LOCAL/file-a\"" &&
+		git config difftool.cat-right-link.cmd "cat \"\$REMOTE/link\"" &&
+		git config difftool.cat-right-b.cmd "cat \"\$REMOTE/file-b\"" &&
+
+		# Record the empty initial state so that we can come back here
+		# later and not have to consider the any cases where difftool
+		# will create symlinks back into the worktree.
+		test_tick &&
+		git commit --allow-empty -m init &&
+
+		# Create a file called "file-a" with a symlink pointing to it.
+		git switch -c branch-a &&
+		echo a >file-a &&
+		ln -s file-a link &&
+		git add file-a link &&
+		test_tick &&
+		git commit -m link-to-file-a &&
+
+		# Create a file called "file-b" and point the symlink to it.
+		git switch -c branch-b &&
+		echo b >file-b &&
+		rm link &&
+		ln -s file-b link &&
+		git add file-b link &&
+		git rm file-a &&
+		test_tick &&
+		git commit -m link-to-file-b &&
+
+		# Checkout the initial branch so that the --symlinks behavior is
+		# not activated. The two directories should be completely
+		# independent with no syminks pointing back here.
+		git switch branch-init &&
+
+		# The left link must be "file-a" and "file-a" must contain "a".
+		printf "%s\n" file-a >expect &&
+		git difftool --symlinks --dir-diff --tool cat-left-link \
+			branch-a branch-b >actual &&
+		test_cmp expect actual &&
+
+		echo a >expect &&
+		git difftool --symlinks --dir-diff --tool cat-left-a \
+			branch-a branch-b >actual &&
+		test_cmp expect actual &&
+
+		# The right link must be "file-b" and "file-b" must contain "b".
+		printf "%s\n" file-b >expect &&
+		git difftool --symlinks --dir-diff --tool cat-right-link \
+			branch-a branch-b >actual &&
+		test_cmp expect actual &&
+
+		echo b >expect &&
+		git difftool --symlinks --dir-diff --tool cat-right-b \
+			branch-a branch-b >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'add -N and difftool -d' '
 	test_when_finished git reset --hard &&
 
-- 
2.30.1 (Apple Git-130)

