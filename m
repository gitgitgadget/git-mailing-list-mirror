From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/5] dir.c: add free_excludes()
Date: Sat, 27 Nov 2010 01:17:44 +0700
Message-ID: <1290795467-7570-3-git-send-email-pclouds@gmail.com>
References: <1290795467-7570-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Niedier <jrnieder@gmail.com>, tfransosi@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 26 19:19:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM2tQ-0003MS-J7
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 19:19:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389Ab0KZSTS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 13:19:18 -0500
Received: from mail-pw0-f66.google.com ([209.85.160.66]:36343 "EHLO
	mail-pw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab0KZSTR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 13:19:17 -0500
Received: by mail-pw0-f66.google.com with SMTP id 5so492729pwj.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 10:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Z39WjGBocVjgRwWYaKTpJ0DjEiU391czMQcsgP0iQ+4=;
        b=PaHHb79rYf1EBsL9l6L3DVdQZt8dpdksCRDcAF5cBQk/uUzPX+w21zt9Q/ko4X2Fhp
         dKI9yS8dXx0cCPOTu44nClSSA5OgCLut5a3GrDJo91Z6nEoUC2HIpSuKYp0G5jL5wWfJ
         xSOPdssaUiSBV5gJ1Z2pkbiEwkckfDBajRXOc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uYmK9sBxrauTXCfwj/0kzlQnOtNa86pCLpsZpLUhmxyjX5o7wdou7vQ4WTgJ5qqUSb
         XRxyVQ2faOpjgJV7KbvHsjl/YbDT3RLkrwiyojP/sMASfz589A1MAiM310BfoMXTVbAk
         2LGMcZE61Rm8A5dulLRyFwRVRkWYJ8aQKG8b0=
Received: by 10.142.14.10 with SMTP id 10mr2743707wfn.214.1290795556965;
        Fri, 26 Nov 2010 10:19:16 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id w22sm2857880wfd.19.2010.11.26.10.19.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 10:19:15 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 27 Nov 2010 01:18:14 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290795467-7570-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162268>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c          |   12 ++++++++++++
 dir.h          |    1 +
 unpack-trees.c |    6 +-----
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index b2dfb69..39eb7a3 100644
--- a/dir.c
+++ b/dir.c
@@ -223,6 +223,18 @@ static void *read_skip_worktree_file_from_index(co=
nst char *path, size_t *size)
 	return data;
 }
=20
+void free_excludes(struct exclude_list *el)
+{
+	int i;
+
+	for (i =3D 0; i < el->nr; i++)
+		free(el->excludes[i]);
+	free(el->excludes);
+
+	el->nr =3D 0;
+	el->excludes =3D NULL;
+}
+
 int add_excludes_from_file_to_list(const char *fname,
 				   const char *base,
 				   int baselen,
diff --git a/dir.h b/dir.h
index 278d84c..ce55008 100644
--- a/dir.h
+++ b/dir.h
@@ -78,6 +78,7 @@ extern int add_excludes_from_file_to_list(const char =
*fname, const char *base, i
 extern void add_excludes_from_file(struct dir_struct *, const char *fn=
ame);
 extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *which);
+extern void free_excludes(struct exclude_list *el);
 extern int file_exists(const char *);
=20
 extern char *get_relative_cwd(char *buffer, int size, const char *dir)=
;
diff --git a/unpack-trees.c b/unpack-trees.c
index 803445a..4d92412 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -945,11 +945,7 @@ int unpack_trees(unsigned len, struct tree_desc *t=
, struct unpack_trees_options
 		*o->dst_index =3D o->result;
=20
 done:
-	for (i =3D 0;i < el.nr;i++)
-		free(el.excludes[i]);
-	if (el.excludes)
-		free(el.excludes);
-
+	free_excludes(&el);
 	return ret;
=20
 return_failed:
--=20
1.7.3.2.316.gda8b3
