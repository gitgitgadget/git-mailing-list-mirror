From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/9] clone: allow an explicit argument for parallel submodule clones
Date: Tue, 27 Oct 2015 11:15:50 -0700
Message-ID: <1445969753-418-7-git-send-email-sbeller@google.com>
References: <1445969753-418-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 19:16:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr8nB-00035m-UF
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 19:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbbJ0SQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 14:16:13 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36128 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965104AbbJ0SQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 14:16:09 -0400
Received: by pacfv9 with SMTP id fv9so239723017pac.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 11:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lbEWj7iPIAigCmlzxqqrakbn/jWhunJAirgyWXI1Y+c=;
        b=WDitqi76asrX9/PfKcSmRh/H07R7wVcOYYCAwlR9eqc1bwiQTwHfF6qEhzIy+0xC/I
         nfUbUBgploZRKr9n93aNL3xOvRtpNwiqyxdHOuwk/bWYVVaNXbtOAf3r5FDHSLxZqJMQ
         WjPKTrqAF+KV4COmCy3rUabYyvG5BDVeByIE4QwAffBgdCMZ4fwrb9oz1sozPcGDdMSL
         Pq0/vr8r0KQNMpmi4KJ8w3p1rWKKglkgUiJYDKwjQ47TQkwqWrfpdo9CEi69Tu8jmHur
         G87lI3qVvcJlvxdWgDHdGY19jJJw+MxP5B12esm8mDQefIPfo27jsNfQlxKkzsn6RAFP
         AL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lbEWj7iPIAigCmlzxqqrakbn/jWhunJAirgyWXI1Y+c=;
        b=T9na0+RZJTn+o9ZJwIJTpNMTVwS+a70UKFOw+Uz3rQVZ1ko4W5iTTF9TVV6to0P5Rs
         33OadBGaQajSGdCQhQWN1ivVjmyqzBMNEas0bRZEguUIEdsMRUC/MInLICYMEgYRLQkv
         yOY7d/V+ussyIX00UBqtB37VXuGZE03SMqy0YofYWP8KM57sLnLd1m87XI+rC3mkejqs
         iYPFyLye3QDm8NhRSkjsY6YJ/pb+GJ4Ff7fwFug4B558bENXr7WXhH8NZKcR1wdkaVrq
         Dgxp4qidrvZrVSnJcD1Du2ZUSZehZg4Uo45H1hmOJcbjpwb3jnT2/Ll0xOYdjW8Jw9zz
         vVfw==
X-Gm-Message-State: ALoCoQlAAoL3Oey1zjcYPhQNHkSqgy18pokRhd7A/UjcEOrytfcaqktNUaZJSB34xW8ZyYjTxuqT
X-Received: by 10.66.63.34 with SMTP id d2mr9138858pas.80.1445969768410;
        Tue, 27 Oct 2015 11:16:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:582c:77b:3135:2d26])
        by smtp.gmail.com with ESMTPSA id be3sm40853757pbc.88.2015.10.27.11.16.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 27 Oct 2015 11:16:07 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.283.g1a79c94.dirty
In-Reply-To: <1445969753-418-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280275>

Just pass it along to "git submodule update", which may pick reasonable
defaults if you don't specify an explicit number.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-clone.txt |  5 ++++-
 builtin/clone.c             | 26 ++++++++++++++++++++------
 t/t7406-submodule-update.sh | 15 +++++++++++++++
 3 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index f1f2a3f..affa52e 100644
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
@@ -216,6 +216,9 @@ objects from the source repository into a pack in the cloned repository.
 	The result is Git repository can be separated from working
 	tree.
 
+-j::
+--jobs::
+	The number of submodules fetched at the same time.
 
 <repository>::
 	The (possibly remote) repository to clone from.  See the
diff --git a/builtin/clone.c b/builtin/clone.c
index 5864ad1..b8b1d4c 100644
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
@@ -674,8 +673,23 @@ static int checkout(void)
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   sha1_to_hex(sha1), "1", NULL);
 
-	if (!err && option_recursive)
-		err = run_command_v_opt(argv_submodule, RUN_GIT_CMD);
+	if (!err && option_recursive) {
+		struct argv_array args = ARGV_ARRAY_INIT;
+		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
+
+		if (max_jobs == -1)
+			if (git_config_get_int("submodule.jobs", &max_jobs))
+				max_jobs = 1;
+		if (max_jobs != 1) {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_addf(&sb, "--jobs=%d", max_jobs);
+			argv_array_push(&args, sb.buf);
+			strbuf_release(&sb);
+		}
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
2.5.0.283.g1a79c94.dirty
