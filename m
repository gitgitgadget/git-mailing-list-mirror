From: David Turner <dturner@twopensource.com>
Subject: [PATCH v8 17/19] index-helper: optionally automatically run
Date: Thu,  5 May 2016 17:47:09 -0400
Message-ID: <1462484831-13643-18-git-send-email-dturner@twopensource.com>
References: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:48:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayR7n-00082K-HQ
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757953AbcEEVrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 17:47:52 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:33573 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757844AbcEEVrt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:47:49 -0400
Received: by mail-qg0-f49.google.com with SMTP id f92so47408742qgf.0
        for <git@vger.kernel.org>; Thu, 05 May 2016 14:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6dnl1AGgTdDKFZk/2BV8zCwxJ6f345ytDXNvtWlxjkE=;
        b=CJoyTq3qO9RvB8YnMjvuN4fsufXagZtAnu7EB6kzYhHO3AAumiMWtDULprkrYIPR38
         ouqPlN960hFLsv1oX+8B2PLi5+CdDDbyetHG6HjSzShhJNfPrI5pKTdLy7m1UNccMN5c
         JVMDnoFYw9G1OuR/UoYZW6ADOS5enTu+X2c7iAvq1+6hgrxVGe419ad7+7KLr28okxzi
         daCxl5+6VpOvc795/WgSz5oWuzwL4Q4fSbRkQnJcV/WIJb91LQXcp/voxSV6HlTvW1xH
         eVJAKIm+XEuUJZJTTfbgoZ5tGCINESdV8j9SPEs5T6yWFdVU+ikogMii+wtAb0Rx7kVk
         9k0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6dnl1AGgTdDKFZk/2BV8zCwxJ6f345ytDXNvtWlxjkE=;
        b=cQiBAYbzgS/L1b/aztI1v7vlphHZt0knkNJ7H6MVc+mQ7IYEaaTic/dRqSclhABabO
         mBaxP2RQP2M3f634qFyo11IEsMjSTe4bme4JhxNRARwGIdrfbTHXflWXNUodEmwbjOEV
         1LFAaidUKo7IMgQjjFOVXLJEhRGV2txgU1UKstqbWN3j9nZQh9DELNmXppBjL2SPREZ9
         lZXr0TmAfFXeZIFRQW/U7g2gQuGZADO/vSjlcUW7lwc5xE85Dy4PPxmP+GAkW4i/BVrR
         zTWqFEG4YaS1RLbHelsL6JKgFZKIW+cxSJL+eN3ftxDHSaVuL85Ui0UTvJnpT9gYg9HE
         gx+g==
X-Gm-Message-State: AOPr4FUzTfmhrPkkDQZRKpVRgbLLsxT/Hqvx3XjTbXWniWpmV0Y43jaVJ8xWEdOeaPpr4A==
X-Received: by 10.140.107.70 with SMTP id g64mr7135129qgf.43.1462484867007;
        Thu, 05 May 2016 14:47:47 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g186sm4393740qke.49.2016.05.05.14.47.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2016 14:47:46 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293694>

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
index b00919a..d91742c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -22,6 +22,7 @@
 #include "pkt-line.h"
 #include "sigchain.h"
 #include "ewah/ewok.h"
+#include "run-command.h"
 
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 					       unsigned int options);
@@ -1724,6 +1725,33 @@ static void post_read_index_from(struct index_state *istate)
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
 
@@ -1797,6 +1825,7 @@ static int poke_daemon(struct index_state *istate,
 	if (fd < 0) {
 		warning("Failed to connect to index-helper socket");
 		unlink(git_path("index-helper.sock"));
+		autorun_index_helper();
 		return -1;
 	}
 	sigchain_push(SIGPIPE, SIG_IGN);
@@ -1836,9 +1865,13 @@ static int try_shm(struct index_state *istate)
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
