Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C896EC49361
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF09F61057
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhFQKZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhFQKZb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:31 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283E9C0617AD
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:17 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id df12so771988edb.2
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G8dO6wJi/v/+/qmdQwVbTmJWMQp/M50ti1LojmYp6C4=;
        b=ZjvUvmZyXsKl1q38AdfZU2hOLkinFCha4i94p7eAEUo6PMx0vZnGzc1tE4bSG5CC+F
         EZLS0U1yGcJWb4gmnI4DYkl/H9PaxCzKP27am9W+/EZwA93uZjUvin1LtJyDX/zBdvJZ
         ToXG9KhsY1WeJ9kki/fb68LrnPfoJJrQ49jcG5IHo442NJXtfS8pva4zFWl37srfLFQ/
         05Ikzotog/4x1sFHqNhMf2ZaKqdX2NGph+EmxPMiR29bkCdFnzPXxub+bNWlMX5vzhiT
         rYGRjeZ8s9f+KqAs3uoh9qpT+5HI2LB/N0a9nGUqgCmijmxImiVZ8fBBJh/jyQGKLXZ7
         MzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G8dO6wJi/v/+/qmdQwVbTmJWMQp/M50ti1LojmYp6C4=;
        b=cSuJ+28FXdgX5a1jTCDvpovTZrGmyYuEp5RrTkBs1vDg/Y/Wgns/Xh5UByOW6YDTgU
         bmi8t2vq3o2ypvhtyG8Kx7OTUw56kXXOwJp9j5uDIlVZVVPKRVCei7v1ugzibqXaQj2a
         jMkSRkLCWS4FLzaHmE817+g6jc9304UdRc+4bO9/JK6OJ6enEtpAKCzwfy+6dja1SJfF
         BClALhnxZE+o1HQFPrVZz9gKx8Kmb/vEEt931yXXEtfybCfChLkgbXFGUPyXaOEMlZuI
         sMrTvQQS/sT1g8KN3qlT+819crXXq238sGv7BKohiJY696jLZSHtBJNmnGGCNiQ0cuqM
         YbdA==
X-Gm-Message-State: AOAM5307rfCUUAWh1s1tJk8p3Fwye8DrIG3q7oqKwIbF/Fr74/3xN4ey
        qIYzPn8NhqzZVeD0bVYICFCwkjI4N7Nf2g==
X-Google-Smtp-Source: ABdhPJwXBGj2g657wdNog7OIjVsa+VS4o3x9q+Z3bG/UENny/hdP9ZkRYyQ8FbwiijZAfVpqTHacXA==
X-Received: by 2002:a05:6402:1cad:: with SMTP id cz13mr5439196edb.67.1623925395504;
        Thu, 17 Jun 2021 03:23:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:15 -0700 (PDT)
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
Subject: [PATCH 08/27] send-email: use 'git hook run' for 'sendemail-validate'
Date:   Thu, 17 Jun 2021 12:22:42 +0200
Message-Id: <patch-08.27-71d209b407-20210617T101217Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
References: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com> <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
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
index 7ba0b3433d..9e47430403 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -214,13 +214,13 @@ sub format_2822_time {
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
@@ -1979,9 +1979,9 @@ sub validate_patch {
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
@@ -1990,13 +1990,17 @@ sub validate_patch {
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
index 30eff725a9..6d4e25df8d 100755
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
2.32.0.576.g59759b6ca7d

