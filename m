From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 7/8] submodule update: expose parallelism to the user
Date: Mon, 11 Jan 2016 11:42:00 -0800
Message-ID: <1452541321-27810-8-git-send-email-sbeller@google.com>
References: <1452541321-27810-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de
To: sbeller@google.com, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 11 20:42:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIiMM-00057R-RR
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 20:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbcAKTmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 14:42:32 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35273 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964836AbcAKTmX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 14:42:23 -0500
Received: by mail-pf0-f177.google.com with SMTP id 65so49349806pff.2
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 11:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KMQVe6leVtvD21bSisvwswo2OYfUZ73A6fTtP1woQys=;
        b=hYUCBj1D+hbd5cQaD4/E8M4eNUJGRgVMwFZsjYaq/MIMbxr8sdct8Pf4jDsYR+jr8H
         XNYsGzAWSQJUgqSTTA4uwZNHAjkEgiI9ueIi+U0NRNjYYrRxwC+cJ5MVj5m01iUAx6gH
         RiFAY/gh5AEvc4aJcM2Sq3fAEE9H431f4W0yvVxTx1oGMait2QS6Noab1vTl7Ez4lNXX
         Iw6dFYCdkQKKJo/VTM4GdcdJUhNLvzgxl6mxaWE2Dv7Sb6ikKH1/8bNMZ2S3yiJR8MeX
         Iwnme4fsg2z290Z1Xdi6zLxRc0qsZhjBqQ1/MOjM1MrlyeHeY6b1A+VyIBiyVLlRXyOA
         B+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KMQVe6leVtvD21bSisvwswo2OYfUZ73A6fTtP1woQys=;
        b=YQRmuB1x7od5foCWR21c0WGNQPTQoIrxSCapuO7W5xumZsv+wLaWuOdhXGRr67HS9X
         gPxnrsbW4XnvVleOt3/X+Gf0II9snut+4VRN6xFTL/YULGm4fUuW9JXxjHetfOjJ/bjt
         xix+U/oHKkUAn0uJxROdLjjZMSW1bqBKSCyzruXH+/YHEMiwvEWoJfTW1we+OdZFADwQ
         ev/3tP7TOBLV5U6T5deYI1zvPrXUKAQLuGBf0V34JvIO5qVQrZI/aECyalpueZvaXdVe
         xH6GNI+b3Jwxa7N35rh4JTBbp0k4Rd3nTb4AxeyxTvDlp/9imi/qTzZRcHnOvFUjBIkX
         bzDw==
X-Gm-Message-State: ALoCoQnFcjhcwdrBKpTB1GeZe/uiY/6oyJmKfyOH/TiBtn96vFSpxGfCNVG+edIFyOSJW94qIJ7wvrAeVIyw7kW18G1CRYcJIQ==
X-Received: by 10.98.68.193 with SMTP id m62mr28452374pfi.153.1452541342508;
        Mon, 11 Jan 2016 11:42:22 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:8d8c:9316:e7e7:6f4f])
        by smtp.gmail.com with ESMTPSA id y18sm25070493pfi.84.2016.01.11.11.42.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 11 Jan 2016 11:42:21 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc1.7.gf4541cb.dirty
In-Reply-To: <1452541321-27810-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283707>

Expose possible parallelism either via the "--jobs" CLI parameter or
the "submodule.fetchJobs" setting.

By having the variable initialized to -1, we make sure 0 can be passed
into the parallel processing machine, which will then pick as many parallel
workers as there are CPUs.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-submodule.txt |  7 ++++++-
 builtin/submodule--helper.c     | 18 ++++++++++++++----
 git-submodule.sh                |  9 +++++++++
 t/t7406-submodule-update.sh     | 12 ++++++++++++
 4 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 1572f05..13adebf 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
 	      [-f|--force] [--rebase|--merge] [--reference <repository>]
-	      [--depth <depth>] [--recursive] [--] [<path>...]
+	      [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
@@ -377,6 +377,11 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
 	clone with a history truncated to the specified number of revisions.
 	See linkgit:git-clone[1]
 
+-j <n>::
+--jobs <n>::
+	This option is only valid for the update command.
+	Clone new submodules in parallel with as many jobs.
+	Defaults to the `submodule.fetchJobs` option.
 
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9441f20..8002187 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -426,6 +426,7 @@ static int update_clone_task_finished(int result,
 
 static int update_clone(int argc, const char **argv, const char *prefix)
 {
+	int max_jobs = -1;
 	struct string_list_item *item;
 	struct submodule_update_clone pp = SUBMODULE_UPDATE_CLONE_INIT;
 
@@ -446,6 +447,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "depth", &pp.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
 			      "specified number of revisions")),
+		OPT_INTEGER('j', "jobs", &max_jobs,
+			    N_("parallel jobs")),
 		OPT__QUIET(&pp.quiet, N_("do't print cloning progress")),
 		OPT_END()
 	};
@@ -467,10 +470,17 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	gitmodules_config();
 	/* Overlay the parsed .gitmodules file with .git/config */
 	git_config(git_submodule_config, NULL);
-	run_processes_parallel(1, update_clone_get_next_task,
-				  update_clone_start_failure,
-				  update_clone_task_finished,
-				  &pp);
+
+	if (max_jobs < 0)
+		max_jobs = config_parallel_submodules();
+	if (max_jobs < 0)
+		max_jobs = 1;
+
+	run_processes_parallel(max_jobs,
+			       update_clone_get_next_task,
+			       update_clone_start_failure,
+			       update_clone_task_finished,
+			       &pp);
 
 	if (pp.print_unmatched) {
 		printf("#unmatched\n");
diff --git a/git-submodule.sh b/git-submodule.sh
index 9f554fb..10c5af9 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -645,6 +645,14 @@ cmd_update()
 		--depth=*)
 			depth=$1
 			;;
+		-j|--jobs)
+			case "$2" in '') usage ;; esac
+			jobs="--jobs=$2"
+			shift
+			;;
+		--jobs=*)
+			jobs=$1
+			;;
 		--)
 			shift
 			break
@@ -670,6 +678,7 @@ cmd_update()
 		${update:+--update "$update"} \
 		${reference:+--reference "$reference"} \
 		${depth:+--depth "$depth"} \
+		${jobs:+$jobs} \
 		"$@" | {
 	err=
 	while read mode sha1 stage just_cloned sm_path
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index dda3929..7fd5142 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -774,4 +774,16 @@ test_expect_success 'submodule update --recursive drops module name before recur
 	 test_i18ngrep "Submodule path .deeper/submodule/subsubmodule.: checked out" actual
 	)
 '
+
+test_expect_success 'submodule update can be run in parallel' '
+	(cd super2 &&
+	 GIT_TRACE=$(pwd)/trace.out git submodule update --jobs 7 &&
+	 grep "7 tasks" trace.out &&
+	 git config submodule.fetchJobs 8 &&
+	 GIT_TRACE=$(pwd)/trace.out git submodule update &&
+	 grep "8 tasks" trace.out &&
+	 GIT_TRACE=$(pwd)/trace.out git submodule update --jobs 9 &&
+	 grep "9 tasks" trace.out
+	)
+'
 test_done
-- 
2.7.0.rc1.7.gf4541cb.dirty
