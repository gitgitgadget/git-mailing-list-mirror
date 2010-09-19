From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/6] Add struct pathspec
Date: Mon, 20 Sep 2010 09:21:49 +1000
Message-ID: <1284938514-16663-2-git-send-email-pclouds@gmail.com>
References: <1284938514-16663-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 01:22:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxTDk-0007qb-Fa
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 01:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914Ab0ISXWY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 19:22:24 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49220 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754862Ab0ISXWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 19:22:09 -0400
Received: by pzk34 with SMTP id 34so1008822pzk.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 16:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=AIQKJFwboSnk6jIUZTLup/Nxjkw51qXKSwofLVrIgZk=;
        b=Ulxj5c+bCW73tC1wbmV7vsB6UQQQhe3BrGrR6VWCsaEPgKJrhCWcDq3rUCUpw5bjVq
         vOEMrgFMVc0SLxhrliVS4zmqMlq5uJp5dLtfBlIWcK7lO2ZHklt+Bed7Mbt7KnL4xkRT
         36lzWhNb3Icia1tsObyzU4v3k1OSRL9dr02Dc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=CjDcYcNY7QYSMK15Mmrc3u2R1UZS6+9ch1AyRJR10Z3opx17/Vy3S1BGvjnO8HISfT
         HWYdYZBLIrFDCLAnRDCswS0GHo0meaGC0qgeZp07cJggRODESX7fGQlU7uewiMvr91ea
         CZ4qUY69qoVdQ0rqPI+VCxQWEyJ5I93Ac1Wi4=
Received: by 10.142.247.10 with SMTP id u10mr6962587wfh.106.1284938528538;
        Sun, 19 Sep 2010 16:22:08 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id e12sm8168753wfh.1.2010.09.19.16.22.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 16:22:07 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon, 20 Sep 2010 09:22:02 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g788ca
In-Reply-To: <1284938514-16663-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156523>

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
index eb77e1d..6227ddb 100644
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
+	const char **raw;
+	int nr;
+};
+
+extern int init_pathspec(struct pathspec *,const char **);
+extern void free_pathspec(struct pathspec *);
 extern int ce_path_match(const struct cache_entry *ce, const char **pa=
thspec);
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int =
write_object, enum object_type type, const char *path);
 extern int index_path(unsigned char *sha1, const char *path, struct st=
at *st, int write_object);
diff --git a/dir.c b/dir.c
index 133f472..5815b64 100644
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
+	/* do nothing */
+}
--=20
1.7.1.rc1.70.g788ca
