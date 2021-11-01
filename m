Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223EFC433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0323060EE9
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhKATCT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbhKATAl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:00:41 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D415C061229
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 11:56:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso480695wmh.0
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 11:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JfY+bFqCONWSOECkngNmAvGoK4qO2SA8wAsKCpzqfDE=;
        b=RGxGbUZqhbHtHXWEXt7LBLFc604irGwgt7xyZZSSFoZ/0da0vOOBR7FeJRr6pS3Bn8
         jq4Z4Nduar/1kekKmFr34ytxUQHxJU2/IsWPAKV0wmmsxEnw1GqonWZUO9hmMwjcIdTV
         2YkWE/p/eR3vgRBDY7xE3K2E1JxmgkZYde45iDV2Iqr3vEe61EsCrqws43Xwa1JzL09Q
         +UWVmrpgMQKDMMgnN9E8360v11Z6Xt+zpXsWlgFxdKndhUv6U+RJGazFmmrO9uCO5zhA
         IolIGkYXveuyGy6sxRwMM14ZVwi+xxPB7zGjANT9m+7DgpNonWZbkYRRIFi4la5TQslO
         y04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JfY+bFqCONWSOECkngNmAvGoK4qO2SA8wAsKCpzqfDE=;
        b=bdYMZS+PYAZbqf5bF9Lpq07Zw844Jd7dwTYt5ZTATniD4lQ2BWgvEGNYVPRJIQKjaW
         uFjJ9zlkZjXQwuKIvsvobo7jdtOvmazdpuAZKtdaJlTXIdVDz3jVCvXmoCQL4O0g00G8
         IUttxW/qmBqRXpXn1gqOV0FIYKYdkMkVwiZz2IQOoALJ7rCHhqnZpWLefQwLf8gauuQb
         Lm5XEkl/C1H2Tgv3UXFJ0u+i1nOzWu782aPtQDPgAbQBZgxY2jpCkZK3lYqo2f/XKQ7g
         NfATcyz2N2qZG1KiJTxXSZN9iIBmvchCTOIwAEdXu0NfSKUGfsamaO6I8HwRexQksgMj
         qxvQ==
X-Gm-Message-State: AOAM533JRfH10B7SPEpfVrGupcdzct6r0XlnczIqlfUnOhS5i/Zk7baq
        ccc47oJCRMR/yuMyqmGITSvtEnML0PgKBNRZ
X-Google-Smtp-Source: ABdhPJysWDo8tsyMBCIilj3nmQ3JlAlrVqWqOYZYg8r7oqTRnPkjVJt7C+tKIBBMiGnu3RG2qvXmsQ==
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr830223wmi.11.1635792994401;
        Mon, 01 Nov 2021 11:56:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14sm314185wmq.4.2021.11.01.11.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 11:56:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 12/17] send-email: use 'git hook run' for 'sendemail-validate'
Date:   Mon,  1 Nov 2021 19:56:17 +0100
Message-Id: <patch-v4-12.17-efa35971e9f-20211101T184938Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
References: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Change the "sendmail-validate" hook to be run via the "git hook run"
wrapper instead of via a direct invocation.

This is the smallest possibly change to get "send-email" using "git
hook run". We still check the hook itself with "-x", and set a
"GIT_DIR" variable, both of which are asserted by our tests. We'll
need to get rid of this special behavior if we start running N hooks,
but for now let's be as close to bug-for-bug compatible as possible.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl   | 22 ++++++++++++++--------
 t/t9001-send-email.sh |  4 ++--
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5262d88ee32..4c20c0bbb79 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -195,13 +195,13 @@ sub format_2822_time {
 my $editor;
 
 sub system_or_msg {
-	my ($args, $msg) = @_;
+	my ($args, $msg, $cmd_name) = @_;
 	system(@$args);
 	my $signalled = $? & 127;
 	my $exit_code = $? >> 8;
 	return unless $signalled or $exit_code;
 
-	my @sprintf_args = ($args->[0], $exit_code);
+	my @sprintf_args = ($cmd_name ? $cmd_name : $args->[0], $exit_code);
 	if (defined $msg) {
 		# Quiet the 'redundant' warning category, except we
 		# need to support down to Perl 5.8, so we can't do a
@@ -2039,10 +2039,10 @@ sub validate_patch {
 	my ($fn, $xfer_encoding) = @_;
 
 	if ($repo) {
+		my $hook_name = 'sendemail-validate';
 		my $hooks_path = $repo->command_oneline('rev-parse', '--git-path', 'hooks');
 		require File::Spec;
-		my $validate_hook = File::Spec->catfile($hooks_path,
-					    'sendemail-validate');
+		my $validate_hook = File::Spec->catfile($hooks_path, $hook_name);
 		my $hook_error;
 		if (-x $validate_hook) {
 			require Cwd;
@@ -2052,13 +2052,19 @@ sub validate_patch {
 			chdir($repo->wc_path() or $repo->repo_path())
 				or die("chdir: $!");
 			local $ENV{"GIT_DIR"} = $repo->repo_path();
-			$hook_error = system_or_msg([$validate_hook, $target]);
+			my @cmd = ("git", "hook", "run", "--ignore-missing",
+				    $hook_name, "--");
+			my @cmd_msg = (@cmd, "<patch>");
+			my @cmd_run = (@cmd, $target);
+			$hook_error = system_or_msg(\@cmd_run, undef, "@cmd_msg");
 			chdir($cwd_save) or die("chdir: $!");
 		}
 		if ($hook_error) {
-			die sprintf(__("fatal: %s: rejected by sendemail-validate hook\n" .
-				       "%s\n" .
-				       "warning: no patches were sent\n"), $fn, $hook_error);
+			$hook_error = sprintf(__("fatal: %s: rejected by %s hook\n" .
+						 $hook_error . "\n" .
+						 "warning: no patches were sent\n"),
+					      $fn, $hook_name);
+			die $hook_error;
 		}
 	}
 
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index aa0c20499ba..84d0f40d76a 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -539,7 +539,7 @@ test_expect_success $PREREQ "--validate respects relative core.hooksPath path" '
 	test_path_is_file my-hooks.ran &&
 	cat >expect <<-EOF &&
 	fatal: longline.patch: rejected by sendemail-validate hook
-	fatal: command '"'"'my-hooks/sendemail-validate'"'"' died with exit code 1
+	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <patch>'"'"' died with exit code 1
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
@@ -558,7 +558,7 @@ test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
 	test_path_is_file my-hooks.ran &&
 	cat >expect <<-EOF &&
 	fatal: longline.patch: rejected by sendemail-validate hook
-	fatal: command '"'"'$hooks_path/sendemail-validate'"'"' died with exit code 1
+	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <patch>'"'"' died with exit code 1
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
-- 
2.33.1.1570.g069344fdd45

