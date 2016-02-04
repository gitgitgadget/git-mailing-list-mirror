From: Dan Aloni <alonid@gmail.com>
Subject: [PATCH v4 2/3] Add user.useConfigOnly boolean for when ident shouldn't be guessed
Date: Thu,  4 Feb 2016 11:12:39 +0200
Message-ID: <1454577160-24484-3-git-send-email-alonid@gmail.com>
References: <1454577160-24484-1-git-send-email-alonid@gmail.com>
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:15:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRG17-00024p-0b
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965680AbcBDJPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 04:15:14 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38226 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965660AbcBDJOb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:14:31 -0500
Received: by mail-wm0-f54.google.com with SMTP id p63so107379991wmp.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yRRI3bxjFkOKCnpDGaxvqVwef2ZLfZrYjaEe2jpfAqI=;
        b=xHM5BmGw9Lhds74Pq3OQkR3DJtJ5rEjPGKITkhh4kcfJGRgOTVArvuVi2F7VoYSTd3
         lMPus6vtGiF/69IQcuiu8N348+12lTK/4p7pOjvKD0PZwLHiyQB4dC3KWbErtMTn0ZE8
         gSWKfZzxE2DGFN7uzDhu4xaewZA+C/PlIPFbBLgtpfKkUmKjZVlFk24l8SQ+cVRxLrEv
         jmwgtT7nizkZauZugmKjND8qUJXBI0u72qRiZ2IjqYa6ZBjHIdQiwnU9XNdd5Su5N4fl
         YfKqSNUaabZYNRYJHkL7IJvn2S8kVvu0AumvUs4ga7H4EdjQuwJzMGnNpjZHG3daNDm5
         RMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yRRI3bxjFkOKCnpDGaxvqVwef2ZLfZrYjaEe2jpfAqI=;
        b=NLAqnEaZjLs/RusxJJlx4DYWnnbc1L+WZkbKgJkM3o9TJPax8tPpY/6Fg4gRmxpgUz
         kyZfRTNC8w64wycIAZNYDbnp9CUG5KjZ2S62aN2s+ttlabatKCWucz+c7oXegbfpy6nG
         getvz0GLCnlgFT7o8kLFifHHdODvtiS/XEf2bL6ke5SWHqTQHvETUgwO4DyGwET17pTu
         V3VRwEQ+bWmIswcvEebyXlvhhK0Rha6bkYDhuxs2Zq6CmnmdMGTrkd9PfaykxJHRSnti
         Lt/NN04HEssSMtv1s2bP8Gn4LIYTQJbYy7W9Ta7+mHSzS3hbeNI1xJCbw8XcWkJWRRfa
         LPNQ==
X-Gm-Message-State: AG10YOQdKVGMLeZ6JPPIALXrmTGX9fWqKHBhx5CGTR831FK/0wuKqwKLFGY8wZhVYD6OHw==
X-Received: by 10.194.103.234 with SMTP id fz10mr7002481wjb.31.1454577270017;
        Thu, 04 Feb 2016 01:14:30 -0800 (PST)
Received: from nitrogen.home.aloni.org ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id c7sm10806435wmd.13.2016.02.04.01.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:14:29 -0800 (PST)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1454577160-24484-1-git-send-email-alonid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285443>

Previously, before 5498c57cdd63, many people did the following:

   git config --global user.email "(none)"

This was helpful for people with more than one email address,
targeting different email addresses for different clones.
as it barred git from creating commit unless the user.email
config was set in the per-repo config to the correct email
address.

This commit provides the same functionality by adding a new
configuration variable.

Signed-off-by: Dan Aloni <alonid@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
Cc: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
---
 Documentation/config.txt  |  9 ++++++++
 ident.c                   | 15 ++++++++++++
 t/t9904-per-repo-email.sh | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)
 create mode 100755 t/t9904-per-repo-email.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 02bcde6bb596..25cf7ce4e83a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2821,6 +2821,15 @@ user.name::
 	Can be overridden by the 'GIT_AUTHOR_NAME' and 'GIT_COMMITTER_NAME'
 	environment variables.  See linkgit:git-commit-tree[1].
 
+user.useConfigOnly::
+	This instruct Git to avoid trying to guess defaults for 'user.email'
+	and 'user.name' other than strictly from environment or config.
+	If you have multiple email addresses that you would like to set
+	up per repository, you may want to set this to 'true' in the global
+	config, and then Git would prompt you to set user.email separately,
+	in each of the cloned repositories.
+	Defaults to `false`.
+
 user.signingKey::
 	If linkgit:git-tag[1] or linkgit:git-commit[1] is not selecting the
 	key you want it to automatically when creating a signed tag or
diff --git a/ident.c b/ident.c
index f3a431f738cc..1216079d0b0d 100644
--- a/ident.c
+++ b/ident.c
@@ -13,11 +13,14 @@ static struct strbuf git_default_date = STRBUF_INIT;
 static int default_email_is_bogus;
 static int default_name_is_bogus;
 
+static int ident_use_config_only;
+
 #define IDENT_NAME_GIVEN 01
 #define IDENT_MAIL_GIVEN 02
 #define IDENT_ALL_GIVEN (IDENT_NAME_GIVEN|IDENT_MAIL_GIVEN)
 static int committer_ident_explicitly_given;
 static int author_ident_explicitly_given;
+static int ident_config_given;
 
 #ifdef NO_GECOS_IN_PWENT
 #define get_gecos(ignored) "&"
@@ -354,6 +357,9 @@ const char *fmt_ident(const char *name, const char *email,
 				fputs(env_hint, stderr);
 				die("unable to auto-detect name (got '%s')", name);
 			}
+			if (strict && ident_use_config_only &&
+			    !(ident_config_given & IDENT_NAME_GIVEN))
+				die("user.useConfigOnly set but no name given");
 		}
 		if (!*name) {
 			struct passwd *pw;
@@ -373,6 +379,8 @@ const char *fmt_ident(const char *name, const char *email,
 			fputs(env_hint, stderr);
 			die("unable to auto-detect email address (got '%s')", email);
 		}
+		if (strict && ident_use_config_only && !(ident_config_given & IDENT_MAIL_GIVEN))
+			die("user.useConfigOnly set but no mail given");
 	}
 
 	strbuf_reset(&ident);
@@ -446,6 +454,11 @@ int author_ident_sufficiently_given(void)
 
 int git_ident_config(const char *var, const char *value, void *data)
 {
+	if (!strcmp(var, "user.useconfigonly")) {
+		ident_use_config_only = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "user.name")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -453,6 +466,7 @@ int git_ident_config(const char *var, const char *value, void *data)
 		strbuf_addstr(&git_default_name, value);
 		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
 		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
+		ident_config_given |= IDENT_NAME_GIVEN;
 		return 0;
 	}
 
@@ -463,6 +477,7 @@ int git_ident_config(const char *var, const char *value, void *data)
 		strbuf_addstr(&git_default_email, value);
 		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
+		ident_config_given |= IDENT_MAIL_GIVEN;
 		return 0;
 	}
 
diff --git a/t/t9904-per-repo-email.sh b/t/t9904-per-repo-email.sh
new file mode 100755
index 000000000000..9522a640951b
--- /dev/null
+++ b/t/t9904-per-repo-email.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+#
+# Copyright (c) 2016 Dan Aloni
+#
+
+test_description='per-repo forced setting of email address'
+
+. ./test-lib.sh
+
+prepare () {
+        # Have a non-empty repository
+        rm -fr .git
+        git init
+	echo "Initial" >foo &&
+        git add foo &&
+        EDITOR=: VISUAL=: git commit -m foo &&
+
+	# Setup a likely user.useConfigOnly use case
+	unset GIT_AUTHOR_NAME &&
+	unset GIT_AUTHOR_EMAIL &&
+	test_unconfig --global user.name &&
+	test_unconfig --global user.email &&
+	test_config user.name "test" &&
+	test_unconfig user.email &&
+	test_config_global user.useConfigOnly true
+}
+
+about_to_commit () {
+	echo "Second" >>foo &&
+	git add foo
+}
+
+test_expect_success 'fails committing if clone email is not set' '
+        prepare && about_to_commit &&
+
+	EDITOR=: VISUAL=: test_must_fail git commit -m msg
+'
+
+test_expect_success 'fails committing if clone email is not set, but EMAIL set' '
+        prepare && about_to_commit &&
+
+	EMAIL=test@fail.com EDITOR=: VISUAL=: test_must_fail git commit -m msg
+'
+
+test_expect_success 'succeeds committing if clone email is set' '
+        prepare && about_to_commit &&
+
+	test_config user.email "test@ok.com" &&
+	EDITOR=: VISUAL=: git commit -m msg
+'
+
+test_expect_success 'succeeds cloning if global email is not set' '
+        prepare &&
+
+        git clone . clone
+'
+
+test_done
-- 
2.5.0
