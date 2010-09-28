From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/6] Add struct pathspec
Date: Tue, 28 Sep 2010 22:00:24 +1000
Message-ID: <1285675229-28019-2-git-send-email-pclouds@gmail.com>
References: <1285675229-28019-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 00:33:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0ijL-00032E-3o
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 00:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941Ab0I1Wcy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 18:32:54 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55020 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab0I1Wcy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 18:32:54 -0400
Received: by pvg2 with SMTP id 2so35176pvg.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 15:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=yuEZfFE6alsmaem3rHZwodYO5pViFMKlf5Etm0NrmtE=;
        b=KWRWrqPipOvOeQodCK68OIlRlapiommaBbzJDkplwW9EwrAJNev5/3zOZjD3pdCugI
         JcreDJMjYa13ApTf2C03Ke7xDGZjip+9RReKjqqoajRLArX+8M1BPSiMAUImF0kk156f
         UT3kq4CILeFFTMvNySRFcNXFJ0tSk6I0ngpWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=C02Zgp2ov1EHcbME1I5moKtbcspP2XkzENvMiLxwokNDy6nN25070kG43qN1CtrjgP
         juxPOW9DezMTgxEqky6N3hRlaptzQKQYZmXzOYijV2VBYlJ6dbbGx1NH/jR3ITFp7w99
         W40STBD8+egWPYBx93GbMtXQcx/GcYjGP8pqc=
Received: by 10.114.102.20 with SMTP id z20mr836723wab.133.1285713173555;
        Tue, 28 Sep 2010 15:32:53 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id d39sm13304139wam.16.2010.09.28.15.32.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 15:32:52 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Tue, 28 Sep 2010 22:00:36 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g788ca
In-Reply-To: <1285675229-28019-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157486>

This struct for now is just a wrapper for the current pathspec form:
const char **. It is intended to be extended with more useful
pathspec-related information over time.

The data structure for passing pathspec around remains const char **,
struct pathspec will be initialized locally to be used and destroyed.
Hopefully all pathspec related code will be gradually migrated to pass
this struct instead.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |    7 +++++++
 dir.c   |   18 ++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index eb77e1d..a3029fd 100644
--- a/cache.h
+++ b/cache.h
@@ -492,6 +492,13 @@ extern int index_name_is_other(const struct index_=
state *, const char *, int);
 extern int ie_match_stat(const struct index_state *, struct cache_entr=
y *, struct stat *, unsigned int);
 extern int ie_modified(const struct index_state *, struct cache_entry =
*, struct stat *, unsigned int);
=20
+struct pathspec {
+	const char **raw; /* get_pathspec() result, not freed by free_pathspe=
c() */
+	int nr;
+};
+
+extern int init_pathspec(struct pathspec *, const char **);
+extern void free_pathspec(struct pathspec *);
 extern int ce_path_match(const struct cache_entry *ce, const char **pa=
thspec);
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int =
write_object, enum object_type type, const char *path);
 extern int index_path(unsigned char *sha1, const char *path, struct st=
at *st, int write_object);
diff --git a/dir.c b/dir.c
index 133f472..205adc4 100644
--- a/dir.c
+++ b/dir.c
@@ -1071,3 +1071,21 @@ int remove_path(const char *name)
 	return 0;
 }
=20
+int init_pathspec(struct pathspec *pathspec, const char **paths)
+{
+	const char **p =3D paths;
+
+	memset(pathspec, 0, sizeof(*pathspec));
+	if (!p)
+		return 0;
+	while (*p)
+		p++;
+	pathspec->raw =3D paths;
+	pathspec->nr =3D p - paths;
+	return 0;
+}
+
+void free_pathspec(struct pathspec *pathspec)
+{
+	; /* do nothing */
+}
--=20
1.7.1.rc1.70.g788ca
