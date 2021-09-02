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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F088C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A366108E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345167AbhIBNNQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345125AbhIBNND (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:13:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABD3C0612A6
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:12:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i6so2864933wrv.2
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=joo/s8DEOqX7PV/Qs2fEu8tKGCO39ibpaiHqibIa79I=;
        b=Tt3odRUTT2af/rC3nqDv8nXFZRJ148Q0kJNGU7fteZ15ZkmR1QvGXcJAsQmO4hQ7f6
         Kc+HIM42N3TJbfwhqtEnqjtLWk4p/Q38oelOfLTf1H3YF3Qn3PL3nXB6lioUEo/NkMuf
         p46kuNrmY4yUeNYhj290f86N4X7EWuIfOMrXsLc++iVJXoZtsiqEvGV902gGvFluMp5M
         Y0kOu+bdPfkXBbT/hbC2KHsLZV7XRBU5qk8WJ4YE5MedAALTiQgkvwFsIXpM+luUEQuI
         gWSkTtCkEBrxaA/4OekYE0up3iKuNp53/QEr24tX+6lh126u5OmdKRnCycHjYEis241k
         LPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=joo/s8DEOqX7PV/Qs2fEu8tKGCO39ibpaiHqibIa79I=;
        b=Vhr6bdKwCXuaDRElAXP1m5k3UXoXTBZUkCoV/nAQMlEvEnAUzaPTPTfDi7ja/muW/E
         zgfPLHx5xkYdCrtpvmKIPnW+/jDhOVlJlgOE7p8t/yZ22zMhYUIzl5LKbC1p2f2HfZBY
         wA7/vIJx2urbOazLCXR3kDew3IYRNL8wZK1sFfTpgus6XMBekIQwB7qo5Ii1rsNUx83v
         Zy0U5VukWbM3rynCPgjJ01NN974H9nqBWhGiyjISiFgxuLxv+6aqBXX+9CCh36TyYBCT
         u74YsUyBcgw1CaHtHp4KjlmO4826a58kVPEjl21bqvgFgwE8mzEboF9APMaC9GI0HrCL
         TF0w==
X-Gm-Message-State: AOAM531sKvPPL9OAUDufKvAGaIQOko6ZTWkbdEO5bYc3VUuX5EdeitxK
        EuyPm9zLYoODkiyoL6VvRbU4v+lkBcJIyQ==
X-Google-Smtp-Source: ABdhPJwZdYsrALT+AXKXcDctfoTjEK2IsnoKC6DU9h6vtw8zncsbCcIcY/yyC29ABS3tvQIe0kAEoA==
X-Received: by 2002:a5d:55cd:: with SMTP id i13mr3635016wrw.366.1630588318143;
        Thu, 02 Sep 2021 06:11:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:11:57 -0700 (PDT)
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
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 15/36] send-email: use 'git hook run' for 'sendemail-validate'
Date:   Thu,  2 Sep 2021 15:11:15 +0200
Message-Id: <patch-v5-15.36-d4976a0821f-20210902T125110Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com> <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
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
index e65d969d0bb..126850d974b 100755
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
@@ -2031,10 +2031,10 @@ sub validate_patch {
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
@@ -2044,13 +2044,17 @@ sub validate_patch {
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
index 57fc10e7f82..9ec7d75f0ff 100755
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
2.33.0.816.g1ba32acadee

