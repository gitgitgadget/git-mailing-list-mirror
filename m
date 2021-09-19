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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57069C4332F
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 01:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34BE9610A8
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 01:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240852AbhISB7G (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 21:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbhISB7B (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 21:59:01 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84D3C061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 18:57:36 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id ay33so30357487qkb.10
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 18:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CN2JF8fbiQSU8jbyNDRSCwbS8i3O+VfBt+qUz5Xl3Ig=;
        b=qCwcHj6vf/i7Q9q0c1QDteQ13A0nCCJ1cSlPEFcB4FSvJnbUhieofwejBglW655GLl
         cr1BJOKdpab+KftTGWNSKPkOqm1r6UxpIsGnVTBUnseRKXhFGy7NjIJLkSITQbLY1nt7
         8gnENfuJFrhS/HjDb29q0JNCBBHzWtEsMpYDt0DOk9vACbP47EIfqzMBzJgkNe17FRpW
         8W6tgRhqQAt5ERgwNvklzn/c46Ou0Km6Qo/z3FFoSVJ/MfeUeoL49TgVRH1F2wdt5rni
         OhFAmxSOEqNteeOC/oB/FZLhFcQIm/O/xVT6SBoCJ0/Ub+xFYEUtL2MJVeRHkOwDktbF
         9RAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CN2JF8fbiQSU8jbyNDRSCwbS8i3O+VfBt+qUz5Xl3Ig=;
        b=y7x0jwZrb+tBgY2L32GjLNyobVXrgU4Unh6VRwyV4XpedtapmTpWRfC1VIpiSfq6aI
         f812mlK7jBG9nHfLMSZ5RsFP4JPZ5P3oxIojACIrjJBmtYyV4w41eGuUZTD09G7lC8V1
         7umURZANcsS9n3I9nHDAMpMLXHjNueE/KQfLV0Tf+XPy/nyHInzyDXP0Pkqj8Yq7mj5H
         xgl0UecJ32R8ePbn65V5CHNYhaWo7JsU5LlOWFlQpXoFVZcFN0W5PzaG40gYc6WWR/8R
         5+Q3Sqn4SU79Wt9bCzjzSHVzPZ5RE3cTVLk6Fi3dG7Nx0ya0nV9v9yCWjRSpmW9dXsrc
         50aw==
X-Gm-Message-State: AOAM530g/kjDyEIRau1ryAemoHIZV/K/vRPdyFJ25cJ6Ljc63Z4uE3Be
        Q2ptFZza0XZgsLf9I3VQW+OR5woQeO0=
X-Google-Smtp-Source: ABdhPJzOMCy0hYJ3VF3FRue9oYTOaGk58UVmYfzWOHfHLaauBoY6Svb+peT2C/YrrUmhG0IjJr4QhA==
X-Received: by 2002:a37:a605:: with SMTP id p5mr3815609qke.442.1632016656075;
        Sat, 18 Sep 2021 18:57:36 -0700 (PDT)
Received: from sarawiggum.attlocal.net ([2600:1700:5d80:a320:4412:822d:c222:aea8])
        by smtp.gmail.com with ESMTPSA id k10sm6759062qth.44.2021.09.18.18.57.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Sep 2021 18:57:35 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 4/4] difftool: fix symlink-file writing in dir-diff mode
Date:   Sat, 18 Sep 2021 18:57:29 -0700
Message-Id: <20210919015729.98323-4-davvid@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210919015729.98323-1-davvid@gmail.com>
References: <20210919015729.98323-1-davvid@gmail.com>
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
 t/t7800-difftool.sh | 70 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 70 insertions(+), 2 deletions(-)

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
index 3863afcaac..97077f34a5 100755
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
@@ -732,6 +730,74 @@ test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
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
+
 test_expect_success 'add -N and difftool -d' '
 	test_when_finished git reset --hard &&
 
-- 
2.30.1 (Apple Git-130)

