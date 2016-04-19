From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 15/15] index-helper: optionally automatically run
Date: Tue, 19 Apr 2016 19:28:09 -0400
Message-ID: <1461108489-29376-16-git-send-email-dturner@twopensource.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 20 01:28:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asf4e-0008QM-Ce
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 01:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbcDSX2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 19:28:47 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35659 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396AbcDSX2d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 19:28:33 -0400
Received: by mail-qk0-f175.google.com with SMTP id q76so702437qke.2
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 16:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E8WplIbeHPqFm5UdyDHjcuFe0lgwzp25mUBY/DH3vxg=;
        b=eLWK+2QlVSvU650y2QlrvWp93z6FMnP/kcJSbFFT8th71hrnU3hwSI6VvnR82jyyrg
         oYNLdSIGiEdw6L/fGIJ1e18pRUuRaLBqRNlxg1elMDO5QWlY7+/sP7HM/48vIi40iGzF
         ULhy6gkADkatR7xXqX9JLET2zKAPWJogExQymp/204DIjgILJV5sxLTqv79beFl58HtG
         FdkLZQ2VHIWfIdhiNBYQDKc0HffrS45WcsA5NdhvPIEz+gs/PFnPxnu87E4aCkn22KJu
         sgdQOgu2pk3imIPA8Zvy9S5U/fFZAKZ7lIh5SgPsycwv5T+KqVpS1arhcT/thQEES5Cf
         h0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E8WplIbeHPqFm5UdyDHjcuFe0lgwzp25mUBY/DH3vxg=;
        b=gQTAgK8HOkGBIectgjBpwo1KqkGr9d9r/yCOwLW8lDRIMr0eDAI4iWwIOKWX+QgmW5
         t96bR9BZp27cA4KFpBi/ugcUjVhHn+w42E38STlgALj5PAaytQ1FqH1VNKTyFyqJqoDW
         v6KJ+mgf/e+Sr0ce5fNrurrRsJYBfxqLmBz/2peVkWkn+G/iiNHnh8qQUHP69+3ucoMS
         PdvWdogCoNtszzIQphpvb8a+CcSlbCqvSTFkfHXbsCQi1PTImiWql5H+eFWADZ8eO0B1
         iwBUzb5a9tbbb3I4FDAEGt6d7ciUTLk/tAm1+UsKUl+0JUFeGKhFBohxotsHZBl2b0Tk
         +T5Q==
X-Gm-Message-State: AOPr4FVhvc5RXHTxPUozpF2hdmgiwlBhRXZX2TBnP2bdi8MbuSLad9RbcM2l85KaQwiNvg==
X-Received: by 10.55.31.200 with SMTP id n69mr1218153qkh.99.1461108512375;
        Tue, 19 Apr 2016 16:28:32 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id h34sm29879663qge.30.2016.04.19.16.28.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 16:28:31 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291964>

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
index 2cd6bdd..8ec8824 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1852,6 +1852,10 @@ index.version::
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
index 65f22f9..a73487e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -20,6 +20,7 @@
 #include "utf8.h"
 #include "unix-socket.h"
 #include "ewah/ewok.h"
+#include "run-command.h"
 
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 					       unsigned int options);
@@ -1722,6 +1723,33 @@ static void post_read_index_from(struct index_state *istate)
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
@@ -1776,6 +1804,7 @@ static int poke_daemon(struct index_state *istate,
 	if (fd < 0) {
 		warning("Failed to connect to index-helper socket");
 		unlink(git_path("index-helper.sock"));
+		autorun_index_helper();
 		return -1;
 	}
 
@@ -1811,9 +1840,13 @@ static int try_shm(struct index_state *istate)
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
