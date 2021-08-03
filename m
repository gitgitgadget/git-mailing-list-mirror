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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B7FC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B2EB60EE8
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240197AbhHCTj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240196AbhHCTjj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:39 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB1FC0613D5
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:27 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso2441520wmg.4
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lA/GciJUmH/qCBPPiz7AGNvVtgWXz38AQgNSnm6L2+I=;
        b=QsSCoWF6a0awAzCksV5SiuknckAgvIOGeKqIAA1ZBxev6ECBL4Fxbz4Xlhur4gnrS3
         uD+N3rC0ak/XNbbcvr+rBlV6pxrUkfQNi3ZluAC7iNWUpofJ9dsZK831YUDQZWHcFlar
         wwYTmoR2Stw79GUVK9YDx4yBNLUAc3cmuybi4Rp1R+TP9kjdmTv9byntMlk9/L495ca1
         mV/XzFIjYRoUlpHvNp+1EJi9gYjGWm98nxXsdqLzbK7xKmaPQLeVHl3UyjJ1C6Z6YX6J
         Pl7/ABpXcMyS2AceOgI3NLodWrLHcLWDI9ERXwUfta+MY0akOa/3LC9BGTpLQOSjT50z
         T52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lA/GciJUmH/qCBPPiz7AGNvVtgWXz38AQgNSnm6L2+I=;
        b=kpVvQxoEgouaZAz/A/sDLFHouJOGfuLe756O+m35Yhz35d51mueyVDSNJq5JaHcY9P
         4k+Jt9sGbq+4F7CiKLAN91qM/+oWw6DHwWSHQu9Erklx0Hw1GEJ+oc2EI8crXGWgbBI+
         ZF3H1B34ZpaIEWQ6Hov2rUvNwcLmMbl0z3vjU+5T3p3pX300XrJhQAJs9L9vp7Beacet
         banXIsuItEJt8wU/PITzrsMVWbLy66cRMBe+Ftrv33HdoVJG3up/P0zBHBehAkoXRns6
         dUh+pjL3iER49Z3QPyA6kiPI/2pAOMqIaViRNr2ACt0I0+OFbjCCqYU81my1ZMK/kCC5
         W9aw==
X-Gm-Message-State: AOAM5330RtYznrWbxpDjIVHjCtjVxllRn1CjbeeBcMv1VECVbgIa/z/5
        iEp03uGYMjyHb+JO58fiw2Pww25N3UpEUA==
X-Google-Smtp-Source: ABdhPJwzFIW5tVh+BVcznYkjmSYNCBarpP1eH3RSzmwGj7XBSQZ9HXmaak71JeNxJna3RIB70bMApQ==
X-Received: by 2002:a7b:cb13:: with SMTP id u19mr23483818wmj.122.1628019565672;
        Tue, 03 Aug 2021 12:39:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:25 -0700 (PDT)
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
Subject: [PATCH v4 15/36] send-email: use 'git hook run' for 'sendemail-validate'
Date:   Tue,  3 Aug 2021 21:38:41 +0200
Message-Id: <patch-v4-15.36-5b66b04bec7-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com> <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
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
2.33.0.rc0.595.ge31e012651d

