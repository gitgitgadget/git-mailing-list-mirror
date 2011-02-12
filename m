From: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
Subject: [PATCH 3/4] Dont use the same variable for different things
Date: Sun, 13 Feb 2011 00:38:30 +0200
Message-ID: <1297550311-17723-4-git-send-email-vvavrychuk@gmail.com>
References: <1297550311-17723-1-git-send-email-vvavrychuk@gmail.com>
Cc: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 12 23:39:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoO7K-00033k-Ok
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 23:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839Ab1BLWi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 17:38:58 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50167 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584Ab1BLWio (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 17:38:44 -0500
Received: by fxm20 with SMTP id 20so3929996fxm.19
        for <git@vger.kernel.org>; Sat, 12 Feb 2011 14:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=6BNb0bIQcBvwIFlaKADP6oz+eeO1SPg+a+G8qbGB3PM=;
        b=VfAB/e6kdwMpX1G6svgyZpxya1gKGm+8aYLHqWsbzynXsnXsyFk2FZGD2AEID8hEA6
         4OF63dkRk5/7Wi9GtMbE5eVYTp0gm/U3lx3JpsINabjf3jZSsxzD0w1Ut8F+6ld9Ed7S
         6rqtrMckI2sGkQua2rey8HQRuM2KSZqc4qAvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Qr7E9mc9Wr4pl4w0ULvsX48+OyEw0sMo84+3w2STgiGs3SadYWBPWmRyylA4tsJlU5
         zwT6Lhx2rhZX7LIDCb1pSaM6Z1FsZI/Qk4dTXlVQ3bbOj2j3UMSNLGl9TsvkWtz+lfO0
         hPs5bLNc3zzjeMg8AXDxmKDq+mO2CqzValZMk=
Received: by 10.223.74.200 with SMTP id v8mr7352784faj.144.1297550322980;
        Sat, 12 Feb 2011 14:38:42 -0800 (PST)
Received: from localhost.localdomain ([91.200.115.239])
        by mx.google.com with ESMTPS id n7sm369494fam.35.2011.02.12.14.38.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 Feb 2011 14:38:42 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.30.ga83dc
In-Reply-To: <1297550311-17723-1-git-send-email-vvavrychuk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166626>

Signed-off-by: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
---
 builtin/fetch.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 46d8fd6..ddb40c6 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -343,7 +343,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	FILE *fp;
 	struct commit *commit;
 	int i, note_len, shown_url = 0, rc = 0;
-	char note[1024];
+	char note[1024], display[1024];
 	const char *what, *kind;
 	struct ref *rm;
 	char *url, *filename = dry_run ? "/dev/null" : git_path("FETCH_HEAD");
@@ -415,19 +415,20 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 		fputc('\n', fp);
 
 		if (ref) {
-			rc |= update_local_ref(ref, what, note);
+			rc |= update_local_ref(ref, what, display);
 			free(ref);
-		} else
-			sprintf(note, "* %-*s %-*s -> FETCH_HEAD",
+		} else {
+			sprintf(display, "* %-*s %-*s -> FETCH_HEAD",
 				TRANSPORT_SUMMARY_WIDTH, *kind ? kind : "branch",
 				 REFCOL_WIDTH, *what ? what : "HEAD");
-		if (*note) {
+		}
+		if (*display) {
 			if (verbosity >= 0 && !shown_url) {
 				fprintf(stderr, "From %s\n", url);
 				shown_url = 1;
 			}
 			if (verbosity >= 0)
-				fprintf(stderr, " %s\n", note);
+				fprintf(stderr, " %s\n", display);
 		}
 	}
 	free(url);
-- 
1.7.1
