From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/19] untracked cache: print stats with $GIT_TRACE_UNTRACKED_STATS
Date: Mon, 27 Oct 2014 19:10:41 +0700
Message-ID: <1414411846-4450-15-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 13:12:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xij9V-00038h-Ba
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 13:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbaJ0ML5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2014 08:11:57 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:46909 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbaJ0ML4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 08:11:56 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so1218494pab.8
        for <git@vger.kernel.org>; Mon, 27 Oct 2014 05:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CDaTy1bbSKraT5SxFAQ9tk0j4ZcP4zcIPgYwCadIiz0=;
        b=Syv0bnLpbrSLwVDVWpGSJdD1tCysTn75/BrDSDoZNnViulhuOHmU7fVS8oENU2FFZY
         BG9kqv3vywupimRhsoLW8ckRM81AnTqJNuUkCeiohZzgW44qcImx7hEVkA+GtxEKiGFI
         x+ceA+fVX6vxgPTWvFUYTpU+7QAeDGJdwl4szCXHMiJmYw18RCPBTpzJ0bgNus//ROb+
         70Gl/SGOdEwKcd4gkh8jNbLk2RlvSSbclYMpAAkNp8nWS6PWYIO5FWHLgQh2+hITVABJ
         FsOxS06a8b6pixO8U7fSzG2kH1Sf5m4TovkY7pzQ81FWQ7eVxpwyojG+n2i//8eT4y6C
         JfLA==
X-Received: by 10.66.139.234 with SMTP id rb10mr1470008pab.146.1414411916490;
        Mon, 27 Oct 2014 05:11:56 -0700 (PDT)
Received: from lanh ([115.73.192.230])
        by mx.google.com with ESMTPSA id ra4sm10852479pab.33.2014.10.27.05.11.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Oct 2014 05:11:55 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 27 Oct 2014 19:11:59 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This could be used to verify correct behavior in tests

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/dir.c b/dir.c
index 3eb1a12..57b49f7 100644
--- a/dir.c
+++ b/dir.c
@@ -1918,6 +1918,18 @@ int read_directory(struct dir_struct *dir, const=
 char *path, int len, const stru
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_=
name);
+	if (dir->untracked) {
+		static struct trace_key trace_untracked_stats =3D TRACE_KEY_INIT(UNT=
RACKED_STATS);
+		trace_printf_key(&trace_untracked_stats,
+				 "node creation: %u\n"
+				 "gitignore invalidation: %u\n"
+				 "directory invalidation: %u\n"
+				 "opendir: %u\n",
+				 dir->untracked->dir_created,
+				 dir->untracked->gitignore_invalidated,
+				 dir->untracked->dir_invalidated,
+				 dir->untracked->dir_opened);
+	}
 	return dir->nr;
 }
=20
--=20
2.1.0.rc0.78.gc0d8480
