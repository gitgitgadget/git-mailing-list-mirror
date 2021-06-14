Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EBEC4743C
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF3646145C
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbhFNKkR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:40:17 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:42930 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbhFNKhK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:37:10 -0400
Received: by mail-wm1-f54.google.com with SMTP id l7-20020a05600c1d07b02901b0e2ebd6deso12495033wms.1
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WqB5TOSPl2zwh8YNxAlEV2KiLZYYnpFRMKrG+o1Ixfg=;
        b=qSL7IVsFpSF6YGXPRK7DqbFkF6KprrBhwC8MkqOD9pz60zs+oO6+AFHWLZYu5PZBbR
         tUgPI35fzKVUG2R2gWZ/LOM860bivUR0QCBnMXdyK7ptBniO84F1IZ+lYgNFYh6QbzNi
         blRXwcODRjNAwAUHAayyJGezpkigeAlK4jwgQck6qt80RJ6qi1h7UDaSA/ce+lWOL3Y6
         brNnZVwsQdP86NrQQ4tI8ltVxQ0l+8vNTX5avwpzn62ZIFd8RDTdtR4QJZciLxXshtQH
         1yK0speehHTQLshhDMNbFo0hl33lu3EwEEsmdC7dMDVzt6fz0ch7agJ8QkwkGwCL8i8G
         KTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WqB5TOSPl2zwh8YNxAlEV2KiLZYYnpFRMKrG+o1Ixfg=;
        b=kvfIZ42g3H/QJcP82U01PD0ngJQFMRZxuag/9EC/LzKclpAt8UewpFQE5R4mXr2CuQ
         f9hik6RswrqJV6VMTTt1Oux91zGORXWbQr5AnO3a9V4hf8WtlNBW/D/PPLfiUkZjzova
         L/P867a0PGnnT6Vz3DTwHXssprXEZqRxvxJHPYZIP/c3dXJI0HrwCtWJBR0lDwnGkkOv
         qUMo4lzPEjh0MZSqTpFi3vFjPgn6kTnhAvq6e7XqZ28d/Z3mMlMYqpfyxyXA8ltzSmUU
         U5QmUKcrairdESdmiqnZUb2b9l37+O/GXkoNF58YlaHtk5sG7a6Q5CABwo0QlkFRC0qb
         nl8Q==
X-Gm-Message-State: AOAM530lyZ1xqPABVYmC5dToz4qyzjWTaVcAoi6EdWzbr+uXHeZNTIWn
        SKKEgfLmN9E8LzSi4nWlwmL/C7xuj1n/3Q==
X-Google-Smtp-Source: ABdhPJyV1vjHmNuhZ8ojAWk9cmmtZxvWYW759g65XC4gzus9L6u14kPHgkyUqLDM5rwhYwpKkdMe2g==
X-Received: by 2002:a1c:bb45:: with SMTP id l66mr32295920wmf.29.1623666833026;
        Mon, 14 Jun 2021 03:33:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:33:52 -0700 (PDT)
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
Subject: [PATCH v2 10/30] send-email: use 'git hook run' for 'sendemail-validate'
Date:   Mon, 14 Jun 2021 12:32:59 +0200
Message-Id: <patch-10.30-1953326d1db-20210614T101920Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com> <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
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
index 7ba0b3433d7..9e474304036 100755
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
index 30eff725a96..6d4e25df8dc 100755
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
2.32.0.rc3.434.gd8aed1f08a7

