From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v10 04/14] Refactor write_name_quoted_relative, remove unused params
Date: Thu, 16 May 2013 17:53:35 +0800
Message-ID: <a2794488b5ec4f221ff404b4875c7c23a54492c4.1368696028.git.worldhello.net@gmail.com>
References: <cover.1368696028.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 16 11:54:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcutB-0000qG-Qv
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 11:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996Ab3EPJyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 05:54:14 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:42530 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab3EPJyM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 05:54:12 -0400
Received: by mail-pa0-f45.google.com with SMTP id lj1so2358495pab.18
        for <git@vger.kernel.org>; Thu, 16 May 2013 02:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=FKSS0bNEFB3hkjZtBG93QMsTyiC9E7irJcv40KYJ8rA=;
        b=QUoIX6odiySpWwO1MzOXUyBvGCQj5v1pDfDD6SA+qKe+IdAWbBPu2GiEfYWYE0p/ve
         0j62cfTIxEDLpxNbBHuKdQ96RHqN0m2xp+QxpepspMJr5aRUSat/kFgJRy0TL1K0aKS+
         kI+j8ve9m75Td2g/MYJBt+n9nCfaSIPWzTkt1n8J2y6ykF87S26FAIcB/XBoQoxFK15Z
         UKO2T9eh3UVf2VgGAc2DbjEEUmDlzGFxPCoopBcFvZU8dWJ0nYWxkHG8icqSStlLEXQ0
         rbqA4mDphqIZQ2OPZTj2KywsMC/6P3dOQbqzd41nK/789FawAnktfVCV0pO00Zyisr3n
         I1Mg==
X-Received: by 10.66.4.106 with SMTP id j10mr43431174paj.218.1368698051650;
        Thu, 16 May 2013 02:54:11 -0700 (PDT)
Received: from localhost.localdomain ([114.248.153.37])
        by mx.google.com with ESMTPSA id cd2sm6183092pbd.35.2013.05.16.02.54.08
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 02:54:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.407.g762149a
In-Reply-To: <cover.1368696028.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368696028.git.worldhello.net@gmail.com>
References: <cover.1368696028.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224531>

After substitude path_relative() in quote.c with relative_path() from
path.c, parameters (such as len and prefix_len) are obsolte in function
write_name_quoted_relative(). Remove unused parameters from
write_name_quoted_relative() and related functions.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/ls-files.c | 14 ++++++++------
 quote.c            |  3 +--
 quote.h            |  3 +--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 00f07..d3b33 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -46,10 +46,12 @@ static const char *tag_modified = "";
 static const char *tag_skip_worktree = "";
 static const char *tag_resolve_undo = "";
 
-static void write_name(const char* name, size_t len)
+static void write_name(const char* name)
 {
-	write_name_quoted_relative(name, len, prefix, prefix_len, stdout,
-			line_terminator);
+
+	/* turn off prefix, if run with "--full-name" */
+	write_name_quoted_relative(name, prefix_len > 0 ? prefix : NULL,
+				   stdout, line_terminator);
 }
 
 static void show_dir_entry(const char *tag, struct dir_entry *ent)
@@ -63,7 +65,7 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
 		return;
 
 	fputs(tag, stdout);
-	write_name(ent->name, ent->len);
+	write_name(ent->name);
 }
 
 static void show_other_files(struct dir_struct *dir)
@@ -163,7 +165,7 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 		       find_unique_abbrev(ce->sha1,abbrev),
 		       ce_stage(ce));
 	}
-	write_name(ce->name, ce_namelen(ce));
+	write_name(ce->name);
 	if (debug_mode) {
 		printf("  ctime: %d:%d\n", ce->ce_ctime.sec, ce->ce_ctime.nsec);
 		printf("  mtime: %d:%d\n", ce->ce_mtime.sec, ce->ce_mtime.nsec);
@@ -196,7 +198,7 @@ static void show_ru_info(void)
 			printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
 			       find_unique_abbrev(ui->sha1[i], abbrev),
 			       i + 1);
-			write_name(path, len);
+			write_name(path);
 		}
 	}
 }
diff --git a/quote.c b/quote.c
index ebb8..5c880 100644
--- a/quote.c
+++ b/quote.c
@@ -312,8 +312,7 @@ void write_name_quotedpfx(const char *pfx, size_t pfxlen,
 	fputc(terminator, fp);
 }
 
-void write_name_quoted_relative(const char *name, size_t len,
-				const char *prefix, size_t prefix_len,
+void write_name_quoted_relative(const char *name, const char *prefix,
 				FILE *fp, int terminator)
 {
 	struct strbuf sb = STRBUF_INIT;
diff --git a/quote.h b/quote.h
index 5610159..ed110 100644
--- a/quote.h
+++ b/quote.h
@@ -60,8 +60,7 @@ extern void quote_two_c_style(struct strbuf *, const char *, const char *, int);
 extern void write_name_quoted(const char *name, FILE *, int terminator);
 extern void write_name_quotedpfx(const char *pfx, size_t pfxlen,
                                  const char *name, FILE *, int terminator);
-extern void write_name_quoted_relative(const char *name, size_t len,
-		const char *prefix, size_t prefix_len,
+extern void write_name_quoted_relative(const char *name, const char *prefix,
 		FILE *fp, int terminator);
 
 /* quote path as relative to the given prefix */
-- 
1.8.3.rc1.407.g762149a
