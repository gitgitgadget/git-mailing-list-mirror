From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 7/7] clone: allow an explicit argument for parallel submodule clones
Date: Wed, 24 Feb 2016 17:42:05 -0800
Message-ID: <1456364525-21190-8-git-send-email-sbeller@google.com>
References: <1456364525-21190-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 02:42:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYkwm-0000Lz-PS
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 02:42:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758264AbcBYBmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 20:42:22 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36309 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757934AbcBYBmT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 20:42:19 -0500
Received: by mail-pf0-f177.google.com with SMTP id e127so23125671pfe.3
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 17:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jQorMGYHCKDv/4vWESlVN1gqP3SSu1S7cFp64majnYg=;
        b=jBEv23+w/6ki1wAJHMGP+4z2Vb2tu87z1L7WPitA9fMr3/iPRfGrdHYhcLefLycrjG
         7LV7wJsA86H0cZsW83wIhCmv0wP+zrBlBScZv8U+d+Fhi2qQKC0aA9e/Xztvfu4oI5tQ
         vEhRmEgC0xCX1FvvuReGYo/9+dol7Gjf+vYaZCmrUt+d4mn7jkygLLw9Jx7E0FctsHyf
         Wn31U3A8mTJJIWPbOiATkBEBeWLDx6XiN7gEyu8uIDFy6GWvAwKDJ34ufWk8MIzGYGCR
         4A0jP5Xh7sS98jVdg8qxch88ldDEpmpDGKQgEOIjN0YZQtTRlVpaQ+hrrpbeM7KUdeTM
         9vQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jQorMGYHCKDv/4vWESlVN1gqP3SSu1S7cFp64majnYg=;
        b=NRN4RQYmlK29lJD4N0NmBMaWblWrCP5jVvXm9qNUTPAAaJKGavcGzntgkbO68dDw1c
         E3c/iThNplAYQZEfO527ALKL7fqVm991XbnJVKi3V+6GDvACCE31IDDVlj0Fj7AW27Ao
         EkcCAUIQAxumItWGyevhVuemgcbFCN4RM+FHeIYRo7pEjuVvXF01mQRYzGk1OS+6KJnR
         vymeDr36YNUdZ3hJ/4rAPrjP1GnB/sPym0T1I8uK8J5M/7pxgnfNOKs6Pc5W0FyXeZIU
         2GxXBIA2r23wuhkldAP8cscquRzbstNgbzC8sC2/B8yIRUvHva/CA8kBD8llEXJcqv3U
         2nMg==
X-Gm-Message-State: AG10YORBfywlkFA4EvJ7V7kAlM7i97w0ygCoRvG7R6cUIx804LePNhUFy+uYBHrlEDje/y6n
X-Received: by 10.98.68.73 with SMTP id r70mr60119470pfa.136.1456364539009;
        Wed, 24 Feb 2016 17:42:19 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:74de:af7a:dfba:15a4])
        by smtp.gmail.com with ESMTPSA id wt2sm7700604pac.48.2016.02.24.17.42.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 17:42:18 -0800 (PST)
X-Mailer: git-send-email 2.7.2.335.g3f96d05
In-Reply-To: <1456364525-21190-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287306>

Just pass it along to "git submodule update", which may pick reasonable
defaults if you don't specify an explicit number.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-clone.txt |  6 +++++-
 builtin/clone.c             | 19 +++++++++++++------
 t/t7406-submodule-update.sh | 15 +++++++++++++++
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 6bf000d..6db7b6d 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch]
-	  [--recursive | --recurse-submodules] [--] <repository>
+	  [--recursive | --recurse-submodules] [--jobs <n>] [--] <repository>
 	  [<directory>]
 
 DESCRIPTION
@@ -221,6 +221,10 @@ objects from the source repository into a pack in the cloned repository.
 	The result is Git repository can be separated from working
 	tree.
 
+-j <n>::
+--jobs <n>::
+	The number of submodules fetched at the same time.
+	Defaults to the `submodule.fetchJobs` option.
 
 <repository>::
 	The (possibly remote) repository to clone from.  See the
diff --git a/builtin/clone.c b/builtin/clone.c
index a0b3cd9..b004fb4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -50,6 +50,7 @@ static int option_progress = -1;
 static struct string_list option_config;
 static struct string_list option_reference;
 static int option_dissociate;
+static int max_jobs = -1;
 
 static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
@@ -72,6 +73,8 @@ static struct option builtin_clone_options[] = {
 		    N_("initialize submodules in the clone")),
 	OPT_BOOL(0, "recurse-submodules", &option_recursive,
 		    N_("initialize submodules in the clone")),
+	OPT_INTEGER('j', "jobs", &max_jobs,
+		    N_("number of submodules cloned in parallel")),
 	OPT_STRING(0, "template", &option_template, N_("template-directory"),
 		   N_("directory from which templates will be used")),
 	OPT_STRING_LIST(0, "reference", &option_reference, N_("repo"),
@@ -95,10 +98,6 @@ static struct option builtin_clone_options[] = {
 	OPT_END()
 };
 
-static const char *argv_submodule[] = {
-	"submodule", "update", "--init", "--recursive", NULL
-};
-
 static const char *get_repo_path_1(struct strbuf *path, int *is_bundle)
 {
 	static char *suffix[] = { "/.git", "", ".git/.git", ".git" };
@@ -724,8 +723,16 @@ static int checkout(void)
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   sha1_to_hex(sha1), "1", NULL);
 
-	if (!err && option_recursive)
-		err = run_command_v_opt(argv_submodule, RUN_GIT_CMD);
+	if (!err && option_recursive) {
+		struct argv_array args = ARGV_ARRAY_INIT;
+		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
+
+		if (max_jobs != -1)
+			argv_array_pushf(&args, "--jobs=%d", max_jobs);
+
+		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
+		argv_array_clear(&args);
+	}
 
 	return err;
 }
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 7fd5142..090891e 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -786,4 +786,19 @@ test_expect_success 'submodule update can be run in parallel' '
 	 grep "9 tasks" trace.out
 	)
 '
+
+test_expect_success 'git clone passes the parallel jobs config on to submodules' '
+	test_when_finished "rm -rf super4" &&
+	GIT_TRACE=$(pwd)/trace.out git clone --recurse-submodules --jobs 7 . super4 &&
+	grep "7 tasks" trace.out &&
+	rm -rf super4 &&
+	git config --global submodule.fetchJobs 8 &&
+	GIT_TRACE=$(pwd)/trace.out git clone --recurse-submodules . super4 &&
+	grep "8 tasks" trace.out &&
+	rm -rf super4 &&
+	GIT_TRACE=$(pwd)/trace.out git clone --recurse-submodules --jobs 9 . super4 &&
+	grep "9 tasks" trace.out &&
+	rm -rf super4
+'
+
 test_done
-- 
2.7.2.335.g3f96d05
