From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 8/8] clone: allow an explicit argument for parallel submodule clones
Date: Mon, 14 Dec 2015 14:54:25 -0800
Message-ID: <1450133665-3783-9-git-send-email-sbeller@google.com>
References: <1450133665-3783-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com, j6t@kdbg.org
To: sbeller@google.com, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 14 23:55:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8c20-0001bd-Tp
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 23:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbbLNWzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 17:55:42 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35510 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932572AbbLNWzI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 17:55:08 -0500
Received: by pff63 with SMTP id 63so18853075pff.2
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 14:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GFrdzgOUqkhL2arUjf84Xqno394pd5zeYYDgOJWK6No=;
        b=FaGMbv0wfjSlv317ADA3QFjlDbX2oI6lgiRx2ZiTrCJOo4f4UOKRdDpSycEpNPGNYJ
         nYNHGm2egxdtTLn+bzOTWLyjLbD7X8d/wG/mBJzV70sg5HY1yufVVX8BsiGEZQP3irlT
         tg4DX+ipltxo4btyiZQM8pY4HjrGLEVlAJUw5VJeshJFPkZ+uP2COypheGD/CQiMAZKR
         bnEBJqs3V8xRUOs34E0U2sucK7FQeTy6mKoXY2oc0fIdvRD7uTfPIweeQ4Reyvkc9WLK
         OP5ll65lNuBQJXRHdrADJ4ickMvf1QnQ+3dFIlf9uYP7EmaAL3IwMt51oJIpo2FKzrGl
         JWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GFrdzgOUqkhL2arUjf84Xqno394pd5zeYYDgOJWK6No=;
        b=FgzroH4M2wElWn1rK6+Wk/D5dt1EYNvpz2knnn0jR8/nQgXDubu6ZOag292AvG1kK3
         cRA/CyGTs6Fw6DymQegOUvCBNKnJdY8tXmOyjZRBs/ERi29y1DqkeguF5jd5EQDXqioU
         C9kqPMSndc2T0epOdfNtPdrVZGWiVr5SY15DWYiPjnHehaMMY8oR1TCqDRMcosFKcz2J
         zB3P2bcAYZqBs58BNxtW1V8jyKTVKEB15XhTFZD4TKNF8PA3a/YdvKxYdIua6rS0u5u4
         0HGDYqGGQWkrembu2st4X2r2yweNf8K9qlvY6roOXwp03ZCe4bwxu1arxb68yRD/yUUL
         I5Rw==
X-Gm-Message-State: ALoCoQkcfgK0MXe2E6IxNQ1m7T1+pLvPO20zFcOIbtcROn73FtTAFbQfCcapuWwnG2ZGgkRFuisWajXopsBtu9Qm7+DgBxuDEg==
X-Received: by 10.98.18.157 with SMTP id 29mr39319059pfs.43.1450133707470;
        Mon, 14 Dec 2015 14:55:07 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e502:49aa:9791:cefa])
        by smtp.gmail.com with ESMTPSA id y83sm44465991pfi.85.2015.12.14.14.55.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 14 Dec 2015 14:55:06 -0800 (PST)
X-Mailer: git-send-email 2.6.4.443.ge094245.dirty
In-Reply-To: <1450133665-3783-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282439>

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
2.6.4.443.ge094245.dirty
