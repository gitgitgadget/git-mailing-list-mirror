From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCHv3 5/9] branch, commit, name-rev: ease up boolean conditions
Date: Sat,  3 Aug 2013 13:51:22 +0200
Message-ID: <1375530686-2309-6-git-send-email-stefanbeller@googlemail.com>
References: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Sat Aug 03 13:51:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5aN3-0005cc-JP
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 13:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588Ab3HCLvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 07:51:16 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:60244 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502Ab3HCLvO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 07:51:14 -0400
Received: by mail-ee0-f54.google.com with SMTP id e53so761597eek.41
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 04:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8+rlhikCzTZQ7YHSCmcT9symFXeEP/EL+YzlNJRcO6w=;
        b=Zv+GZYU40TwJElplJoYQACAyW/0EacYztVYFyihkrEIcr1QF+7BMU8VDiMe1RPhWXb
         ErO/mm6iIibqFCSOT91T4BOzShMM7CzIo0EBqAsDlE9vfiQor9Ad0oreGk+OjsCzsaYk
         CkoQ8bjalK9D/MF489qWsouW65JmGfozUtXHuqjNgnKBrBpWG0BbqFbHJBWvN1YbeMSi
         aMEUWQjPR2x8oC3vjHrNUqB0ZwfmN+ax1+tYlbnYnBOawDwK/Dpz7dnSbVYmvcm/fhCV
         u446zFrEbaIUa3Z+2FgrP2OYcB48vWmNIYTnV7gjX6y4/4O72BOcgkcFDbm0xEaLxNt+
         3ivQ==
X-Received: by 10.15.26.66 with SMTP id m42mr9312429eeu.73.1375530673076;
        Sat, 03 Aug 2013 04:51:13 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id x3sm3741629eew.4.2013.08.03.04.51.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 03 Aug 2013 04:51:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.16.g7fca822.dirty
In-Reply-To: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231585>

Now that the variables are readin by OPT_BOOL, which makes sure
to have the values being 0 or 1 after reading, we do not need
the double negation to map any other value to 1 for integer
variables.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/branch.c   | 3 ++-
 builtin/commit.c   | 2 +-
 builtin/name-rev.c | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 4daed0b..33ba1fb 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -872,7 +872,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (with_commit || merge_filter != NO_FILTER)
 		list = 1;
 
-	if (!!delete + !!rename + !!force_create + !!list + !!new_upstream + !!unset_upstream > 1)
+	if (delete + rename + force_create + list + unset_upstream +
+	    !!new_upstream > 1)
 		usage_with_options(builtin_branch_usage, options);
 
 	if (abbrev == -1)
diff --git a/builtin/commit.c b/builtin/commit.c
index c20426b..b0f86c8 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1072,7 +1072,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (patch_interactive)
 		interactive = 1;
 
-	if (!!also + !!only + !!all + !!interactive > 1)
+	if (also + only + all + interactive > 1)
 		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
 	if (argc == 0 && (also || (only && !amend)))
 		die(_("No paths with --include/--only does not make sense."));
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index a908a34..20fcf8c 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -331,7 +331,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
-	if (!!all + !!transform_stdin + !!argc > 1) {
+	if (all + transform_stdin + !!argc > 1) {
 		error("Specify either a list, or --all, not both!");
 		usage_with_options(name_rev_usage, opts);
 	}
-- 
1.8.4.rc0.16.g7fca822.dirty
