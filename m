Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ED2C18E5B
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 10:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E262074D
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 10:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONdiS2ls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387895AbgDBKPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 06:15:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38196 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387722AbgDBKPw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 06:15:52 -0400
Received: by mail-pl1-f195.google.com with SMTP id w3so1168826plz.5
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 03:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W9TVd/7G6FofTnH1A/e7MTy0xkilt5zKEWxXUbg+c9U=;
        b=ONdiS2lsv/kLWVBe6tZ+Hfo5OAi1uiuoeTt5Q9+7mjDhuJ51rLGVSmyD/F7YgjKDex
         +MJa+zMH9PPQ68iVVQgHPxES2ftK5jFDyqgVIlB8mKRLqc7yUmzG5o/aJt2+ar6pAhgm
         qHA6EpG3LRE7+gpZRIK71LBoi8Y8H+NLUHshqh+Vi+IpoZ3xzCJ8ElvUoP89fKzH/VQj
         HLdgtsh1wM/twcfBArvX1pUtQoZ7VcukxvMzxlGUWqHhXgpZnQuDtbUiyPeaAxwy98yV
         kIxdky+1UYgJVkNDhxyjawQWuCKoEsM5zU8oCOonFbVKHDmlxqlFRg/4JlfZ5Jj2nixY
         6P8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W9TVd/7G6FofTnH1A/e7MTy0xkilt5zKEWxXUbg+c9U=;
        b=CiBtxJkcjAak0nQJ1UARtbLoXpiA7FWY6KeYjHBPkH9j1jDnkBst64gu0tSNCcupND
         ZjN9rktdN2+qmtNxssRhjX3+Eot+Gz593FWaT+kiftayN65oUKq3AtAWxIWO/Y8B6OGz
         z+kPC9oLx4f54gq7WhJmrEkEKQnHLr6guSIc4i1AADfQF6MDEOBubPo0ebb1p44swOin
         6/SqDulC+MIK8XBwEKQnuqkSBZkp6CrSUPSu79yNOG8c7CGH+YY2wTcJWbDiIHaU0lxB
         bGCd/EAERO68uTM1v+gWmuL2WIGdzQX1q06j2JgoTO7VCDn3jM7qHmIuZmiJn0ycEzLk
         /fAg==
X-Gm-Message-State: AGi0PuZ1bvFP7q9ks3C/mcYsfRJgisr7eQ2rpHFqmQNJ5gjwoG1d+WVQ
        eIIayMBreJWJSv3Gy+WIZV17/uVE
X-Google-Smtp-Source: APiQypLaujfIxTJsoRo7VEUICDO56Rmtx+5pEdkQ3qrdfSbSfs/hUFrvkB2Zy5VKK1z62EQfsGya0A==
X-Received: by 2002:a17:902:ea8a:: with SMTP id x10mr2319840plb.328.1585822549156;
        Thu, 02 Apr 2020 03:15:49 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id nu13sm3599948pjb.22.2020.04.02.03.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 03:15:48 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 2/5] cherry-pick/revert: honour --no-gpg-sign in all case
Date:   Thu,  2 Apr 2020 17:15:31 +0700
Message-Id: <9516562b0025d23dc8642bdaa4a4f7f2a1ff4933.1585821581.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585821581.git.congdanhqx@gmail.com>
References: <20200331064456.GA15850@danh.dev> <cover.1585821581.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

{cherry-pick,revert} --edit hasn't honoured --no-gpg-sign yet.

Pass this option down to git-commit to honour it.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/git-cherry-pick.txt |  5 +-
 Documentation/git-revert.txt      |  5 +-
 sequencer.c                       |  2 +
 t/t3514-cherry-pick-revert-gpg.sh | 86 +++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+), 2 deletions(-)
 create mode 100755 t/t3514-cherry-pick-revert-gpg.sh

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 83ce51aedf..89d7a7920a 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -109,9 +109,12 @@ effect to your index in a row.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
+--no-gpg-sign::
 	GPG-sign commits. The `keyid` argument is optional and
 	defaults to the committer identity; if specified, it must be
-	stuck to the option without a space.
+	stuck to the option without a space. "--no-gpg-sign" is useful to
+	countermand both `commit.gpgSign` configuration variable, and
+	earlier "--gpg-sign".
 
 --ff::
 	If the current HEAD is the same as the parent of the
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 9d22270757..7e7f39517b 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -90,9 +90,12 @@ effect to your index in a row.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
+--no-gpg-sign::
 	GPG-sign commits. The `keyid` argument is optional and
 	defaults to the committer identity; if specified, it must be
-	stuck to the option without a space.
+	stuck to the option without a space. "--no-gpg-sign" is useful to
+	countermand both `commit.gpgSign` configuration variable, and
+	earlier "--gpg-sign".
 
 -s::
 --signoff::
diff --git a/sequencer.c b/sequencer.c
index 6fd2674632..9969355de7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -946,6 +946,8 @@ static int run_git_commit(struct repository *r,
 		argv_array_push(&cmd.args, "--amend");
 	if (opts->gpg_sign)
 		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
+	else
+		argv_array_push(&cmd.args, "--no-gpg-sign");
 	if (defmsg)
 		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
 	else if (!(flags & EDIT_MSG))
diff --git a/t/t3514-cherry-pick-revert-gpg.sh b/t/t3514-cherry-pick-revert-gpg.sh
new file mode 100755
index 0000000000..5b2e250eaa
--- /dev/null
+++ b/t/t3514-cherry-pick-revert-gpg.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+#
+# Copyright (c) 2020 Doan Tran Cong Danh
+#
+
+test_description='test {cherry-pick,revert} --[no-]gpg-sign'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
+
+if ! test_have_prereq GPG
+then
+	skip_all='skip all test {cherry-pick,revert} --[no-]gpg-sign, gpg not available'
+	test_done
+fi
+
+test_gpg_sign () {
+	local must_fail= will=will fake_editor=
+	if test "x$1" = "x!"
+	then
+		must_fail=test_must_fail
+		will="won't"
+		shift
+	fi
+	conf=$1
+	cmd=$2
+	cmit=$3
+	shift 3
+	test_expect_success "$cmd $* $cmit with commit.gpgsign=$conf $will sign commit" "
+		git reset --hard tip &&
+		git config commit.gpgsign $conf &&
+		git $cmd $* $cmit &&
+		git rev-list tip.. >rev-list &&
+		$must_fail git verify-commit \$(cat rev-list)
+	"
+}
+
+test_expect_success 'setup' '
+	test_commit one &&
+	git switch -c side &&
+	test_commit side1 &&
+	test_commit side2 &&
+	git switch - &&
+	test_commit two &&
+	test_commit three &&
+	test_commit tip
+'
+
+test_gpg_sign ! false cherry-pick   side
+test_gpg_sign ! false cherry-pick ..side
+test_gpg_sign   true  cherry-pick   side
+test_gpg_sign   true  cherry-pick ..side
+test_gpg_sign ! true  cherry-pick   side --no-gpg-sign
+test_gpg_sign ! true  cherry-pick ..side --no-gpg-sign
+test_gpg_sign ! true  cherry-pick   side --gpg-sign --no-gpg-sign
+test_gpg_sign ! true  cherry-pick ..side --gpg-sign --no-gpg-sign
+test_gpg_sign   false cherry-pick   side --no-gpg-sign --gpg-sign
+test_gpg_sign   false cherry-pick ..side --no-gpg-sign --gpg-sign
+test_gpg_sign   true  cherry-pick   side --edit
+test_gpg_sign   true  cherry-pick ..side --edit
+test_gpg_sign ! true  cherry-pick   side --edit --no-gpg-sign
+test_gpg_sign ! true  cherry-pick ..side --edit --no-gpg-sign
+test_gpg_sign ! true  cherry-pick   side --edit --gpg-sign --no-gpg-sign
+test_gpg_sign ! true  cherry-pick ..side --edit --gpg-sign --no-gpg-sign
+test_gpg_sign   false cherry-pick   side --edit --no-gpg-sign --gpg-sign
+test_gpg_sign   false cherry-pick ..side --edit --no-gpg-sign --gpg-sign
+
+test_gpg_sign ! false revert HEAD  --edit
+test_gpg_sign ! false revert two.. --edit
+test_gpg_sign   true  revert HEAD  --edit
+test_gpg_sign   true  revert two.. --edit
+test_gpg_sign ! true  revert HEAD  --edit --no-gpg-sign
+test_gpg_sign ! true  revert two.. --edit --no-gpg-sign
+test_gpg_sign ! true  revert HEAD  --edit --gpg-sign --no-gpg-sign
+test_gpg_sign ! true  revert two.. --edit --gpg-sign --no-gpg-sign
+test_gpg_sign   false revert HEAD  --edit --no-gpg-sign --gpg-sign
+test_gpg_sign   false revert two.. --edit --no-gpg-sign --gpg-sign
+test_gpg_sign   true  revert HEAD  --no-edit
+test_gpg_sign   true  revert two.. --no-edit
+test_gpg_sign ! true  revert HEAD  --no-edit --no-gpg-sign
+test_gpg_sign ! true  revert two.. --no-edit --no-gpg-sign
+test_gpg_sign ! true  revert HEAD  --no-edit --gpg-sign --no-gpg-sign
+test_gpg_sign ! true  revert two.. --no-edit --gpg-sign --no-gpg-sign
+test_gpg_sign   false revert HEAD  --no-edit --no-gpg-sign --gpg-sign
+
+test_done
-- 
2.26.0.334.g6536db25bb

