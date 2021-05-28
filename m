Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9603C47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC6B4613E6
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbhE1MNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbhE1MN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:13:29 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C28C0613ED
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:53 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x8so3068500wrq.9
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BDpqV0yBXKPaX/BTacQ2XgGOr5OICnJ0IhKZ/EXa8Jg=;
        b=CpEGfcaJDy4tU7TZ06tFa43SuaLTaVugRrSX77QLlRmhjmUqSGJCjaR5VLAr/acy0I
         1g1PhMENciC8TpCPgpLn6De7/vPN/zeM3ArGKEgwNAfej+LXhe32+gDDH9PT+0CY0JzG
         wn5z3li7a/WwEOVTB8Wsfn9CC9q2JSdT4aIwCLw5YdCPUr92z9UYAhu1IjHnZXL5goke
         PKeQlDb7k94z2jgdfZwUDi6ZTUK9+i5V6ElG92yJrQohVUqlKDX1s25DNPbmqLJ3asPj
         e3kWKO5g9HiHG+v8APi2pzQ60JFTrKbii0Nw96I4NfBwmZVhaX6qu4nJhdMeD8+Y9PzA
         HLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BDpqV0yBXKPaX/BTacQ2XgGOr5OICnJ0IhKZ/EXa8Jg=;
        b=TVp+edRCk3ZwPI98RLRQG/glweOMpYwHXoceVISO1g3wOyRD7FKtaql2sq0NssuwIO
         549ZqP4druaGl+cYRPQogy90oFELzcA7RFuyQFsz/uKkNxB18pmWaexapnUH3L1XrpcM
         YJKvzLrKLxJcVKnxR+IJkgtBMF8Fm/E7HxemSfwN14nm/vtT5i/7QttobKYnUBGRX+tD
         C7DoGittHzbJY/KVXJ5WibRgCMlVrcMxoXF/+R7R6Gv/pn93lsxdOnmLdioDdql14nwv
         2olih1uHDxzJQO9tt6P0ChKlgYgtcZ90CfK45yND9imFvHFl1Z7ThvrvK4d7ZFhtbWPo
         3NpQ==
X-Gm-Message-State: AOAM5333+NQ1nSsRVaPWxIYt33MPIOHsvyM2yBwKV3f3mYEZrJxSYzl1
        Dfq0JEJ0OxBS59zKLWpii4rhVbm6+Y4Pbg==
X-Google-Smtp-Source: ABdhPJyXL2jHWuNh3M7Nsh3ds2fydAb7EJTXTE2H0lLFUOSca/26Wne4E6jQMROSZKiTViOmDJgRxA==
X-Received: by 2002:a05:6000:104a:: with SMTP id c10mr8475079wrx.45.1622203911413;
        Fri, 28 May 2021 05:11:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:11:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/31] send-email: use 'git hook run' for 'sendemail-validate'
Date:   Fri, 28 May 2021 14:11:14 +0200
Message-Id: <patch-12.31-8795e9ceab8-20210528T110515Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.460.g26a014da44c
In-Reply-To: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com> <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
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
 git-send-email.perl   | 20 ++++++++++++--------
 t/t9001-send-email.sh |  4 ++--
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 25be2ebd2af..2ab8dfdbded 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -213,13 +213,13 @@ sub format_2822_time {
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
@@ -1959,9 +1959,9 @@ sub validate_patch {
 	my ($fn, $xfer_encoding) = @_;
 
 	if ($repo) {
+		my $hook_name = 'sendemail-validate';
 		my $hooks_path = $repo->command_oneline('rev-parse', '--git-path', 'hooks');
-		my $validate_hook = catfile($hooks_path,
-					    'sendemail-validate');
+		my $validate_hook = catfile($hooks_path, $hook_name);
 		my $hook_error;
 		if (-x $validate_hook) {
 			my $target = abs_path($fn);
@@ -1970,13 +1970,17 @@ sub validate_patch {
 			chdir($repo->wc_path() or $repo->repo_path())
 				or die("chdir: $!");
 			local $ENV{"GIT_DIR"} = $repo->repo_path();
-			$hook_error = system_or_msg([$validate_hook, $target]);
+			my @validate_hook = ("git", "hook", "run", "--ignore-missing", $hook_name, "--", $target);
+			$hook_error = system_or_msg(\@validate_hook, undef,
+						       "git hook run $hook_name -- <patch>");
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
index 3b7540050ca..35b513c015f 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -539,7 +539,7 @@ test_expect_success $PREREQ "--validate respects relative core.hooksPath path" '
 	test_path_is_file my-hooks.ran &&
 	cat >expect <<-EOF &&
 	fatal: longline.patch: rejected by sendemail-validate hook
-	fatal: command '"'"'my-hooks/sendemail-validate'"'"' died with exit code 1
+	fatal: command '"'"'git hook run sendemail-validate -- <patch>'"'"' died with exit code 1
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
@@ -558,7 +558,7 @@ test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
 	test_path_is_file my-hooks.ran &&
 	cat >expect <<-EOF &&
 	fatal: longline.patch: rejected by sendemail-validate hook
-	fatal: command '"'"'$hooks_path/sendemail-validate'"'"' died with exit code 1
+	fatal: command '"'"'git hook run sendemail-validate -- <patch>'"'"' died with exit code 1
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
-- 
2.32.0.rc1.458.gd885d4f985c

