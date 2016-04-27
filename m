From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 17/19] index-helper: optionally automatically run
Date: Wed, 27 Apr 2016 16:04:39 -0400
Message-ID: <1461787481-877-18-git-send-email-dturner@twopensource.com>
References: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 27 22:06:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avVj4-0003YM-Qu
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605AbcD0UFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 16:05:36 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:34851 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbcD0UFb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:05:31 -0400
Received: by mail-qg0-f47.google.com with SMTP id f74so21849137qge.2
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 13:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=51xC6m6R1dneDPG7/68g2Ty9qAKwnty++fTHNXxWf4Q=;
        b=TcDFj962GzTj4NNuzi+xhV2a3O2N1r/n7u1TC1OB97ycOCIPBoFa/ZhWus9YsBev46
         Zcfr55AGMxJsCYu3dOrieZr9r4QIvj62KFxm9O9NjNdlVphj1sjTBOMWmXuQiJ7eVoT2
         +N/DgeEXSVuxrKGrD74sKcLxwdWGFSpko15VLrt37gg3nyyR92Wt7Zcrj9lU/DFjXnA5
         aISeBrvKAJYKhwu5EDDXD/97CqXTSEgoEQ8FbMyNq9apEOtTtyFJ3PcOL8J6RU/Juywe
         /2Cn+ucx/NA/RJe5mpfwV8FlKSDzdxuR8wkBWRPmSYzX/V5R9RLQsAQ8N4N/9KJcFhBE
         xnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=51xC6m6R1dneDPG7/68g2Ty9qAKwnty++fTHNXxWf4Q=;
        b=NSh2TaZEW+wNrrs+n9l9UxH3bQaX11IUPZee7fZbD/I1O6Yla+fWbFcllPETgHf/mY
         dR20+xxf1BdN7yzzvmKCgTqCbZ3Uestx0T6zB4XEZVlWYtL+dcrzl0yOY1ndC7fUtGPr
         /53X/jVN4yqp2iTWyWVxkz0OjFOB3xIHGiAgdHL9obGUzqWM/scAd5ng0pdjFgJsMNbc
         vIS9u0roiBgumGTRUdjCBmXGX4xL2L5ac/KeazVsNuaRppCVEAKyZFqOpERcu4BG2P4y
         r3LKKEYKTtuHdTSZS4Lll+Vu+O8lORaEtLWZa03XaSdL8MGDm6aOyOXLyyNRCDjqnd6o
         FGxQ==
X-Gm-Message-State: AOPr4FXyMFnBrt82dM8bxvTkp2ev6cBh96pQLop9DW7Yzv2TezSsxk9sryh043Z7aCqlPQ==
X-Received: by 10.140.197.130 with SMTP id s124mr10933077qha.17.1461787529539;
        Wed, 27 Apr 2016 13:05:29 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id r124sm1700085qhr.48.2016.04.27.13.05.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2016 13:05:28 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292798>

Introduce a new config option, indexhelper.autorun, to automatically
run git index-helper before starting up a builtin git command.  This
enables users to keep index-helper running without manual
intervention.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/config.txt |  4 ++++
 read-cache.c             | 37 +++++++++++++++++++++++++++++++++++--
 t/t7900-index-helper.sh  | 19 +++++++++++++++++++
 3 files changed, 58 insertions(+), 2 deletions(-)

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
index 252299d..9329967 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -21,6 +21,7 @@
 #include "unix-socket.h"
 #include "pkt-line.h"
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
 static int poke_and_wait_for_reply(int fd)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -1797,6 +1825,7 @@ static int poke_daemon(struct index_state *istate,
 	if (fd < 0) {
 		warning("Failed to connect to index-helper socket");
 		unlink(git_path("index-helper.sock"));
+		autorun_index_helper();
 		return -1;
 	}
 
@@ -1834,9 +1863,13 @@ static int try_shm(struct index_state *istate)
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
index aa6e5fc..2d3ce3c 100755
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
@@ -46,4 +49,20 @@ test_expect_success 'index-helper is quiet with --autorun' '
 	git index-helper --autorun
 '
 
+test_expect_success 'index-helper autorun works' '
+	rm -f .git/index-helper.sock &&
+	git status &&
+	test_path_is_missing .git/index-helper.sock &&
+	test_config indexhelper.autorun true &&
+	git status &&
+	test -S .git/index-helper.sock &&
+	git status 2>err &&
+	test -S .git/index-helper.sock &&
+	! grep -q . err &&
+	git index-helper --kill &&
+	test_config indexhelper.autorun false &&
+	git status &&
+	test_path_is_missing .git/index-helper.sock
+'
+
 test_done
-- 
2.4.2.767.g62658d5-twtrsrc
