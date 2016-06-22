Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB2A720189
	for <e@80x24.org>; Wed, 22 Jun 2016 16:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852AbcFVQxo (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 12:53:44 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35462 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbcFVQxm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 12:53:42 -0400
Received: by mail-pf0-f194.google.com with SMTP id t190so4494758pfb.2
        for <git@vger.kernel.org>; Wed, 22 Jun 2016 09:53:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pRNsD6wk7HWRW/WocP4moNxFvFOblTrAVB4JzOuc0o8=;
        b=abjE8XlXgk8Y3TuUeUFtlblLcgo9ox5k23ZU2N/YMeWh//bSdh1eHxnyfFRRGYreHy
         2VHYXozKqLt54WRsGbj9Abnkkf9AVfnUGcDwuQzjJM9TQ9L8TZf8CDfM2fpMpzdxWltT
         5MvpsJQaU0IyhFbH3dylsiPYED5KybTjeVi2BvLXUTlobfOQU6K1G0beLDy95gF6LmcE
         XrGdMsva37L0v2UD8nfKN3O+ZtgvVYMdaYdScr3s1NRDYVGf1fmThP9wt+BZWArcdUJ8
         BmcWYLYZHfsJHmD4CccCnpShCygWcyybZ566x1Lbc+CU53qPY2z7jjSLOituaT4ju1Nl
         7ZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pRNsD6wk7HWRW/WocP4moNxFvFOblTrAVB4JzOuc0o8=;
        b=T+qwkLxISsqjbkR9Y5r9A9DqjlcWJerIJaGqTcYV+ho77Af5txUyfErhM1R9v5kTXz
         WYzlWNiSPvhSvv31sVa7RRwoKZDY4dTeBK5ontmHkG3pdX8giKkhKKK6VDKahmXY8/9F
         Rds7XkTQB339EDwxzM4bBis5PZVFfVSFN9Jqbso5VdRq6BUE9E22ps7/NUhYJQmmCqmL
         JrxcGmhLK3wZIEAINowfZ7oXJVeQ6oZl2D/NJbHAwwPI3yBoam1fO6MiRV6ZxLJ24Mc1
         wXZto8Am5p+r/V0n6/votpaFfeh8iDifL5ruIncZuqPsIkPlRJFMsTMECKmE3bLeIu8Y
         8uPg==
X-Gm-Message-State: ALyK8tKnIaUxb2IwREiRsX05eXGVhf2nrcNeUaDdNZePI9ErvD79IMOUJcFXU5OqatuO4A==
X-Received: by 10.98.5.2 with SMTP id 2mr22030239pff.58.1466614421759;
        Wed, 22 Jun 2016 09:53:41 -0700 (PDT)
Received: from localhost.localdomain ([106.218.86.37])
        by smtp.gmail.com with ESMTPSA id sz7sm1132865pab.23.2016.06.22.09.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Jun 2016 09:53:41 -0700 (PDT)
From:	Mehul Jain <mehul.jain2029@gmail.com>
To:	git@vger.kernel.org
Cc:	Eric Sunshine <sunshine@sunshineco.com>,
	Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v3 3/3] log: add log.showSignature configuration variable
Date:	Wed, 22 Jun 2016 22:21:26 +0530
Message-Id: <20160622165126.12786-4-mehul.jain2029@gmail.com>
X-Mailer: git-send-email 2.9.0.rc0.dirty
In-Reply-To: <20160622165126.12786-1-mehul.jain2029@gmail.com>
References: <20160622165126.12786-1-mehul.jain2029@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Users may want to always use "--show-signature" while using git-log and
related commands.

When log.showSignature is set to true, git-log and related commands will
behave as if "--show-signature" was given to them.

Note that this config variable is meant to affect git-log, git-show,
git-whatchanged and git-reflog. Other commands like git-format-patch,
git-rev-list are not to be affected by this config variable.

Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 Documentation/git-log.txt |  4 ++++
 builtin/log.c             |  6 ++++++
 t/t4202-log.sh            | 20 ++++++++++++++++++++
 t/t7510-signed-commit.sh  |  7 +++++++
 4 files changed, 37 insertions(+)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 03f9580..bbb5adc 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -196,6 +196,10 @@ log.showRoot::
 	`git log -p` output would be shown without a diff attached.
 	The default is `true`.
 
+log.showSignature::
+	If `true`, `git log` and related commands will act as if the
+	`--show-signature` option was passed to them.
+
 mailmap.*::
 	See linkgit:git-shortlog[1].
 
diff --git a/builtin/log.c b/builtin/log.c
index 099f4f7..7103217 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -33,6 +33,7 @@ static const char *default_date_mode = NULL;
 static int default_abbrev_commit;
 static int default_show_root = 1;
 static int default_follow;
+static int default_show_signature;
 static int decoration_style;
 static int decoration_given;
 static int use_mailmap_config;
@@ -119,6 +120,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 	rev->abbrev_commit = default_abbrev_commit;
 	rev->show_root_diff = default_show_root;
 	rev->subject_prefix = fmt_patch_subject_prefix;
+	rev->show_signature = default_show_signature;
 	DIFF_OPT_SET(&rev->diffopt, ALLOW_TEXTCONV);
 
 	if (default_date_mode)
@@ -409,6 +411,10 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		use_mailmap_config = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "log.showsignature")) {
+		default_show_signature = git_config_bool(var, value);
+		return 0;
+	}
 
 	if (grep_config(var, value, cb) < 0)
 		return -1;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 93a82e9..ecac186 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -898,6 +898,26 @@ test_expect_success GPG '--no-show-signature overrides --show-signature' '
 	! grep "^gpg:" actual
 '
 
+test_expect_success GPG 'log.showsignature=true behaves like --show-signature' '
+	test_config log.showsignature true &&
+	git log -1 signed >actual &&
+	grep "gpg: Signature made" actual &&
+	grep "gpg: Good signature" actual
+'
+
+test_expect_success GPG '--no-show-signature overrides log.showsignature=true' '
+	test_config log.showsignature true &&
+	git log -1 --no-show-signature signed >actual &&
+	! grep "^gpg:" actual
+'
+
+test_expect_success GPG '--show-signature overrides log.showsignature=false' '
+	test_config log.showsignature false &&
+	git log -1 --show-signature signed >actual &&
+	grep "gpg: Signature made" actual &&
+	grep "gpg: Good signature" actual
+'
+
 test_expect_success 'log --graph --no-walk is forbidden' '
 	test_must_fail git log --graph --no-walk
 '
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 4177a86..6e839f5 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -210,4 +210,11 @@ test_expect_success GPG 'show lack of signature with custom format' '
 	test_cmp expect actual
 '
 
+test_expect_success GPG 'log.showsignature behaves like --show-signature' '
+	test_config log.showsignature true &&
+	git show initial >actual &&
+	grep "gpg: Signature made" actual &&
+	grep "gpg: Good signature" actual
+'
+
 test_done
-- 
2.9.0.rc0.dirty

