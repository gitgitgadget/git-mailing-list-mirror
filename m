From: David Turner <dturner@twopensource.com>
Subject: [PATCH v9 17/19] index-helper: optionally automatically run
Date: Mon,  9 May 2016 16:48:47 -0400
Message-ID: <1462826929-7567-18-git-send-email-dturner@twopensource.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon May 09 22:51:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azs7j-0004LM-Hj
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 22:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbcEIUta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 16:49:30 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:35187 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbcEIUt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 16:49:27 -0400
Received: by mail-qg0-f50.google.com with SMTP id f74so95809475qge.2
        for <git@vger.kernel.org>; Mon, 09 May 2016 13:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GLwFzp/rKwkwClpRyM9vwwcqw7g1GrsLsFGSdlfwEN4=;
        b=Y/bt51sDhSZftrkrORg6fhIrAyZwxFq9J/NURVggPm/McF+DQcTxc/prO+qe92hJpn
         TBrKb70qP2TBo5oM3AuX8PDr8yZQVf/dbCBsegxoqKqIniXzIbJZzMZVprQPc4uOK5Wn
         8rZhGdXsD4r7hbcQPUky/snoigv1F2QJFAak+nLDTpCgwURnjB73CbJ8XCVQ16bjRN/3
         Ca1YL+1hYiz6plVEqztF7XH0bCbusgaHH+YeMIWYS3VqacOFGDJhO7n4qs5ptLlDENKI
         8wHiRTU27MU4PiMBEXk1RrS8spZj72zkq//m/b9WyIDo+ij6fhwy5y6aFeqUJiForwjZ
         aIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GLwFzp/rKwkwClpRyM9vwwcqw7g1GrsLsFGSdlfwEN4=;
        b=Q5yWdGmAh/ItqICGQdy7kEM8o5EHBDDK9Lt3DJAmUTDoA9lsgkRfxQIVNBvtu/AU+F
         g+kfGirLFn29mTskZvFnPwQk+hBYuheLje4kDH+Sod64jNNo6CB+TYUMnnYHlW3WORrU
         K2XN5fgWBABlGbNPOpGPvBya7brZIsUftPxVfFN+srg97sWdcV7HdFicdpg1dtFqLnd4
         VcxvD2P91QK1HP1Yrbmqsb2MfbkjW/VTov7MjAQqexra+lwhBxZIVzJAp/6ybF4Nc9E+
         FpponmxUAiejZ0Y1/0kK5sYchxa9lfwqeWD+iz3n7ojw7/HzLNq5bZn616gs3g1bXNz6
         0xWw==
X-Gm-Message-State: AOPr4FVb1eR6vBkuI/53x3KeMeYtNqab6sDHqTIir3muqQEdHsCr+3qE9BHOgPyidGBFKg==
X-Received: by 10.140.109.132 with SMTP id l4mr38299813qgf.9.1462826966692;
        Mon, 09 May 2016 13:49:26 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id n1sm12729182qkn.3.2016.05.09.13.49.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2016 13:49:25 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294061>

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
index 7b7cb39..ebbcb7f 100644
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
 
@@ -1796,6 +1824,7 @@ static int poke_daemon(struct index_state *istate,
 	if (fd < 0) {
 		warning("Failed to connect to index-helper socket");
 		unlink(git_path("index-helper.sock"));
+		autorun_index_helper();
 		return -1;
 	}
 	sigchain_push(SIGPIPE, SIG_IGN);
@@ -1835,9 +1864,13 @@ static int try_shm(struct index_state *istate)
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
