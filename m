From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v7 1/2] git-pull.c: introduce git_pull_config()
Date: Wed,  9 Mar 2016 09:48:19 +0530
Message-ID: <1457497100-13045-1-git-send-email-mehul.jain2029@gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
Cc: Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com,
	pyokagan@gmail.com, sunshine@sunshineco.com,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 05:18:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adVaE-0006NQ-DF
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 05:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbcCIESr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 23:18:47 -0500
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34894 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbcCIESp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 23:18:45 -0500
Received: by mail-pa0-f67.google.com with SMTP id fl4so2447105pad.2
        for <git@vger.kernel.org>; Tue, 08 Mar 2016 20:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zk2lIiwD2WaaVKTKqRCAHY5rmtVAIWm+oAR4BX7aIsg=;
        b=ZEzeHJ9TUoVAvYy9ri/dOhOberU571M0wQuNm/zJ1oZq5jNnEhw5fuL38KJezYkeeU
         2JYAMatUhJ5gQlWce2Et5xi+owkrGqP33RPxOEew5W7U+nuE5kXjHjV0PiM144X0ECDT
         NMM3+KW28BaKgUS9KI9t+D097iE5443gB1Er5gHfqDsUp4EBh1gS1figPdU606v8fLLn
         bdERYGwL5zv/uu4NvdzxxGTntAiasA+KKWy45naiNyrn78ytIoahMwI76RpAhux2Gfnd
         394fb+wAlC72z6Mz4f1gB4PfeTXPmY4+B/ufAflO86Oe9Sam16xcFsVnw+t9efZsUtm+
         jVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zk2lIiwD2WaaVKTKqRCAHY5rmtVAIWm+oAR4BX7aIsg=;
        b=ldZhSGK6VHadszHD9a+SCWd3LBhLIfhS6VWG+oc4NTiTmeLZ8iEadRopvOMbvEk6zB
         EZGTbDXdRtW0MNtSIyIahSOEkv35tfoOHm4D0nKOU51xwfC0K1amFQcKAARSCRT/hl0g
         ANVzcK7cpYd3Pqn9voc6axJtmvrCMNzl7YYswcPtKxK9esbreoMwSjtoa4tF56xu3hC/
         kcsfhoeVOJoPSuctnfh2LXcH0+9GYe0asqzm/aNzkAL9WJcpTrBh/SMdCtiuEtYpXWoP
         XzCuY1Pl1XvVLfeV+soQyWj4SKUAoEbNn9DRpqrm4Y71zLM/a+KDVPIKyaO1VeQfHqaw
         ggRQ==
X-Gm-Message-State: AD7BkJJHX7klaRVDvCl8oGyyi4suDFu6NVJrMtFNy+ujP44O9iuCru3B+1GLMeIvGSUrQQ==
X-Received: by 10.66.66.108 with SMTP id e12mr248840pat.33.1457497124957;
        Tue, 08 Mar 2016 20:18:44 -0800 (PST)
Received: from localhost.localdomain ([1.39.36.88])
        by smtp.gmail.com with ESMTPSA id s21sm8291548pfi.29.2016.03.08.20.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Mar 2016 20:18:44 -0800 (PST)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288473>

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
