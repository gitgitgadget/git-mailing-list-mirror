From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 14/22] untracked cache: print stats with $GIT_TRACE_UNTRACKED_STATS
Date: Sat,  8 Nov 2014 16:39:47 +0700
Message-ID: <1415439595-469-15-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
 <1415439595-469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 10:41:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn2W6-0001OW-J9
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 10:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663AbaKHJlD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2014 04:41:03 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:57189 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659AbaKHJlB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 04:41:01 -0500
Received: by mail-pd0-f179.google.com with SMTP id g10so4742365pdj.24
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 01:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=26L++pVORS0c5ldpnpBo6rnmzt3KsPbuXXQHW5y5obQ=;
        b=rqS59V3EjAVTFoy9jXIcg9Jl4e3LtdXxyw3eG5DzDXk9xA6bR8HPkS+/X1TOLZS6DT
         AC0TVK70A+Bg2HILBQ2ge0VDml/7Ys9MA4KUpytlRApWlYrsSYr7BsIor00o1DopdoWy
         d2P37bOVsj0efa/nERh4kkD73/R+nsgVjsP3hijOWtJFLxmk6E98QuwX+ELPuTXFwnJ7
         K5bleXhgKKnCSQP9UND5DwrBXwAbz6IaTyjc8szge7LiGsap4/1GJA3wAE5RMF4Dgcge
         ICtV80xtKdTPzF4785TJSc/5Gita98sIOoNg5/xEnQgibxcSFlmfkitviaD9me6T+Oam
         GZCA==
X-Received: by 10.66.242.203 with SMTP id ws11mr18398181pac.69.1415439661011;
        Sat, 08 Nov 2014 01:41:01 -0800 (PST)
Received: from lanh ([115.73.197.54])
        by mx.google.com with ESMTPSA id xf1sm11036092pbb.18.2014.11.08.01.40.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Nov 2014 01:41:00 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Nov 2014 16:41:15 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1415439595-469-1-git-send-email-pclouds@gmail.com>
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
index 52daaf7..27bd40a 100644
--- a/dir.c
+++ b/dir.c
@@ -1920,6 +1920,18 @@ int read_directory(struct dir_struct *dir, const=
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
