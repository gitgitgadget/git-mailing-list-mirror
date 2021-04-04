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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4319DC433B4
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 09:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188C861365
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 09:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhDDJUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 05:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhDDJT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 05:19:59 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F69C061788
        for <git@vger.kernel.org>; Sun,  4 Apr 2021 02:19:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f6so2307232wrv.12
        for <git@vger.kernel.org>; Sun, 04 Apr 2021 02:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/qgOKT3niMb3thE5qVdAccAtkqEJ4Ad1PdS/GhsNDus=;
        b=aiBHovWIIOk5YgE1VIEBjI/fxzuciNLxViNr+I6TUyLRV3ylj0SqtMFhI7/1o2bAQC
         NEbgirdHeOXX4zK+hs7PaI/BNGwshNnD7nwgPlcktbdiq9QNQtryPsAcm4gSC0Hmcelg
         Ye/xHqU+YmB7QZUr9sYCSm/JJVrNKzANMIS8cSKKh0tlF970eFMKQt6fa9i6iRsvphN5
         l1ZxVenvK6lUHFpEqfUoSJApHhHVm9KV40lO46Muu99GWBxqaqBeEmhgLRRf4BkSE9ml
         9/gS7+d/GO7FyiXGKF2BN7uISuJwqkahqQ0GXbOSy8BdedwljhMVvXYR7uo8vhNKHQv2
         yMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/qgOKT3niMb3thE5qVdAccAtkqEJ4Ad1PdS/GhsNDus=;
        b=g57gNZ0O6LyImXrbCB0RaZLJrv65htQQmpb8zqigHi3xsK0FA5woLAwGcYfAX3OX6f
         onKRxZV1WXagx+NbbuA7XkMikT3iMCvHU7VHGkXJQ0vh+7+h7rKcCD+wRMfztKl3gbCr
         sc2YvThsfV+tu1V9q/zZOiLeKoFhrAKkW6+1iEMQ1NI0GE1GRBqrKAPXV+IOpPw1vV8/
         nTITqb/1UoQN7q274a66UyelN7Zu5TshYMRYaNVBfhmlfx2KMvhanvqN19v/CDgb4HEh
         FQj2krgrS8MUfZ4R/LdqPyjJU4KEwBRmtDZ69gDP0fo8EBY6cHZ05StUiE6O1iJf0dO7
         4AKA==
X-Gm-Message-State: AOAM5300F43JvN3i0ailD7MwUeXxeeCdCQE9bH6VZt8XaaMUV7bxQpaZ
        BIHCEdD6+E/tuRy/a5oox+6e/wplNZ/Lcw==
X-Google-Smtp-Source: ABdhPJzp/eik1ssSP/dclJL/cTHL6Y7gbVgGlBNkOAB9Ok9WbTweedWrWIsQdMRheknUPbIwspQvQA==
X-Received: by 2002:a5d:58e5:: with SMTP id f5mr9908651wrd.131.1617527991898;
        Sun, 04 Apr 2021 02:19:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z25sm22480540wmi.23.2021.04.04.02.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 02:19:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/4] git-send-email: refactor duplicate $? checks into a function
Date:   Sun,  4 Apr 2021 11:19:44 +0200
Message-Id: <patch-2.5-f236f083e36-20210404T091649Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.482.g6691c1be520
In-Reply-To: <cover-0.5-00000000000-20210404T091649Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210402T112946Z-avarab@gmail.com> <cover-0.5-00000000000-20210404T091649Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the duplicate checking of $? into a function. There's an
outstanding series[1] wanting to add a third use of system() in this
file, let's not copy this boilerplate anymore when that happens.

1. http://lore.kernel.org/git/87y2esg22j.fsf@evledraar.gmail.com

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 48 +++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 6893c8e5808..9724a9cae27 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -212,22 +212,31 @@ sub format_2822_time {
 my $multiedit;
 my $editor;
 
+sub system_or_msg {
+	my ($args, $msg) = @_;
+	system(@$args);
+	my $signalled = $? & 127;
+	my $exit_code = $? >> 8;
+	return unless $signalled or $exit_code;
+
+	return sprintf(__("failed to run command %s, died with code %d"),
+		       "@$args", $exit_code);
+}
+
+sub system_or_die {
+	my $msg = system_or_msg(@_);
+	die $msg if $msg;
+}
+
 sub do_edit {
 	if (!defined($editor)) {
 		$editor = Git::command_oneline('var', 'GIT_EDITOR');
 	}
+	my $die_msg = __("the editor exited uncleanly, aborting everything");
 	if (defined($multiedit) && !$multiedit) {
-		for (@_) {
-			system('sh', '-c', $editor.' "$@"', $editor, $_);
-			if (($? & 127) || ($? >> 8)) {
-				die(__("the editor exited uncleanly, aborting everything"));
-			}
-		}
+		system_or_die(['sh', '-c', $editor.' "$@"', $editor, $_], $die_msg) for @_;
 	} else {
-		system('sh', '-c', $editor.' "$@"', $editor, @_);
-		if (($? & 127) || ($? >> 8)) {
-			die(__("the editor exited uncleanly, aborting everything"));
-		}
+		system_or_die(['sh', '-c', $editor.' "$@"', $editor, @_], $die_msg);
 	}
 }
 
@@ -698,9 +707,7 @@ sub is_format_patch_arg {
 if ($validate) {
 	foreach my $f (@files) {
 		unless (-p $f) {
-			my $error = validate_patch($f, $target_xfer_encoding);
-			$error and die sprintf(__("fatal: %s: %s\nwarning: no patches were sent\n"),
-						  $f, $error);
+			validate_patch($f, $target_xfer_encoding);
 		}
 	}
 }
@@ -1938,6 +1945,12 @@ sub unique_email_list {
 	return @emails;
 }
 
+sub validate_patch_error {
+	my ($fn, $error) = @_;
+	die sprintf(__("fatal: %s: %s\nwarning: no patches were sent\n"),
+		    $fn, $error);
+}
+
 sub validate_patch {
 	my ($fn, $xfer_encoding) = @_;
 
@@ -1952,11 +1965,12 @@ sub validate_patch {
 			chdir($repo->wc_path() or $repo->repo_path())
 				or die("chdir: $!");
 			local $ENV{"GIT_DIR"} = $repo->repo_path();
-			$hook_error = "rejected by sendemail-validate hook"
-				if system($validate_hook, $target);
+			if (my $msg = system_or_msg([$validate_hook, $target])) {
+				$hook_error = __("rejected by sendemail-validate hook");
+			}
 			chdir($cwd_save) or die("chdir: $!");
 		}
-		return $hook_error if $hook_error;
+		validate_patch_error($fn, $hook_error) if $hook_error;
 	}
 
 	# Any long lines will be automatically fixed if we use a suitable transfer
@@ -1966,7 +1980,7 @@ sub validate_patch {
 			or die sprintf(__("unable to open %s: %s\n"), $fn, $!);
 		while (my $line = <$fh>) {
 			if (length($line) > 998) {
-				return sprintf(__("%s: patch contains a line longer than 998 characters"), $.);
+				validate_patch_error($fn, sprintf(__("%s: patch contains a line longer than 998 characters"), $.));
 			}
 		}
 	}
-- 
2.31.1.482.g6691c1be520

