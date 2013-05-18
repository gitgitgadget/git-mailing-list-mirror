From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v12 05/15] Refactor write_name_quoted_relative, remove unused params
Date: Sat, 18 May 2013 11:18:57 +0800
Message-ID: <48e2072058302b355e0ec138727d1b481ac131c4.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368846844.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 18 05:19:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdXgV-0004GC-0e
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 05:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492Ab3ERDTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 23:19:43 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:60131 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932387Ab3ERDTl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 23:19:41 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa7so3842488pbc.11
        for <git@vger.kernel.org>; Fri, 17 May 2013 20:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=wut96yoxTv0fNBvwb0dbGy8FbbY4+IZttWhd960DxUk=;
        b=zzBST+ikU0xtt3nv0cKRNwsh63DsAw2Z3mmn50v5vwygX0RtNN+Tixdq22meOj5JMk
         cRuqA63MAhoKziNMRzHeLB6wFIXiYWoBaNzlsRQ4JXIfOX5SzsLOdN20zIQOG/405tLs
         4voxZzI4p6w2+U/idgy/ZMJmvbeeYlxiTsyZlOuFtzMTB37dTUBAhlPiXMogdK+5Xu5z
         CorgsM84f6Ui4hlKr9VNqX9d3IOe/UObfp4/28yWl9jvmbvpjQ8XMatxz98rwc2grg68
         ZsGrEpcydthH5gJ69wuQVUAPItU803CHXmPcD88nFLIUQpAL/rE18yVYhLIYXB17F96s
         KRKg==
X-Received: by 10.66.158.101 with SMTP id wt5mr26604150pab.8.1368847181245;
        Fri, 17 May 2013 20:19:41 -0700 (PDT)
Received: from localhost.localdomain ([114.248.155.144])
        by mx.google.com with ESMTPSA id fn2sm13676683pbc.15.2013.05.17.20.19.33
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 20:19:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.26.g7472058
In-Reply-To: <cover.1368846844.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368782129.git.worldhello.net@gmail.com> <cover.1368846844.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224760>

After substitute path_relative() in quote.c with relative_path() from
path.c, parameters (such as len and prefix_len) are obsolete in function
write_name_quoted_relative(). Remove unused parameters from
write_name_quoted_relative() and related functions.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
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
1.8.3.rc2.26.g7472058
