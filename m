From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv13 7/7] clone: allow an explicit argument for parallel submodule clones
Date: Thu, 18 Feb 2016 15:33:18 -0800
Message-ID: <1455838398-12379-8-git-send-email-sbeller@google.com>
References: <1455838398-12379-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 19 00:33:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWY4x-00049V-3j
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 00:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1948694AbcBRXdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 18:33:36 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35227 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1948692AbcBRXdc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 18:33:32 -0500
Received: by mail-pa0-f54.google.com with SMTP id ho8so40122956pac.2
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 15:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q5GnELQU6xj/KyZJqMAwpSZoLzKER+i0CKXD87Sz+bM=;
        b=bW0oTEAnmT1JTksdumgBQ6EYbRWC+XpXO6zjZGkosuOty9N2kcunX+F0CTZzDDTIx6
         1JrvyYsZvHQBzx8F/hnjMVD5LiCIA/408oJFjOvE1VKw5HZPQZ8NpqjBzob6uZ8QMwmh
         lhyDuf99V/lAHwjktoRswusHEkuM3m+bv7cE4pskpSJW0yo9vgKfLDHqhqt8LLJmxRJa
         BKRy2GyQi1rldrpW7PY8eZMtdk+dHCOuc+WpZ5cHOWZcu781tO/CI3YVdw85rftz5jdL
         UjtKgObpFVgaGYSouujYjZni8D/61knb5v3iXaf7Ne2OKlc6H6Al9mI85IgR+m7+evyi
         E+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q5GnELQU6xj/KyZJqMAwpSZoLzKER+i0CKXD87Sz+bM=;
        b=kmdMu3/XLUFxVxATT75P3qIcps7moitbWw13gE61sV5OP1rFp0H6pquzGsrJa+2kW6
         qJ2YKj0JhihN/xhvkasEtzGitdlf4zw31ne3yNzd6KbWqf8dQGE48D45FlvI02O2KIRb
         KM0oGuDJnfnua3gm+IKZU9geD53nLz5dTWVekQFzuxw80J/xzw4HJbEUaE6ZAdeG/3R2
         d9JLkPnzmQ/S9e+DSNUShCfEC65vYKUh8ZoPAMV90MU7AepWWW8xuHL9r/YSyTZ3GLU5
         bVp484mZ8CHAXIvYCaD1BB9Vls1iqHVAl4IdddQxUUd3JfaJxp3If+wTLJD/jM3IDx8f
         r+Ow==
X-Gm-Message-State: AG10YOTKs9tEpgEqE0nk3kRJmIWiBTLWT1l9aIPHSnIS3E1aUG18rsRCFyP7z+8z8h9y8t41
X-Received: by 10.66.144.134 with SMTP id sm6mr14162118pab.158.1455838411462;
        Thu, 18 Feb 2016 15:33:31 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:d444:f36c:1851:bb54])
        by smtp.gmail.com with ESMTPSA id k14sm12890691pfj.0.2016.02.18.15.33.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 Feb 2016 15:33:30 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.g65aed89
In-Reply-To: <1455838398-12379-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286650>

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
