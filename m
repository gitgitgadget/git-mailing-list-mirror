Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBA4C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 10:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EAD20787
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 10:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKAVCaAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390541AbgDCK2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:28:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42594 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDCK2g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 06:28:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id 22so3272137pfa.9
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 03:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TfiCFBcEscmFgaoXbzjzBdCQMTmRszXm0lpXzuORUks=;
        b=FKAVCaAIA2xsxCtWaVUfKg1sH2Q412uUqAz3j6/nM0eJWOvTNoQWw2KIRPtMsbOPT2
         XFphZ1Np//tbONY+L49IaICj5/3HLM7wXRnzRMawHn0FucuoP10vWKHk1hEnjen+FziN
         3dU9OgDHZe7gReAHcNpCU048Nt5/715KURhhwyvRHlWUBTZ31dwZYv4AicwRpJ0iYpiR
         jTpogOgWasg+9MqA+21JyCrTzTkowI1TVfUahaRdmNoxlLd3kL66EzqJMBp2meD0ZMVV
         6Rm2U0nURibmqaIK+VHv/mXxpFROVR2lniypIhX7g7UshAlCesHUB4vfMb9p2GxO1e44
         CSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TfiCFBcEscmFgaoXbzjzBdCQMTmRszXm0lpXzuORUks=;
        b=VBAETOZtpwA/7yWE9Jx55O79QmwFEEBAkNEok/eEKLgKNWCKiqOuDkgyCHu/b0NLr+
         KOtUPfhxX/ZoQgeqW7+K7l/0UrJi50ko/I+a2WpNpm+XeIxtovKC1ara8hcv+vQVQEDg
         rsHahN2lT/62BxBsG4jAjHBtahbVLxwDc+YjcycUBzmHRuQmP1C1OAA6IBeGm9gGDxCA
         MkeRJEQsGhKR7oqWf5OeMIw7vrSoWwq+IQqef9IxKdCPfbYRqlOx1NJAXsuX4znbhsJM
         A1tXfuWsd6QtilyTR7ml5PAClBvvGYlQhbdq1g44e1KAnWP8aeJQ+99dUVflkiDdZwY8
         AVuA==
X-Gm-Message-State: AGi0PuY9lcCjMwQLxx9KGCb1KMkHcXVkocUwvRam2pha9HMZGnZ4XFk1
        wnN97Snyp4c4bx3qZUkJjXjvL3yC
X-Google-Smtp-Source: APiQypLL8akxQSqUp243IH1FQwjZaTkpyYKvw7b27X/djkIYCY0GbqMeo/pSbdnw2d+Fs6BghGqvjA==
X-Received: by 2002:a63:7c16:: with SMTP id x22mr7489008pgc.172.1585909715500;
        Fri, 03 Apr 2020 03:28:35 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id c21sm4958126pgn.84.2020.04.03.03.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 03:28:35 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 2/6] cherry-pick/revert: honour --no-gpg-sign in all case
Date:   Fri,  3 Apr 2020 17:28:03 +0700
Message-Id: <28ebbfe72a04b787fb92702199efea663a6b7ee5.1585909453.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585909453.git.congdanhqx@gmail.com>
References: <20200331064456.GA15850@danh.dev> <cover.1585909453.git.congdanhqx@gmail.com>
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
index 83ce51aedf..75feeef08a 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -109,9 +109,12 @@ effect to your index in a row.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
+--no-gpg-sign::
 	GPG-sign commits. The `keyid` argument is optional and
 	defaults to the committer identity; if specified, it must be
-	stuck to the option without a space.
+	stuck to the option without a space. `--no-gpg-sign` is useful to
+	countermand both `commit.gpgSign` configuration variable, and
+	earlier `--gpg-sign`.
 
 --ff::
 	If the current HEAD is the same as the parent of the
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 9d22270757..044276e9da 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -90,9 +90,12 @@ effect to your index in a row.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
+--no-gpg-sign::
 	GPG-sign commits. The `keyid` argument is optional and
 	defaults to the committer identity; if specified, it must be
-	stuck to the option without a space.
+	stuck to the option without a space. `--no-gpg-sign` is useful to
+	countermand both `commit.gpgSign` configuration variable, and
+	earlier `--gpg-sign`.
 
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

