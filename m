From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 8/8] clone: allow an explicit argument for parallel submodule clones
Date: Tue,  2 Feb 2016 09:51:37 -0800
Message-ID: <1454435497-26429-9-git-send-email-sbeller@google.com>
References: <1454435497-26429-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Feb 02 18:52:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQf7W-0002BP-Oh
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 18:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933293AbcBBRwC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 12:52:02 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35733 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933171AbcBBRv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 12:51:57 -0500
Received: by mail-pa0-f45.google.com with SMTP id ho8so102596115pac.2
        for <git@vger.kernel.org>; Tue, 02 Feb 2016 09:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IUZplBvaqWmtTj0K4k4MYWKcxZX4aNq62G/uH+7CocI=;
        b=HaPP3HIhbGHA0YDwOQyihYx0CeH9RM352U/qTmhXS/tm92r5Yp9wBUlUR9azemK+v/
         SW8Rg0ESboOMRPzvxzx/sNdbXLaoX8k/SManHP8njpMt8rvLi69pajVfvZaxpO1cgS7f
         Ha+m8YUdT8BmUjIGg0QRaa0cr0ik8fmfFQS1Ge3qotw6PeC2YdnxjAIqnAyto5tn+iM7
         PGCdW0b4r8YtY5rMb6hF1eEBhyxJUUmHY0Ge27GvQRxJVMINGvWkE5XvweyP5OpxJXeS
         7QaGMV9HDqqp80b3cuPcxdpLcSUIjg1AC6ETaXipsCYoOFsyiFLrqskTOnx3jFs3dl49
         7w7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IUZplBvaqWmtTj0K4k4MYWKcxZX4aNq62G/uH+7CocI=;
        b=kZb13qZEWCjmqr3LAjR84z7Wm6tu0D4Rmd0K2SUxxbyYsfiQNUTIs+Vkqv/GoUPqo6
         R50ar8Xqbji/thdEYH58snQG5kGBxdEFW/yVesEzMimB3CAZ5BOjEtyhMmBUvRFfgVjq
         kPl+lJRpn+KpUD2x2a8/gJg7GXt/nMW/bH7AbWYG/wcYEKw3KC4SF32yeDzSsig8FPmX
         XWfdiicw+wpcPHhRuy+m1hnj7m2IyUhG9brHxNLyNTIg+RTWIfQJU5YzAkQqkXQtyHu4
         67wKVBVI74y6/CaDVdyVQCGMl3dDaAq41Rk+m5aP8Xv/5jhGjvazzaIN+WTG7eSh/t2E
         o19A==
X-Gm-Message-State: AG10YOTmmJ94Wgmj+SIM9FC7PZszyAVpknEztUlyZC5cIkLiLe81zcYry8EkmiV05SYaUyTO
X-Received: by 10.66.144.37 with SMTP id sj5mr48530803pab.69.1454435516332;
        Tue, 02 Feb 2016 09:51:56 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:11e1:ff63:6d72:465a])
        by smtp.gmail.com with ESMTPSA id kw10sm4188479pab.0.2016.02.02.09.51.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 Feb 2016 09:51:55 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.42.ge5f5e2d
In-Reply-To: <1454435497-26429-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285288>

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
2.7.0.rc0.42.ge5f5e2d
