From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v6 1/2] git-pull.c: introduce git_pull_config()
Date: Tue,  8 Mar 2016 23:49:07 +0530
Message-ID: <1457461148-8109-1-git-send-email-mehul.jain2029@gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
Cc: Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com,
	pyokagan@gmail.com, sunshine@sunshineco.com,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 19:19:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adMEY-0003Ss-G3
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 19:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbcCHSTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 13:19:47 -0500
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35396 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbcCHSTp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 13:19:45 -0500
Received: by mail-pa0-f66.google.com with SMTP id fl4so1636438pad.2
        for <git@vger.kernel.org>; Tue, 08 Mar 2016 10:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zk2lIiwD2WaaVKTKqRCAHY5rmtVAIWm+oAR4BX7aIsg=;
        b=jJHBTfAPcR5pSQbrn1l4ucijj7IBD5NwhJ9Vx1IPSkpQWJhVemM2FpBjE+uj3x18lT
         MYvTw/he1W2jPna+0oNkPVrmOYRCR/mGB7hVXp00/t8qDul4MqpVaZ4GAVRxM8PX+hR7
         SdGR3FZBG0x8tEnB6jL7jact9CSltglckX5eFxKMpxfOiIVy0GBCsjE86TUducRloetp
         F99dNat+/dVKGVItDfLN1ImhVNCf81OWNnnJ/jvcyJIs7CiXk2FyH/vK5er0mDpdpb02
         51rJw6IyHFoQMqP/09SFGR54SCkTe1KJ8RVvPH4YNEY55hXV5yjYKMv7b60S1IIZLKji
         DDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zk2lIiwD2WaaVKTKqRCAHY5rmtVAIWm+oAR4BX7aIsg=;
        b=lqIDM8NKhf1pWKYHZqFyu1wtVDdJ5+Ejb4kiK4N1cGp/nwvWbNF4i11UpJiuB178zL
         v9Ttv0/0CgcCww0EW0FxvF0ZtkpTGrZTmYrNKIM8mp/F19Cngo/pTwgQwW9n8FbqPs1D
         VEOX6LnvUYvK1m7kD2APNoqhx5hj2CRS/F3DL2C0iYdQUTXHW6vSLFiA/V45Q1emDpNx
         +gf2mDy21xJxYsorxVmPfzgolPepzOZBxDQ0+Hx7YidM6BpJaX/ZOB6gWrD4+UQ6uZVa
         XmI1LDSR1HqvcqFOXwAUTBzJxgCUbYCXr8Ik4Y7PcXkTV2pNZWUxaeqMyBXSm3itu72u
         m6Hg==
X-Gm-Message-State: AD7BkJKDI9rdtjZP0l4IgtdutjtxzwlGb7cYFZRuXSjbK+Hw7m6LqvTy+P1aR3I3zrYDkA==
X-Received: by 10.66.65.109 with SMTP id w13mr43468028pas.142.1457461184512;
        Tue, 08 Mar 2016 10:19:44 -0800 (PST)
Received: from localhost.localdomain ([1.39.39.116])
        by smtp.gmail.com with ESMTPSA id y27sm6510684pfi.82.2016.03.08.10.19.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Mar 2016 10:19:43 -0800 (PST)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288445>

git-pull makes a seperate call to git_config_get_bool() to read the value
of "rebase.autostash", this can be reduced as a call to git_config() is
already there in the code.

Introduce a callback function git_pull_config() to read "rebase.autostash"
along with other variables.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
previous patches: $gname287709

This is a clean-up patch to add --[no-]autostash option to 
"git pull --rebase".
 
 builtin/pull.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 10eff03..8a318e9 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -86,6 +86,7 @@ static char *opt_commit;
 static char *opt_edit;
 static char *opt_ff;
 static char *opt_verify_signatures;
+static int config_autostash = -1;
 static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
 static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
 static char *opt_gpg_sign;
@@ -304,6 +305,17 @@ static enum rebase_type config_get_rebase(void)
 
 	return REBASE_FALSE;
 }
+/**
+ * Read config variables.
+ */
+static int git_pull_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "rebase.autostash")) {
+		config_autostash = git_config_bool(var, value);
+		return 0;
+	}
+	return git_default_config(var, value, cb);
+}
 
 /**
  * Returns 1 if there are unstaged changes, 0 otherwise.
@@ -823,7 +835,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (opt_rebase < 0)
 		opt_rebase = config_get_rebase();
 
-	git_config(git_default_config, NULL);
+	git_config(git_pull_config, NULL);
 
 	if (read_cache_unmerged())
 		die_resolve_conflict("Pull");
@@ -835,13 +847,11 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		hashclr(orig_head);
 
 	if (opt_rebase) {
-		int autostash = 0;
 
 		if (is_null_sha1(orig_head) && !is_cache_unborn())
 			die(_("Updating an unborn branch with changes added to the index."));
 
-		git_config_get_bool("rebase.autostash", &autostash);
-		if (!autostash)
+		if (config_autostash != 1)
 			die_on_unclean_work_tree(prefix);
 
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
-- 
2.7.1.340.g69eb491.dirty
