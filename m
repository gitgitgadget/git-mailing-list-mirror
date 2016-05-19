From: David Turner <dturner@twopensource.com>
Subject: [PATCH v12 18/20] index-helper: optionally automatically run
Date: Thu, 19 May 2016 17:45:55 -0400
Message-ID: <1463694357-6503-19-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 23:47:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Vmo-0006rX-8f
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 23:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932823AbcESVrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 17:47:07 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36231 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932420AbcESVq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 17:46:59 -0400
Received: by mail-qk0-f175.google.com with SMTP id x7so56507286qkd.3
        for <git@vger.kernel.org>; Thu, 19 May 2016 14:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZfppNGoS1DHmWzGM2zeOhVQOylI0my8GU7BOLO3HUXg=;
        b=ZjDvHLu9q5CBvkoHMkg+ze2qS/KU18NsPDkJU/SdHxs4Lkf7nFP9Im8bhNAalgLeZ/
         aL2fV5t8T5+BFOQayhULn5lK+xvaM1v0GUaubbpfwAuQJOE5iQ+dGR/ewZnnjkOGBypY
         HStobN+Mdb/KzD25CdqrTQqz4KlmvaS3RrFTN2mIK2xpDz7nnfBDxyLGCICjLE8ub2XN
         ZkBJofDzefuXrR8SErJWzW3mgILKJhyY3rR2pZpOPXWvsYJvx/OCcPkLUu55c23xAqRL
         1vM3qIblr1g3gkqqEJG7NsqOHDB+aMaX2BySIm3MIf9yxpJii5MqLGyC6hh+NbE8LyrY
         bJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZfppNGoS1DHmWzGM2zeOhVQOylI0my8GU7BOLO3HUXg=;
        b=j+lGrGTj56ti9uUnKqXaf9H8AFvHYtim27wdKaEQIbdPNk8kAdXnqg0wVumYPP+7Ze
         31NJ+Wuj6pEloJRaPrL1B4ru1IR/uKOFP74ExH8UqDiK/z+fSKAnmXMQVEGZ1B4i79rA
         Yk+p0cHzlXYUA/OZwK9NzobwdYZQBnaPb+rLODPJDBNsakFWYr/2bF23+WKjbVXYxgdt
         9H6cqgvoNhmBxkxd8Tww6SDXMOxcee5oXrOBcR/O6RrqTXaqTXuxpLqN9ErdBfTrxNK+
         etu1XusxWtR6Ems6MH1jG8gNKetgmLXAHeH0z/tP4pFLqu0Dzy6x0mFezrqz1WjxMkWv
         gY6w==
X-Gm-Message-State: AOPr4FUPtHoluLO1y1zaBEzWnMgbwnDg6yx0v3LjHtwVPJ6PQ0Kq6f6hrVXkXMtNmdFRKg==
X-Received: by 10.55.165.11 with SMTP id o11mr17579981qke.196.1463694418403;
        Thu, 19 May 2016 14:46:58 -0700 (PDT)
Received: from twopensource.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id r124sm7424730qhr.48.2016.05.19.14.46.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 May 2016 14:46:57 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295117>

Introduce a new config option, indexhelper.autorun, to automatically
run git index-helper before starting up a builtin git command.  This
enables users to keep index-helper running without manual
intervention.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/config.txt |  4 ++++
 read-cache.c             | 37 +++++++++++++++++++++++++++++++++++--
 t/t7900-index-helper.sh  | 20 ++++++++++++++++++++
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 15001ce..385ea66 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1856,6 +1856,10 @@ index.version::
 	Specify the version with which new index files should be
 	initialized.  This does not affect existing repositories.
 
+indexhelper.autorun::
+	Automatically run git index-helper when any builtin git
+	command is run inside a repository.
+
 init.templateDir::
 	Specify the directory from which templates will be copied.
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
diff --git a/read-cache.c b/read-cache.c
index 6d3fe71..76aecca 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -22,6 +22,7 @@
 #include "pkt-line.h"
 #include "sigchain.h"
 #include "ewah/ewok.h"
+#include "run-command.h"
 
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 					       unsigned int options);
@@ -1723,6 +1724,33 @@ static void post_read_index_from(struct index_state *istate)
 	tweak_untracked_cache(istate);
 }
 
+static int want_auto_index_helper(void)
+{
+	int want = -1;
+	const char *value = NULL;
+	const char *key = "indexhelper.autorun";
+
+	if (git_config_key_is_valid(key) &&
+	    !git_config_get_value(key, &value)) {
+		int b = git_config_maybe_bool(key, value);
+		want = b >= 0 ? b : 0;
+	}
+	return want;
+}
+
+static void autorun_index_helper(void)
+{
+	const char *argv[] = {"git-index-helper", "--detach", "--autorun", NULL};
+	if (want_auto_index_helper() <= 0)
+		return;
+
+	trace_argv_printf(argv, "trace: auto index-helper:");
+
+	if (run_command_v_opt(argv,
+			      RUN_SILENT_EXEC_FAILURE | RUN_CLEAN_ON_EXIT))
+		warning(_("You specified indexhelper.autorun, but running git-index-helper failed."));
+}
+
 /* in ms */
 #define WATCHMAN_TIMEOUT 1000
 
@@ -1794,6 +1822,7 @@ static int poke_daemon(struct index_state *istate,
 	if (fd < 0) {
 		warning("Failed to connect to index-helper socket");
 		unlink(git_path("index-helper.sock"));
+		autorun_index_helper();
 		return -1;
 	}
 	sigchain_push(SIGPIPE, SIG_IGN);
@@ -1833,9 +1862,13 @@ static int try_shm(struct index_state *istate)
 	int fd = -1;
 
 	if (!is_main_index(istate) ||
-	    old_size <= 20 ||
-	    stat(git_path("index-helper.sock"), &st))
+	    old_size <= 20)
 		return -1;
+
+	if (stat(git_path("index-helper.sock"), &st)) {
+		autorun_index_helper();
+		return -1;
+	}
 	if (poke_daemon(istate, &st, 0))
 		return -1;
 	sha1 = (unsigned char *)istate->mmap + old_size - 20;
diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
index aa6e5fc..3cfdf63 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -16,6 +16,9 @@ test -n "$NO_MMAP" && {
 }
 
 test_expect_success 'index-helper smoke test' '
+	# We need an existing commit so that the index exists (otherwise,
+	# the index-helper will not be autostarted)
+	test_commit x &&
 	git index-helper --exit-after 1 &&
 	test_path_is_missing .git/index-helper.sock
 '
@@ -46,4 +49,21 @@ test_expect_success 'index-helper is quiet with --autorun' '
 	git index-helper --autorun
 '
 
+test_expect_success 'index-helper autorun works' '
+	test_when_finished "git index-helper --kill" &&
+	rm -f .git/index-helper.sock &&
+	git status &&
+	test_path_is_missing .git/index-helper.sock &&
+	test_config indexhelper.autorun true &&
+	git status &&
+	test -S .git/index-helper.sock &&
+	git status 2>err &&
+	test -S .git/index-helper.sock &&
+	test_must_be_empty err &&
+	git index-helper --kill &&
+	test_config indexhelper.autorun false &&
+	git status &&
+	test_path_is_missing .git/index-helper.sock
+'
+
 test_done
-- 
2.4.2.767.g62658d5-twtrsrc
