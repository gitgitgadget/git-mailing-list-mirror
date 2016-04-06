From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 14/16] index-helper: autorun mode
Date: Wed,  6 Apr 2016 18:12:00 -0400
Message-ID: <1459980722-4836-15-git-send-email-dturner@twopensource.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com, aevarb@gmail.com,
	jeffhost@microsoft.com
X-From: git-owner@vger.kernel.org Thu Apr 07 00:13:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anvhM-0004xc-Dj
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 00:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280AbcDFWM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 18:12:59 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34016 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184AbcDFWMv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 18:12:51 -0400
Received: by mail-qg0-f54.google.com with SMTP id c6so48313431qga.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 15:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rndm95JHItWSSOehJWnuDUgwQ58RdJKBQHooUEz2vr0=;
        b=FbcLl8aoOH25WYNm/pMJcIe3d/wlqjGe/kRDawEa9/9dmSzKJus1rG9tHAUz0pvPEM
         mJUgaabLu8jBj0CehpGGR1f1iqFgo5mcOhvpbgx8JWCLLa8RNcOx2AQKE/jZJzEZ9U4/
         tYtoXWGWAt0XZKv13cxCHsNh5aLJW8p1hNKx9DvM9v2QWtMKx5Muw9bGDDPAl7OjILAT
         9abM5lXvETTWgccjZJJbP8ntETTdVvq82KQqALl+wOd1K+j7sN82FR2O54RUavnSgqP9
         7Utr3aG0WHAVKUezEIaEv/I22S6zRkWtxsVgXqvEql5556KH5I4eSUlA1q42FCvGureg
         RJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rndm95JHItWSSOehJWnuDUgwQ58RdJKBQHooUEz2vr0=;
        b=NTUOPNOTvZRAY4STwh3KsOsx07oVbKUhG5qd+GAiDWAYvk/xzfWnzoj/2XuwbMcpHU
         W6qlXcfrN1znSfSFGNLm2D0Pi9iKmNCdeGySAsps0BLplltwYBZX3e3AJgG6I9sI1SSY
         8Q4VyNaOXU4Wcs92JzWKrjYSQyx0pw88vMi6nuOWp+rBxEygYYcwGB8X4Nq9FyAhx/Sr
         hHljhr5RKNrJR2wx+bubmT1U12/F66CNstdtGRulYhXvMqPQ9HPhW3e6SPkKieG6K2cw
         oClRHhXEG0gHvB2x5oGVDucarKSNj/D+uh2XDpHG8eSkeyF2etQ8YAP33pwg6Udp8k5x
         f28Q==
X-Gm-Message-State: AD7BkJLdR4c2b2XUcVjmp7USG23M01pTmgha4fp8dGVcbTPoARe9D2U3T/++p5N/TCZb9w==
X-Received: by 10.140.139.72 with SMTP id 69mr25721935qhl.68.1459980770221;
        Wed, 06 Apr 2016 15:12:50 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id l33sm2165241qge.11.2016.04.06.15.12.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 15:12:49 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290885>

Soon, we'll want to automatically start index-helper, so we need
a mode that silently exits if it can't start up (either because
it's not in a git dir, or because another one is already running).

Signed-off-by: David Turner <dturner@twopensource.com>
---
 index-helper.c          | 29 +++++++++++++++++++++++------
 t/t7900-index-helper.sh |  8 ++++++++
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/index-helper.c b/index-helper.c
index b62d805..4d08ff4 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -382,8 +382,9 @@ static void request_kill(void)
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
@@ -392,6 +393,7 @@ int main(int argc, char **argv)
 			 "verify shared memory after creating"),
 		OPT_BOOL(0, "detach", &detach, "detach the process"),
 		OPT_BOOL(0, "kill", &kill, "request that existing index helper processes exit"),
+		OPT_BOOL(0, "autorun", &autorun, "this is an automatic run of git index-helper, so certain errors can be solved by silently exiting"),
 		OPT_END()
 	};
 
@@ -401,7 +403,14 @@ int main(int argc, char **argv)
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
@@ -415,10 +424,18 @@ int main(int argc, char **argv)
 
 	/* check that no other copy is running */
 	fd = connect_to_index_helper();
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
index 3f94d8a..3925ee3 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -42,4 +42,12 @@ test_expect_success 'index-helper will not start if already running' '
 	grep "Already running" err
 '
 
+test_expect_success 'index-helper is quiet with --autorun' '
+	test_when_finished "git index-helper --kill" &&
+	git index-helper --kill &&
+	git index-helper --detach &&
+	test -L .git/index-helper.path &&
+	git index-helper --autorun
+'
+
 test_done
-- 
2.4.2.767.g62658d5-twtrsrc
