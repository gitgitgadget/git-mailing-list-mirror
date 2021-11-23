Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B19C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 11:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbhKWLuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbhKWLtl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 06:49:41 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A0FC061746
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:33 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so2005354wme.0
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=83bR3ixLMYsp2AGkwxrbKZ/gxEE8MQxui3SCGPSvrRc=;
        b=f/2BHTEJp3ZqWpwz9CzwF1BRYeszxlEnA6e3m3vsseQHm5jBO+GkmeX+YAIO5ww4kn
         n47VR+cC95WudJ9AG1KeWIP5MPCT4F2/d86VkyMOELQyelMIQrxY1WGr5w6Rx6qAySlS
         OINVVkr5LU0E6Z6SiPMudVwutrOhndo+ofG8FRLzcpGrAPGr3/YcMnU1QvcHo5uwKdMT
         UlvrPY/fQreluG+yDEIhrjO3VWJ9d/Ut1hG5c0HoSuq9lX0/UY7BlsIJP9ZZATMtUlb4
         GfOBpmxNrH1kXcxgNPWcF/FONCDX9zTfb/C13xmCcSvR6opS2eMsHokOQVvtWILqKxLl
         hxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=83bR3ixLMYsp2AGkwxrbKZ/gxEE8MQxui3SCGPSvrRc=;
        b=HVyf6fIJQbUN2UdgnggDQki/ffr7d/UtJqwVPqU1jYfwehLctRhFZPPUJShviWNAz2
         frqjnnnkfBtIH8BE11YSW0IqlvLFZ3Cv2sAM86/bku9xsva+RO/h5+knBZpRWU+sQhqp
         ZJRU1Rr6OWSVzosR7CK/olDMs0gjr0KiBaHzGW5LQ0CrSF0wdC89Ek4+j97iCPVSp9/L
         EQeBWsUsULiGa9QczGltrEVjvotzqVNrv1d3Wbb53evdCz7N+Jaqvqr+eJOykfkfgfFC
         sRb+PCFwHlyidO7uObeT38dtZuZ13BrtWtMbmAg2MLUT0hhKzrUdvYh79S/Vyw6+Ghvh
         PFKw==
X-Gm-Message-State: AOAM530UMowqFCbjrTpFO0gG13dCHbCH40WocVA3z3543/orgR/cET8F
        AtUv7D5sxNxoQ0tEo+w2OT3ff5pJ0F/b1w==
X-Google-Smtp-Source: ABdhPJzSZvxL3xXdPypzInquSV8SfMjzvyz/TQagsF5s0s23bh+g+vKvJn0ys3kPBzYCeYRY2tJA+Q==
X-Received: by 2002:a7b:c1c5:: with SMTP id a5mr2218501wmj.149.1637667991392;
        Tue, 23 Nov 2021 03:46:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c11sm1723145wmq.27.2021.11.23.03.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:46:30 -0800 (PST)
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
Subject: [PATCH v5 12/17] send-email: use 'git hook run' for 'sendemail-validate'
Date:   Tue, 23 Nov 2021 12:46:11 +0100
Message-Id: <patch-v5-12.17-4e0f94d9102-20211123T114206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.831.gd33babec0d1
In-Reply-To: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
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
2.34.0.831.gd33babec0d1

