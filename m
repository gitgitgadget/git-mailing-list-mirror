From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv14 7/7] clone: allow an explicit argument for parallel submodule clones
Date: Fri, 19 Feb 2016 10:17:13 -0800
Message-ID: <1455905833-7449-8-git-send-email-sbeller@google.com>
References: <1455905833-7449-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 19 19:17:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWpcg-00015c-CR
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 19:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992824AbcBSSRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 13:17:42 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35530 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992787AbcBSSR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 13:17:28 -0500
Received: by mail-pf0-f181.google.com with SMTP id c10so56721224pfc.2
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 10:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FjlxncsdxLfXcll22MX9JnhDCdVrfKtlxjxb3EK7DZo=;
        b=N222cNEIEH8tan1gUecf+wHYhgOhNWqMc52VpWldREXM0RaNm7AI6f+gK/qUon7kl0
         bnTnueEyB5fNP7BQUsTXENTR8CDE77sea8CqEjWtm3aSP2Vnm/+V1Ls9o8wu9gzy36uX
         PGZbKopU0jbERZGVqphZRe9o2m8jMAVcEHkL/JAUe3gDyKMXysKSs0jwx6sVoA0mT6ey
         VvODYvkAthwkmsR9cJHRrU8vzYpmIh4U7Bd3p17Sz4V1tQTgGgXxwpJAEpKZsko4eVYe
         IBdy1/MBy7uAiVKQLeE+qroxRxGpf8vWdSFbQAqwP/ci0/UfG3HfJ5XkXZ4CoNg0HRsX
         JQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FjlxncsdxLfXcll22MX9JnhDCdVrfKtlxjxb3EK7DZo=;
        b=Kt3NxjA3oATUmNwOzvM+C0OaeBqJUz1QwswUpeuR0M6Tu1QZFLVLmlQbjUT0dtL2UW
         AesX4/vQEM72UbzzDXotoKZ1YDtiNU5sJcyahK8e4OO8aOFt/QP6WQ9vcYa+dsBIqzAH
         WKLLZB6SQbT1VwOkVHkJrUjNFcX+NFpU103ARvV3ncUZ2E7xK/vJLp0HYEO6vKE0tBZ0
         pCaPFiQBJ6TVxNh1wVyUjcEeK0v6dw2Z1FB7S2oMdetj5PO8gR0CzMvyyUo/+5+akYaD
         BFvMCF3yRMV1E1nXAuoV3tx4jk7gySL4qxeCh4YeBPhXx5MecHDszeQ2SPTD+1dUHmfV
         vBXA==
X-Gm-Message-State: AG10YOQk0Eut9zWCQDDtiou9VQ3g9ED3nFUQEm6+Tj7nI9stoWnC/H1HNL4k5QrLpt+KeP6v
X-Received: by 10.98.65.206 with SMTP id g75mr20052667pfd.94.1455905847819;
        Fri, 19 Feb 2016 10:17:27 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:d444:f36c:1851:bb54])
        by smtp.gmail.com with ESMTPSA id w89sm19348157pfi.13.2016.02.19.10.17.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 19 Feb 2016 10:17:26 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.ga06e0b3.dirty
In-Reply-To: <1455905833-7449-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286729>

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
2.7.0.rc0.34.ga06e0b3.dirty
