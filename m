From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv20 12/12] clone: allow an explicit argument for parallel submodule clones
Date: Mon, 29 Feb 2016 11:14:10 -0800
Message-ID: <1456773250-5510-13-git-send-email-sbeller@google.com>
References: <1456773250-5510-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 29 20:14:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaTHN-0005nN-96
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 20:14:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792AbcB2TOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 14:14:46 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36689 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654AbcB2TOk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 14:14:40 -0500
Received: by mail-pa0-f52.google.com with SMTP id yy13so96660633pab.3
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 11:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QcI9craKrvBuYB1OhoeNKOY/+s295Zl//dmkY0ssYpA=;
        b=mEME84gWHlCpqvIIXMFNAbANps735IUMP5lPZY0xoFEPdfHIrIHvYoK4SAvIJpE0jV
         eKSeMUQW2NHwhUnJ8+NxyE6OJEslRPO/kid0nJAgREmT+FUNUjEhHJpeULzzk/qC5MgX
         lLoGC1BSbCuGb+HHfXg62797bNSeMtAUrZeP7FUnB0qak8E0T8CqmLSuMXLHTXi/ZSBU
         Lr6/dD4V53N8RmndNJpsNlqhnnkxBa2L3fQsAHNvdSzTkfeRXBzCZ3LxgJ5KfGdXgOBz
         1moJhF6bYLL1rRwE9ghLvX6hDOTh5CZGdEw8ULMpN/FyR8TmgbGLe4bF1Uewkv/GwDX6
         gpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QcI9craKrvBuYB1OhoeNKOY/+s295Zl//dmkY0ssYpA=;
        b=T8fC3jq0THZIHzw4XxxNafRzoZpqMQ0UeNOzxJhviFeK3Q0qN0L1vZv4YZIVl9fxUY
         PHmHz/24IjXM26piPM1M0m9xIe92m3paBLy5okcKQkl7sQlDGahiHSZwpsEolnMxfzpF
         q0auEYnFA0vMQnn0pVeqJDq/AnOCDuAYHf1Ypee+KQ/hPxVo4lcnsvv+v+3EA/bamZDz
         ZKZ4NaixxJIsj50TOA0yr4usXZbL6S0owsyGSsCvg/SB+sSL8ghDwkCHnCl745W9op1t
         IWmtIfYIBT0lEbARNCpbyfN7qlyohSNKS4/l36yezXIYssYG5VYZYvfcd/QZFmV+inNx
         kJyA==
X-Gm-Message-State: AD7BkJJovE6ePCvDo7W45X3cAtAZ2dTzVK/BcWiqXRP9Gjxsi9YS9dB5VrY8pcdCZtwSkxyn
X-Received: by 10.66.118.198 with SMTP id ko6mr24558332pab.11.1456773274103;
        Mon, 29 Feb 2016 11:14:34 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e195:dbe1:d842:476])
        by smtp.gmail.com with ESMTPSA id n28sm39884724pfa.45.2016.02.29.11.14.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 11:14:33 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.37.gb7b9e8e
In-Reply-To: <1456773250-5510-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287884>

Just pass it along to "git submodule update", which may pick reasonable
defaults if you don't specify an explicit number.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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
2.7.0.rc0.37.gb7b9e8e
