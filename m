From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/5] submodule: display summary header in bold
Date: Tue,  2 Oct 2012 22:21:10 +0530
Message-ID: <1349196670-2844-6-git-send-email-artagnon@gmail.com>
References: <1349196670-2844-1-git-send-email-artagnon@gmail.com>
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 18:52:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ5hg-0007bu-Tu
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 18:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307Ab2JBQvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 12:51:52 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61183 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050Ab2JBQvn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 12:51:43 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so8944010pbb.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 09:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=YXdDXrpg5FmihGBjSzoJjBtcITgC6h1qSP5j59Q4eNA=;
        b=C7Fz7dURTGTtdvLGMp3ZHKUhGHkUmzwbYAWASS4slTIYv1otKQp2Zy9j/dzH9EXHeD
         TGcweVGZU9AfaL4CePOAnSTIAsG8YlsRJtl/J8oaYRFDoIggvL0zGmWr83usu3a7/l09
         HTG8irseDHWqm7xRkm/Yxy7ADWStVrKE6mROoXUWsoCfxhWmVoyWvd5kdVdCqSrKcRib
         6ahcKGygoaP6tLT1RkT8uLvgybQi72oMGcT0F75gBcTWZdTWL2+at9MghmR4Tf1CNf8g
         mnzrT07QfBnpZSkNRBx9iAYRyQ9d1HQfUc4eoBr4cMd9NILW2D10K3HdwdMC7rBwNjuU
         aNUA==
Received: by 10.66.79.36 with SMTP id g4mr45344617pax.67.1349196703527;
        Tue, 02 Oct 2012 09:51:43 -0700 (PDT)
Received: from localhost.localdomain ([49.206.137.123])
        by mx.google.com with ESMTPS id qd9sm1151524pbb.31.2012.10.02.09.51.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Oct 2012 09:51:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1349196670-2844-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206817>

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
index 4cb8dd2..cf369c5 100644
--- a/diff.c
+++ b/diff.c
@@ -2240,7 +2240,7 @@ static void builtin_diff(const char *name_a,
 			const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
 			show_submodule_summary(o->file, one ? one->path : two->path,
 					one->sha1, two->sha1, two->dirty_submodule,
-					del, add, reset);
+					set, del, add, reset);
 			return;
 		}
 	}
diff --git a/submodule.c b/submodule.c
index 50f213e..be60e89 100644
--- a/submodule.c
+++ b/submodule.c
@@ -258,7 +258,7 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
 
 void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
-		unsigned dirty_submodule,
+		unsigned dirty_submodule, const char *set,
 		const char *del, const char *add, const char *reset)
 {
 	struct rev_info rev;
@@ -292,15 +292,15 @@ void show_submodule_summary(FILE *f, const char *path,
 		return;
 	}
 
-	strbuf_addf(&sb, "Submodule %s %s..", path,
+	strbuf_addf(&sb, "%sSubmodule %s %s..", set, path,
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
index 594b50d..ef5aab6 100644
--- a/submodule.h
+++ b/submodule.h
@@ -20,7 +20,7 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
-		unsigned dirty_submodule,
+		unsigned dirty_submodule, const char *set,
 		const char *del, const char *add, const char *reset);
 void set_config_fetch_recurse_submodules(int value);
 void check_for_new_submodule_commits(unsigned char new_sha1[20]);
-- 
1.7.8.1.362.g5d6df.dirty
