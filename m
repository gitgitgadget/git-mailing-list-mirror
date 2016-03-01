From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv21 09/10] submodule update: expose parallelism to the user
Date: Mon, 29 Feb 2016 18:07:19 -0800
Message-ID: <1456798040-30129-10-git-send-email-sbeller@google.com>
References: <1456798040-30129-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com,
	Jens.Lehmann@web.de, peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 01 03:07:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaZiy-0002xr-7U
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 03:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbcCACHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 21:07:41 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:32777 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbcCACHi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 21:07:38 -0500
Received: by mail-pa0-f46.google.com with SMTP id fl4so102377000pad.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 18:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PYo5Y79o6HGkRgwhuQUgGP6rU4YzgkFGoLr79naA5hI=;
        b=gjAjtwdNqG9Jqn4UvLQABjgNAGhgwTB08iB2Uz4rqzsHDW4YKXjBfNi8EXZ39On0Wi
         93I3ABxYGl4NM7ZBaz+cAzgaoprZ8gMXpcIxxknat0StkesgG8IcVOwHoyYzWafRWLPh
         J1WKdOGUhmXsnQSNQAMrTNCmGYfBXpe81kPH+4h+66yjiQ8acxqkzWEfVt+lBsAtAvG2
         onc+AxhPW+y4s4iZvGmHhFNCaLQxX1cNRkSYf5FmdJ0hDsmnKvabvqztjzSJWdWwP/4D
         W6aq7CvsUX1erguosayTS+4Z4hqIq5iPffGP0M3ePVhMnNG5rFGlQvbadvoFISH0o97W
         0Hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PYo5Y79o6HGkRgwhuQUgGP6rU4YzgkFGoLr79naA5hI=;
        b=A2uZcShm26ita+ZitIpvYdZw0PDz9+hzyHMcPe8CsqszF8X15Utvh0dCoG510sqxDq
         IajA53OEe+kkGGHsJ1MZ6QgeSwJjVuO4OohRDUlzuVNr4NWfQETIaAr0UUGkR72eee5P
         dKy70QjmKejNRM75heEfXOJ+vyPrVWTByuXpHS/0tQXveYnFTIQ1loyJLohoV4OycbZs
         UTTWnA2VWcERCgOubg8G6PtH4wanYt70hMvbj3+VYXmBPJ4zOi+oG0jOq3aNooMnFoti
         WmcYuvYbPqQYAeENSOtZzKH2gNSgaSFPXuseJlsQzvc0cjtfdzhX+V+sh5owSSem/k3a
         E+aA==
X-Gm-Message-State: AD7BkJJNOLDUhfM97M5AZoluU3UilJn3pPOD1ucMd8UrcKJ6T/6tFSXmHZS7Ty8iG9E3e0ox
X-Received: by 10.66.65.109 with SMTP id w13mr26309980pas.142.1456798057857;
        Mon, 29 Feb 2016 18:07:37 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e195:dbe1:d842:476])
        by smtp.gmail.com with ESMTPSA id w69sm25884930pfi.55.2016.02.29.18.07.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 18:07:36 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0.1.g68b4e3f
In-Reply-To: <1456798040-30129-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287988>

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
index 9e8109e..a484945 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -430,6 +430,7 @@ static int update_clone_task_finished(int result,
 static int update_clone(int argc, const char **argv, const char *prefix)
 {
 	const char *update = NULL;
+	int max_jobs = -1;
 	struct string_list_item *item;
 	struct pathspec pathspec;
 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
@@ -450,6 +451,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "depth", &suc.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
 			      "specified number of revisions")),
+		OPT_INTEGER('j', "jobs", &max_jobs,
+			    N_("parallel jobs")),
 		OPT__QUIET(&suc.quiet, N_("don't print cloning progress")),
 		OPT_END()
 	};
@@ -477,7 +480,10 @@ static int update_clone(int argc, const char **argv, const char *prefix)
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
2.8.0.rc0.1.g68b4e3f
