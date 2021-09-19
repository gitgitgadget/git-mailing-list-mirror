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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38B6C433EF
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 02:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A149610A8
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 02:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240863AbhISCEE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 22:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhISCED (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 22:04:03 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F4BC061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 19:02:39 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id e16so1449243qte.13
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 19:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/fmNZvqEx/ATHrDO4Oi5QIlPQDtEIpsJtRuO0oEHQCA=;
        b=PkZfL3V0ZuxWMd0kzObYMyBip1hn9UR3TVKNkPGUqnfv00jqb/HT5X5iI8AMvcq/Az
         1hdkOhsk+nteAylvjuW5lntFVnHLSFnNl2I6dh1hkLEUg+P02RDgKA+7aQQTfQBqV7To
         XmUy3SZxcOHzFGNs478Hr9KZg9oeK0mLtHBtTzmOhOOARkByO+HCu2VFL5eYFvZY9bwx
         +7lgr7GRWNjmFrlKuxtUc+PDHnozzgYtqDxNdIwJ7jqMlJYp/Fm7s0SXDB2+Y3mrzhNW
         Mutp1oFIayL0VFnuXHe4jujIB8xGCuw+Sqogti8L/jqUVeYDtVCieqUwt/tb9urx/Raf
         Mhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/fmNZvqEx/ATHrDO4Oi5QIlPQDtEIpsJtRuO0oEHQCA=;
        b=MteB8K40Xh/gKnFiOCm8V9QHnX2LXb9DMY/X0uft02sLXR50/4e0TmAifvA4trrn8g
         q+2jFjFD6Bfy/GeCQSeML8gG6AnQqBkuVHyTN2NS7hDl75bw13zZviivbX0zXYUQgu57
         0d3vAupfAxapNpuq++MgvSwp+IwXhepSzadel5poW64TbwoR6LSpfjP3mJIuSbsuNIc2
         HzVtfTPOZ+tHIy+jPvS/H83aDDCLRQ8b0A5YYqq+rpfH0hqpZebhdxqYOcDo0yI89MYe
         xJT+eYWG1KbQXeZVzuPgV2AoZo4fNepjBbpHZo2j1B97nPhPE6H8HHLfJM8D+qR85M9k
         TqEg==
X-Gm-Message-State: AOAM53337Mk+hgwNDQZ6inZNjfHqF8U7zrcyTRKi8cxyj+xtYG8YURQz
        NRF3OrwYEsweo6Jq0mL+ikM=
X-Google-Smtp-Source: ABdhPJyXdz3CUSy1y/VIe99avKZ8iUxREdLup5rd/z0QHkbyoW7tCntT8s1pRk0XhXsYl4oAYcHCbA==
X-Received: by 2002:a05:622a:84:: with SMTP id o4mr16978088qtw.174.1632016958126;
        Sat, 18 Sep 2021 19:02:38 -0700 (PDT)
Received: from sarawiggum.attlocal.net ([2600:1700:5d80:a320:4412:822d:c222:aea8])
        by smtp.gmail.com with ESMTPSA id c4sm8617191qkf.122.2021.09.18.19.02.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Sep 2021 19:02:37 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 4/4] difftool: fix symlink-file writing in dir-diff mode
Date:   Sat, 18 Sep 2021 19:02:35 -0700
Message-Id: <20210919020235.98799-1-davvid@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210919015729.98323-4-davvid@gmail.com>
References: <20210919015729.98323-4-davvid@gmail.com>
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

Please drop the previous patch.
v2 removes a spurious extra newline that was added after the new test.
No changes otherwise.

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
index 3863afcaac..d9f6d15183 100755
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
+	# Start out on a branch called "init".
+	git init -b branch-init symlink-files &&
+	test_when_finished rm -rf symlink-files &&
+	(
+		cd ./symlink-files &&
+
+		# This test ensures that symlinks are written as raw text.
+		# The "cat" tool cats the file only if it is not a symlink.
+		git config difftool.cat-left-link.cmd "cat \$LOCAL/link" &&
+		git config difftool.cat-left-a.cmd "cat \$LOCAL/file-a" &&
+		git config difftool.cat-right-link.cmd "cat \$REMOTE/link" &&
+		git config difftool.cat-right-b.cmd "cat \$REMOTE/file-b" &&
+
+		# Record the empty start so that we can come back here later and
+		# not have to consider the any cases where difftool will create
+		# symlinks back into the worktree.
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

