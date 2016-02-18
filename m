From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv12 7/7] clone: allow an explicit argument for parallel submodule clones
Date: Thu, 18 Feb 2016 14:19:24 -0800
Message-ID: <1455833964-3629-8-git-send-email-sbeller@google.com>
References: <1455833964-3629-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 18 23:20:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWWvc-0005yK-4w
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 23:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946992AbcBRWTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 17:19:47 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36367 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965596AbcBRWTi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 17:19:38 -0500
Received: by mail-pf0-f175.google.com with SMTP id e127so38848860pfe.3
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 14:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q5GnELQU6xj/KyZJqMAwpSZoLzKER+i0CKXD87Sz+bM=;
        b=Ah05jExfEeBy5QJ7rHoSEq0VmmsVxnVp649sD2XqAma42Nj3LjuKFkwwQ5mQUHJYx8
         6cGP6DE1uIXi4X85ZuFRf5su0yvkLNpLklVAALy1ZfrPo5EbcGETNYaYGoUOvxZ4Zz2X
         VRY/MUiwdv52Fie3txmrorITyh2YrBMJBMZURdGVZQjQey2Rcm3QZaCI8pWFz/5PcshO
         zexjsk+4Ka9JLZa1Kc0oxBpvMjiaEPKURiBrPbAD7t9Mem4H6wFul6TpxBQyv3RbG4BP
         y6m241BIFWoZch5CoquDp5rw5X9e3OdK1t2V5R2ngjwHjTwEg2we/ZZbhQX8iZJqbGMI
         CI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q5GnELQU6xj/KyZJqMAwpSZoLzKER+i0CKXD87Sz+bM=;
        b=UEVuLUtu6Zz2dpmgCQtkz+Csp3nvIHwa884TK4T2LrnbwkRobeic5vqCrQNQ/yx3Cq
         qE7BuCijWz+u1N5Gg3HUVmGgIIvJrjyj4fXjdoqOsdCAiFopLziOLPT3K7shH8SnOqIE
         gDz4YCEZOxxuTzVRWh+xk6Sw+QCDVpfBnOq9PB3Nw3Ed0HV7fRzHpgjMX6hWYY8CA47G
         d6OJNuw2qs1HdJgie9vbFgHnUUbda3/uwTbcN/u+5JULODMQ0FxQecUSme/RVgq5r8y6
         0s0DD0MIrKvuJ/pFj8vXfDzlyzeKDV4URZRqiYiazx1gK/LmIZJAly/OzhDXjKXem9rZ
         j/Ng==
X-Gm-Message-State: AG10YOR9nXOcA/4fXsxR0vImu3XdRvvMt8AEVf1i12QwPXP7h+WPp3WQ/dOtvCjVLrHcqX1e
X-Received: by 10.98.64.26 with SMTP id n26mr13703004pfa.149.1455833978021;
        Thu, 18 Feb 2016 14:19:38 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:d444:f36c:1851:bb54])
        by smtp.gmail.com with ESMTPSA id o17sm12610743pfj.50.2016.02.18.14.19.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 Feb 2016 14:19:37 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.g65aed89
In-Reply-To: <1455833964-3629-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286632>

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
2.7.0.rc0.34.g65aed89
