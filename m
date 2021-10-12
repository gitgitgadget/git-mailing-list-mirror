Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81414C433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6218F61050
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbhJLNfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236920AbhJLNdP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:33:15 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642C2C061767
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:31:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i20so64599759edj.10
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4BFFKJStaje5Bteau/87786ZGo86FiscjRMM7Bq9g68=;
        b=YvE9fuPYXQZVxbUMVqmXM4M6a6/c2h1hDWz8Y65iUdOo/IR6rKh0++hWjHJFJWtmwR
         Va5zqu62G5nDfhtWwRkOEgImz4zjIZb8aCW6jl5inSepU4Y2nDF99BaulpEjAR8OpTN5
         JyDsHYVVHCDzKvfG/Z+IAVN5Gxh3PmDx3JSteLfjN1I75sdmJYuK7miRLANRL5+lRbbh
         zHP3QIPq0ewdggOR4Bh3wM0sv/K0a3feyWcwetZ8Mv0MZjyRPLX2HQ0eRU/yeNzqNlvc
         R9vBizPRx/BqnWB7RzhId7iS6V6THb6GbrFuS9U9vuNhlGt6u/hC1oVroy9DdLxV3cEP
         u3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4BFFKJStaje5Bteau/87786ZGo86FiscjRMM7Bq9g68=;
        b=Gn/F/467QGUMqcw6DEoI8UMeags7tpyGPyXVlFz51QBplmAJDe6wHmmN8fp7q3lIcy
         OTUjEFZaQxSf7+r/BIdWs1sFuBon0SLJVh4LE3NDEt2GE15RZyGi0WjazHqHo0dsKfpD
         asS+yD1WzlbAp6iAQGt31Rh71+1vqDlCBrBOrAWhcEOk7xH75B3ae5b4slXLvbXagiYm
         MYWrt5j/ivwz0DgH8z/iS3i/J8wMbJnVAixzjgGEY4fXbOT4V7Fsq1c/QSqEosmvbLos
         /dF1MA1MoEoQbj8X/PF1E7QESKXplEALPlwJlwZ13xZdtPCvjpfbTk5pKPkeH/GjAHeI
         7w+w==
X-Gm-Message-State: AOAM5303paMAljTtP44d+nfC0ZPDozq8YHn9qToMyAQLN5ZvRbEbMLvI
        911xe6Akb3TbaPxzhwdi1ahPwkA3CuUCqg==
X-Google-Smtp-Source: ABdhPJwo6miv0M5QMDErY8SfYCxdmexZJTPkOOyttRWrqsRZkO0KB0v7CWDtGwp6dIm4hoI3n7Y8Vg==
X-Received: by 2002:a17:906:fc7:: with SMTP id c7mr32830806ejk.333.1634045465174;
        Tue, 12 Oct 2021 06:31:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bi23sm2016405ejb.122.2021.10.12.06.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:31:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Luke Diamand <luke@diamand.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/13] send-email: use 'git hook run' for 'sendemail-validate'
Date:   Tue, 12 Oct 2021 15:30:33 +0200
Message-Id: <patch-08.13-1d30e2dbbe0-20211012T131934Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
In-Reply-To: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
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
2.33.0.1567.g7b23ce7ed9e

