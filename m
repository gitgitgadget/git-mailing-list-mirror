Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45973C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbhLVEAG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238931AbhLVD76 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 22:59:58 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7589C061763
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:57 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso710681wme.1
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LMflRAJWFPo2LUUHCj/aRw+wr8spaxRcfqdnSadEjYA=;
        b=BX8DUjmpNUibhNeqgF2LmPBWxZiDPRs5pcWvEEYQTa0sirteK6n3gGEOcbOcFW7h2x
         KQRBIq4A23FRs67y9gecJ+K4gAIejydYqygoYHLSLEpnI0eOSy8UdIYsgJicFlpwrp1a
         o9rLapUVjPSdfNf4tXRTqZ/443yHT7rGUt1hniUBNNLCvnplh+amnPO+ySiP3pyCJ2wU
         Yh420UkXhiod9vztRM153e5K/6CFbredND3G8aL+wokfi3ie6MEfrWHrISrVjYOuiErl
         BTBdCWcJBD1dBGa+934BA8mb4aFS6CurBI1VGfX+SH884tGY82RJEXSdT3D+xZPL0ZPv
         8f/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LMflRAJWFPo2LUUHCj/aRw+wr8spaxRcfqdnSadEjYA=;
        b=lkhiQfKz9QVxqzArMI1+glaEp27vTJsAtfg51h2cecSHckm24KIvzLHf4kJ8mCXGOM
         AZ9UU4y/gLvIvRV4TxLswHS2PeiCfgqg+SP2HHus7j/w4WQLfbVSs4TshVqcggh4zfpW
         vCDZLAVyntV6QpY1jb6kaQeM98XPdCE69afHvc2VRvC1mykBJLokUS0fTMYnnEqt4Uw7
         xCsvnDYoV44TyiRTxi3R6phvY5Wy7gjZChhaG3smYpzGNrDBGafJQpPZOrUfxWwdFUp3
         u0asVhHknHpzq0fZS9q8j+INww2/jnDb9bP7CWbIOzeNj0EGq6vSGxdRCFbdpeUcUNYI
         1dDQ==
X-Gm-Message-State: AOAM532jrDW4VKUxo0JWWlVnBb6xkaADGVs/rYEodZt0IJrxOxfqGhDU
        i4Qac5u74eFCeMeGfGi6ajdVsO6ajfNVuw==
X-Google-Smtp-Source: ABdhPJxS2uhA7hvEqdPIzKJdYVg9KUT5m7YI/1MLu/RzgQxswLhsJ39LI4/TSMjAGjZahV5nogp60Q==
X-Received: by 2002:a05:600c:4e8d:: with SMTP id f13mr902771wmq.7.1640145596178;
        Tue, 21 Dec 2021 19:59:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s8sm867300wra.9.2021.12.21.19.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:59:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 12/17] send-email: use 'git hook run' for 'sendemail-validate'
Date:   Wed, 22 Dec 2021 04:59:38 +0100
Message-Id: <patch-v6-12.17-8ea3b250dff-20211222T035755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
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
index 04087221aa7..a98460bdb96 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -225,13 +225,13 @@ sub format_2822_time {
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
@@ -2075,10 +2075,10 @@ sub validate_patch {
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
@@ -2088,13 +2088,19 @@ sub validate_patch {
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
2.34.1.1146.gb52885e7c44

