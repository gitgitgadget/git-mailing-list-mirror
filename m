Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681D2C2BA19
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2732076E
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVmEJ9eQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgDCUsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:48:31 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36560 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgDCUs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 16:48:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id i7so10945912edq.3
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 13:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p0goYEAGAkM938d45wxG7Ig5Uy9EhvHHYBBuFO5J+EY=;
        b=qVmEJ9eQxoLZweQIAQwJnfJSzYMH2OVUwyJVFOVIrrzCntc/ZMU1RwHV+RP6HKjfbz
         QDAbNSx1dProx2yfl6VMFNeXNznL4XenLD489fY6mvggMDZRtln/ZAAQ8jD+3dJqmRSe
         AdaDo1QtNnhzxjgBOvE7G7YESzo4nnoTYymczgWBIBt/C+CGkERdDKNvDFX2zcWsSJ0J
         7s/q4Ot0xmDbOllvgHdH82/JXr8Mtr2Qol6ALKWaAQ/elYzrQyS32Ns7sP2UMRR9m9qS
         vh5b8BNmMuh7TU5C0iPkqB29FJnMaI6MejpqiKghQKRfGsZ+2lWB0uVaNPRrM9fHEkK9
         GvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p0goYEAGAkM938d45wxG7Ig5Uy9EhvHHYBBuFO5J+EY=;
        b=WX4qHad9xdfrpsCf8wCP1pizTu6xp8/BkMQkK6T/PRTcuQVPCeu+RW7SOB7cPnfHYw
         cxipZU14WmhdJsoJR6Cb0pUBV76DVY4I9+auHd+NvsS0RJFKTzU3dw4Jl+N7DwQLsP12
         sJ15m77gLu12Hsr+YqEgjTNYqQociTGS+pwvvLrysFfMRchEOe6Y5d6ck0I+a8214oT5
         Mu2QI5xqzJ3j959u4aLVb+nRgPV2+oK64bSSl9wf7w4bI96tGbtQmmtyTlT+EFt6Oc7i
         ehu+kB6gZCA3VFL4uWdUfh59eYakf8k4Uf5sviH7P9jjT2KWCLjFuHy66zA8AH7oizGU
         U7Xw==
X-Gm-Message-State: AGi0PuY+uatlZdNCSCwJq40HdPCE/ouq25nOYARY1FjKMZCVFNFFFOiP
        jc1a7BOA6OSYogu9HkJL8Vqlt7Kt
X-Google-Smtp-Source: APiQypLcRplmAKKqp6IFpWjdFZEQP4foofibEkmoP77wgAdhrZxwvvG/FYz7JBbOnxw64zy1xXWHSg==
X-Received: by 2002:a50:fd0d:: with SMTP id i13mr9775448eds.263.1585946906505;
        Fri, 03 Apr 2020 13:48:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u5sm1575178edy.88.2020.04.03.13.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:48:26 -0700 (PDT)
Message-Id: <b22398b00443388ece4cd352ac347cd364fc11a3.1585946894.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.597.git.1585946894.gitgitgadget@gmail.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Apr 2020 20:48:13 +0000
Subject: [PATCH 14/15] job-runner: add --daemonize option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@google.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Git has the ability to fork the process and launch a "daemonized"
copy of the current process. This is used to launch a background
'git gc' command in some cases or to launch the 'git daemon'
server process.

Update the 'git job-runner' command with a --daemonize option that
launches this background process.

The implementation of daemonize() in setup.c is very clear that
this may no-op and return an error if NO_POSIX_GOODIES is not
defined. Include an error message to point out that this mechanism
may not be available on a platform-by-platform basis.

Include a clear error message that daemonize() might fail due to
platform incompatibilities.

I have been running the current version of this series on my
Linux VM using --daemonize to keep my copies of torvalds/linux and
git/git maintained. Using GIT_TRACE2_PERF set to a path, I can see
that the 'git run-job' processes are being created on the correct
schedule according to my config for each.

RFC QUESTION: I notice that 'git gc' does not document --daemonize.
Is that intentional? Or is it an oversight?

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-job-runner.txt |  5 +++++
 builtin/job-runner.c             | 12 ++++++++++--
 cache.h                          |  4 +---
 daemon.h                         |  7 +++++++
 4 files changed, 23 insertions(+), 5 deletions(-)
 create mode 100644 daemon.h

diff --git a/Documentation/git-job-runner.txt b/Documentation/git-job-runner.txt
index 0719113a008..f48d6bcd10b 100644
--- a/Documentation/git-job-runner.txt
+++ b/Documentation/git-job-runner.txt
@@ -39,6 +39,11 @@ OPTIONS
 	If this is not specified, then the default will be found from
 	`jobs.loopInterval` or the default value of 30 minutes.
 
+--daemonize::
+	If supported by your platform, launch an identical
+	`git job-runner` process in the background and close the
+	foreground process immediately.
+
 
 CONFIGURATION
 -------------
diff --git a/builtin/job-runner.c b/builtin/job-runner.c
index 45f82a50d49..3b629428ef1 100644
--- a/builtin/job-runner.c
+++ b/builtin/job-runner.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "config.h"
+#include "daemon.h"
 #include "parse-options.h"
 #include "run-command.h"
 #include "string-list.h"
@@ -78,7 +79,8 @@ static int try_get_config(const char *job,
 
 	fclose(proc_out);
 
-	result = finish_command(config_proc);
+	/* ignore result as 'git config' fails on non-existent value */
+	finish_command(config_proc);
 
 cleanup:
 	free(config_proc);
@@ -93,7 +95,7 @@ static int try_get_timestamp(const char *job,
 	char *value;
 	int result = try_get_config(job, repo, postfix, &value);
 
-	if (!result) {
+	if (!result && value) {
 		*t = atol(value);
 		free(value);
 	}
@@ -304,6 +306,7 @@ static int initialize_jobs(struct string_list *list)
 	return 0;
 }
 
+static int arg_daemonize = 0;
 int cmd_job_runner(int argc, const char **argv, const char *prefix)
 {
 	int result;
@@ -316,6 +319,8 @@ int cmd_job_runner(int argc, const char **argv, const char *prefix)
 			       PARSE_OPT_NONEG, arg_repos_append),
 		OPT_INTEGER(0, "interval", &arg_interval,
 			    N_("seconds to pause between running any jobs")),
+		OPT_BOOL(0, "daemonize", &arg_daemonize,
+			 N_("request to spawn a background process")),
 		OPT_END(),
 	};
 
@@ -328,6 +333,9 @@ int cmd_job_runner(int argc, const char **argv, const char *prefix)
 			     builtin_job_runner_usage,
 			     0);
 
+	if (arg_daemonize && daemonize())
+		die(_("failed to daemonize; this may not be available on your platform."));
+
 	result = initialize_jobs(&job_list);
 
 	while (!(result = run_job_loop_step(&job_list))) {
diff --git a/cache.h b/cache.h
index c77b95870a5..34ef690faf6 100644
--- a/cache.h
+++ b/cache.h
@@ -17,6 +17,7 @@
 #include "sha1-array.h"
 #include "repository.h"
 #include "mem-pool.h"
+#include "daemon.h"
 
 #include <zlib.h>
 typedef struct git_zstream {
@@ -631,9 +632,6 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	    unsigned int flags);
 void initialize_repository_version(int hash_algo);
 
-void sanitize_stdfds(void);
-int daemonize(void);
-
 #define alloc_nr(x) (((x)+16)*3/2)
 
 /**
diff --git a/daemon.h b/daemon.h
new file mode 100644
index 00000000000..c1e50a20354
--- /dev/null
+++ b/daemon.h
@@ -0,0 +1,7 @@
+#ifndef DAEMON_H__
+#define DAEMON_H__
+
+void sanitize_stdfds(void);
+int daemonize(void);
+
+#endif
-- 
gitgitgadget

