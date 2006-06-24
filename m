From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH 1/7] Clean up diff.c
Date: Sat, 24 Jun 2006 20:20:32 +0300
Message-ID: <20060624202032.ec7203d8.tihirvon@gmail.com>
References: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 19:30:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuBxo-0001XZ-SN
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 19:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWFXRaR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 13:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWFXRaR
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 13:30:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:17675 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750944AbWFXRaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 13:30:16 -0400
Received: by nf-out-0910.google.com with SMTP id m19so402614nfc
        for <git@vger.kernel.org>; Sat, 24 Jun 2006 10:30:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Yngbqf97FKjCgs9+5i9XIamR2zbJyvoBAEW3r43v2sxLzsvKIze2bfd8/gJt57fynnLCllYsP+e0WSdZXLT+rowH8X/O0qEwD5ykdfZMo+Rt229MwFnGvkSXkFkD5Swfr4S9s/06cWZ0fXhssX7m/KVrAmiYVF9VoUwrbJo+muQ=
Received: by 10.48.143.15 with SMTP id q15mr3516740nfd;
        Sat, 24 Jun 2006 10:30:15 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id q28sm2372756nfc.2006.06.24.10.30.14;
        Sat, 24 Jun 2006 10:30:14 -0700 (PDT)
To: junkio@cox.net
In-Reply-To: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22529>


Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---
 diff.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index ad77543..f358546 100644
--- a/diff.c
+++ b/diff.c
@@ -203,7 +203,7 @@ static void emit_rewrite_diff(const char
 static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
 {
 	if (!DIFF_FILE_VALID(one)) {
-		mf->ptr = ""; /* does not matter */
+		mf->ptr = (char *)""; /* does not matter */
 		mf->size = 0;
 		return 0;
 	}
@@ -395,7 +395,7 @@ static void show_stats(struct diffstat_t
 	}
 
 	for (i = 0; i < data->nr; i++) {
-		char *prefix = "";
+		const char *prefix = "";
 		char *name = data->files[i]->name;
 		int added = data->files[i]->added;
 		int deleted = data->files[i]->deleted;
@@ -918,7 +918,7 @@ int diff_populate_filespec(struct diff_f
 			err_empty:
 				err = -1;
 			empty:
-				s->data = "";
+				s->data = (char *)"";
 				s->size = 0;
 				return err;
 			}
@@ -1409,7 +1409,7 @@ int diff_setup_done(struct diff_options 
 	return 0;
 }
 
-int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
+static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
 {
 	char c, *eq;
 	int len;
@@ -1725,16 +1725,12 @@ static void diff_flush_raw(struct diff_f
 		free((void*)path_two);
 }
 
-static void diff_flush_name(struct diff_filepair *p,
-			    int inter_name_termination,
-			    int line_termination)
+static void diff_flush_name(struct diff_filepair *p, int line_termination)
 {
 	char *path = p->two->path;
 
 	if (line_termination)
 		path = quote_one(p->two->path);
-	else
-		path = p->two->path;
 	printf("%s%c", path, line_termination);
 	if (p->two->path != path)
 		free(path);
@@ -1955,9 +1951,7 @@ static void flush_one_pair(struct diff_f
 				       options, diff_output_format);
 			break;
 		case DIFF_FORMAT_NAME:
-			diff_flush_name(p,
-					inter_name_termination,
-					line_termination);
+			diff_flush_name(p, line_termination);
 			break;
 		case DIFF_FORMAT_NO_OUTPUT:
 			break;
-- 
1.4.1.rc1.g8637
