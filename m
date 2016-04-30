From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 17/19] index-helper: optionally automatically run
Date: Fri, 29 Apr 2016 21:02:11 -0400
Message-ID: <1461978133-13966-18-git-send-email-dturner@twopensource.com>
References: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Sat Apr 30 03:02:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awJJC-00082g-D2
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 03:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbcD3BCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 21:02:47 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34687 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021AbcD3BCo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 21:02:44 -0400
Received: by mail-qg0-f54.google.com with SMTP id 90so34036431qgz.1
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 18:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q+aFqRnivMVVoElj8FXGorCM5t9kSdIidmfJJdML3sY=;
        b=oZQJkKYODKVQAK19z7+X1BJitPyugx1Rzn68RNXqAo1SDogoSa5Lkn8hPd45EbfMEq
         v3oOH5SVUSQMkrlmX/NZigXmnjHt6NAvnqxbANpLtKE/ZPWHNHs67gZeHialYf2m+kRz
         s7gnUojviib0JG5TUjSs/cgSR7RPhMs+hebJM/SX3CyeqCJEnONvHskrDpYVJtR8erK3
         NrDswDZNXsSd1Dkcku6LvGs639FpHPMbFbsmQec9ZE1BTZIjkhocOBnkq5YyScX3/jFY
         w1aaqjbXWwOZLyTGHPh9q7033d8eTS4N8HvZb0je8VCSdRIIzVTGFshypgv3Ia0awdAy
         C90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q+aFqRnivMVVoElj8FXGorCM5t9kSdIidmfJJdML3sY=;
        b=drFhYayyaoyMsE98/lt0mEwwVj65xN6r+u48V7nnpk1NpV7oOEYxrsymENlaFfeFnU
         ivTNb9O1SJodoG1c14ZntfXZpX+habqVTKyjPIb/abgKdbFXqubV8vYy/E7tU8C8v+9r
         oaPV4JaiFMWVr4f4xmr94rQG/b6jnRGGzbLRzs2lW3aoXdbmp3RHFM8Yt2n/yNDwVvid
         9sTXEEyc4Fpiev4+0twO+IDmBOlH0ZvC6HrN5OLR+ccYBQfgAmtn+wuxruMRIbSZscI5
         ouxXCBeBdxaXpP4js8kbUROXwwa4mIVufdxpMEES97AUDpPI8N98nFFm5N8ZsM1o+n42
         FYig==
X-Gm-Message-State: AOPr4FXnXZzhaEYEsLRvIQMqvEIQI3hr/pB0biF2xS9fnfl1BcG1kfCnmd6UtWCyxWOqOA==
X-Received: by 10.140.29.97 with SMTP id a88mr21965448qga.45.1461978163380;
        Fri, 29 Apr 2016 18:02:43 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g11sm5284485qhg.22.2016.04.29.18.02.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Apr 2016 18:02:42 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293108>

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
index 5f5e933..99eeee4 100644
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
 /* in ms */
 #define WATCHMAN_TIMEOUT 1000
 
@@ -1796,6 +1824,7 @@ static int poke_daemon(struct index_state *istate,
 	if (fd < 0) {
 		warning("Failed to connect to index-helper socket");
 		unlink(git_path("index-helper.sock"));
+		autorun_index_helper();
 		return -1;
 	}
 
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
