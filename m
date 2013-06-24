From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v14 05/16] Refactor write_name_quoted_relative, remove unused params
Date: Mon, 24 Jun 2013 23:21:29 +0800
Message-ID: <6e5f34b62ff6a7d6b379a5cabc07b849539fb08f.1372087065.git.worldhello.net@gmail.com>
References: <cover.1372087065.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 24 17:22:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur8b1-0006R9-K3
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 17:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829Ab3FXPWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 11:22:20 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:64774 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab3FXPWS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 11:22:18 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp16so11220461pbb.28
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 08:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=tLOLHBeFBRxY0G2SifqF47Hjg5cR0GupUymPb7Kqcg4=;
        b=f6W3jDeAZ5RVR5PxTjDUYGKlvXQPCLfm9dJze6Icp69EgMpWYI0WVfm22DTEIraXJG
         QXK+M4qlI2CHQrsBI8ltosPdD8SMiQ1bvve5j3QiG0lwGMnW7Q1KMKtlgHAT3c2n+E3k
         9fFzrlH14FK4di6GZ1YfZ3jgp1haxNuJWMIe9z6RkCoatKJp42L6qvMxpc1Ir7wqU9CQ
         zAnB+iUZ3dnvTU/yaPC5wq4DDCysTeKIPRDrv+4xNjpcwmzHbPbs/srLAvyKYoJ+R7hu
         5fyUXbZgaO53zqr8WujuEEy+KKf8Xam/3ETVKJZGv+bWs4RnnZpnqEUAvNoOI0ck7gsd
         2YaA==
X-Received: by 10.69.1.69 with SMTP id be5mr18767718pbd.138.1372087337771;
        Mon, 24 Jun 2013 08:22:17 -0700 (PDT)
Received: from localhost.localdomain ([114.248.133.39])
        by mx.google.com with ESMTPSA id ix3sm18576807pbc.37.2013.06.24.08.22.14
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 08:22:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.756.g41beab0
In-Reply-To: <cover.1372087065.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1372087065.git.worldhello.net@gmail.com>
References: <CANYiYbHQ307TroSd6Lk=5zg68jdKxGeA4N=hWGfaz1W29NhNVw@mail.gmail.com> <cover.1372087065.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228827>

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
index 16d4f..df83f9 100644
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
 		struct stat_data *sd = &ce->ce_stat_data;
 
@@ -198,7 +200,7 @@ static void show_ru_info(void)
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
1.8.3.1.756.g41beab0
