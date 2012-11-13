From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 4/4] submodule: display summary header in bold
Date: Tue, 13 Nov 2012 21:12:47 +0530
Message-ID: <1352821367-3611-5-git-send-email-artagnon@gmail.com>
References: <http://mid.gmane.org/1352653146-3932-1-git-send-email-artagnon@gmail.com>
 <1352821367-3611-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 16:43:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYIe8-0000wO-MR
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 16:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060Ab2KMPnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 10:43:10 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:37022 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851Ab2KMPnD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 10:43:03 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so5097397pad.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 07:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jRy4uW/Req4DIJWCXprczdTVVfvh/HQgVSiCO3Tj1Ck=;
        b=f3Ff17FSmO8q2g5rru2aF58S0Wrju2GhwsNbTg70aT4pvlglbzSgDnTXEgwWvfnLZs
         HrQcLGotkjFI5PLp7lVaBztsTeBzFs8S8IeeTkjt7sI7nWjmW8mRycsPVrDBV3svUNoH
         qyb3MA1v5jPlJzSHeH8m6aVhtHZHmjS4tD4BCvXrK3T8iBFCkxAP0FdE6RbI8Otjr0QC
         0L5uZWew+8mw+x7TzmC3tLBL7+hYybzUKZwUk3j6+pr4CXjyGuFi+YHZdeFGKw9PBTyM
         lqSmRaldLt77RdzCWLu5dsEVKim9OupNn4YWm9aczPkjFDQHFxzitFPUgfqJN92gGnRH
         bQ+Q==
Received: by 10.68.219.164 with SMTP id pp4mr29949212pbc.72.1352821383158;
        Tue, 13 Nov 2012 07:43:03 -0800 (PST)
Received: from localhost.localdomain ([49.206.137.123])
        by mx.google.com with ESMTPS id hs2sm3546550pbc.22.2012.11.13.07.43.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 07:43:02 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1352821367-3611-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209623>

Currently, 'git diff --submodule' displays output with a bold diff
header for non-submodules.  So this part is in bold:

    diff --git a/file1 b/file1
    index 30b2f6c..2638038 100644
    --- a/file1
    +++ b/file1

For submodules, the header looks like this:

    Submodule submodule1 012b072..248d0fd:

Unfortunately, it's easy to miss in the output because it's not bold.
Change this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 diff.c      |    2 +-
 submodule.c |    8 ++++----
 submodule.h |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index ffaed72..1065978 100644
--- a/diff.c
+++ b/diff.c
@@ -2261,7 +2261,7 @@ static void builtin_diff(const char *name_a,
 		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
 		show_submodule_summary(o->file, one ? one->path : two->path,
 				one->sha1, two->sha1, two->dirty_submodule,
-				del, add, reset);
+				meta, del, add, reset);
 		return;
 	}
 
diff --git a/submodule.c b/submodule.c
index e3e0b45..2f55436 100644
--- a/submodule.c
+++ b/submodule.c
@@ -258,7 +258,7 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
 
 void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
-		unsigned dirty_submodule,
+		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset)
 {
 	struct rev_info rev;
@@ -292,15 +292,15 @@ void show_submodule_summary(FILE *f, const char *path,
 		return;
 	}
 
-	strbuf_addf(&sb, "Submodule %s %s..", path,
+	strbuf_addf(&sb, "%sSubmodule %s %s..", meta, path,
 			find_unique_abbrev(one, DEFAULT_ABBREV));
 	if (!fast_backward && !fast_forward)
 		strbuf_addch(&sb, '.');
 	strbuf_addf(&sb, "%s", find_unique_abbrev(two, DEFAULT_ABBREV));
 	if (message)
-		strbuf_addf(&sb, " %s\n", message);
+		strbuf_addf(&sb, " %s%s\n", message, reset);
 	else
-		strbuf_addf(&sb, "%s:\n", fast_backward ? " (rewind)" : "");
+		strbuf_addf(&sb, "%s:%s\n", fast_backward ? " (rewind)" : "", reset);
 	fwrite(sb.buf, sb.len, 1, f);
 
 	if (!message) {
diff --git a/submodule.h b/submodule.h
index f2e8271..3dc1b3f 100644
--- a/submodule.h
+++ b/submodule.h
@@ -20,7 +20,7 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
-		unsigned dirty_submodule,
+		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset);
 void set_config_fetch_recurse_submodules(int value);
 void check_for_new_submodule_commits(unsigned char new_sha1[20]);
-- 
1.7.8.1.362.g5d6df.dirty
