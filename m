From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v15 05/16] Refactor write_name_quoted_relative, remove unused params
Date: Tue, 25 Jun 2013 23:53:46 +0800
Message-ID: <90f3639d0978fb4f9e04fd2da5bb25994d52e849.1372175283.git.worldhello.net@gmail.com>
References: <cover.1372175282.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jun 25 17:54:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrVZl-0003q3-S3
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 17:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487Ab3FYPyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 11:54:33 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:61215 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444Ab3FYPya (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 11:54:30 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa11so12818305pad.33
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 08:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=GEuv4jC5A/7JO1e/zlUKD7OcS+v166zcBoK0IZVLH/8=;
        b=vfnXDgzBfXNb2KXb9Eg3vrBAw4/bv/Eqz8eDwooQewhqOPTwco4cMkzBaTIYVE6xVN
         0CibYgvXDgOeG0ZKQ68dpW7kCgB8gqcueSue49meIjxgMYfHmGeZvkLiQt54rolkwg5V
         AlV5f6P+oUjzW7nXjmbS7O7SOcUmJcisA57KI71w95sr5Rf6JkXX5uyVCRQarZkmV8Fv
         UFkVQzC3YKkcJjc3FXHpDnPMKqsq6izdSoEyVnoVHFYXhjSO56IUuA6/itclCWEXVrU7
         vuhg7gFipceh4HtW70hqF5BKMDLst8DQKgklNqp8Qr5qMqumHjLjeRkND08AG1rWodDQ
         /GAQ==
X-Received: by 10.66.160.97 with SMTP id xj1mr559978pab.5.1372175669672;
        Tue, 25 Jun 2013 08:54:29 -0700 (PDT)
Received: from localhost.localdomain ([114.248.133.39])
        by mx.google.com with ESMTPSA id pb5sm23760930pbc.29.2013.06.25.08.54.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 25 Jun 2013 08:54:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.756.g2e9b71f
In-Reply-To: <cover.1372175282.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1372175282.git.worldhello.net@gmail.com>
References: <cover.1372175282.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228965>

After substitute path_relative() in quote.c with relative_path() from
path.c, parameters (such as len and prefix_len) are obsolete in function
write_name_quoted_relative(). Remove unused parameters from
write_name_quoted_relative() and related functions.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/ls-files.c | 14 +++++++-------
 quote.c            |  3 +--
 quote.h            |  3 +--
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c7d2b..af6cd 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -46,13 +46,13 @@ static const char *tag_modified = "";
 static const char *tag_skip_worktree = "";
 static const char *tag_resolve_undo = "";
 
-static void write_name(const char* name, size_t len)
+static void write_name(const char *name)
 {
-	/* Since prefix_len is ignored in write_name_quoted_relative, we
+	/* Since prefix_len won't pass to write_name_quoted_relative, we
 	 * should turn off prefix here in case of running "git ls-files"
 	 * with "--full-name" option */
-	write_name_quoted_relative(name, len, prefix_len ? prefix : NULL,
-			prefix_len, stdout, line_terminator);
+	write_name_quoted_relative(name, prefix_len ? prefix : NULL,
+				   stdout, line_terminator);
 }
 
 static void show_dir_entry(const char *tag, struct dir_entry *ent)
@@ -66,7 +66,7 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
 		return;
 
 	fputs(tag, stdout);
-	write_name(ent->name, ent->len);
+	write_name(ent->name);
 }
 
 static void show_other_files(struct dir_struct *dir)
@@ -166,7 +166,7 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 		       find_unique_abbrev(ce->sha1,abbrev),
 		       ce_stage(ce));
 	}
-	write_name(ce->name, ce_namelen(ce));
+	write_name(ce->name);
 	if (debug_mode) {
 		struct stat_data *sd = &ce->ce_stat_data;
 
@@ -201,7 +201,7 @@ static void show_ru_info(void)
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
1.8.3.1.756.g2e9b71f
