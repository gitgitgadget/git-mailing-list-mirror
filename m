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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4E1C433B4
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 11:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921C4610CF
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 11:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbhDBLfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 07:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhDBLe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 07:34:58 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0A9C06178A
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 04:34:51 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c8so4483368wrq.11
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 04:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A0zDYWQew5nkkBAAgxGEMjFqTzW7OXnrGXy6C8oVg8o=;
        b=G6QwNrVAZK8VKE9BL3e09tKZDX/pK6eD8zSEZR0bfxH8USIzNN3ojsLd8yPS1LlstV
         YV7tfkhUyaqTM/z+A/764AwRfJZEmLK0JBShD0H8O1N/jnWl7+GJuIr64kucJePqyK1X
         0FdN2U40/0nuh6vv51WFZNEhpIzmMsGQs3iG4PaV7bBPomoBM9GW35Y+Og7KDH7eIpId
         P0cIZguE+7BqpyOcRIfjLiO9KOYuqI/IT7xvTK3x5Bs7joKgyNl3yEoFayftDR3ZcrI9
         B2vENj0sYtJtzkpr5dh8U9P3MtQxQ+429OfhyAP0VwL40IPb5dxVcs7mxoDRvmT5r9FT
         OfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A0zDYWQew5nkkBAAgxGEMjFqTzW7OXnrGXy6C8oVg8o=;
        b=Sdp/0nAhcOohRlmSHmUnk3QYbLF6Ir2W9Jbl25umnhbeRofcdMyCkC9xrQ+w98JM0D
         sxko/+gxajze8wXGN+K85aOPJua1y2pFxe26w3GS50tDEoMbHpa2dPmxsG8EwYi2RF6U
         PlXqKPAbz2d6hJxp0jJZqEDLBtiJ7xAommFWeXblqDS+AAU0I9UrsKxJnTOmZZpjr0xh
         RXhTRVgUA3qqeaPkHGdnJVfvKky83Mmp+iwRAYOtHLTwfgMGTg/sl/anR/1saUWjKcAS
         LpPeNbFjnyHPeiYjt8+tW8Wz+beN+t9bmppl3m8dNluQ7d5VKTaExNvi6Gi4JxCUAvo6
         YRjQ==
X-Gm-Message-State: AOAM5324VNs3rCVgAZUKSpCfz/iwhU3/tBARNTkURxLvLn4PD5k/Klkr
        qk6of2PU7iNlwYCRT3kIkfAraCTh10YPfg==
X-Google-Smtp-Source: ABdhPJzdCxrzpjLUys8zh/XZzt8BUOWSOKYQhL6AJoR9zNfxS4tA0Xy0818x6b2Ts5MdzvY6cG7rtA==
X-Received: by 2002:a05:6000:2af:: with SMTP id l15mr15133463wry.387.1617363289780;
        Fri, 02 Apr 2021 04:34:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 12sm11535818wmw.43.2021.04.02.04.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 04:34:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] git-send-email: refactor duplicate $? checks into a function
Date:   Fri,  2 Apr 2021 13:34:34 +0200
Message-Id: <patch-2.3-f4bace5607c-20210402T112946Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.482.g6691c1be520
In-Reply-To: <cover-0.3-00000000000-20210402T112946Z-avarab@gmail.com>
References: <YGTt2cNwq3BlpB7n@google.com> <cover-0.3-00000000000-20210402T112946Z-avarab@gmail.com>
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
 git-send-email.perl | 49 +++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 6893c8e5808..901c935455d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -212,22 +212,30 @@ sub format_2822_time {
 my $multiedit;
 my $editor;
 
+sub system_or_msg {
+	my ($args, $msg) = @_;
+	system(@$args);
+	return unless (($? & 127) || ($? >> 8));
+
+	die $msg if $msg;
+	return sprintf(__("failed to run command %s, died with code %d"),
+		       "@$args", $? >> 8);
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
 
@@ -698,9 +706,7 @@ sub is_format_patch_arg {
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
@@ -1938,6 +1944,12 @@ sub unique_email_list {
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
 
@@ -1952,11 +1964,14 @@ sub validate_patch {
 			chdir($repo->wc_path() or $repo->repo_path())
 				or die("chdir: $!");
 			local $ENV{"GIT_DIR"} = $repo->repo_path();
-			$hook_error = "rejected by sendemail-validate hook"
-				if system($validate_hook, $target);
+			if (my $msg = system_or_msg([$validate_hook, $target])) {
+				# TODO Use $msg and emit exit code on
+				# hook failures?
+				$hook_error = __("rejected by sendemail-validate hook");
+			}
 			chdir($cwd_save) or die("chdir: $!");
 		}
-		return $hook_error if $hook_error;
+		validate_patch_error($fn, $hook_error) if $hook_error;
 	}
 
 	# Any long lines will be automatically fixed if we use a suitable transfer
@@ -1966,7 +1981,7 @@ sub validate_patch {
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

