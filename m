From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/8] test-run-command: Increase test coverage
Date: Tue, 20 Oct 2015 15:43:47 -0700
Message-ID: <1445381030-23912-6-git-send-email-sbeller@google.com>
References: <1445381030-23912-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 00:44:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zofe3-00026B-Ox
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 00:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbbJTWoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 18:44:30 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35147 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219AbbJTWoD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 18:44:03 -0400
Received: by pasz6 with SMTP id z6so33863095pas.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 15:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y6DJXSJEYBObBpWuOEcqeVt94K/hS51yA2zQyUgX3VE=;
        b=guyatpci4r5DPPFmif9gDsOPLw7w7QETrGVuQVSvEbp/E0c7+s6qvIFfQ7L/iChXPr
         GSqkl/93s/Avi7F7+qlMcVwYsMJRUpf2/rs/Ewl+9egec3zS736g/pw3JYL079LR7QjO
         Bj8BJq7+BMyhz7Zj2lmJzzDhyPZL492eZL8eIUNZnmMGwTNqvGc5Va7Y0hPl+WWEwUI6
         s5CaDvhGiJHeNuxoUY4Qgprx1RqNBgfFq4TOh+ByubR+hzEvrr8l7SNWv76LqD07Wt7S
         hrBFBcxKnKTGgY8TYuEi6HBGJ3P4JIAMCBtzM5atwU/z7sMTkBLLFBi52z8oN1KEhHMU
         9FYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y6DJXSJEYBObBpWuOEcqeVt94K/hS51yA2zQyUgX3VE=;
        b=IG0ghMGS5MWtHRMrB+4BoTTcOygJuVfLUBRuXwBhto7mlLshr2fQkHn03NM59kJdJf
         PyH+Fj5arDpVHMXv4nH4uaS7oOP7Ty1fBL41cQSa8alyoqhrCQSHXBwTX7KPUZxtnbHu
         Q/AD0M8nJ+jKU0c65y9CW5DAlLVmQrbiEoVUTE7dIwcJUSi4mx5kID485HyYe9EXtK1+
         pXpVU9Ib/097nQkqbk7koi8hn0E2IvBrvoJSLlrO1ZkCBZtgkxui05EtXpWV8+/jUK0G
         XgD5Q0CxjuWtweD4XKB6MH54EYEjg06r3BDs59zS3qT2yvpcCAxFB+uf/mgEGlaJvcrD
         T02w==
X-Gm-Message-State: ALoCoQlQXwddD1MHlUzLQiYpi+oQjfT2NAMnOkImg9SY2sXqDxhnZ/E1mJ7zaoMIYxPggfPYr4Ob
X-Received: by 10.68.178.131 with SMTP id cy3mr6547041pbc.153.1445381042440;
        Tue, 20 Oct 2015 15:44:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:95b6:4bcd:ddcd:b6a3])
        by smtp.gmail.com with ESMTPSA id c3sm5607911pbu.24.2015.10.20.15.44.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Oct 2015 15:44:02 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.gbfc1651.dirty
In-Reply-To: <1445381030-23912-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279952>

Currently we have exact 4 jobs to be run with at most 4 parallel
processes. This sounds as if we're testing only one special case,
but in reality we want to have any number of tasks be processed
successfully, so test:
* more tasks than max jobs (implying slots get reused)
* equal number of jobs and max jobs
* less tasks than max jobs (implying there are unused slots)

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t0061-run-command.sh | 16 +++++++++++++---
 test-run-command.c     | 14 +++++++++-----
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 0af77cd..f27ada7 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -62,8 +62,18 @@ Hello
 World
 EOF
 
-test_expect_success 'run_command runs in parallel' '
-	test-run-command run-command-parallel-4 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+test_expect_success 'run_command runs in parallel with more jobs available than tasks' '
+	test-run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'run_command runs in parallel with as many jobs as tasks' '
+	test-run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'run_command runs in parallel with more tasks than jobs available' '
+	test-run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
 	test_cmp expect actual
 '
 
@@ -77,7 +87,7 @@ asking for a quick stop
 EOF
 
 test_expect_success 'run_command is asked to abort gracefully' '
-	test-run-command run-command-abort-3 false 2>actual &&
+	test-run-command run-command-abort 3 false 2>actual &&
 	test_cmp expect actual
 '
 
diff --git a/test-run-command.c b/test-run-command.c
index 4b59482..c8770c2 100644
--- a/test-run-command.c
+++ b/test-run-command.c
@@ -47,10 +47,11 @@ static int task_finished(int result,
 int main(int argc, char **argv)
 {
 	struct child_process proc = CHILD_PROCESS_INIT;
+	int jobs;
 
 	if (argc < 3)
 		return 1;
-	proc.argv = (const char **)argv+2;
+	proc.argv = (const char **)argv + 2;
 
 	if (!strcmp(argv[1], "start-command-ENOENT")) {
 		if (start_command(&proc) < 0 && errno == ENOENT)
@@ -61,12 +62,15 @@ int main(int argc, char **argv)
 	if (!strcmp(argv[1], "run-command"))
 		exit(run_command(&proc));
 
-	if (!strcmp(argv[1], "run-command-parallel-4"))
-		exit(run_processes_parallel(4, parallel_next,
+	jobs = atoi(argv[2]);
+	proc.argv = (const char **)argv + 3;
+
+	if (!strcmp(argv[1], "run-command-parallel"))
+		exit(run_processes_parallel(jobs, parallel_next,
 					    NULL, NULL, &proc));
 
-	if (!strcmp(argv[1], "run-command-abort-3"))
-		exit(run_processes_parallel(3, parallel_next,
+	if (!strcmp(argv[1], "run-command-abort"))
+		exit(run_processes_parallel(jobs, parallel_next,
 					    NULL, task_finished, &proc));
 
 	fprintf(stderr, "check usage\n");
-- 
2.5.0.275.gbfc1651.dirty
