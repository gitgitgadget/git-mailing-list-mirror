Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51614C433FE
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 00:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237409AbhKUAuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 19:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbhKUAuI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 19:50:08 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF70DC061574
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 16:47:03 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r8so25262764wra.7
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 16:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BOYpUluqwNatwvKtNga45xDXh7nrcYdcitiqQBHzpx8=;
        b=kc0Rpr54quYgXSxJvhjMdtlkCNs9Ec+d3D6TPKucIxrsL+qyXfmyoq1K5QMCtUVWJP
         Au6VYqtnngbn/j6JZFfEh59sNYl9DkyJ8f/PZQMq9V+lthQsqJlakwri3YPltuAa40Dl
         o2XgjEImUmdRK9uIqc26u23m0TvoOG8HZhkMP/pXmueMQLzUG0o7nON3inOOT7h+nBDk
         lotDbhC5eE4ayGzE0Vj686aTCuo67tykXC1+UwylJHqEBL3JK1FT3z1GHTGNDDMYWkS1
         Xvy2apxzU3szTbYJcA4Bgp3jTc3qBz+FiZtXoG44oHEprwdwAwt8QcMgL6qBYT5olipw
         CtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BOYpUluqwNatwvKtNga45xDXh7nrcYdcitiqQBHzpx8=;
        b=AKzSoIh81QJ7eskHIO73ITAg4JIx4yc0GNtN+oxWlvm4w/Muk13O0soW4EA+qcUlGu
         svtXV0o2OcVZEopG2rHV6jO08rv+QHktjLlviCkWUsRyd6Aou0386aWyKdOegxJfG15v
         1C96J4kGaO7gnN8ZADphL9B1JqGeyQ07JcZuvaw1t9l3YT/gz5iIQN1qMuKEmo1n8dTe
         REO/x6OHZvSsy13J+M74rH/71AYKRAIeCMy6tORj+E/I6kvcbb/+yVQCBtqZzzGthWVl
         ZIVq0W5EEpVCx9x3jg2WqxAfV4TEpis9RsbdDbjmgzXvSOEMIUyscxe9kcAwQU1gWleH
         x63Q==
X-Gm-Message-State: AOAM532UEGbYmJqb+uNcxFUCiwJ4+Emp/9v4Nhx9WswjUg79qgx7PRXb
        gi9KKztoM+0DQNdc/ZC8ZKbDxkEzbbA=
X-Google-Smtp-Source: ABdhPJyFOW/eUny8jk7Ehx4J6Tnqu13nTdYtFEntWi1GjWlrfLY6H8Yp2aHHoy9iQQpDHuSlyS62LQ==
X-Received: by 2002:adf:fe4b:: with SMTP id m11mr22284005wrs.136.1637455622122;
        Sat, 20 Nov 2021 16:47:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f81sm18587674wmf.22.2021.11.20.16.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 16:47:01 -0800 (PST)
Message-Id: <0b71996a3b462d4147fb792b20057544b9ef1710.1637455620.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Nov 2021 00:46:53 +0000
Subject: [PATCH 1/8] t2501: add various tests for removing the current working
 directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Numerous commands will remove empty working directories, especially if
they are in the way of placing needed files.  That is normally fine, but
removing the current working directory can cause confusion for the user
when they run subsequent commands.  Add some tests checking for such
problems.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t2501-cwd-empty.sh | 255 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 255 insertions(+)
 create mode 100755 t/t2501-cwd-empty.sh

diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
new file mode 100755
index 00000000000..5dfb456a691
--- /dev/null
+++ b/t/t2501-cwd-empty.sh
@@ -0,0 +1,255 @@
+#!/bin/sh
+
+test_description='Test handling of the current working directory becoming empty'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit init &&
+	mkdir subdir &&
+	test_commit subdir/file &&
+
+	git branch fd_conflict &&
+
+	mkdir -p foo/bar &&
+	test_commit foo/bar/baz &&
+
+	git revert HEAD &&
+	git tag reverted &&
+
+	git checkout fd_conflict &&
+	git rm subdir/file.t &&
+	echo not-a-directory >dirORfile &&
+	git add dirORfile &&
+	git commit -m dirORfile
+'
+
+test_expect_failure 'checkout does not clean cwd incidentally' '
+	git checkout foo/bar/baz &&
+	test_path_is_dir foo/bar &&
+
+	(
+		cd foo &&
+		git checkout init &&
+		cd ..
+	) &&
+	test_path_is_missing foo/bar/baz &&
+	test_path_is_missing foo/bar &&
+	test_path_is_dir foo
+'
+
+test_expect_failure 'checkout fails if cwd needs to be removed' '
+	git checkout foo/bar/baz &&
+	test_when_finished "git clean -fdx" &&
+
+	mkdir dirORfile &&
+	(
+		cd dirORfile &&
+
+		test_must_fail git checkout fd_conflict 2>../error &&
+		grep "Refusing to remove the current working directory" ../error
+	) &&
+
+	test_path_is_dir dirORfile
+'
+
+test_expect_failure 'reset --hard does not clean cwd incidentally' '
+	git checkout foo/bar/baz &&
+	test_path_is_dir foo/bar &&
+
+	(
+		cd foo &&
+		git reset --hard init &&
+		cd ..
+	) &&
+	test_path_is_missing foo/bar/baz &&
+	test_path_is_missing foo/bar &&
+	test_path_is_dir foo
+'
+
+test_expect_failure 'reset --hard fails if cwd needs to be removed' '
+	git checkout foo/bar/baz &&
+	test_when_finished "git clean -fdx" &&
+
+	mkdir dirORfile &&
+	(
+		cd dirORfile &&
+
+		test_must_fail git reset --hard fd_conflict 2>../error &&
+		grep "Refusing to remove.*the current working directory" ../error
+	) &&
+
+	test_path_is_dir dirORfile
+'
+
+test_expect_failure 'merge does not remove cwd incidentally' '
+	git checkout foo/bar/baz &&
+	test_when_finished "git clean -fdx" &&
+
+	(
+		cd subdir &&
+		git merge fd_conflict
+	) &&
+
+	test_path_is_missing subdir/file.t &&
+	test_path_is_dir subdir
+'
+
+test_expect_failure 'merge fails if cwd needs to be removed' '
+	git checkout foo/bar/baz &&
+	test_when_finished "git clean -fdx" &&
+
+	mkdir dirORfile &&
+	(
+		cd dirORfile &&
+		test_must_fail git merge fd_conflict 2>../error &&
+		grep "Refusing to remove the current working directory" ../error
+	) &&
+
+	test_path_is_dir dirORfile
+'
+
+test_expect_failure 'cherry-pick does not remove cwd incidentally' '
+	git checkout foo/bar/baz &&
+	test_when_finished "git clean -fdx" &&
+
+	(
+		cd subdir &&
+		git cherry-pick fd_conflict
+	) &&
+
+	test_path_is_missing subdir/file.t &&
+	test_path_is_dir subdir
+'
+
+test_expect_failure 'cherry-pick fails if cwd needs to be removed' '
+	git checkout foo/bar/baz &&
+	test_when_finished "git clean -fdx" &&
+
+	mkdir dirORfile &&
+	(
+		cd dirORfile &&
+		test_must_fail git cherry-pick fd_conflict 2>../error &&
+		grep "Refusing to remove the current working directory" ../error
+	) &&
+
+	test_path_is_dir dirORfile
+'
+
+test_expect_failure 'rebase does not remove cwd incidentally' '
+	git checkout foo/bar/baz &&
+	test_when_finished "git clean -fdx" &&
+
+	(
+		cd subdir &&
+		git rebase foo/bar/baz fd_conflict
+	) &&
+
+	test_path_is_missing subdir/file.t &&
+	test_path_is_dir subdir
+'
+
+test_expect_failure 'rebase fails if cwd needs to be removed' '
+	git checkout foo/bar/baz &&
+	test_when_finished "git clean -fdx" &&
+
+	mkdir dirORfile &&
+	(
+		cd dirORfile &&
+		test_must_fail git rebase foo/bar/baz fd_conflict 2>../error &&
+		grep "Refusing to remove the current working directory" ../error
+	) &&
+
+	test_path_is_dir dirORfile
+'
+
+test_expect_failure 'revert does not remove cwd incidentally' '
+	git checkout foo/bar/baz &&
+	test_when_finished "git clean -fdx" &&
+
+	(
+		cd subdir &&
+		git revert subdir/file
+	) &&
+
+	test_path_is_missing subdir/file.t &&
+	test_path_is_dir subdir
+'
+
+test_expect_failure 'revert fails if cwd needs to be removed' '
+	git checkout fd_conflict &&
+	git revert HEAD &&
+	test_when_finished "git clean -fdx" &&
+
+	mkdir dirORfile &&
+	(
+		cd dirORfile &&
+		test_must_fail git revert HEAD 2>../error &&
+		grep "Refusing to remove the current working directory" ../error
+	) &&
+
+	test_path_is_dir dirORfile
+'
+
+test_expect_failure 'rm does not remove cwd incidentally' '
+	test_when_finished "git reset --hard" &&
+	git checkout foo/bar/baz &&
+
+	(
+		cd foo &&
+		git rm bar/baz.t
+	) &&
+
+	test_path_is_missing foo/bar/baz &&
+	test_path_is_missing foo/bar &&
+	test_path_is_dir foo
+'
+
+test_expect_failure 'apply does not remove cwd incidentally' '
+	test_when_finished "git reset --hard" &&
+	git checkout foo/bar/baz &&
+
+	(
+		cd subdir &&
+		git diff subdir/file init | git apply
+	) &&
+
+	test_path_is_missing subdir/file.t &&
+	test_path_is_dir subdir
+'
+
+test_expect_failure 'clean does not remove cwd incidentally' '
+	git checkout foo/bar/baz &&
+	test_when_finished "git clean -fdx" &&
+
+	mkdir empty &&
+	mkdir untracked &&
+	>untracked/random &&
+	(
+		cd untracked &&
+		git clean -fd -e warnings :/ >../warnings &&
+		grep "Refusing to remove current working directory" ../warnings
+	) &&
+
+	test_path_is_missing empty &&
+	test_path_is_missing untracked/random &&
+	test_path_is_dir untracked
+'
+
+test_expect_failure 'stash does not remove cwd incidentally' '
+	git checkout foo/bar/baz &&
+	test_when_finished "git clean -fdx" &&
+
+	mkdir untracked &&
+	>untracked/random &&
+	(
+		cd untracked &&
+		git stash --include-untracked &&
+		git status
+	) &&
+
+	test_path_is_missing untracked/random &&
+	test_path_is_dir untracked
+'
+
+test_done
-- 
gitgitgadget

