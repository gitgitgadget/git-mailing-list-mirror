From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 8/8] clone: allow an explicit argument for parallel submodule clones
Date: Mon, 11 Jan 2016 11:42:01 -0800
Message-ID: <1452541321-27810-9-git-send-email-sbeller@google.com>
References: <1452541321-27810-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de
To: sbeller@google.com, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 11 20:42:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIiMT-0005Dz-6H
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 20:42:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbcAKTma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 14:42:30 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35869 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964840AbcAKTmY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 14:42:24 -0500
Received: by mail-pa0-f42.google.com with SMTP id yy13so233360790pab.3
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 11:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JsZVyCVGG2+84pNsZC0hlqQSu1i4DBp5veZLUeshTKU=;
        b=ESpVHKWhddH483nVtHRNwxKHFev6TJUy/NpZSD1fEQthM/qI9a0ZNFSUNtcbb5vO//
         2dBvAFpaXYH5oQVb6bOxCDzarbGsrnsv1PKHVnKQxegXdhhPawHyzIBFCwD+ODllifXa
         GZYY8gWxTd5ytAksrYx4IWrY/htf8EsWpnpEO93jRQqawCcDQ9vkHf12sgFXfZiIBn7a
         lWgmTQO6WMHuyynSCFXhLU1RNZYcVdBldCqSq+Zg7uzoMlRTWgKU+UMQ67G2ahotCRnQ
         8cFjIAXVMcNywv33SWUfdmN0LnEsaBs4zukjMt+dONGc++7/7l9CsRnR4IPNfSokIf4w
         z04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JsZVyCVGG2+84pNsZC0hlqQSu1i4DBp5veZLUeshTKU=;
        b=IYyumhPGwXVB5HPjEFKgpobOuk4WTCa5B0YDPwk7uv/9WJdoylAlIMVDDdsY5xEJc4
         vgVRQGg7uFwe7716QfeIAAzSKGKdDhckn299EsraiF2v0nE4HQGybAI8HfJzmOHKRmVg
         wguRJHINcIy+vMSEXNQHXC58JrTHQ4ZxsFxA2PxK9Ty45UEXb37Kp6HT17tbQiTd5WZ1
         f/n19yNRbPNnqhZO1txw3M1gvgNJHSFVAAPnd/tXipvCk82jacmDrgkyB8OQHqdBf55B
         9AS7138ustqPc+1QhBxMSWNPiwdeu/Eu0wwgEgPsvvYjTOizOXX1WA0DhRM/QHYyS8nb
         nhbQ==
X-Gm-Message-State: ALoCoQlLwsURajxpHY2m9RVL6W3Xs9sVLHY5FY4+PSehLkkTsnVg435BMa6HxH9ZE+dyRmOW+sZyT8c/E7i8eFcsQqctQWqd5A==
X-Received: by 10.66.227.35 with SMTP id rx3mr181701534pac.3.1452541343728;
        Mon, 11 Jan 2016 11:42:23 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:8d8c:9316:e7e7:6f4f])
        by smtp.gmail.com with ESMTPSA id xr8sm187547601pab.26.2016.01.11.11.42.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 11 Jan 2016 11:42:23 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc1.7.gf4541cb.dirty
In-Reply-To: <1452541321-27810-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283710>

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
2.7.0.rc1.7.gf4541cb.dirty
