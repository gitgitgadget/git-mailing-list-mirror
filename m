From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 9/9] clone: allow an explicit argument for parallel submodule clones
Date: Tue, 24 Nov 2015 17:14:56 -0800
Message-ID: <1448414096-22021-10-git-send-email-sbeller@google.com>
References: <1448414096-22021-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 02:15:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1OgB-0001DR-Vc
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 02:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754974AbbKYBP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 20:15:26 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36511 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190AbbKYBPN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 20:15:13 -0500
Received: by pacdm15 with SMTP id dm15so39115886pac.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 17:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ncYyuEGsq81yUj9Z8PDMVxd3XcuEnEDxN88gvwNE/gk=;
        b=dR3F1P5kw5IOd80USxwjhm2VT0aQ49oaWDcbHqq8+LfSCotZz8rh3WmcTfI9aeW0mI
         5eYSDGDAFGc4i/irIpyESjMsxfwXGnF+7tDz1t1UDx3PV3P+3qDorsxgBFGjh8pJSzCw
         jMUobyFyEeFPnEFCB67Exh6e2NjLZhVaDJdZsDyMADW9iOKBc5z3gqeqYRVq/b5WnAbk
         gBW4QaKDerXvBwHYY78P66qwhX+5WfwPb9wVWbumJTsujvsL7JSq9EGV5iF9cIx05+hk
         RNysoCO9uxGqQOCO+UakUWDZmhvCud9ZLSzKemAtARpIoSV19VlPG6L4KX5JrNOP4ydo
         LLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ncYyuEGsq81yUj9Z8PDMVxd3XcuEnEDxN88gvwNE/gk=;
        b=jhFvdDN4vGj4H6nG+JbydpoqfK8Uvx38bKf3KLg+BvLMf9lQZ8oYE/R8TsvU0dkbfF
         YU+6znlpdjp7l8O/XmbnBqlBhnqeE3iBWWFhK+rrVzGf0SFg+unOKj3aLY8k0Y6goOO8
         Sv6Ef4HOT6MJ7T97PU2+z+4n3cwn/kB83V/tucazpSCFO6FbX7ZTbObZGzdCE8rYBjOg
         75ORtfbSY9F94heeZABDcFdcFqhLjR+iiK9S6GPQlHz4ogUliK7foKNARunpswh+NarO
         bFUCGTFUZM7KtBvc41jqsLjL6sFCCnXHMf2tUJttMk0sJ4aztEaCRDcxEX6SE9ug78Cm
         0fCA==
X-Gm-Message-State: ALoCoQnSeaXwo8xt+tKpeyBQjmhvsOh6DqVS8MPmOVrOc5i0FmNJdJNlu9vbC6agqAVhjHH4UWjY
X-Received: by 10.66.150.5 with SMTP id ue5mr46769851pab.42.1448414113232;
        Tue, 24 Nov 2015 17:15:13 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5407:71cc:c14:4343])
        by smtp.gmail.com with ESMTPSA id o2sm4083670pap.31.2015.11.24.17.15.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Nov 2015 17:15:12 -0800 (PST)
X-Mailer: git-send-email 2.6.1.261.g0d9c4c1
In-Reply-To: <1448414096-22021-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281666>

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
2.6.1.261.g0d9c4c1
