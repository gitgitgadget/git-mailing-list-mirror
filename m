From: David Turner <dturner@twopensource.com>
Subject: [PATCH v8 16/19] index-helper: autorun mode
Date: Thu,  5 May 2016 17:47:08 -0400
Message-ID: <1462484831-13643-17-git-send-email-dturner@twopensource.com>
References: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:48:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayR8A-0008Mw-Fn
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757960AbcEEVsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 17:48:13 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33971 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757945AbcEEVrr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:47:47 -0400
Received: by mail-qg0-f48.google.com with SMTP id 90so47397037qgz.1
        for <git@vger.kernel.org>; Thu, 05 May 2016 14:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uqiTzTheVkJCbw9q4fwpmo5iQ74l1mhGKBqmj2I7EtQ=;
        b=SGW+DcW96nDreAzXdoORMQ9ZO6s/wdYyOgaoJ519xHOAcFU0kfHB9o+DUEtHlyG0Jq
         LiVUEiIhh0qvcgCZFshkYpHEtT1oG8m5f9dE6ZoIhW3aBTFRWGAC4VJTtE8bA3tBaiz1
         1I3w6uKiRgTohqtIOzYibo9agjZKGiS0T01DYr3jzvHz8rp+CSq4vLQYdAUFp/4EfJ4y
         kFdSWoP1gIrjIZMIHr2mHRm/7bdcTObPp/FP9nJ54MnHPTFBB0QSrUt4kMGpXXl3QBpF
         l9MIgDSxE6jyNCfZjRhbPo9bUq1LIHCv3uqrrrzTYI7cYDBSi32EA2UAu7llddgqXZeq
         MCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uqiTzTheVkJCbw9q4fwpmo5iQ74l1mhGKBqmj2I7EtQ=;
        b=DScODt0+oNRfumskrbCWb5XDfKGjSpo0x8tOP09CSwMIFJ84jMkHfCGzOHFvUFRCNH
         z8c9BCtXj3DsIw+B+Q6B5muiVl2Tbj+oPuBcPBo21TVkVbI/EQGj1+FE9FxSnAdiyz/g
         8dIbbd28abD2aapCw022hB9VPnXNcTaYaboqnOd6ytGTKfXng7/DrGDU4YGsp4COcV0H
         8qyJBT7WNkLT9hA347IMEGydsMbgwkInxV0ZA7NVxseiTUpcJRld1wJgxwKs5Ela4a05
         E6LcoKCJneCmGdK3+vRYC++2xEcOZIXySZOGH7DcZp2ZAhiIMEmQ3Kg+OUsRftLTJQ2A
         gtEw==
X-Gm-Message-State: AOPr4FX9efTB7hnzUOX89xyz3Q1snCh4lYszmpEKCwC5pxD1xSVAVr8xsfjZl06q15Bn+w==
X-Received: by 10.140.98.175 with SMTP id o44mr16949716qge.46.1462484865977;
        Thu, 05 May 2016 14:47:45 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g186sm4393740qke.49.2016.05.05.14.47.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2016 14:47:44 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293702>

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
index b275f6e..9743481 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -427,8 +427,9 @@ static void request_kill(void)
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
@@ -437,6 +438,7 @@ int main(int argc, char **argv)
 			 "verify shared memory after creating"),
 		OPT_BOOL(0, "detach", &detach, "detach the process"),
 		OPT_BOOL(0, "kill", &kill, "request that existing index helper processes exit"),
+		OPT_BOOL(0, "autorun", &autorun, "this is an automatic run of git index-helper, so certain errors can be solved by silently exiting"),
 		OPT_END()
 	};
 
@@ -446,7 +448,14 @@ int main(int argc, char **argv)
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
@@ -460,10 +469,18 @@ int main(int argc, char **argv)
 
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
