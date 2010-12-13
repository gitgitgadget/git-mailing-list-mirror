From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/19] Add struct pathspec
Date: Mon, 13 Dec 2010 16:46:38 +0700
Message-ID: <1292233616-27692-2-git-send-email-pclouds@gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 10:48:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS515-0004Xi-Uj
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 10:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653Ab0LMJr6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 04:47:58 -0500
Received: from mail-px0-f179.google.com ([209.85.212.179]:36304 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab0LMJr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 04:47:57 -0500
Received: by mail-px0-f179.google.com with SMTP id 20so1600185pxi.10
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 01:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=QhdMiujBap8ehLXnNURYNn1wQzY2aGLxXebZl4X39yk=;
        b=F9FBeTDdxUZOPPHakrnkj060Q+p0Ojzu7zbGx6OMgC9yms49VHWTEK9Jq1lD1lx29L
         oG4jSyLPp1uLAUqjImKKlVbaeaZDaJ2ycn8T1DNf1enWFlsY7KD694c6ZG5XyXGjSG4a
         fsOyLfZ2epJckeVKP4cFNQERpOw5Nc7bOsACs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=FxrJR6WSfKmHfKgjoNVY1+qnV6dmztPnkUdN9BaRXHbCD5LWyFQho1HSbh03B5xiS6
         RkkPkTfXVbD/p5oKD6TW4OFNFeZjUOC3rr1/lg9QLxNoNKKNqYSfC3BqBPq4U/c4zrld
         SfOpPQyXUVSDj66Vuy2qYwd/GHUvDygZxwueA=
Received: by 10.142.218.12 with SMTP id q12mr2997908wfg.447.1292233677257;
        Mon, 13 Dec 2010 01:47:57 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id w42sm8677951wfh.3.2010.12.13.01.47.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 01:47:56 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 13 Dec 2010 16:47:04 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163531>

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
index 2ef2fa3..3330769 100644
--- a/cache.h
+++ b/cache.h
@@ -493,6 +493,13 @@ extern int index_name_is_other(const struct index_=
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
1.7.3.3.476.g10a82
