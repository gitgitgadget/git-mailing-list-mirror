From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 16/19] index-helper: autorun mode
Date: Fri, 29 Apr 2016 21:02:10 -0400
Message-ID: <1461978133-13966-17-git-send-email-dturner@twopensource.com>
References: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Sat Apr 30 03:02:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awJJB-00082g-PG
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 03:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072AbcD3BCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 21:02:44 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33623 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbcD3BCm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 21:02:42 -0400
Received: by mail-qg0-f48.google.com with SMTP id f92so49709235qgf.0
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 18:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=efvD51k90Hlm3Mp9edFHXzkajAt/QJNtYprvugOiE9M=;
        b=ULqcKxp7RZhhAnadRTS283N6DENE9KNE0vzRdEElWZLzV5OID428Uk85kuUKhm2du9
         mpyjA54XI1y5E6Gb/cTHua9/aC0MEh3Q5BQbrliukQax1O8grO0fy9FQLz/oAjc+w43h
         PhzuDaBb52FgmTduzzGV+IEzN2n0kpSxNNllMc8PMUM1EB3FY1689MPvf80SkU/lwxV/
         3oJwffVQ7WCyDroRCEQmabUT1sQ8TqAjBpZ8EnO+6WAs1JNrAtIeLvktsMwBg2Gytrou
         iSGl1Uuz0fUHCPOE3W8Dn37jA8ILuzM/KMATCN8GvrIQNLqu1Ms5mvLoskYxuLbxbvII
         jpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=efvD51k90Hlm3Mp9edFHXzkajAt/QJNtYprvugOiE9M=;
        b=eWcFcq1M2FhrNe7gJ2QFj3W1o31Z4gsRE7YNrIynA5ZSifSzkBWTaetMOZSIT6tPT7
         lCeLbU0J4m4sRei8PoN74X0ajU+RipGRAuPSKb+EvNhSaKDUA3JXZgsg2BoU1AJNmN4N
         vq461uykZ7hkEkDdriE0SPTPQ0gHa6M5V3mtjKcjUPoN6quy27BzpXRaqCe9rP5tdh1r
         dAU3ZhRznGrhLO1AuDOQamVDiRDrxw9SIP8Ph2JzMzqug0yuwqe5Eg4v5NNuefdT0YHm
         iGgx6i8whKvebfzbqvbD6BvISXn+CN5lV0vJnc1cOrJXXO+7g/0us5xMBvYyUSFy7l3H
         slWA==
X-Gm-Message-State: AOPr4FXJLXuQDtalTrM/DvXTB4c1Zuqb8QP8YqK3zmEc5JImHEjSYnVzSaOWmyfdNEHsoA==
X-Received: by 10.140.27.163 with SMTP id 32mr3838574qgx.4.1461978162012;
        Fri, 29 Apr 2016 18:02:42 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g11sm5284485qhg.22.2016.04.29.18.02.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Apr 2016 18:02:41 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293107>

Soon, we'll want to automatically start index-helper, so we need
a mode that silently exits if it can't start up (either because
it's not in a git dir, or because another one is already running).

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-index-helper.txt |  4 ++++
 index-helper.c                     | 29 +++++++++++++++++++++++------
 t/t7900-index-helper.sh            |  8 ++++++++
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-index-helper.txt
index addf694..0466296 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -43,6 +43,10 @@ OPTIONS
 --kill::
 	Kill any running index-helper and clean up the socket
 
+--autorun::
+	If index-helper is not already running, start it.  Else, do
+	nothing.
+
 NOTES
 -----
 
diff --git a/index-helper.c b/index-helper.c
index e8d1311..a361776 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -424,8 +424,9 @@ static void request_kill(void)
 int main(int argc, char **argv)
 {
 	const char *prefix;
-	int idle_in_seconds = 600, detach = 0, kill = 0;
+	int idle_in_seconds = 600, detach = 0, kill = 0, autorun = 0;
 	int fd;
+	int nongit;
 	struct strbuf socket_path = STRBUF_INIT;
 	struct option options[] = {
 		OPT_INTEGER(0, "exit-after", &idle_in_seconds,
@@ -434,6 +435,7 @@ int main(int argc, char **argv)
 			 "verify shared memory after creating"),
 		OPT_BOOL(0, "detach", &detach, "detach the process"),
 		OPT_BOOL(0, "kill", &kill, "request that existing index helper processes exit"),
+		OPT_BOOL(0, "autorun", &autorun, "this is an automatic run of git index-helper, so certain errors can be solved by silently exiting"),
 		OPT_END()
 	};
 
@@ -443,7 +445,14 @@ int main(int argc, char **argv)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(usage_text, options);
 
-	prefix = setup_git_directory();
+	prefix = setup_git_directory_gently(&nongit);
+	if (nongit) {
+		if (autorun)
+			exit(0);
+		else
+			die(_("not a git repository"));
+	}
+
 	if (parse_options(argc, (const char **)argv, prefix,
 			  options, usage_text, 0))
 		die(_("too many arguments"));
@@ -457,10 +466,18 @@ int main(int argc, char **argv)
 
 	/* check that no other copy is running */
 	fd = unix_stream_connect(git_path("index-helper.sock"));
-	if (fd > 0)
-		die(_("Already running"));
-	if (errno != ECONNREFUSED && errno != ENOENT)
-		die_errno(_("Unexpected error checking socket"));
+	if (fd > 0) {
+		if (autorun)
+			exit(0);
+		else
+			die(_("Already running"));
+	}
+	if (errno != ECONNREFUSED && errno != ENOENT) {
+		if (autorun)
+			return 0;
+		else
+			die_errno(_("Unexpected error checking socket"));
+	}
 
 	atexit(cleanup);
 	sigchain_push_common(cleanup_on_signal);
diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
index 7159971..aa6e5fc 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -38,4 +38,12 @@ test_expect_success 'index-helper will not start if already running' '
 	grep "Already running" err
 '
 
+test_expect_success 'index-helper is quiet with --autorun' '
+	test_when_finished "git index-helper --kill" &&
+	git index-helper --kill &&
+	git index-helper --detach &&
+	test -S .git/index-helper.sock &&
+	git index-helper --autorun
+'
+
 test_done
-- 
2.4.2.767.g62658d5-twtrsrc
