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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3872C43461
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 14:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82B3861396
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 14:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344837AbhDFOA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 10:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344832AbhDFOA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 10:00:57 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D33C06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 07:00:49 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id b133-20020a1c678b0000b02901231346381dso428168wmc.0
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 07:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xn7DgsophynFP8y+sziGcvzzoV1c0RbQ53IurH8K6uY=;
        b=l68sBgNQ4SGRtmst6Myq+CnfJvyRjxchwntpk/vF7MXL46Whl60GsG6+oZZC7kOKmH
         VM8VcYqe+KqEPNVGhcxlnCYi1OsTpm2ilSS5nDYqApgYmi3BTD6D83D2O1fsPJiC9mlS
         aeM07P+fQiFhXFjHrDCXY134r/y5IEnWDNT+LZu7TR+YWbSH2qYarAoU4EfUtvNIG6Ej
         UY3sF86TnIqVEZR/2MUt9pL97LlA2r8CETj7B3/d/S9Uf1NlJFouSGy2nvn6dI/mg8uW
         yeKy97m5XRHwZsPgU9pTA0tHIXRYqxaVACf/ACICvfoVBjrC4zmSoYEhFsYlyZZufdgn
         lhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xn7DgsophynFP8y+sziGcvzzoV1c0RbQ53IurH8K6uY=;
        b=EczBB1XiHum3cWXk1FPMpIBpI3BgUYhJfGf3dldNPYIgsVgf1drtivQRzW9jaR6gDZ
         BrmyJP8HP6p1Rur3C8LiL+KKrG4I9o5qli03NnxE1K3w5QNMaybU2676+SLNlEdhLvC3
         H2mmLoNuvrr4gJJ6ubcDxeoeKcgJCXOhk+yXOUHhXwwEogNejGFT8d1olu5+l97Q+4Us
         jrVecd+13XGXoIY5l6Bu480YXOIX9fskr4Dx/F2nDpX86OZeJ9vj/M20GtO/xFxuXyX9
         B1w+Jvwk/wfOhy+ykwWpsBFGXLGCA1NH5KSDVXeIlT3fAtVXNOLJaM8+Zq8Cykme0rmp
         pktQ==
X-Gm-Message-State: AOAM531GiIyWstzgZc+jUs0BmY3VqmBo626ES7fmbxVV2PlMePEcPqxt
        UzLh32fGUgxRyt60Fu1OGOymhTJo+0xK4A==
X-Google-Smtp-Source: ABdhPJwHOJnZYauNjdCc+SIB2fI2CZOQClEmQfy3KaCPQJEliIDdgdCZs3VqVDLoxVsP98AZhKalbw==
X-Received: by 2002:a7b:c24e:: with SMTP id b14mr4300891wmj.73.1617717647619;
        Tue, 06 Apr 2021 07:00:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h6sm20029696wrr.21.2021.04.06.07.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 07:00:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/3] git-send-email: refactor duplicate $? checks into a function
Date:   Tue,  6 Apr 2021 16:00:36 +0200
Message-Id: <patch-2.4-4ee582d8301-20210406T135716Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g9b8f7de2547
In-Reply-To: <cover-0.4-00000000000-20210406T135715Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210404T091649Z-avarab@gmail.com> <cover-0.4-00000000000-20210406T135715Z-avarab@gmail.com>
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
 git-send-email.perl | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 6893c8e5808..2dd48621759 100755
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
@@ -1952,11 +1959,13 @@ sub validate_patch {
 			chdir($repo->wc_path() or $repo->repo_path())
 				or die("chdir: $!");
 			local $ENV{"GIT_DIR"} = $repo->repo_path();
-			$hook_error = "rejected by sendemail-validate hook"
-				if system($validate_hook, $target);
+			$hook_error = system_or_msg([$validate_hook, $target]);
 			chdir($cwd_save) or die("chdir: $!");
 		}
-		return $hook_error if $hook_error;
+		if ($hook_error) {
+			die sprintf(__("fatal: %s: rejected by sendemail-validate hook\n" .
+				       "warning: no patches were sent\n"), $fn);
+		}
 	}
 
 	# Any long lines will be automatically fixed if we use a suitable transfer
@@ -1966,7 +1975,9 @@ sub validate_patch {
 			or die sprintf(__("unable to open %s: %s\n"), $fn, $!);
 		while (my $line = <$fh>) {
 			if (length($line) > 998) {
-				return sprintf(__("%s: patch contains a line longer than 998 characters"), $.);
+				die sprintf(__("fatal: %s: %d: patch contains a line longer than 998 characters\n" .
+					       "warning: no patches were sent\n"),
+					    $fn, $.);
 			}
 		}
 	}
-- 
2.31.1.527.g9b8f7de2547

