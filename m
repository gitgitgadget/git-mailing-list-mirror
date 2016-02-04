From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv8 9/9] clone: allow an explicit argument for parallel submodule clones
Date: Thu,  4 Feb 2016 14:09:36 -0800
Message-ID: <1454623776-3347-10-git-send-email-sbeller@google.com>
References: <1454623776-3347-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 04 23:10:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRS6I-0007S4-4t
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 23:10:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965565AbcBDWJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 17:09:59 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36015 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756801AbcBDWJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 17:09:57 -0500
Received: by mail-pf0-f174.google.com with SMTP id n128so56329871pfn.3
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 14:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Obb21QtuLORNbFEyn2yhgbyUwAaXfjdfFpA70OEPVY8=;
        b=Am4tFkb8EklJmnCELNn4AhWMNrPF80xqhgtw9B2/HkUNZD8BMQ2uom0qtzchXC3LH+
         V6g2PncZ6FSPfRkOb7k2ZTqehcKgKlr45syVjGa0cOo82f7wqJq1rvMUNvEMGJOibUUY
         H+8cr6uUrTEIMW8W1mJeKrihVOdlF72fqi5z505zvehdXLuC34AS+nYQagHbvpyDfyhV
         VgY/yJhCvfX/HykjrRyiiCBnLeZxVflc4n+nDOHOVVIoCgrY7ZGGLQ7jw/HDROO/edv8
         7aoONhjF7ZqdC4LzGkH2/zlqB/sF+A8r6CzKTnR+Jc8c/4TzW7myaCD7N4DH1vcDTxwb
         lJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Obb21QtuLORNbFEyn2yhgbyUwAaXfjdfFpA70OEPVY8=;
        b=llbd5+zNower2rNxHc4FKge4nSCpvBP4sA7x4s1IGm1NHgz9njOTtEDRtG6svJw1V2
         YSiDRnjQa8LSneqrIjpIAz5jp5dpBoeCGQuygEYNKSkuTmaugsMD+RKC5Y3edSJee1sB
         phmtOs+IAdRbNs16Emkb0h+Bbp7tOKCDKRDu9SFBvQWQkH2YSqFniNqw8nH5pBMt5O4Q
         yfOJCQ99NaRVNVMBsQy8penxzBf3Z3D9Zg+6ENat2JkHA92Gm9vu/+chn+yLqDUDgp6O
         EEy2QLyl0SChlYceU2dW0pPxS80h+3OvCpq4sqgbYheQqDnhJsWmraW789kQkUvOfLmt
         B5Zw==
X-Gm-Message-State: AG10YOSArRR1zn/qLfzZ4HqWrr9is9+gYBXqkawuZIK+GlhNgr6CNYXCPPIVcPSGYaVKFXbY
X-Received: by 10.98.89.78 with SMTP id n75mr14515262pfb.120.1454623796164;
        Thu, 04 Feb 2016 14:09:56 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5194:ebf5:4051:c1fd])
        by smtp.gmail.com with ESMTPSA id l62sm19447091pfj.7.2016.02.04.14.09.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 04 Feb 2016 14:09:55 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.41.gd102984.dirty
In-Reply-To: <1454623776-3347-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285503>

Just pass it along to "git submodule update", which may pick reasonable
defaults if you don't specify an explicit number.

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
2.7.0.rc0.41.gd102984.dirty
