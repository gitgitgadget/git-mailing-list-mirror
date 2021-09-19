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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE854C433FE
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 20:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5DF3610A8
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 20:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhISUkF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 16:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhISUkE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 16:40:04 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFAEC061574
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 13:38:39 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id g184so15294754pgc.6
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 13:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DBniU2FLIGXk1NXiNbM5epJCe+cKShMfg0VuR3+nUFs=;
        b=qnoeGjUQGJ7Hiwfc1GnITiG1tlhdIgshZqu6vWQvlWUDPVbP5/oQbrm/j5ZDK/sLzB
         P+5NaemNl25++D7dimcQjd7qxD9LTMh0CbnwXxmvlY9ZTKsMSFJgXOH3TMsLS0LYfa1k
         XHINb6fzRhSde/6RrcHbCYskJs3cSXuaaUmKeWJyRr8qIbFZuRHNRq20qCHQkq19xtfS
         p5guNbxPP5cHkvLpuUWeA3sq/HNH6CTgw8wmZLlBOZELGXLldV0gKNRlEy1PfS/QCSSU
         zTaDle4GxRG0q5N/zi8+yeMq2JRzj6RKi0n7Y8PgxaHnypdt0h7XaOCSphzd6/FtLi1x
         1Yvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DBniU2FLIGXk1NXiNbM5epJCe+cKShMfg0VuR3+nUFs=;
        b=RIocWPhd8pwxbZLLD8qq/QkFnjEW9UbtHL5iqWDbLSBW3/IZehzCMuibTegdqtzKtC
         I1yDc/e6KEqMilmmNKhBRBfdVSz8bX/TgcraBxFQ608O12gAzy2L2qQvdatXW9SIyQ6Q
         d0bGuzgS73sWu1Jgzn3hB2UDBKZQlFHxb5IPA/VNTKYS7vI2KA1dJui0NTGr4fuPzldW
         baGQxHDNCccRnwp3cPjV/ZgaoyWKsYN0THA/sMz95ABRAjACL7pe7gKYaHVw9542gv5o
         Uvz9BsNPsueZ2riTT3oEigEEz2i9njtCOfKX3wxt914vW9hoOs5qJK9KQQLHQozI3iJG
         8hIw==
X-Gm-Message-State: AOAM533XJi/7vKSQdVRcTSGW6XzbXFPumExRMmjhcS8R0v7LVkIlY40+
        bojLnHC1AVIzZWBZUfOBOqc=
X-Google-Smtp-Source: ABdhPJyvq26mxKVZnjSh+u/GCAWVIleP546ZFQBgBZ0Ntxv8VxEBY4iftQSvdmFLOJdK7J7m0FmAKQ==
X-Received: by 2002:a65:5643:: with SMTP id m3mr20224490pgs.224.1632083918722;
        Sun, 19 Sep 2021 13:38:38 -0700 (PDT)
Received: from sarawiggum.fas.fa.disney.com ([198.187.190.10])
        by smtp.gmail.com with ESMTPSA id v4sm12132073pff.11.2021.09.19.13.38.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Sep 2021 13:38:38 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 1/3] difftool: fix symlink-file writing in dir-diff mode
Date:   Sun, 19 Sep 2021 13:38:30 -0700
Message-Id: <20210919203832.91207-2-davvid@gmail.com>
X-Mailer: git-send-email 2.33.0.720.g5b0b3ce580
In-Reply-To: <20210919203832.91207-1-davvid@gmail.com>
References: <20210919203832.91207-1-davvid@gmail.com>
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
 builtin/difftool.c  |  2 ++
 t/t7800-difftool.sh | 68 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index bb9fe7245a..21e055d13a 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -557,11 +557,13 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
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
index a173f564bc..07a52fb8e1 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -674,7 +674,6 @@ test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
 	rm c &&
 	ln -s d c &&
 	cat >expect <<-EOF &&
-		b
 		c
 
 		c
@@ -710,7 +709,6 @@ test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
 	# Deleted symlinks
 	rm -f c &&
 	cat >expect <<-EOF &&
-		b
 		c
 
 	EOF
@@ -723,6 +721,72 @@ test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
 	test_cmp expect actual
 '
 
+test_expect_success SYMLINKS 'difftool --dir-diff writes symlinks as raw text' '
+	# Start out on a branch called "branch-init".
+	git init -b branch-init symlink-files &&
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
+		# independent with no symlinks pointing back here.
+		git switch branch-init &&
+
+		# The left link must be "file-a" and "file-a" must contain "a".
+		echo file-a >expect &&
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
+		echo file-b >expect &&
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
2.33.0.720.g5b0b3ce580

