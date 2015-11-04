From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 11/11] clone: allow an explicit argument for parallel submodule clones
Date: Tue,  3 Nov 2015 16:37:14 -0800
Message-ID: <1446597434-1740-12-git-send-email-sbeller@google.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 01:37:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztm57-0002qW-4G
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 01:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbbKDAhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 19:37:38 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33557 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965059AbbKDAhc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 19:37:32 -0500
Received: by pabfh17 with SMTP id fh17so33775033pab.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 16:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YO2mA4hm4Ir84w/QjVQbw0lvuLexfvC7F21aLgap968=;
        b=AkXaJYPP/9WofN8UHH9KVYDI4yGPRPjigIaRxSTv8ZMqZ5ZGLdOcsbyrXvh8z+zixA
         t6m8B/AICGLLwYT8VYBru6SpArteZbirZ81LnU5UtuYF7l3QFh4f1Zuj0bgXbn6edWXB
         oiUApsZ7Pri0WUtUuhN+TEerMLfMIZfE4m7QBYvexFiubAAcVrCe3ziPUGFZ8mr5AQEo
         zVGyIavObXfbXyft9AyB8DPEDQP9SdxRLWqYVvZb0o9dlBZlcwW73rfoVSQAG4VReF9z
         HX2rrhYtx1GYAWMahqt/5CqmOQp6Yby0ylNovbq0hsIsiXSysopHxKY7zl9MlZsUm5sM
         j53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YO2mA4hm4Ir84w/QjVQbw0lvuLexfvC7F21aLgap968=;
        b=miUEAXhIq6UqBE3T6BvE+523znG+AjsDGkhjw3iePQkxlQkpSCnyZpHLDJugwPyOdU
         Rnz/SBghaMVv2vb3hLub8tWa+Y9y9GIpTgduE7HtPd9cWjPsrcJSwwVxYICuwmvUOZ6N
         oCkwXUHFPQeErhwpXUc+EmuWPewSaRkHqoe8x9pfRFR55ILydbhM6kRaDRltllXLEmX7
         19mVRsCGVh/IsbzFLKO/7awiESDfZwumF46W6jWEKfuPqEHurhpYadfGAif5i4Di8gyQ
         OyPOeCKGLvrS9oJ2rIMAeYV3iOiIyRNRDaaEj5vpr3uuLouFeC+aF1JPwJo1e+PBM+aA
         qk9A==
X-Gm-Message-State: ALoCoQkGxhfzMFNG+u9NoHi0ur//6DRern2QHZy7tEbw+dZznPsxjlawwhnN9NJeud2jtIT+zmT5
X-Received: by 10.66.123.72 with SMTP id ly8mr36964861pab.92.1446597451592;
        Tue, 03 Nov 2015 16:37:31 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:799e:c67e:2702:f55])
        by smtp.gmail.com with ESMTPSA id hi4sm5669567pbc.7.2015.11.03.16.37.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 03 Nov 2015 16:37:31 -0800 (PST)
X-Mailer: git-send-email 2.6.1.247.ge8f2a41.dirty
In-Reply-To: <1446597434-1740-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280838>

Just pass it along to "git submodule update", which may pick reasonable
defaults if you don't specify an explicit number.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-clone.txt |  6 +++++-
 builtin/clone.c             | 19 +++++++++++++------
 t/t7406-submodule-update.sh | 15 +++++++++++++++
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index f1f2a3f..01bd6b7 100644
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
@@ -216,6 +216,10 @@ objects from the source repository into a pack in the cloned repository.
 	The result is Git repository can be separated from working
 	tree.
 
+-j <n>::
+--jobs <n>::
+	The number of submodules fetched at the same time.
+	Defaults to the `submodule.jobs` option.
 
 <repository>::
 	The (possibly remote) repository to clone from.  See the
diff --git a/builtin/clone.c b/builtin/clone.c
index 9eaecd9..ce578d2 100644
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
index 05ea66f..ade0524 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -786,4 +786,19 @@ test_expect_success 'submodule update can be run in parallel' '
 	 grep "9 children" trace.out
 	)
 '
+
+test_expect_success 'git clone passes the parallel jobs config on to submodules' '
+	test_when_finished "rm -rf super4" &&
+	GIT_TRACE=$(pwd)/trace.out git clone --recurse-submodules --jobs 7 . super4 &&
+	grep "7 children" trace.out &&
+	rm -rf super4 &&
+	git config --global submodule.jobs 8 &&
+	GIT_TRACE=$(pwd)/trace.out git clone --recurse-submodules . super4 &&
+	grep "8 children" trace.out &&
+	rm -rf super4 &&
+	GIT_TRACE=$(pwd)/trace.out git clone --recurse-submodules --jobs 9 . super4 &&
+	grep "9 children" trace.out &&
+	rm -rf super4
+'
+
 test_done
-- 
2.6.1.247.ge8f2a41.dirty
