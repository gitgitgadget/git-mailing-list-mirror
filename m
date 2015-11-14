From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 9/9] clone: allow an explicit argument for parallel submodule clones
Date: Fri, 13 Nov 2015 17:07:02 -0800
Message-ID: <1447463222-12589-10-git-send-email-sbeller@google.com>
References: <1447463222-12589-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 02:07:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxPJW-0003VQ-HA
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 02:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbbKNBH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 20:07:29 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34587 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835AbbKNBHY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 20:07:24 -0500
Received: by padhx2 with SMTP id hx2so115654777pad.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 17:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZH42SqzW6KULihcuk/UrLt8MvT3VwFLl/AWFFci8Ua8=;
        b=nTptVjzo+ADUFIaD1rt+uCkNvJMUFHNe/GGlrqvYS7bAvaAqWA/amzlTsvdu12zYCT
         lu/j4g13stgh+Zq17gfb1tTIDDGaZc8bklxJMpT6NQeCDBExxZFDMCVZaZrseDN+quV5
         O6twIIG2zuaIOitJrnZWsUpb9jYeEi++V44AlkSNhKSUcn1GC0QYva4CQoUDoiGUKI8q
         gNSdqVtqFjXE9HqZKDVStYSsJWqz2ylul8s+71cAwkF4vKZuMdoxr5FrNjv30Yytwt6T
         JFv4YDgJhiZpKIR2/JDbH4olC8/SpX0ZGdYgREDfsQ4UxXl+Eb7HCVl9k3Iz23MSEekx
         7R4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZH42SqzW6KULihcuk/UrLt8MvT3VwFLl/AWFFci8Ua8=;
        b=fP1OAtN1bqT9glmqYfc9XsMfTo80FvrymppNOXa6zbrbsO6CySgSCQRLSffD/1EdGF
         ++1eWweoPUzJsQ2P/jaIQ2BB9bVtRtm62IugioClGtNFNGQYiz+YjRfVTgyia2AOvHk7
         nK5kaJgwwrdZotwHaCMzOsEe8DmL5+XqdJzdHe0Ov9D1CiBOUng4n/HEDis4X7LTIrjL
         AHuQaDWaDXPcUrI76+cgvr7QwD7kWaeaR9k3AxN94izxSrQejyAkhEsJSj0XvwHKfAQ2
         18BUKVFH3cCauD6M7fp1/kXp/XRwIXbhgIpXmO0Jnjwr2O9pYx3LmOREjZQmHgsU8rUv
         1LBw==
X-Gm-Message-State: ALoCoQmzdKY79xGyMQysRSnrtGwvMmOxa+WpIMZsQ2CFBwPz+vBh98g/IIwDXdRbd5/qTW/uZ0IA
X-Received: by 10.68.194.227 with SMTP id hz3mr36294458pbc.105.1447463244176;
        Fri, 13 Nov 2015 17:07:24 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:f5eb:b7b9:3afa:a95c])
        by smtp.gmail.com with ESMTPSA id jp1sm20484027pbc.54.2015.11.13.17.07.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 13 Nov 2015 17:07:23 -0800 (PST)
X-Mailer: git-send-email 2.6.3.369.gea52ac0
In-Reply-To: <1447463222-12589-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281294>

Just pass it along to "git submodule update", which may pick reasonable
defaults if you don't specify an explicit number.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-clone.txt |  6 +++++-
 builtin/clone.c             | 19 +++++++++++++------
 t/t7406-submodule-update.sh | 15 +++++++++++++++
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index f1f2a3f..59d8c67 100644
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
+	Defaults to the `submodule.fetchJobs` option.
 
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
2.6.3.369.gea52ac0
