From: David Turner <dturner@twopensource.com>
Subject: [PATCH v10 17/20] index-helper: autorun mode
Date: Thu, 12 May 2016 16:20:12 -0400
Message-ID: <1463084415-19826-18-git-send-email-dturner@twopensource.com>
References: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 12 22:21:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0x6Y-0005AB-7N
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbcELUU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 16:20:56 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:36359 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbcELUUv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:20:51 -0400
Received: by mail-io0-f178.google.com with SMTP id i75so103993324ioa.3
        for <git@vger.kernel.org>; Thu, 12 May 2016 13:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V4EBgeBPTed02y+iF2/6rzzSwETFgRPUxI5mY69GHUE=;
        b=CRPGWeUawf/XAXPFrPjRWnnS+zhKev+BqzxxM2w73K+hH9lho0QmKKO2hvW1t8iRMG
         4h4ubnLY2Nav3gc5vEBiwjv5pQx7tNJja4eVanwWfoUgYRZDRo2EtY/O9fg88fV/qiMw
         lRRTcmhDOuVjPOcmptmoLOTKFHZ5F/Ttvib9XJ8PPPv6/H6mmdlMnZ+sdwYGHkg27mwW
         1TBNaRnZl2YJxQA8bs6kj1/3aS++A7Q0YjdwK3tYQIIFkhyan4UuipGAfrCs6J9Vqcxg
         SwCNzH/jFuty7We5OVisroe0ztCvYD3R7HAK2JXzGWxGeY45lcCXpboKrys9PPa4hqxL
         0gVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V4EBgeBPTed02y+iF2/6rzzSwETFgRPUxI5mY69GHUE=;
        b=MXkzIGMA1h6a2ab53vDQv7bXhAlFEr8YcJsx1AtglR3k/vamVN5MVT3CVRHELalsbc
         R6I4O7LbDNGlyZf1EYhfU3MdbPBG3z8Pi0oRYFzHMRz5PLN9rrl8Qreva1t3ohRbnCyo
         LwvS9qnrk5hAUehkhe9JKxs4CS7JSegTcwAQLgaUVjax8OCaxBu50BltGHhQ7Y/wrO96
         YSR0ylcixaeEPCd9w/oix81HeT9ncl1R3K8JjOvRPujn38yXPxs8acIQ5nvEPHs9+Ggc
         2cWfXWi8yjLMdev1MLRimVP/osY9OsMxMaDMQQUE2KhOo4aHQz1wMh/7reS3HbdhCqJC
         cy/w==
X-Gm-Message-State: AOPr4FWg2tSMBA3jZWNP2TaIkK/VyqifHwIYT0cq5jhykN4KzeXN7KAtX05sAMLmr8TyTA==
X-Received: by 10.107.59.195 with SMTP id i186mr9668600ioa.36.1463084451042;
        Thu, 12 May 2016 13:20:51 -0700 (PDT)
Received: from twopensource.com ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id s8sm5055496igg.17.2016.05.12.13.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 May 2016 13:20:49 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294458>

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
index 7b893a0..4b31da2 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -404,8 +404,9 @@ static void request_kill(void)
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
@@ -414,6 +415,7 @@ int main(int argc, char **argv)
 			 "verify shared memory after creating"),
 		OPT_BOOL(0, "detach", &detach, "detach the process"),
 		OPT_BOOL(0, "kill", &kill, "request that existing index helper processes exit"),
+		OPT_BOOL(0, "autorun", &autorun, "this is an automatic run of git index-helper, so certain errors can be solved by silently exiting"),
 		OPT_END()
 	};
 
@@ -423,7 +425,14 @@ int main(int argc, char **argv)
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
@@ -437,10 +446,18 @@ int main(int argc, char **argv)
 
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
