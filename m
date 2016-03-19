From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 16/17] index-helper: optionally automatically run
Date: Fri, 18 Mar 2016 21:04:49 -0400
Message-ID: <1458349490-1704-17-git-send-email-dturner@twopensource.com>
References: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 19 02:08:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah5Ni-00018v-8o
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 02:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754359AbcCSBIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 21:08:36 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:35495 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526AbcCSBI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 21:08:27 -0400
Received: by mail-qg0-f53.google.com with SMTP id y89so115401729qge.2
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 18:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TFr4LFBPPTnQGM/E9/mbcoTUNGf9zO7aWvnEeQ1DplI=;
        b=ppTF589/vCkFI9o0bKKqvmuCSnPnsjljbhTn1noKkGZAhxfnHVYpLPblX4R1o36jFr
         UQa7DAhdl2ogg0ow/kNeTpAzdlc3UmQAz81C/g4r+WnynIgbCil+auyCWnwXsEvYmLLO
         UZ/KThvyl533PwMZ28Na+cUWKrsJvnz7jxg8hcAazeUCKQub0O6kulDpbmqHiNz8CArk
         V6VhSjMjY4o+JLbOtEaMVCtQ4qlB0XpYCHMgKroE2V62rccBLQQtsyECOMMSzoh4Qh0+
         dHcYGaE8jBEmkVxYNIkFqgSSu3lkF31CJc2a6OePmbZG6vJooXq6ZSyhDKRBXMSQci3u
         Whkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TFr4LFBPPTnQGM/E9/mbcoTUNGf9zO7aWvnEeQ1DplI=;
        b=VSc8d1hzUTbPcwWuReMOuoK59mLFNH4OKjwFVW2KpKYUQ0OvwdkgC4GdrzjF2PmTuY
         0OO03qI5Khb8SYll48GY8BomOWuMC5eDT7BJrARS2GnYxCxMaVZyIqjfUPlkvdEBh0nT
         TTX1do9F81Q+IRp2Tt75bl3Ce/jBn3zyGi3dspwHZXJiC2wuHNWZFCrgINWoFYHZ/Sdw
         w061mj0e+pfmujdvoHFBvQdFQ4ZgWZe/+2Sz02jpLJm6OqQWvxGuXR2CrP7dhaQRY4ry
         cTgOjAk86+G0ZYHVVVlU2gFztoc3yMDPx8q1Vx6yfMrsQU2Dp34cClSShnS93e0ktrk/
         E5OQ==
X-Gm-Message-State: AD7BkJJFa/Wcysthox3yckQVFaEjd29kuwIkb7GOUGS6IJ2gKHFee3JMGSkOMpK+3GjSoQ==
X-Received: by 10.140.249.6 with SMTP id u6mr27745894qhc.83.1458349706631;
        Fri, 18 Mar 2016 18:08:26 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id 139sm7186154qho.2.2016.03.18.18.08.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2016 18:08:25 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289284>

Introduce a new config option, indexhelper.autorun, to automatically
run git index-helper before starting up a builtin git command.  This
enables users to keep index-helper running without manual
intervention.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 git.c                   | 35 ++++++++++++++++++++++++++++++++++-
 t/t7900-index-helper.sh | 16 ++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/git.c b/git.c
index 6cc0c07..7d27782 100644
--- a/git.c
+++ b/git.c
@@ -521,6 +521,37 @@ static void strip_extension(const char **argv)
 #define strip_extension(cmd)
 #endif
 
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
+static void maybe_run_index_helper(struct cmd_struct *cmd)
+{
+	const char *argv[] = {"git-index-helper", "--detach", "--autorun", NULL};
+
+	if (!(cmd->option & NEED_WORK_TREE))
+		return;
+
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
 static void handle_builtin(int argc, const char **argv)
 {
 	const char *cmd;
@@ -536,8 +567,10 @@ static void handle_builtin(int argc, const char **argv)
 	}
 
 	builtin = get_builtin(cmd);
-	if (builtin)
+	if (builtin) {
+		maybe_run_index_helper(builtin);
 		exit(run_builtin(builtin, argc, argv));
+	}
 }
 
 static void execv_dashed_external(const char **argv)
diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
index 6020fe4..7fe66b7 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -41,4 +41,20 @@ test_expect_success 'index-helper is quiet with --autorun' '
 	git index-helper --autorun
 '
 
+test_expect_success 'index-helper autorun works' '
+	rm -f .git/index-helper.pipe &&
+	git status &&
+	test_path_is_missing .git/index-helper.pipe &&
+	test_config indexhelper.autorun true &&
+	git status &&
+	test -p .git/index-helper.pipe &&
+	git status 2>err &&
+	test -p .git/index-helper.pipe &&
+	! grep -q . err &&
+	git index-helper --kill &&
+	test_config indexhelper.autorun false &&
+	git status &&
+	test_path_is_missing .git/index-helper.pipe
+'
+
 test_done
-- 
2.4.2.767.g62658d5-twtrsrc
