From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v9 1/2] git-pull.c: introduce git_pull_config()
Date: Thu, 17 Mar 2016 22:19:29 +0530
Message-ID: <1458233370-8343-1-git-send-email-mehul.jain2029@gmail.com>
Cc: gitster@pobox.com, Matthieu.Moy@grenoble-inp.fr,
	pyokagan@gmail.com, sunshine@sunshineco.com,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 17:52:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agbA3-0001Xq-Ca
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 17:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031217AbcCQQwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 12:52:33 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33546 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967128AbcCQQwb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 12:52:31 -0400
Received: by mail-pf0-f196.google.com with SMTP id x3so11842285pfb.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 09:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=azUyT8cX2uoyIQoqP3hWnYA6iVFSmWjJVwV8bwWQ74k=;
        b=OvuNNsXgkvLW4DRW2MTCeRxlkAFCgdK4qP8UWXt+1tHuxNaUtvuXBzJejYAG49j5fe
         3anMJn04JSj8QbevlLAMWIfGja/SiHIvRbMlns1RLKo5xoHSt+NqswKmYkCUbLyasosD
         SDsJvdtOnbwSiroY4zzQ6pnbkqViD6k7EPS3CkOVl6HY6WSr+2HZrK+GYFIEiXUhBIDh
         LwEl8Ck+1ek3m11GXg9bQLgp8eAK2D515zzKf8fi5oHI78DYzxbrJSKBmCMB4a5Oy22F
         Rxpo2yZ2/2RsEdQPN5JnCGsaHRfyC//7xUsXEh/IJaDl8rnx+cByLVTQAmWGBA47nZX9
         FWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=azUyT8cX2uoyIQoqP3hWnYA6iVFSmWjJVwV8bwWQ74k=;
        b=JpCv1Z6jqnENvBlqXv6Np2izkwY+y0xfZ1D4rza+rZIxxIIJged7jcDC+RMJwGxIg8
         BySwgJTyJmngDU7S9Mk6kICkgsbxlG0vnhhvdcA85Uue+tW0Y+Jl7Jc+WS0afw8sK61v
         B/Ln7ZSIrlshSB2kDckOJ+SyP0kpnoPAzbvf1FCGL8r/kY4BWvHCbiNz97DtIlJ0/t8D
         QOu2JwgrsNK9CqsW7kU2mNN2mK6nKNxhlBxHMwc2KdcGi3yZESz5o20WRpU04Z1g796m
         CsikBu2WJ1vYvBfcErFlrhOWGZmpOQRozbfWTVz7lzLb27RD7R8yIRW44p/7MG4xUgp1
         TpHg==
X-Gm-Message-State: AD7BkJJwQCApVGhbdaLkV2OE4tB5CS8x1r2omJo2V/w7kRjEoz25AHQJmloRvaL221FkAA==
X-Received: by 10.98.7.135 with SMTP id 7mr16235127pfh.124.1458233550853;
        Thu, 17 Mar 2016 09:52:30 -0700 (PDT)
Received: from localhost.localdomain ([1.39.37.204])
        by smtp.gmail.com with ESMTPSA id q2sm14600258pfq.88.2016.03.17.09.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Mar 2016 09:52:30 -0700 (PDT)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289127>

git-pull makes a seperate call to git_config_get_bool() to read the value
of "rebase.autostash". This can be reduced as a call to git_config() is
already there in the code.

Introduce a callback function git_pull_config() to read "rebase.autostash"
along with other variables.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Paul Tan <pyokagan@gmail.com>
Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
previous patches: http://thread.gmane.org/gmane.comp.version-control.git/287709
 builtin/pull.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 10eff03..72f4475 100644
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
@@ -835,13 +847,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		hashclr(orig_head);
 
 	if (opt_rebase) {
-		int autostash = 0;
-
 		if (is_null_sha1(orig_head) && !is_cache_unborn())
 			die(_("Updating an unborn branch with changes added to the index."));
 
-		git_config_get_bool("rebase.autostash", &autostash);
-		if (!autostash)
+		if (!config_autostash)
 			die_on_unclean_work_tree(prefix);
 
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
-- 
2.7.1.340.g69eb491.dirty
