From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv15 4/5] submodule update: expose parallelism to the user
Date: Tue, 23 Feb 2016 19:20:16 -0800
Message-ID: <1456284017-26141-5-git-send-email-sbeller@google.com>
References: <1456284017-26141-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 24 04:22:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYQ1v-0006ei-4l
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 04:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755508AbcBXDWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 22:22:19 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33535 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755461AbcBXDWR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 22:22:17 -0500
Received: by mail-pf0-f174.google.com with SMTP id q63so4376993pfb.0
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 19:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WrAIajiN96rqdYxVLy2n2Tqd9zXnWWG5Bt/VivuMr7A=;
        b=GBu7UDmVy5kf9HjqFHQ7SQjJhLfwk/aPoWIF0EGlphXxZUjFZJv1zjehIwgjEYHEvD
         Gua9c1Zml+VzdueEuXAq962McPjGWGnrEPPwZTMjxzwUOp7P89oR6Ixv8pGSu7VZXk8p
         6/fmV+3KipnR0nS169gDfxmn+tPva/CP1LE4E6jXgHuzMAxxBfXthI/37SFrOEMIGGiU
         lOaBMm0CFwrVgxbA5jDTKZGj1CI2L7s1P/tbkZAecsu8TvSZeKJArdj29QktgwrS2M2R
         WtWbfxpgmtsK5JFILY0+eFhHNHqVIfoYQ0LXTPX+0Zm70yhgbRgMicCpkuMP3IeSNnyv
         NiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WrAIajiN96rqdYxVLy2n2Tqd9zXnWWG5Bt/VivuMr7A=;
        b=EHD7SF/XsAahQFaP8YbpIOiOmY+isM2woBGRrw3BOR0erDe/8ZiozlSK/1nsvxKXW8
         7oaQ6pv3afTB+I2bTvddq2dXP81Pc8Ajk/JzFDHaq9pBpaBRddt61svtBDOv2/a0eZX4
         Rbm7LJy2i1mSc18VYRjIvWMMRx+pmyLyD9Lh0DRAi3DmxmPoBDbtDC/9ODWo0EhTowNC
         qeQlWSayHThu4tokmizEnfas0xDdMVIl4/TxTiC4ee6zqgFWfm58xqju3J/UGphWwM8n
         licdNCIuPARhxUJ+AGT14oD6h42jpvvcttlhVtdsqGt94cHVch5dt6D7ykHAD50Qs1BZ
         6t+g==
X-Gm-Message-State: AG10YOTo974AHv8K5OoUK78mAz+UfF1MSMCz5aQcGrSTSyXLgffbXEdhymID/oOQ3scNlzBN
X-Received: by 10.98.16.198 with SMTP id 67mr51404471pfq.21.1456284136794;
        Tue, 23 Feb 2016 19:22:16 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a8b2:5b44:5b58:45af])
        by smtp.gmail.com with ESMTPSA id h66sm714130pfd.91.2016.02.23.19.22.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 Feb 2016 19:22:15 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.ga06e0b3.dirty
In-Reply-To: <1456284017-26141-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287166>

Expose possible parallelism either via the "--jobs" CLI parameter or
the "submodule.fetchJobs" setting.

By having the variable initialized to -1, we make sure 0 can be passed
into the parallel processing machine, which will then pick as many parallel
workers as there are CPUs.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-submodule.txt |  7 ++++++-
 builtin/submodule--helper.c     | 16 ++++++++++++----
 git-submodule.sh                |  9 +++++++++
 t/t7406-submodule-update.sh     | 12 ++++++++++++
 4 files changed, 39 insertions(+), 5 deletions(-)

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
index 85fb702..32254cd 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -429,6 +429,7 @@ static int update_clone_task_finished(int result,
 static int update_clone(int argc, const char **argv, const char *prefix)
 {
 	const char *update = NULL;
+	int max_jobs = -1;
 	struct string_list_item *item;
 	struct pathspec pathspec;
 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
@@ -449,6 +450,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "depth", &suc.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
 			      "specified number of revisions")),
+		OPT_INTEGER('j', "jobs", &max_jobs,
+			    N_("parallel jobs")),
 		OPT__QUIET(&suc.quiet, N_("don't print cloning progress")),
 		OPT_END()
 	};
@@ -475,10 +478,15 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	gitmodules_config();
 	/* Overlay the parsed .gitmodules file with .git/config */
 	git_config(submodule_config, NULL);
-	run_processes_parallel(1, update_clone_get_next_task,
-				  update_clone_start_failure,
-				  update_clone_task_finished,
-				  &suc);
+
+	if (max_jobs < 0)
+		max_jobs = parallel_submodules();
+
+	run_processes_parallel(max_jobs,
+			       update_clone_get_next_task,
+			       update_clone_start_failure,
+			       update_clone_task_finished,
+			       &suc);
 
 	/*
 	 * We saved the output and put it out all at once now.
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
2.7.0.rc0.34.ga06e0b3.dirty
