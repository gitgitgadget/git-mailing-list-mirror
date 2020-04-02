Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB738C10F26
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 10:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE5F2077D
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 10:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmEaN0H2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387716AbgDBKPt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 06:15:49 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39949 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgDBKPt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 06:15:49 -0400
Received: by mail-pj1-f65.google.com with SMTP id kx8so1322211pjb.5
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 03:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YDm9IctFq3zUMcF5grU0Y4i/PTn9uSS/uBA/jufTMUo=;
        b=HmEaN0H29IovnSisbWLGrIqoP4Nw7VN0T0xvjvzfK+Q0t9x1pdW6KW35EHdeIb5LFz
         ZIVR+P4A6jNqSU+7IVttPqdBKu/i40qxW8YJlvjd5bCZQWNmHJRx2MOnFcMOw1+9ZfEv
         +E2pAFy6nfuQUoSzn0RtyvKwQ0etdiLVv0n3KIMlaoXIqzODBamd3KgFyDj35KhS/5a1
         /6DERQaE2rS+DXEegQn8rPsmHxo6Grchpo3mGKrbd7+k5FenkuCtT+sZtWDIy/adxhdc
         N++CwbKCUQqcexU9ydd8PZibbOL6Nkwxs14NmTYZPW2RAaHt9venaTTHsMjPmruZ7dQR
         XBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YDm9IctFq3zUMcF5grU0Y4i/PTn9uSS/uBA/jufTMUo=;
        b=RPnQ8+ZFpcfPaCprdJZU2zb9fxJMEVI6+v085HjmqJCAWcKUUsDAd6aZsu7UeFGqbM
         sE4U9i+yB31XraLmstwdnlY1sQPcxaqNRB8+W/db8eK2MKwKD234ytYjsQV+1QI4o85N
         FAFuHsPLkrVlRc3RD+jCMUQvq9hWSF9zgf1cJZzn5dffwjyNhP3WGQaI4RX/OA+VtggR
         Qdn1d52UR9Iuzt+dD8d5lUCgxsJBpXFubnW/7IVcQbhgSekybyTZA3sc773r03l9C8O/
         H4YhOY8F89Nv165meqq0i9TgAh+W+LlsnSOBgkmM+l9C9ySG8BsDcjXKq6ynxG01Cn4u
         1Pjw==
X-Gm-Message-State: AGi0PubniB0aZ/t+VVzsofVjUSebFB/DIrMWx0dIaWDhOSvr58GYqx1W
        mBisKCwmCHjVGnlwuTItVVzG57e4
X-Google-Smtp-Source: APiQypKeZKN4n40RXRjJB475gdEBKz+hWFuXZRwY/PnxsqN1rUnGGxlMGiikF7qBN4iCetguM0C1Ug==
X-Received: by 2002:a17:90a:304:: with SMTP id 4mr3053085pje.28.1585822547654;
        Thu, 02 Apr 2020 03:15:47 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id nu13sm3599948pjb.22.2020.04.02.03.15.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 03:15:47 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 1/5] rebase.c: honour --no-gpg-sign
Date:   Thu,  2 Apr 2020 17:15:30 +0700
Message-Id: <9975d4c61301f865dbd6aa3e1f70c6b5cc64daf0.1585821581.git.congdanhqx@gmail.com>
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

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/git-rebase.txt |  5 ++-
 builtin/rebase.c             |  7 ++--
 t/t3435-rebase-gpg-sign.sh   | 71 ++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 4 deletions(-)
 create mode 100755 t/t3435-rebase-gpg-sign.sh

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f7a6033607..3b94c134fe 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -354,9 +354,12 @@ See also INCOMPATIBLE OPTIONS below.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
+--no-gpg-sign::
 	GPG-sign commits. The `keyid` argument is optional and
 	defaults to the committer identity; if specified, it must be
-	stuck to the option without a space.
+	stuck to the option without a space. "--no-gpg-sign" is useful to
+	countermand both `commit.gpgSign` configuration variable, and
+	earlier "--gpg-sign".
 
 -q::
 --quiet::
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 27a07d4e78..7e2ad66e9e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1593,6 +1593,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	options.allow_empty_message = 1;
 	git_config(rebase_config, &options);
+	/* options.gpg_sign_opt will be either "-S" or NULL */
+	gpg_sign = options.gpg_sign_opt ? "" : NULL;
+	FREE_AND_NULL(options.gpg_sign_opt);
 
 	if (options.use_legacy_rebase ||
 	    !git_env_bool("GIT_TEST_REBASE_USE_BUILTIN", -1))
@@ -1823,10 +1826,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.empty != EMPTY_UNSPECIFIED)
 		imply_merge(&options, "--empty");
 
-	if (gpg_sign) {
-		free(options.gpg_sign_opt);
+	if (gpg_sign)
 		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
-	}
 
 	if (exec.nr) {
 		int i;
diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
new file mode 100755
index 0000000000..b47c59c190
--- /dev/null
+++ b/t/t3435-rebase-gpg-sign.sh
@@ -0,0 +1,71 @@
+#!/bin/sh
+#
+# Copyright (c) 2020 Doan Tran Cong Danh
+#
+
+test_description='test rebase --[no-]gpg-sign'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-rebase.sh"
+. "$TEST_DIRECTORY/lib-gpg.sh"
+
+if ! test_have_prereq GPG
+then
+	skip_all='skip all test rebase --[no-]gpg-sign, gpg not available'
+	test_done
+fi
+
+test_rebase_gpg_sign () {
+	local must_fail= will=will fake_editor=
+	if test "x$1" = "x!"
+	then
+		must_fail=test_must_fail
+		will="won't"
+		shift
+	fi
+	conf=$1
+	shift
+	test_expect_success "rebase $* with commit.gpgsign=$conf $will sign commit" "
+		git reset two &&
+		git config commit.gpgsign $conf &&
+		set_fake_editor &&
+		FAKE_LINES='r 1 p 2' git rebase --force-rebase --root $* &&
+		$must_fail git verify-commit HEAD^ &&
+		$must_fail git verify-commit HEAD
+	"
+}
+
+test_expect_success 'setup' '
+	test_commit one &&
+	test_commit two &&
+	test_must_fail git verify-commit HEAD &&
+	test_must_fail git verify-commit HEAD^
+'
+
+test_expect_success 'setup: merge commit' '
+	test_commit fork-point &&
+	git switch -c side &&
+	test_commit three &&
+	git switch master &&
+	git merge --no-ff side &&
+	git tag merged
+'
+
+test_rebase_gpg_sign ! false
+test_rebase_gpg_sign   true
+test_rebase_gpg_sign ! true  --no-gpg-sign
+test_rebase_gpg_sign ! true  --gpg-sign --no-gpg-sign
+test_rebase_gpg_sign   false --no-gpg-sign --gpg-sign
+test_rebase_gpg_sign   true  -i
+test_rebase_gpg_sign ! true  -i --no-gpg-sign
+test_rebase_gpg_sign ! true  -i --gpg-sign --no-gpg-sign
+test_rebase_gpg_sign   false -i --no-gpg-sign --gpg-sign
+
+test_expect_failure 'rebase -p --no-gpg-sign override commit.gpgsign' '
+	git reset --hard merged &&
+	git config commit.gpgsign true &&
+	git rebase -p --no-gpg-sign --onto=one fork-point master &&
+	test_must_fail git verify-commit HEAD
+'
+
+test_done
-- 
2.26.0.334.g6536db25bb

