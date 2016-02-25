From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv17 11/11] clone: allow an explicit argument for parallel submodule clones
Date: Wed, 24 Feb 2016 19:06:58 -0800
Message-ID: <1456369618-18127-12-git-send-email-sbeller@google.com>
References: <1456369618-18127-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 25 04:07:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYmHG-000116-JA
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 04:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759909AbcBYDHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 22:07:32 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36477 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759904AbcBYDHY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 22:07:24 -0500
Received: by mail-pa0-f41.google.com with SMTP id yy13so23776340pab.3
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 19:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iZLjz9rEmI/9mLbTIUpMnEhIX/lPAFuSGOVUYfFnigs=;
        b=DyjZoF18iKDSkooXApSRUDz6fXyz7x/goHHrFYtj0ZcBKeDZm4gNOeDSUfFzZqnUjA
         CxBP0MEHg6oV6NPbE9cjUnPrbRFQOZI3g0O3fdekyQCnL8R7Ojn6vHV08ftC5fMDG25Z
         ohw/VER+B4fmT+eg3Uazvh1GNqV7PswZ8fdBhfctboZEvL3AlzEDJNoZHbFK0oazpwmJ
         LonrXLn7pC0LfOZHGKw807XhsWPRj6YIysYhFRV7BVzxLKs8IvdyC1U3lko2Gj+a9SXF
         nSm3SFouYJ6jACDsseICUDkqGux8XA61ZfsjIa9ihzZ8yKyU8M2ROEQubbFI4xukXJz0
         ZdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iZLjz9rEmI/9mLbTIUpMnEhIX/lPAFuSGOVUYfFnigs=;
        b=EdKfDjywKn5iCVdRglovaBprPPEzq9iGFLBzVw1rcOskXnxMIdD95K1zQwxGW+c3IM
         ZNq7cScIQvbrGtY25h0XCndkxk4m2+G06LdyCKhPTCZVQRwRDy86kKhSXs6hrg3fXAv5
         wDzI6r95viUlCInr5UIDoCSowQSj8RdNui+vYwxX7vY0kiHe4a39Cf7jbTjeaZWVh6TI
         YE9eAxxWhg+oGJ/aSQ/gCl97z8gNRjcYTsSdhJ6l4ehMZFlOsqxvukucJd4M8tZN2ObR
         jPHUPJIV3keqogb9HYiwdmSX6KPVpD90wLdjxEPkd8isFZDQKl2JVbvjkDwMRI1XsXZ3
         PkzQ==
X-Gm-Message-State: AG10YORqrsme9fmiDwH74PE3k25llS/qfkOzYGpuIzO0J6R43HVqJARc6XvccHlgDeLfKuhk
X-Received: by 10.67.6.72 with SMTP id cs8mr59269827pad.138.1456369638265;
        Wed, 24 Feb 2016 19:07:18 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:74de:af7a:dfba:15a4])
        by smtp.gmail.com with ESMTPSA id m16sm7947252pfi.75.2016.02.24.19.07.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 19:07:17 -0800 (PST)
X-Mailer: git-send-email 2.7.2.373.g1655498.dirty
In-Reply-To: <1456369618-18127-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287322>

Just pass it along to "git submodule update", which may pick reasonable
defaults if you don't specify an explicit number.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
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
2.7.2.373.g1655498.dirty
