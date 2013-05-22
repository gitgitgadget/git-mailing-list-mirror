From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v13 05/15] Refactor write_name_quoted_relative, remove unused params
Date: Wed, 22 May 2013 09:40:26 +0800
Message-ID: <aa9edf610ab88f692e1a15c6d0129dbc73039973.1369186574.git.worldhello.net@gmail.com>
References: <cover.1369186574.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 22 03:41:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uey3p-0001jn-Oz
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 03:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732Ab3EVBlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 21:41:47 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:55169 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab3EVBlB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 21:41:01 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp6so1286775pab.21
        for <git@vger.kernel.org>; Tue, 21 May 2013 18:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=vBa81XflmdBRbHx7MuA8sMiVVzm8tyzDfkb6XNPasSc=;
        b=u1OqzYq5pVH4IyRM+RU0B0PPrk3TisBhbvH/TcQghZToK20L19Fw3S1SNmTDBFzH8F
         DK6OW0dyRuVPzwus+DgFGiCblOPtXCEuvg4rIYDewBa2pRs2z2TnGBehd/itdg35m9nq
         Hlj7ireN7EvB9ak22VfMWH9di4t4y4oKyd1tDnSr8ASnf+JmKUSvOnbceLZtR+JB8b8q
         QqL+pYX/e22DarM1Ii2r+xXNqaID7v4ZEBfl3Pz/4tzyvcnIiN2/q8MMDR47NgifaKMd
         QEFiemqSK1xI0A+MyUjUe6pLfCn7m5SIZ4G9MjVnKBS/G6T2f+sh6J0FjixmbPuahkyG
         F9CA==
X-Received: by 10.66.121.108 with SMTP id lj12mr6023924pab.51.1369186861125;
        Tue, 21 May 2013 18:41:01 -0700 (PDT)
Received: from localhost.localdomain ([114.248.150.82])
        by mx.google.com with ESMTPSA id at1sm4939345pbc.10.2013.05.21.18.40.58
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 21 May 2013 18:41:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.368.g7c798dd
In-Reply-To: <cover.1369186574.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1369186574.git.worldhello.net@gmail.com>
References: <7vhahwm5n6.fsf@alter.siamese.dyndns.org> <cover.1369186574.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225119>

After substitute path_relative() in quote.c with relative_path() from
path.c, parameters (such as len and prefix_len) are obsolete in function
write_name_quoted_relative(). Remove unused parameters from
write_name_quoted_relative() and related functions.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/ls-files.c | 14 ++++++++------
 quote.c            |  3 +--
 quote.h            |  3 +--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 00f07..6acff4 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -46,10 +46,12 @@ static const char *tag_modified = "";
 static const char *tag_skip_worktree = "";
 static const char *tag_resolve_undo = "";
 
-static void write_name(const char* name, size_t len)
+static void write_name(const char *name)
 {
-	write_name_quoted_relative(name, len, prefix, prefix_len, stdout,
-			line_terminator);
+
+	/* turn off prefix, if run with "--full-name" */
+	write_name_quoted_relative(name, prefix_len ? prefix : NULL,
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
1.8.3.rc3.368.g7c798dd
