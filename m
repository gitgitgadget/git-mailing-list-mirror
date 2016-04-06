From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 15/16] index-helper: optionally automatically run
Date: Wed,  6 Apr 2016 18:12:01 -0400
Message-ID: <1459980722-4836-16-git-send-email-dturner@twopensource.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com, aevarb@gmail.com,
	jeffhost@microsoft.com
X-From: git-owner@vger.kernel.org Thu Apr 07 00:13:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anvhN-0004xc-UR
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 00:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802AbcDFWM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 18:12:59 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34028 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244AbcDFWMx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 18:12:53 -0400
Received: by mail-qg0-f54.google.com with SMTP id c6so48313758qga.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 15:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VJHJDGAE8gxvDAk3wvczCp+4Pj/y8BpT7CLHMlMeRdE=;
        b=kct5dpKUjbR5toZE4ZXvU6tEAbI1zn5b0M2iQqeTWLKMlKcNiWYR/0iX9QnES7SJy/
         mBjCr3F+4o7EVY4B5U1CTtb6N+cTFrwg3I/Q6VsCNHFtBAkXcbjQtGpjCNUwvji8qHCS
         ejaVgTHOpXZqy8XB82jIf6C0tyEYDL+LJe4SzGabeBlSdXSrinla6NUqftH5QTC8fGMj
         xC0Yn4uAdMEWaE0PjG/NtXDUrgZokx1CiSYgKtcSTryb2cZ7m/b6M6eoT4nsf1es5NI6
         3Kzcufm54SXEXCU1SUgwDgVhAVZsjceS8zW9mOX6ynQ0NFhdzRAFPDx/qRsvhZlQWkwk
         9uKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VJHJDGAE8gxvDAk3wvczCp+4Pj/y8BpT7CLHMlMeRdE=;
        b=KvVslsrmUDGXNRgW9A92QeSn/oh78mS1Q/58dP59KlBNH/QY1hlNT7ylcaiZjbnbe+
         vKp606YVQrECIbVzmo6UbKXzEL7vdTug5RCMh/CSwZQ71mcEdOlrr3tXdXXIMlhqoV25
         iOeDxZ7rqjWgHVsxlxgENCyrXdjj6OjD2kUOFoAx+QRBugw6sn0FrDLb32g0LBPXevgr
         Xm9WEEyIx4ATj7suL1+hXiMkfslhfQ0FIcrzurbSKQBYC3E9a7BbWLPry6+eaJaGCA0f
         FS9YOGceUyM2+ypn9eLavsb+80idoaIhp51ytgwDLR0YnllUdHbDV2koEnHilfRjB49c
         Jv8A==
X-Gm-Message-State: AD7BkJIHeKoaFToh5cXPzADh8t1wGjzTtJmFYdlqf1X8urA3ZnxQjxTWLbbomsPBPfmU3w==
X-Received: by 10.140.232.15 with SMTP id d15mr31742029qhc.87.1459980771237;
        Wed, 06 Apr 2016 15:12:51 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id l33sm2165241qge.11.2016.04.06.15.12.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 15:12:50 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290882>

Introduce a new config option, indexhelper.autorun, to automatically
run git index-helper before starting up a builtin git command.  This
enables users to keep index-helper running without manual
intervention.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/config.txt |  4 ++++
 git.c                    | 35 ++++++++++++++++++++++++++++++++++-
 t/t7900-index-helper.sh  | 16 ++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

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
index 3925ee3..6e11f8c 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -50,4 +50,20 @@ test_expect_success 'index-helper is quiet with --autorun' '
 	git index-helper --autorun
 '
 
+test_expect_success 'index-helper autorun works' '
+	rm -f .git/index-helper.path &&
+	git status &&
+	test_path_is_missing .git/index-helper.path &&
+	test_config indexhelper.autorun true &&
+	git status &&
+	test -L .git/index-helper.path &&
+	git status 2>err &&
+	test -L .git/index-helper.path &&
+	! grep -q . err &&
+	git index-helper --kill &&
+	test_config indexhelper.autorun false &&
+	git status &&
+	test_path_is_missing .git/index-helper.path
+'
+
 test_done
-- 
2.4.2.767.g62658d5-twtrsrc
