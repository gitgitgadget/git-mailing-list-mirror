From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv13 6/7] submodule update: expose parallelism to the user
Date: Thu, 18 Feb 2016 15:33:17 -0800
Message-ID: <1455838398-12379-7-git-send-email-sbeller@google.com>
References: <1455838398-12379-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 19 00:33:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWY4t-00044u-9b
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 00:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1948696AbcBRXdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 18:33:36 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:32999 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1948688AbcBRXda (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 18:33:30 -0500
Received: by mail-pa0-f50.google.com with SMTP id fl4so39184331pad.0
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 15:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9iBJWLGwxfQJkaoPFB7i6XYX33Nux90RlULKTX8yVH4=;
        b=cyoI3JlDLH1bPxH2JY/IazwQrHloFfT8pOECQAPvAkd0TrScfEizbNSj/wfzH/LJ1P
         Mf9USWqDByweMtng968gcGBmgsgZ+HHd+oSoaXRp2Lw7PwYWPT4Fc9drQBiCP/0upFUC
         dySzSrgF9zHhdu6rLYTyOp4L2blCgDBE8HqdATBq/VFrKXUyHmLO3bAJEME5coavpyt6
         4w+/loBUpljY6LF2KAerXLodGRaUjmh6O/tS1YAVo0R478cHd13xjf2RafDR5Kdi9PLK
         WjTE4qAeJ1NvMtD5qfCPIvwCrN1w5MN+3efaYzHV2El19I7pvVhibhUkaZBSJ5LZCTOX
         5wDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9iBJWLGwxfQJkaoPFB7i6XYX33Nux90RlULKTX8yVH4=;
        b=O65yITyKn4iLRcRyIcXU5cMIc0VrJoQXP7w09OqOwhb/d58Z01EOlzuWQU/3JlfIpM
         3XUfRmRHqq0P+dTzE1I25Uk4sWaDB9yjJja+QaR6T4Z8GN8tFZegWyDbok3rLC7sl2eh
         94CIi2dxR6fvQ9jOuCkvmPODtEkOcHogZ4/ss+grmO+nXIhs2sh3q2pVuq9TEJ+Oa+iq
         0/VkY6z1kTgYKF4xPwtwg0m9WAbllHPT14Q3j5UB1/WGj198D+YkK0Y3KlsI0liTuNOW
         WFXr1J/TcoclMibzja6GGZydQmEhXjnky1JN1/03KQcaYxhnpt4ljtvT86nKIKgtAxe5
         MWMQ==
X-Gm-Message-State: AG10YOSjuSYAZkyn3ItXNUyyDcF/rM4pVxp+ol9SEyQFyzrASH2Iau59dvh9Ozr1OQB2C6Yd
X-Received: by 10.66.139.166 with SMTP id qz6mr13936773pab.3.1455838410173;
        Thu, 18 Feb 2016 15:33:30 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:d444:f36c:1851:bb54])
        by smtp.gmail.com with ESMTPSA id s23sm12866489pfi.12.2016.02.18.15.33.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 Feb 2016 15:33:29 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.g65aed89
In-Reply-To: <1455838398-12379-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286647>

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
index 7629a41..65bdc14 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -424,6 +424,7 @@ static int update_clone_task_finished(int result,
 static int update_clone(int argc, const char **argv, const char *prefix)
 {
 	const char *update = NULL;
+	int max_jobs = -1;
 	struct string_list_item *item;
 	struct submodule_update_clone pp = SUBMODULE_UPDATE_CLONE_INIT;
 
@@ -444,6 +445,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "depth", &pp.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
 			      "specified number of revisions")),
+		OPT_INTEGER('j', "jobs", &max_jobs,
+			    N_("parallel jobs")),
 		OPT__QUIET(&pp.quiet, N_("do't print cloning progress")),
 		OPT_END()
 	};
@@ -469,10 +472,15 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	gitmodules_config();
 	/* Overlay the parsed .gitmodules file with .git/config */
 	git_config(submodule_config, NULL);
-	run_processes_parallel(1, update_clone_get_next_task,
-				  update_clone_start_failure,
-				  update_clone_task_finished,
-				  &pp);
+
+	if (max_jobs < 0)
+		max_jobs = parallel_submodules();
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
2.7.0.rc0.34.g65aed89
