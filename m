From: David Turner <dturner@twopensource.com>
Subject: [PATCH v12 17/20] index-helper: autorun mode
Date: Thu, 19 May 2016 17:45:54 -0400
Message-ID: <1463694357-6503-18-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 23:47:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3VmZ-0006fg-IQ
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 23:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbcESVrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 17:47:00 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34004 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932637AbcESVq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 17:46:58 -0400
Received: by mail-qk0-f173.google.com with SMTP id y126so21164071qke.1
        for <git@vger.kernel.org>; Thu, 19 May 2016 14:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4wUqD/0tuMSz2ZX7BXXMFiHENBReuuG7QCj8o9oDLaM=;
        b=zZku7bVrimHbqyOAcHVkDm5CxBsyq5pnrdqJOoWFUaXnWlnXo5k/o/M32C0V5PsfDf
         zikawmuG2pR8fO2vqMJZkqjn+pmZjYfqAx3oYm1p4tsY2oaNuCczrTxyVq7UKx6TmLqA
         Q8tiY3u8bknRC141DgoA+UEovaa91oGPc1Sqnxam837AeqM/Uswaqf/HsrRL0gARwj7r
         lbmDvJ3CKJfbEwshwVjSKIGwhTUq583lBvh7Dpn+zgUVwloji9XUcuBXsYrIMBDOIBLv
         Ax+p34E74XtQsFcXr+mC9BkHbiwmbeV5LjrkwrR6K93CIzWErV9vz1IaMZ84Ym+DQLQi
         I73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4wUqD/0tuMSz2ZX7BXXMFiHENBReuuG7QCj8o9oDLaM=;
        b=ZhY8uC57mpBA0rfIYzSqn7+ADdzXV8Ki+5KTbv2JaqVx5j2MOdDQUe7ESWOZ/OG7bq
         Va81mJRjpCjSHpHFwzFsRirA1BFCwHojr9vbTDnU6CKPLWN0ooxPYhITDRBpQg5SDtlK
         ioD1PzVgJ36ZsZMvh96bQi8CuZgnYj1k2ZD45KolYMyAtIJXK/9xBWwErFgWJYwDHUFE
         FPgAZHshmiJ7SOu/OzIutYi5GVr0VGNkCmgRoQOVPnWLT722QIFw491n/QbCYsqiPTJg
         P7vH0L1kUdF+TNm9/ixdBDeE9Pbira28JfxhcybOYEJCAbIWdxSGXa81mA5pmhYOQe0R
         Fuzg==
X-Gm-Message-State: AOPr4FWF1hnxCnFZyjKddVEFdtB2BMjOpdj3mo94ca375v3wNiev1+P3R/mVrN6KV5hK8Q==
X-Received: by 10.55.140.69 with SMTP id o66mr17481708qkd.188.1463694417228;
        Thu, 19 May 2016 14:46:57 -0700 (PDT)
Received: from twopensource.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id r124sm7424730qhr.48.2016.05.19.14.46.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 May 2016 14:46:56 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295112>

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
index ddc641a..2d97c77 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -407,8 +407,9 @@ static void request_kill(void)
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
@@ -417,6 +418,7 @@ int main(int argc, char **argv)
 			 "verify shared memory after creating"),
 		OPT_BOOL(0, "detach", &detach, "detach the process"),
 		OPT_BOOL(0, "kill", &kill, "request that existing index helper processes exit"),
+		OPT_BOOL(0, "autorun", &autorun, "this is an automatic run of git index-helper, so certain errors can be solved by silently exiting"),
 		OPT_END()
 	};
 
@@ -426,7 +428,14 @@ int main(int argc, char **argv)
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
@@ -440,10 +449,18 @@ int main(int argc, char **argv)
 
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
