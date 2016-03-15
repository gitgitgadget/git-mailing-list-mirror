From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH 1/2] git-pull.c: introduce git_pull_config()
Date: Tue, 15 Mar 2016 22:41:43 +0530
Message-ID: <1458061904-26516-1-git-send-email-mehul.jain2029@gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
Cc: Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com,
	pyokagan@gmail.com, sunshine@sunshineco.com,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 18:12:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afsWL-00036K-TQ
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 18:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbcCORMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 13:12:35 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33450 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934816AbcCORMd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 13:12:33 -0400
Received: by mail-pf0-f178.google.com with SMTP id 124so36716980pfg.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 10:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=10HDiFYoAAw7DZuxF1U/b0znYzulIPpjycCu2A3aq4w=;
        b=RA5AgGmBpcL0cLFOJOZi5UbKAF4XUBhIVqGgJnBpD4k/diLl8sYEzWtPpFR6WjKmSs
         lPuetRdDwomQ+Epq+CbczQx84gD1esre+0dgcqrE2a6cvV72anrMH+ibb3u1R0Ma1IIl
         x+krNP2AnYZMBKvhTOHgen7uAwwZybYaTyI+3rHdrEZ4EZS92PvQC6DiFQ4s8lyOEaVQ
         tB84z+M/MvaSqm3/AXEO6bHhVscJQhFEvBYWqFKE4eEll060Y3UxK/qu+AQq2kxaTxkb
         c0fUC6kMk+kr8mWtLi30V8ecJzf+az9NX7a5EfO42MnEWG7ZjfFP+wEwDkMt5On9fUl3
         2vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=10HDiFYoAAw7DZuxF1U/b0znYzulIPpjycCu2A3aq4w=;
        b=F2Gm5i6VsI7JgSnZ4Lr4XXSyYqUWoHwk1CG49+1yhvvVTyqsX0I9BoqDN/iQUPLFLF
         Y7r4xyDFWvcd1I6CIf/KAJQcqFZeeV2vMMLnPDNRid98Kxg3bcXQly/pO0uCfF/KbRcT
         8DO/CiX6lDKlDBzf0APTgDOMXTfd1dza2Q6v2SQ1V17syNEk68l2ChHfkfV1xl2uDtGy
         wpLMtrjC/9iTHLyM2ukYdcM7AfeaWu4klUYQDnO0bGs1GW5A2LjxPOFsvz+rGSX8wQk2
         Se8CjlbehoLGXnOvmp9PJ8RR7klr2juQctnik9Hgru+ZJ2Fo2GS9hUrnOOlslx7pdkMC
         nGEg==
X-Gm-Message-State: AD7BkJJOHb9md1pA7SbeH35X41BSPBMNHeLRrCKFvoMpZFkeNg9LBb5NRh2V0GmOLQGA3A==
X-Received: by 10.66.65.137 with SMTP id x9mr47785325pas.137.1458061952525;
        Tue, 15 Mar 2016 10:12:32 -0700 (PDT)
Received: from localhost.localdomain ([1.39.36.65])
        by smtp.gmail.com with ESMTPSA id 9sm40988137pfm.10.2016.03.15.10.12.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 10:12:31 -0700 (PDT)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288884>

git-pull makes a seperate call to git_config_get_bool() to read the value
of "rebase.autostash", this can be reduced as a call to git_config() is
already there in the code.

Introduce a callback function git_pull_config() to read "rebase.autostash"
along with other variables.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Paul Tan <pyokagan@gmail.com>
Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
Previous patches: http://thread.gmane.org/gmane.comp.version-control.git/287709

Change: config_autostash initialized with 0 instead of -1

 builtin/pull.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 10eff03..43353f9 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -86,6 +86,7 @@ static char *opt_commit;
 static char *opt_edit;
 static char *opt_ff;
 static char *opt_verify_signatures;
+static int config_autostash;
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
+		if (config_autostash)
 			die_on_unclean_work_tree(prefix);
 
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
-- 
2.7.1.340.g69eb491.dirty
