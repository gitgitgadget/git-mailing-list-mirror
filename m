From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v3 1/3] pull --rebase: add --[no-]autostash flag
Date: Thu,  3 Mar 2016 21:43:19 +0530
Message-ID: <1457021601-9099-1-git-send-email-mehul.jain2029@gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
Cc: pyokagan@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 03 17:14:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abVtS-0004K9-72
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 17:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbcCCQOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 11:14:24 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36503 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932508AbcCCQOX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 11:14:23 -0500
Received: by mail-pf0-f196.google.com with SMTP id q129so1507420pfb.3
        for <git@vger.kernel.org>; Thu, 03 Mar 2016 08:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v0hlZHOjN1X//EItBWVQxRcbZifCMum06WrZ+ypYQDk=;
        b=lKrIDebG+amf52bwuQ+NWE4UhVdaLaysbvhnjWZfOunIWVvC+IXGg98ThR3AxCyvVI
         E8VOFvDE2YIqeHwYPfuUb8ZLySZnSUZKlDKjSR0Ud17fwLmGabHngiWr3ogevoX1WoVR
         lbVpIiXpN4yp1s6LLuEgFv4Uk9+TacQT++1ZHr7X89N3gY6sz9xi5OVos4RVtYAB3JYR
         UPUoxkOw1PDfn+yocBzSKWcjce9j/Bf/Rg/GAg4/jdwW+gnyk72LPcwezXTI9m72yeKa
         pNE8891jjFsOPX4Ig2isfYYpEwj+kDU36iqyb3vPgRQv2E8voiDhdKFfX9fTtqfjpmRX
         QtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v0hlZHOjN1X//EItBWVQxRcbZifCMum06WrZ+ypYQDk=;
        b=hvA5Bzp0c+6koABlJqqRwsS9h4NMmzga2Wqv46yfSkPjASMfWN8O/GpjrWQUP5Mvjv
         MfiIkMfuGH+Cacd7g/1F25Z6WV9+zU0LACuDaXXyx7PqEm+y2MqHwk5CYCtzEq5Dxf0o
         zp7kIXV+yg1CYzZUsgPsI59Wj40aEpUDjb8QcdQ/m+TXoEtSXyFuLIQxLxzbf4xOZZL4
         3ev0AS7qH3AIO+dsvgirxPJ4VbArJcRLx1etCp3LAvWgvfTkbfEhk5YZC9k+YRnIfok5
         Luy/R4+WF9wLY3FSmGNV5CeQUIKlorcEcMNXCEX4AbzgASg07H622XXQKQJyhERHB+c0
         Hw8A==
X-Gm-Message-State: AD7BkJIfUHsHJxXmStT5pokQ9MQNtKYgvEiZcsE07eVofF6+k+EJQPVezpnLr0+y6rNnCA==
X-Received: by 10.98.13.216 with SMTP id 85mr4705476pfn.143.1457021662313;
        Thu, 03 Mar 2016 08:14:22 -0800 (PST)
Received: from localhost.localdomain ([1.39.36.239])
        by smtp.gmail.com with ESMTPSA id z5sm30337230par.21.2016.03.03.08.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Mar 2016 08:14:21 -0800 (PST)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288186>

If rebase.autoStash configuration variable is 
set, there is no way to override it for 
"git pull --rebase" from the command line.

Teach "git pull --rebase" the --[no]autostash
command line flag which overrides the current
value of rebase.autostash, if set. As "git rebase"
understands the --[no]autostash option, it's 
just a matter of passing the option to underlying 
"git rebase" when "git pull --rebase" is called.

Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Paul Tan <pyokagan@gmail.com>
Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
Sorry for a late follow up. I had my mid-semester
examination going on.

Previous patch: $gname287709

Changes:
	* error message is produced when "git pull
	 --[no]autostash" is called.
  	* opt_autostash intialized with -1.

 builtin/pull.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 10eff03..b338b83 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -85,6 +85,7 @@ static char *opt_squash;
 static char *opt_commit;
 static char *opt_edit;
 static char *opt_ff;
+static int opt_autostash = -1;
 static char *opt_verify_signatures;
 static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
 static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
@@ -146,6 +147,8 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
 		N_("abort if fast-forward is not possible"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
+	OPT_BOOL(0, "autostash", &opt_autostash,
+		N_("automatically stash/stash pop before and after rebase")),
 	OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
 		N_("verify that the named commit has a valid GPG signature"),
 		PARSE_OPT_NOARG),
@@ -789,7 +792,8 @@ static int run_rebase(const unsigned char *curr_head,
 	argv_array_pushv(&args, opt_strategy_opts.argv);
 	if (opt_gpg_sign)
 		argv_array_push(&args, opt_gpg_sign);
-
+	if (opt_autostash)
+		argv_array_push(&args, "--autostash");
 	argv_array_push(&args, "--onto");
 	argv_array_push(&args, sha1_to_hex(merge_head));
 
@@ -835,18 +839,25 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		hashclr(orig_head);
 
 	if (opt_rebase) {
-		int autostash = 0;
-
 		if (is_null_sha1(orig_head) && !is_cache_unborn())
 			die(_("Updating an unborn branch with changes added to the index."));
 
-		git_config_get_bool("rebase.autostash", &autostash);
-		if (!autostash)
+		if (opt_autostash == -1)
+			git_config_get_bool("rebase.autostash", &opt_autostash);
+
+		if (opt_autostash == 0 || opt_autostash == -1)
 			die_on_unclean_work_tree(prefix);
 
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
 			hashclr(rebase_fork_point);
 	}
+	else {
+		/* If --[no-]autostash option is called without --rebase */
+		if (opt_autostash == 0)
+			die(_("--no-autostash option is only valid with --rebase."));
+		else if (opt_autostash == 1)
+			die(_("--autostash option is only valid with --rebase."));
+	}
 
 	if (run_fetch(repo, refspecs))
 		return 1;
-- 
2.7.1.340.g69eb491.dirty
