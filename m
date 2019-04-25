Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05DA41F453
	for <e@80x24.org>; Thu, 25 Apr 2019 09:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfDYJrC (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 05:47:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44770 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbfDYJrB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 05:47:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id z16so6308510pgv.11
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 02:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CCKg0ZdLK05T+uIuYjF6X1oRjxhUT4lECNQY4Z4iayE=;
        b=B7/jDFETU/U17P8dscCb4FWUWePFMwL+P2ykLwrjBSchmSSwEsbRLaS1/9w0N4CyNQ
         73aSroa4Nea9wqfS307+rhFX3vkq2xK8UMpQ5K5V4WD+dOtpnK57Qh13LwfOdQVF6180
         kyW0HX6j/KrGDlJBoTHx+7Td4ACNQNDfX6ikX50Or+9repo8rhC/42aCj0zLbSnDHuq8
         LIGuJQ3jkdMVOgxiv9BrqQ0i+9Di0iI3zv2rSq9GhSb340OK+b9hWCps69pCKwuVAnxB
         t2I2SVx5HgtkztwmyvU9OVA7J3+tbcHxymkDj5WKySzxDF+phln9r01N/11vlp2vTcXN
         /Trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CCKg0ZdLK05T+uIuYjF6X1oRjxhUT4lECNQY4Z4iayE=;
        b=hqHebjeQhGLUfVvydFlPelVh3cMD/UOt09JhUi598OePD845W5w+rrg3wmcMrnRCdP
         UaioRiZOMPHyqcbREGjnV14KEggGavP3mt864yQUgHZH3pShrQeKWvkYc51LDL99UuNQ
         Hgilddr6oViNa+G7kFMWOG0qTPk9BqVYtrCLIkV6yVhhn0vm1R34zwdNCwca0r+27Rgz
         +57qQfk4Qr+73NbOMj6Rwer3qjeSpBImCLUEbXbDf/qH5aKCwz7zQY/GXsa7NKMv6rKW
         5wSU6W7tMA4IFovMPhKsZP36PyvrmYdYSrdzPU4rYuGniUzirWq5NW+rXFTMhIvr6E8l
         MLcw==
X-Gm-Message-State: APjAAAVLGbiPnangNsrZT8yxyGqe99AY3TSTCfo+b1oX3g7M9h/JpjBS
        uScP7vfLWqbeTT8fXTshU0k=
X-Google-Smtp-Source: APXvYqyosR9E6uzR0PdjmyAJiuO+TaGX+QZs6tkWNaSi0zUPLZLc2qExFScpOe87mGNRlc+93G07fw==
X-Received: by 2002:a63:1064:: with SMTP id 36mr35739752pgq.155.1556185620924;
        Thu, 25 Apr 2019 02:47:00 -0700 (PDT)
Received: from ash ([115.73.128.9])
        by smtp.gmail.com with ESMTPSA id e21sm2990752pgg.90.2019.04.25.02.46.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:47:00 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 25 Apr 2019 16:46:55 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        jacob.keller@gmail.com, newren@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v3 10/16] restore: support --patch
Date:   Thu, 25 Apr 2019 16:45:54 +0700
Message-Id: <20190425094600.15673-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.854.ge34a79f761
In-Reply-To: <20190425094600.15673-1-pclouds@gmail.com>
References: <20190411131218.19195-1-pclouds@gmail.com>
 <20190425094600.15673-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-restore is different from git-checkout that it only restores the
worktree by default, not both worktree and index. add--interactive
needs some update to support this mode.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c        |  6 +++--
 git-add--interactive.perl | 52 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 824ab65886..bed79ae595 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -454,9 +454,11 @@ static int checkout_paths(const struct checkout_opts *opts,
 			patch_mode = "--patch=checkout";
 		else if (opts->checkout_index && !opts->checkout_worktree)
 			patch_mode = "--patch=reset";
+		else if (!opts->checkout_index && opts->checkout_worktree)
+			patch_mode = "--patch=worktree";
 		else
-			die(_("'%s' with only '%s' is not currently supported"),
-			    "--patch", "--worktree");
+			BUG("either flag must have been set, worktree=%d, index=%d",
+			    opts->checkout_worktree, opts->checkout_index);
 		return run_add_interactive(revision, patch_mode, &opts->pathspec);
 	}
 
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 20eb81cc92..3dfb3629c9 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -149,6 +149,20 @@ sub colored {
 		FILTER => undef,
 		IS_REVERSE => 0,
 	},
+	'worktree_head' => {
+		DIFF => 'diff-index -p',
+		APPLY => sub { apply_patch 'apply -R', @_ },
+		APPLY_CHECK => 'apply -R',
+		FILTER => undef,
+		IS_REVERSE => 1,
+	},
+	'worktree_nothead' => {
+		DIFF => 'diff-index -R -p',
+		APPLY => sub { apply_patch 'apply', @_ },
+		APPLY_CHECK => 'apply',
+		FILTER => undef,
+		IS_REVERSE => 0,
+	},
 );
 
 $patch_mode = 'stage';
@@ -1049,6 +1063,12 @@ sub color_diff {
 marked for discarding."),
 	checkout_nothead => N__(
 "If the patch applies cleanly, the edited hunk will immediately be
+marked for applying."),
+	worktree_head => N__(
+"If the patch applies cleanly, the edited hunk will immediately be
+marked for discarding."),
+	worktree_nothead => N__(
+"If the patch applies cleanly, the edited hunk will immediately be
 marked for applying."),
 );
 
@@ -1259,6 +1279,18 @@ sub edit_hunk_loop {
 n - do not apply this hunk to index and worktree
 q - quit; do not apply this hunk or any of the remaining ones
 a - apply this hunk and all later hunks in the file
+d - do not apply this hunk or any of the later hunks in the file"),
+	worktree_head => N__(
+"y - discard this hunk from worktree
+n - do not discard this hunk from worktree
+q - quit; do not discard this hunk or any of the remaining ones
+a - discard this hunk and all later hunks in the file
+d - do not discard this hunk or any of the later hunks in the file"),
+	worktree_nothead => N__(
+"y - apply this hunk to worktree
+n - do not apply this hunk to worktree
+q - quit; do not apply this hunk or any of the remaining ones
+a - apply this hunk and all later hunks in the file
 d - do not apply this hunk or any of the later hunks in the file"),
 );
 
@@ -1421,6 +1453,16 @@ sub display_hunks {
 		deletion => N__("Apply deletion to index and worktree [y,n,q,a,d%s,?]? "),
 		hunk => N__("Apply this hunk to index and worktree [y,n,q,a,d%s,?]? "),
 	},
+	worktree_head => {
+		mode => N__("Discard mode change from worktree [y,n,q,a,d%s,?]? "),
+		deletion => N__("Discard deletion from worktree [y,n,q,a,d%s,?]? "),
+		hunk => N__("Discard this hunk from worktree [y,n,q,a,d%s,?]? "),
+	},
+	worktree_nothead => {
+		mode => N__("Apply mode change to worktree [y,n,q,a,d%s,?]? "),
+		deletion => N__("Apply deletion to worktree [y,n,q,a,d%s,?]? "),
+		hunk => N__("Apply this hunk to worktree [y,n,q,a,d%s,?]? "),
+	},
 );
 
 sub patch_update_file {
@@ -1756,6 +1798,16 @@ sub process_args {
 						       'checkout_head' : 'checkout_nothead');
 					$arg = shift @ARGV or die __("missing --");
 				}
+			} elsif ($1 eq 'worktree') {
+				$arg = shift @ARGV or die __("missing --");
+				if ($arg eq '--') {
+					$patch_mode = 'checkout_index';
+				} else {
+					$patch_mode_revision = $arg;
+					$patch_mode = ($arg eq 'HEAD' ?
+						       'worktree_head' : 'worktree_nothead');
+					$arg = shift @ARGV or die __("missing --");
+				}
 			} elsif ($1 eq 'stage' or $1 eq 'stash') {
 				$patch_mode = $1;
 				$arg = shift @ARGV or die __("missing --");
-- 
2.21.0.854.ge34a79f761

