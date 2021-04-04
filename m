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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DAAC433ED
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 09:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 058E961103
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 09:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhDDJUA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 05:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhDDJT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 05:19:59 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B647C061756
        for <git@vger.kernel.org>; Sun,  4 Apr 2021 02:19:55 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e18so8390048wrt.6
        for <git@vger.kernel.org>; Sun, 04 Apr 2021 02:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/iHq0Gmz41beMfCSAL/i4iAuvX5Qhkln3+Lmt/zIlGI=;
        b=vXaEyb0Hh6mjkyvZwBrl9YOmF5SLOliNi7/e/QuAsKgxdGMLTzn+vbPTLSEyYSCx+Q
         GHnriMuljNswOrboXmaybp7qNe3JahMgWlpEVHYHD0x1RXPeAa3EOYQDqjPiOF86o3Zr
         vj+3mdUV9XdjZUVgHXOfOO+l0Gn9QF9t7NUW//ETU/bK1CnVv8tPYgJR550aahb95Dva
         9QI2A0azIwqaaM5L6/quBFywArNrXz3NivyzMn4EwUQv5cg6h9BLZJFxcqHQrCA6zTqO
         TCp3wCZDjFF3PK0E0H7j81+tWpnqHStR3/Bn4gv09OxjB2WJfNrfALOacbJdVIMziBTn
         F1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/iHq0Gmz41beMfCSAL/i4iAuvX5Qhkln3+Lmt/zIlGI=;
        b=LAmaKH702n0ZZmMJEiSOu/JK7ybieGKiA3+LnuRwGS/I0V92CwQE+xr/btMguQ3HNh
         gQHUFYlG+EcfV+OaXBANWzCC3KiHc/baBTIUPQwc0QFcbrI9oy9HcRjqHrJzzQs1dNK0
         O8KJ1v+fbpiTSxSLaJSmAGBp8YzJMB56Mc1B3o/gb/s8gPZQuEEhrNu8FSXeojDqt0E/
         PqzwgR1ZLnfsUfcKvY3ir752ZzeSmuWAp/7iyzOGq2pss0JU+kOxKp31wAExejm+gDs3
         d+57q2DaASXbD0HLLZcaA/xytUFCSfW2xvbEROetxqSzpqLnoi7kQE98HwWAuUf6htt4
         U1cA==
X-Gm-Message-State: AOAM531j0JQC2MCnoOklaVmz7X0nlCptgKhWhQW80v7wnfP+9wmEvvfr
        SDL67++bV/WyqiZ3ZN6F/cUYqVi7NxnleQ==
X-Google-Smtp-Source: ABdhPJz7ZgLdtvivFm6yXGVPU3yIw4pdRxV7JqfoEwYIzRCdvFWjGzhRaM8502AOeyRFM9ihT7og/g==
X-Received: by 2002:a5d:4566:: with SMTP id a6mr10827234wrc.250.1617527993493;
        Sun, 04 Apr 2021 02:19:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z25sm22480540wmi.23.2021.04.04.02.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 02:19:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/4] git-send-email: improve --validate error output
Date:   Sun,  4 Apr 2021 11:19:46 +0200
Message-Id: <patch-4.5-a1edceb4913-20210404T091649Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.482.g6691c1be520
In-Reply-To: <cover-0.5-00000000000-20210404T091649Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210402T112946Z-avarab@gmail.com> <cover-0.5-00000000000-20210404T091649Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the output we emit on --validate error to:

 * Say "FILE:LINE" instead of "FILE: LINE".

 * Don't say "patch contains a" after just mentioning the filename,
   just leave it at "FILE:LINE: is longer than[...]. The "contains a"
   sounded like we were talking about the file in general, when we're
   actually checking it line-by-line.

 * Don't just say "rejected by sendemail-validate hook", but combine
   that with the system_or_msg() output to say what exit code the hook
   died with.

I had an aborted attempt to make the line length checker note all
lines that were longer than the limit. I didn't think that was worth
the effort, but I've left in the testing change to check that we die
as soon as we spot the first long line.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl   | 23 ++++++++++-------------
 t/t9001-send-email.sh | 17 ++++++++++++-----
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 9724a9cae27..175da07d946 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -219,8 +219,8 @@ sub system_or_msg {
 	my $exit_code = $? >> 8;
 	return unless $signalled or $exit_code;
 
-	return sprintf(__("failed to run command %s, died with code %d"),
-		       "@$args", $exit_code);
+	return sprintf(__("fatal: command '%s' died with exit code %d"),
+		       $args->[0], $exit_code);
 }
 
 sub system_or_die {
@@ -1945,12 +1945,6 @@ sub unique_email_list {
 	return @emails;
 }
 
-sub validate_patch_error {
-	my ($fn, $error) = @_;
-	die sprintf(__("fatal: %s: %s\nwarning: no patches were sent\n"),
-		    $fn, $error);
-}
-
 sub validate_patch {
 	my ($fn, $xfer_encoding) = @_;
 
@@ -1965,12 +1959,14 @@ sub validate_patch {
 			chdir($repo->wc_path() or $repo->repo_path())
 				or die("chdir: $!");
 			local $ENV{"GIT_DIR"} = $repo->repo_path();
-			if (my $msg = system_or_msg([$validate_hook, $target])) {
-				$hook_error = __("rejected by sendemail-validate hook");
-			}
+			$hook_error = system_or_msg([$validate_hook, $target]);
 			chdir($cwd_save) or die("chdir: $!");
 		}
-		validate_patch_error($fn, $hook_error) if $hook_error;
+		if ($hook_error) {
+			die sprintf(__("fatal: %s: rejected by sendemail-validate hook\n" .
+				       "%s\n" .
+				       "warning: no patches were sent\n"), $fn, $hook_error);
+		}
 	}
 
 	# Any long lines will be automatically fixed if we use a suitable transfer
@@ -1980,7 +1976,8 @@ sub validate_patch {
 			or die sprintf(__("unable to open %s: %s\n"), $fn, $!);
 		while (my $line = <$fh>) {
 			if (length($line) > 998) {
-				validate_patch_error($fn, sprintf(__("%s: patch contains a line longer than 998 characters"), $.));
+				die sprintf(__("fatal: %s:%d is longer than 998 characters\n" .
+					       "warning: no patches were sent\n"), $fn, $.);
 			}
 		}
 	}
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 74225e3dc7a..65b30353719 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -415,7 +415,11 @@ test_expect_success $PREREQ 'reject long lines' '
 	z512=$z64$z64$z64$z64$z64$z64$z64$z64 &&
 	clean_fake_sendmail &&
 	cp $patches longline.patch &&
-	echo $z512$z512 >>longline.patch &&
+	cat >>longline.patch <<-EOF &&
+	$z512$z512
+	not a long line
+	$z512$z512
+	EOF
 	test_must_fail git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
@@ -424,7 +428,7 @@ test_expect_success $PREREQ 'reject long lines' '
 		$patches longline.patch \
 		2>actual &&
 	cat >expect <<-\EOF &&
-	fatal: longline.patch: 35: patch contains a line longer than 998 characters
+	fatal: longline.patch:35 is longer than 998 characters
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
@@ -533,15 +537,17 @@ test_expect_success $PREREQ "--validate respects relative core.hooksPath path" '
 		--validate \
 		longline.patch 2>actual &&
 	test_path_is_file my-hooks.ran &&
-	cat >expect <<-\EOF &&
+	cat >expect <<-EOF &&
 	fatal: longline.patch: rejected by sendemail-validate hook
+	fatal: command '"'"'$(pwd)/my-hooks/sendemail-validate'"'"' died with exit code 1
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
 '
 
 test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
-	test_config core.hooksPath "$(pwd)/my-hooks" &&
+	hooks_path="$(pwd)/my-hooks" &&
+	test_config core.hooksPath "$hooks_path" &&
 	test_when_finished "rm my-hooks.ran" &&
 	test_must_fail git send-email \
 		--from="Example <nobody@example.com>" \
@@ -550,8 +556,9 @@ test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
 		--validate \
 		longline.patch 2>actual &&
 	test_path_is_file my-hooks.ran &&
-	cat >expect <<-\EOF &&
+	cat >expect <<-EOF &&
 	fatal: longline.patch: rejected by sendemail-validate hook
+	fatal: command '"'"'$hooks_path/sendemail-validate'"'"' died with exit code 1
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
-- 
2.31.1.482.g6691c1be520

