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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD82C2BA17
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 10:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229C9208E4
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 10:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYKBRpdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390504AbgDCK2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:28:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34384 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDCK2f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 06:28:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id v23so385089pfm.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 03:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JnFTjtfieg1I1m3De+/JhaHJBf3ebLw/Fn4BrFMog6s=;
        b=pYKBRpdxgZCdmFr76YnS/KEyFHVaF9hUbfzJXZn6sCSIzI6A9bc//Bg4Z31qaw7Y5Y
         oGsDyHuhE+b3at0c76mBguOlDEuCzn6ck8MaH+1KuMu7KwRuCNuPNAMKa0NRhdOG/wyk
         fZfiEhmQ74Ny1hzJBXSQJ0XvsQUM4g0ZQIe6VTO1JsAxQHgZBQs+saBREeNKvndBzpMn
         JsFflTnWlZEkVPRI/9GgRbWEUDYg227bB2n1zTuhAaRrVIhADF6y1j2lt3vvkh/an9kd
         i2+narDkUlSZx4raL8kBkyCI0aFAGTldBlaLwsUrJ0bay/R4ei/dGN/7jzn/bMeojA4/
         TrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JnFTjtfieg1I1m3De+/JhaHJBf3ebLw/Fn4BrFMog6s=;
        b=KSyDYsVR6s0sLNyCgr+ViDENpRoRklJeEF6M1jrz5M4cF0pLTzDCGhRMiryixlT/sE
         W92NeaRoaVtb0Fn06mlqqQnWE4ZP8TOPhz6hLiFZV2pXztqLfMQThruihU7IvGVR+HAI
         AZz9xmGC5SPN3N1Dp3Gq/CaOrXHsVfqYzQbi3wgRfc8u7WFMgGa93Tt2RRiCuo8B+13L
         cVET8jDaBTZ93E+Jss6/CWnEODAt+gd5jJ5SZBYopK/ECc0kFWvc70Sbd2ZRu8R3cFyq
         6d+wb2tJ12LNUWPySch6k4QVHyP5U4XtqUMbnxKhEawW6AEodLPcdKJ7yuN3yuovGL85
         CCxw==
X-Gm-Message-State: AGi0PuaE/tOvlIgB76bler3KIs52psbgO5+zNveyXnTJWaWyGF1QpNxt
        dH3olU8BMMGxO6V3tCzhio+TuxZQ
X-Google-Smtp-Source: APiQypKauJwlC+18R4a9ly06p8PhsxLBTWrBrk5fQL4Ihws0f+LIYX3n0GBz+IHZIru/XKlt6k14sw==
X-Received: by 2002:a63:2989:: with SMTP id p131mr7650944pgp.281.1585909714036;
        Fri, 03 Apr 2020 03:28:34 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id c21sm4958126pgn.84.2020.04.03.03.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 03:28:33 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 1/6] rebase.c: honour --no-gpg-sign
Date:   Fri,  3 Apr 2020 17:28:02 +0700
Message-Id: <b601c99f7b947aa86c10976d9ebcef8e7a917b9b.1585909453.git.congdanhqx@gmail.com>
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

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/git-rebase.txt |  5 ++-
 builtin/rebase.c             |  7 ++--
 t/t3435-rebase-gpg-sign.sh   | 71 ++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 4 deletions(-)
 create mode 100755 t/t3435-rebase-gpg-sign.sh

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f7a6033607..19e280f93f 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -354,9 +354,12 @@ See also INCOMPATIBLE OPTIONS below.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
+--no-gpg-sign::
 	GPG-sign commits. The `keyid` argument is optional and
 	defaults to the committer identity; if specified, it must be
-	stuck to the option without a space.
+	stuck to the option without a space. `--no-gpg-sign` is useful to
+	countermand both `commit.gpgSign` configuration variable, and
+	earlier `--gpg-sign`.
 
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

