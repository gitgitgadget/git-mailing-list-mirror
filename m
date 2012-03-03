From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v2 1/3] Use startup_info->prefix rather than prefix.
Date: Sat,  3 Mar 2012 09:40:28 -0500
Message-ID: <606ef5a298db20ca54dc9a53f0e1541e94aafe57.1330785363.git.jaredhance@gmail.com>
References: <cover.1330740964.git.jaredhance@gmail.com>
Cc: gitster@pobox.com, Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 15:41:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3q95-0000V6-Bh
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 15:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492Ab2CCOlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 09:41:09 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38321 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250Ab2CCOlI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 09:41:08 -0500
Received: by mail-iy0-f174.google.com with SMTP id z16so3544384iag.19
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 06:41:08 -0800 (PST)
Received-SPF: pass (google.com: domain of jaredhance@gmail.com designates 10.43.49.201 as permitted sender) client-ip=10.43.49.201;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jaredhance@gmail.com designates 10.43.49.201 as permitted sender) smtp.mail=jaredhance@gmail.com; dkim=pass header.i=jaredhance@gmail.com
Received: from mr.google.com ([10.43.49.201])
        by 10.43.49.201 with SMTP id vb9mr9556315icb.35.1330785668083 (num_hops = 1);
        Sat, 03 Mar 2012 06:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=C3CV72D/Mm1TfIdGTPGUw1Ivt7lrChzQu7EjYZLeDLY=;
        b=f8nJbZ936leK1ubP5Y/7eZX2UrT3ldA8yXhOSXVxeS+vWjfIZ5F+oCsbQ+Gm55BWip
         jUR7SfUyYchL6bDLXUiLs9jHivQX1N4dYDF/ffbVFKjIpKqgT7mS9aJ6i7F/6BQ+O7zj
         +9LVq4gpI5HL/vChQxt7vcDkLeVCMarpGxExXZ396ut5F+nsBhLfg6Cpuj1pSPMt2ytu
         CfaUH5s/8yS+MIn730CJxGnC2oneqbReo++JmVKL/yzSTteYZ9LEVxW2nTYLeLb4NGK5
         qx5oFxpYMObdvE0rQAOE8mrZau/N9u/rlyzdg2eT+qLrCRFZvxkNoBwqRYED6AXIhYmY
         3qVg==
Received: by 10.43.49.201 with SMTP id vb9mr7847861icb.35.1330785667989;
        Sat, 03 Mar 2012 06:41:07 -0800 (PST)
Received: from localhost.localdomain (cpe-174-101-220-163.cinci.res.rr.com. [174.101.220.163])
        by mx.google.com with ESMTPS id b6sm5212250igj.7.2012.03.03.06.41.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 06:41:06 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <cover.1330740964.git.jaredhance@gmail.com>
In-Reply-To: <cover.1330785363.git.jaredhance@gmail.com>
References: <cover.1330785363.git.jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192111>

In trace_repo_setup, prefix is passed in as startup_info->prefix. But, as
indicated but a FIXME comment, trace_repo_setup has access to
startup_info. The prefix parameter has therefor been eliminated.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---
 cache.h |    2 +-
 git.c   |    2 +-
 trace.c |   10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index e12b15f..baa8852 100644
--- a/cache.h
+++ b/cache.h
@@ -1211,7 +1211,7 @@ extern void trace_printf(const char *format, ...);
 extern void trace_vprintf(const char *key, const char *format, va_list ap);
 __attribute__((format (printf, 2, 3)))
 extern void trace_argv_printf(const char **argv, const char *format, ...);
-extern void trace_repo_setup(const char *prefix);
+extern void trace_repo_setup(void);
 extern int trace_want(const char *key);
 extern void trace_strbuf(const char *key, const struct strbuf *buf);
 
diff --git a/git.c b/git.c
index 3805616..7dcc527 100644
--- a/git.c
+++ b/git.c
@@ -296,7 +296,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 		if ((p->option & (RUN_SETUP | RUN_SETUP_GENTLY)) &&
 		    startup_info->have_repository) /* get_git_dir() may set up repo, avoid that */
-			trace_repo_setup(prefix);
+			trace_repo_setup();
 	}
 	commit_pager_choice();
 
diff --git a/trace.c b/trace.c
index d953416..09a470b 100644
--- a/trace.c
+++ b/trace.c
@@ -152,8 +152,7 @@ static const char *quote_crnl(const char *path)
 	return new_path;
 }
 
-/* FIXME: move prefix to startup_info struct and get rid of this arg */
-void trace_repo_setup(const char *prefix)
+void trace_repo_setup(void)
 {
 	static const char *key = "GIT_TRACE_SETUP";
 	const char *git_work_tree;
@@ -168,13 +167,14 @@ void trace_repo_setup(const char *prefix)
 	if (!(git_work_tree = get_git_work_tree()))
 		git_work_tree = "(null)";
 
-	if (!prefix)
-		prefix = "(null)";
+	if (!startup_info->prefix)
+		startup_info->prefix = "(null)";
 
 	trace_printf_key(key, "setup: git_dir: %s\n", quote_crnl(get_git_dir()));
 	trace_printf_key(key, "setup: worktree: %s\n", quote_crnl(git_work_tree));
 	trace_printf_key(key, "setup: cwd: %s\n", quote_crnl(cwd));
-	trace_printf_key(key, "setup: prefix: %s\n", quote_crnl(prefix));
+	trace_printf_key(key, "setup: prefix: %s\n",
+			 quote_crnl(startup_info->prefix));
 }
 
 int trace_want(const char *key)
-- 
1.7.3.4
