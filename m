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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA4EC433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 04:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE8CD61040
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 04:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhIWEOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 00:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhIWEO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 00:14:29 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FBAC061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 21:12:58 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id bj3-20020a17090b088300b0019e6603fe89so2469103pjb.4
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 21:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E7cMUbVlRWdZY/ipgXQjTiNUmrw5GuRKf2RTf4kdukk=;
        b=DZEZOIpDULHy1CenULIhFNoSj4hfcLjplE6FM1l1MUXVZvXo+21ttJVDYoadYBzWJr
         u2h/P+9UuWD8ucD3/02dtMoKylOZ6VkJ77AJtp7l49bqzHEEaikTUPPZWh4W1SQIRLAk
         ruOLloRrDv7Q8WFi3IhqlJeTLgtku3UlJ9aLGFI2O/NLVIIe51ExE/nC3lZGEjANceix
         Dp9taBBq5pPML4zUKTIbYKtIq6T2zB/0AA6GtoMaoZmk2m/051NBQKvR5T7r+BobgH5f
         686nxgrEzEE52QruCSdS3AZSAli4mKof8h9MuEdAD+LrU1LkmDuwp84o/vNtqEVuWmdd
         u7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E7cMUbVlRWdZY/ipgXQjTiNUmrw5GuRKf2RTf4kdukk=;
        b=fR56LPQpyNyLGk7WF5PLFaPlyH7Z4HFVKvFqGdwAWFJ3eEduBwJBHKRSquyZm6Pj+A
         YtSyNfWWQ/PMVmBm5dSr504o5TajCqNly/EZvisPSpwByhG9UW8aVgY5D8fwogZ4ofwc
         7FHXi6OY2iRSAw4uH9VCeOfM3Rykw17jlLZBiqtceVPCc36CXfUZLkUPpUngBpYFkiKn
         /DK8foHkDKKZozGXIM/ySc7Mq6MUBXfZAMtjGkC21BDp2CjaHSuU585bRyoPJbuQY2aM
         oXMnzMMOFKii3XBQZ5REl8TmNwMIhNVBbCKjSv8UDIdoEO8c4n5uNIg5nq8kDtoB0GaL
         obVA==
X-Gm-Message-State: AOAM530td3PkqnDKnJN71msN4uukreDZwxoMLDyihp3BPyIGzST76YL1
        u9ypLolDAU5ugYgwonOU8us=
X-Google-Smtp-Source: ABdhPJxZBuIGzcZFJBDnmEP4eorqZnKBto89nN5xGTtWfqLvF7QSZnYRflytoZilZRqlsa68CTUyjQ==
X-Received: by 2002:a17:90b:a42:: with SMTP id gw2mr2930878pjb.26.1632370378422;
        Wed, 22 Sep 2021 21:12:58 -0700 (PDT)
Received: from sarawiggum.fas.fa.disney.com ([198.187.190.10])
        by smtp.gmail.com with ESMTPSA id u10sm3649870pjf.46.2021.09.22.21.12.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Sep 2021 21:12:58 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v5 1/3] difftool: fix symlink-file writing in dir-diff mode
Date:   Wed, 22 Sep 2021 21:12:50 -0700
Message-Id: <20210923041252.52596-2-davvid@gmail.com>
X-Mailer: git-send-email 2.33.0.720.g59ef144b50
In-Reply-To: <20210923041252.52596-1-davvid@gmail.com>
References: <20210923041252.52596-1-davvid@gmail.com>
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

When 18ec800512 (difftool: handle modified symlinks in dir-diff mode,
2017-03-15) added handling for modified symlinks this bug got recorded
in the test suite. The tests included the pointed-to symlink target
paths. These paths were being reported because difftool was erroneously
writing to them, but they should have never been reported nor written.

Correct the modified-symlinks test cases by removing the target files
from the expected output.

Add a test to ensure that symlinks are written with the readlink(2)
values and that the target files contain their original content.

Reported-by: Alan Blotz <work@blotz.org>
Helped-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 builtin/difftool.c  |  2 ++
 t/t7800-difftool.sh | 67 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 67 insertions(+), 2 deletions(-)

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
index a173f564bc..528e0dabf0 100755
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
@@ -723,6 +721,71 @@ test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
 	test_cmp expect actual
 '
 
+test_expect_success SYMLINKS 'difftool --dir-diff writes symlinks as raw text' '
+	# Start out on a branch called "branch-init".
+	git init -b branch-init symlink-files &&
+	(
+		cd symlink-files &&
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
2.33.0.720.g59ef144b50

