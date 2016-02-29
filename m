From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv20 11/12] submodule update: expose parallelism to the user
Date: Mon, 29 Feb 2016 11:14:09 -0800
Message-ID: <1456773250-5510-12-git-send-email-sbeller@google.com>
References: <1456773250-5510-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 29 20:14:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaTHL-0005nN-6x
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 20:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716AbcB2TOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 14:14:38 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36675 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641AbcB2TOe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 14:14:34 -0500
Received: by mail-pa0-f48.google.com with SMTP id yy13so96660250pab.3
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 11:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NLtgsqhuERci0kG8Y6glP6ery1TsZY1OSokDhSAoIF8=;
        b=cHdWFX+iZ7Ogwb6lALq10MGXe/XMLn87gJTDD2+KQB1i47dABFiCh2/7auSVEEBTWS
         OhAPPQjswVsb/03rkMIHctCoJjBP0+DQFYYWV7Aiv4veiyqkHD5YyZtElxwFxhO12MO7
         iPPWmc0Okrof2WJCJNbtJWuk+zNBStsb4Jx1Ff0zw7clk6J02KV6qR0Tk4X78SUxsGXj
         ULrNR7VkROI2UDX/d05EKmLoqgVjQHnU+m+0WB1Ixm5bwO53WB4HpAMTcj2nIXNv1uW7
         u22GxYKN7lbOHGpOuB/0FQYSvIdkJ3azphz4PnoeuDw+N3X78tn9PMF65QVSJxML8gG/
         e+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NLtgsqhuERci0kG8Y6glP6ery1TsZY1OSokDhSAoIF8=;
        b=KvVhLF6nbHPVIhGjLZZerDby9Fx9pItwLEyxfOZypBgMLDPLGXOj/nST7p0XBheQue
         1vCKToDafpwE1zzJhMPa3kpgoFfYCCi6o0gphLCywmmYKRUCTq2Kjrz7CbDFcWsjp1oJ
         i9f1wRteMstZc78gv7B1NjGr9PXf7T56KanT/iMwsqWUgebVfh08BGWNCCDmRkTEgHkF
         VRh3Ybx4CzSazezxFGIPbaCQ8IR7InZBQi7i1KJxUiGOEt5KgakirB5RXcSCZHdA6xAE
         d1akbrcOqkXdVsRbzQRc+LMWRI2Zr8syIbTTrrPTuMgpkN5lSe7Y5zGixz5StdQyOL9i
         8oeA==
X-Gm-Message-State: AD7BkJKNSY0YP/HgkAYWaoFtPQT+qWPLwstAwCcmK3K5tJqh3D62dU6oYqe8bROE8+w7MO8R
X-Received: by 10.67.30.163 with SMTP id kf3mr24470543pad.45.1456773272511;
        Mon, 29 Feb 2016 11:14:32 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e195:dbe1:d842:476])
        by smtp.gmail.com with ESMTPSA id z7sm39855358pfi.19.2016.02.29.11.14.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 11:14:31 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.37.gb7b9e8e
In-Reply-To: <1456773250-5510-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287883>

Expose possible parallelism either via the "--jobs" CLI parameter or
the "submodule.fetchJobs" setting.

By having the variable initialized to -1, we make sure 0 can be passed
into the parallel processing machine, which will then pick as many parallel
workers as there are CPUs.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-submodule.txt |  7 ++++++-
 builtin/submodule--helper.c     |  8 +++++++-
 git-submodule.sh                |  9 +++++++++
 t/t7406-submodule-update.sh     | 12 ++++++++++++
 4 files changed, 34 insertions(+), 2 deletions(-)

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
index a111fd2..1b0b13a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -433,6 +433,7 @@ static int update_clone_task_finished(int result,
 static int update_clone(int argc, const char **argv, const char *prefix)
 {
 	const char *update = NULL;
+	int max_jobs = -1;
 	struct string_list_item *item;
 	struct pathspec pathspec;
 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
@@ -453,6 +454,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "depth", &suc.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
 			      "specified number of revisions")),
+		OPT_INTEGER('j', "jobs", &max_jobs,
+			    N_("parallel jobs")),
 		OPT__QUIET(&suc.quiet, N_("don't print cloning progress")),
 		OPT_END()
 	};
@@ -480,7 +483,10 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	gitmodules_config();
 	git_config(submodule_config, NULL);
 
-	run_processes_parallel(1,
+	if (max_jobs < 0)
+		max_jobs = parallel_submodules();
+
+	run_processes_parallel(max_jobs,
 			       update_clone_get_next_task,
 			       update_clone_start_failure,
 			       update_clone_task_finished,
diff --git a/git-submodule.sh b/git-submodule.sh
index a6a82d2..86018ee 100755
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
@@ -671,6 +679,7 @@ cmd_update()
 		${update:+--update "$update"} \
 		${reference:+--reference "$reference"} \
 		${depth:+--depth "$depth"} \
+		${jobs:+$jobs} \
 		"$@" || echo "#unmatched"
 	} | {
 	err=
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
2.7.0.rc0.37.gb7b9e8e
