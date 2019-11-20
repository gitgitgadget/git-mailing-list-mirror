Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634C8C43215
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 09:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3050E21939
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 09:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNQ551AN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfKTJwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 04:52:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40877 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbfKTJws (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 04:52:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id y5so876041wmi.5
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 01:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O9IxIMfhNSZX03CpyAB7jBFKXuJFMcUy4Hvq8pBIuS8=;
        b=aNQ551ANMWrGvZvrbWYwG8odYuLkLGTi/xC3e/jokkZE/kYZlgW0SjqfwJ/zLBV/RI
         dxpgd6yfubTXpqo+VqO7uoFSET84UvkT6r/RCxOAlD+IMDsc38ImUDSBoT/eC4lrobPA
         n4L9QkJcx9gDjPql/hO5hX7UDyzLjZ4QgvZB5xC90aegGRXZYdHLURI2joxhzzDwnPke
         YtJL3taX9M/1Q7RTiamt+9+hpGzISxNDCejUEVBp2AryqxCLludXoVIdyEp6huzt5Rvq
         zCHH1bpsUrAEEwO3Y7NxAxw3Y53FZKwamC8AfCpLEyV8S855G2BFdewGQuFVqFYZRt9b
         DXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O9IxIMfhNSZX03CpyAB7jBFKXuJFMcUy4Hvq8pBIuS8=;
        b=LDbrQ12Fm5T5eYMWYhF2DTX1Pxae76KS8j0lIAKrtQ66Yl5euyfe1x4XedhuzumC88
         BK7mmMTyOxDkOqKde5G7hfuzpLV0UByPQjK0PfL2DSmmF3FNk+hbUG7oVdsQHcldL0jQ
         8Itggzc8lkQUmUsfuZFsmVVR3OguladJIv4GF6UskTWPDewqwJgX784+WG07f1yV66yE
         2dUfF1n38xD+mpIYaFiiCbicuV+b43/8lR9jwKcgWw5t4pwLoTwztnGAM3DY1Pa/n6Ak
         l5jACrEFLEzVQngPEM85qr1Ht2rdEbmhX/dOcpAtN8q0w8sv0WXwqSqdkUSyK6pH1/7o
         fAyA==
X-Gm-Message-State: APjAAAWx1Rk0ECpPLfALmHzYlsawsI9t17xcn1ExSFfqZpxhEzDZmB+A
        YuDClfYYWvMv4pfqfIbXLwx95vlZAclP0A==
X-Google-Smtp-Source: APXvYqyzRm2zKu1ISXXakGwhxwfyDC2/7a04+b4rn6JDKOpVjVas8BaX+qXjGB/CLnBSu50r7QOp6w==
X-Received: by 2002:a05:600c:22cb:: with SMTP id 11mr2091288wmg.117.1574243566228;
        Wed, 20 Nov 2019 01:52:46 -0800 (PST)
Received: from rybak.office.devexperts.com ([185.79.217.61])
        by smtp.googlemail.com with ESMTPSA id p25sm5992516wma.20.2019.11.20.01.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 01:52:45 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        predatoramigo@gmail.com
Subject: [RFC PATCH v2 4/4] rebase -i: allow --edit-todo with --exec
Date:   Wed, 20 Nov 2019 10:52:38 +0100
Message-Id: <20191120095238.4349-5-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20191114163549.7648-1-rybak.a.v@gmail.com>
References: <20191114163549.7648-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using rebase, option --exec can be used, for example, to run tests
after every commit created by rebase.  When using interactive rebase, I
don't always know, if I would want to run something against each commit
before I start rebasing.  Sometimes, I realize this only after doing
some editing in the middle of the rebase.  To do that, I have to
manually edit the todo file.  Additing exec command by hand or
semi-automatically is cumbersome and error prone.  Especially if the
file is big or complex, e.g. when option --rebase-merges is used.

Allow using the --edit-todo action of git rebase with option --exec.
New test is based on test 'rebase --edit-todo can be used to modify
todo'.  Contents of todo file are checked using set_cat_todo_editor
similarly to what test 'respects rebase.abbreviateCommands with fixup,
squash and exec' does.

Remove unnecessary braces around call to usage_with_options, while we're
here.

TODO: Still need better validation of options. With current
      implementation, the following is not rejected:

	git rebase --edit-todo -x 'git show HEAD' --autostash

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 Documentation/git-rebase.txt  |  3 ++-
 builtin/rebase.c              | 16 +++++++++++++---
 t/t3404-rebase-interactive.sh | 26 ++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 639a4179d1..b5db5e80d4 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 	[--onto <newbase> | --keep-base] [<upstream> [<branch>]]
 'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>]
 	--root [<branch>]
-'git rebase' (--continue | --skip | --abort | --quit | --edit-todo | --show-current-patch)
+'git rebase' (--continue | --skip | --abort | --quit |
+	--edit-todo [--exec<cmd>] | --show-current-patch)
 
 DESCRIPTION
 -----------
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 8a6ac7439b..4fd55cfbb4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -33,7 +33,8 @@ static char const * const builtin_rebase_usage[] = {
 		"[--onto <newbase> | --keep-base] [<upstream> [<branch>]]"),
 	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
 		"--root [<branch>]"),
-	N_("git rebase --continue | --abort | --skip | --edit-todo"),
+	N_("git rebase --continue | --abort | --skip | "
+		"--edit-todo [--exec <cmd>]"),
 	NULL
 };
 
@@ -409,6 +410,11 @@ static int run_rebase_interactive(struct rebase_options *opts,
 		break;
 	}
 	case ACTION_EDIT_TODO:
+		if (opts->cmd) {
+			ret = add_exec(opts->cmd);
+			if (ret)
+				break;
+		}
 		ret = edit_todo_file(flags);
 		break;
 	case ACTION_SHOW_CURRENT_PATCH: {
@@ -1565,15 +1571,19 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			     builtin_rebase_options,
 			     builtin_rebase_usage, 0);
 
-	if (action != ACTION_NONE && total_argc != 2) {
+	if (action != ACTION_NONE && action != ACTION_EDIT_TODO &&
+	    total_argc != 2)
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
-	}
 
 	if (argc > 2)
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
 
+	if (action == ACTION_EDIT_TODO && argc > 0)
+		usage_with_options(builtin_rebase_usage,
+				   builtin_rebase_options);
+
 	if (options.type == REBASE_PRESERVE_MERGES)
 		warning(_("git rebase --preserve-merges is deprecated. "
 			  "Use --rebase-merges instead."));
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index d2dfbe46b9..c3b640575d 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1082,6 +1082,32 @@ test_expect_success 'rebase --edit-todo can be used to modify todo' '
 	test L = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
+test_expect_success 'rebase --edit-todo can be used with -x' '
+	test_when_finished "reset_rebase" &&
+	git reset --hard &&
+	git checkout no-conflict-branch^0 &&
+	cat >expected <<-EOF &&
+	pick $(git rev-list --abbrev-commit -1 HEAD^) L
+	exec git show HEAD
+	pick $(git rev-list --abbrev-commit -1 HEAD) M
+	exec git show HEAD
+	EOF
+	set_fake_editor &&
+	FAKE_LINES="1 edit 2 3 4" git rebase -i HEAD~4 &&
+	set_cat_todo_editor &&
+	test_must_fail git rebase --edit-todo -x "git show HEAD" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_failure 'rebase --edit-todo -x does not allow other arguments' '
+	test_when_finished "reset_rebase" &&
+	git reset --hard &&
+	git checkout no-conflict-branch^0 &&
+	set_fake_editor &&
+	FAKE_LINES="1 edit 2 3 4" git rebase -i HEAD~4 &&
+	test_must_fail git rebase --edit-todo -x "git show HEAD" --autostash
+'
+
 test_expect_success 'rebase -i produces readable reflog' '
 	git reset --hard &&
 	git branch -f branch-reflog-test H &&
-- 
2.24.0.windows.2

