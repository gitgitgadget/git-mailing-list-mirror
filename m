From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 15/17] index-helper: autorun mode
Date: Fri, 18 Mar 2016 21:04:48 -0400
Message-ID: <1458349490-1704-16-git-send-email-dturner@twopensource.com>
References: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 19 02:08:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah5Nh-00018v-Mo
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 02:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332AbcCSBIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 21:08:32 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35992 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754257AbcCSBI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 21:08:27 -0400
Received: by mail-qg0-f49.google.com with SMTP id u110so114639766qge.3
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 18:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LEW11AVVxagG/7Yo8PHD/Psid8GyRR10GYmT4RXBj2c=;
        b=wEXzPkgJtLxuu9CAFLu+hIqddFx8X28S2BsOtT63Puu3QJc4+31wUbQuRquqRWl4ZS
         m+siVqKGDR9in9lDrCPpR/v9f08EFyfZi6HnSF7TzrV1ovChCP+MAHYnUXuKorrGgnnc
         RB3f7iPxGerjOsTleONfY7ZOW6e8K772s3oN1kDPrnt5pqewNkMiq3/pGFWCOTYbE+RH
         Eb1OXG+g54qFPZIl9aHIyD7MfkqxAH8GsxrRuCTmFW2+MzBt9ZICuFJe9WZGlocS0iPZ
         2USfzmiRHeflGML8wluNV3Yn/sYBB3T9glkgDcQ38OYQ+N2l5WDrKYAW3/FNdwJ+/BVW
         GDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LEW11AVVxagG/7Yo8PHD/Psid8GyRR10GYmT4RXBj2c=;
        b=XkxXwZAPT6KZ49IuxXqOvRPJeE0N1LG9SwmHZcRslMnwWwmhKs0NvL5K+TSxrCW7q+
         pq2RnJuafzL2LrOejG9nOaVWOJEe/DRSRLY6ujRBhwt3h6a9SCuYljUkwS1cNtDJT1rt
         1VvHoGbM6rDIAaf15tj6GA7QjmH6leGGY/nI1vxZofgX7bh0A1g9ax9mLJZa1w01jB8E
         5byQ3WUVrDxQABeDzF69pI+i6ygC/dc7xqvIxKHhfD/3MpbUVzihXGDHoqV/VGzveYpH
         3STV8/lQ56wc5i/BQPzLeE1vP4PiCZ4KG+KnOcDlIPmXXBOrBVOljcSCkd5jxFQVXQ3E
         G69w==
X-Gm-Message-State: AD7BkJIbaqxkcNqgq+CH4plsrAMVnyhJUt99oKASYw1ymhZI91wdmujv0wcCb8G4SmOrfQ==
X-Received: by 10.140.145.151 with SMTP id 145mr27575404qhr.95.1458349705373;
        Fri, 18 Mar 2016 18:08:25 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id 139sm7186154qho.2.2016.03.18.18.08.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2016 18:08:24 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289283>

Soon, we'll want to automatically start index-helper, so we need
a mode that silently exists if it can't start up (either because
it's not in a git dir, or because another one is already running).

Signed-off-by: David Turner <dturner@twopensource.com>
---
 index-helper.c          | 29 +++++++++++++++++++++++------
 t/t7900-index-helper.sh |  8 ++++++++
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/index-helper.c b/index-helper.c
index 7362abb..ab96ded 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -368,8 +368,9 @@ done:
 int main(int argc, char **argv)
 {
 	const char *prefix;
-	int idle_in_seconds = 600, detach = 0, kill = 0;
+	int idle_in_seconds = 600, detach = 0, kill = 0, autorun = 0;
 	int fd;
+	int nongit;
 	struct strbuf pipe_path = STRBUF_INIT;
 	struct option options[] = {
 		OPT_INTEGER(0, "exit-after", &idle_in_seconds,
@@ -378,6 +379,7 @@ int main(int argc, char **argv)
 			 "verify shared memory after creating"),
 		OPT_BOOL(0, "detach", &detach, "detach the process"),
 		OPT_BOOL(0, "kill", &kill, "request that existing index helper processes exit"),
+		OPT_BOOL(0, "autorun", &autorun, "this is an automatic run of git index-helper, so certain errors can be solved by silently exiting"),
 		OPT_END()
 	};
 
@@ -387,7 +389,14 @@ int main(int argc, char **argv)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(usage_text, options);
 
-	prefix = setup_git_directory();
+	prefix = setup_git_directory_gently(&nongit);
+	if (nongit) {
+		if (autorun)
+			exit(0);
+		else
+			die("Not a git repository");
+	}
+
 	if (parse_options(argc, (const char **)argv, prefix,
 			  options, usage_text, 0))
 		die(_("too many arguments"));
@@ -402,10 +411,18 @@ int main(int argc, char **argv)
 
 	/* check that no other copy is running */
 	fd = open(pipe_path.buf, O_RDONLY | O_NONBLOCK);
-	if (fd > 0)
-		die(_("Already running"));
-	if (errno != ENXIO && errno != ENOENT)
-		die_errno(_("Unexpected error checking pipe"));
+	if (fd > 0) {
+		if (autorun)
+			return 0;
+		else
+			die(_("Already running"));
+	}
+	if (errno != ENXIO && errno != ENOENT) {
+		if (autorun)
+			return 0;
+		else
+			die_errno(_("Unexpected error checking pipe"));
+	}
 
 	atexit(cleanup);
 	sigchain_push_common(cleanup_on_signal);
diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
index ce0cc27..6020fe4 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -33,4 +33,12 @@ test_expect_success 'index-helper will not start if already running' '
 	grep "Already running" err
 '
 
+test_expect_success 'index-helper is quiet with --autorun' '
+	test_when_finished "git index-helper --kill" &&
+	git index-helper --kill &&
+	git index-helper --detach &&
+	test -p .git/index-helper.pipe &&
+	git index-helper --autorun
+'
+
 test_done
-- 
2.4.2.767.g62658d5-twtrsrc
