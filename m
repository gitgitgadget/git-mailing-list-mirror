From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] config: add core.sharedconfig
Date: Thu,  9 Dec 2010 22:09:48 +0700
Message-ID: <1291907388-9068-4-git-send-email-pclouds@gmail.com>
References: <1291907388-9068-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 16:12:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQiAf-0007U2-Hb
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 16:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533Ab0LIPLh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 10:11:37 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59582 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466Ab0LIPLf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 10:11:35 -0500
Received: by gyb11 with SMTP id 11so1413285gyb.19
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 07:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=rEA3xlIYSCoewTfZNT5380OmOZDMIfBnRPmgwYkrMwI=;
        b=LErSvOuyqITRzMx71LV1R2i4Qr58DX2QFfQT4YXW+DPSSy4ka5uZyOCuDuLvTRcBD3
         1iYlZpXOnzV4l9lnr+1kJWx8i51PePEwJp02gFm30mNYEuTyXqsNQegIL8vF+Y3znoLC
         T9dFJPsD2yqKF5ptyaF7RkC4DfgjEkjY9Aoqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ODcoH24GJWGNecVblB1jAG3/bRjW7ErNwoWbHK+Hx7xQX0Bq/MlVupav+X4KgpKIEF
         9tTdgQVLR24Djjy5AJ8tlTw7fELiKklapWu8YUyOmmM8YylKpyRAo7r1d6Am3xnClXkf
         gFo7eNTW1elnZn2ZKH5Hw1TNTarMvCoWGkvn0=
Received: by 10.151.109.4 with SMTP id l4mr6607506ybm.293.1291907494487;
        Thu, 09 Dec 2010 07:11:34 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id u31sm761983yba.9.2010.12.09.07.11.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 07:11:33 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 09 Dec 2010 22:10:35 +0700
X-Mailer: git-send-email 1.7.3.3.476.g893a9
In-Reply-To: <1291907388-9068-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163288>

core.sharedconfig can take anything that resolves to a blob.
$GIT_DIR/config will override the shared config. Nested shared
config is not allowed.

No protection is provided. It's up to the project to maintain good
config. The config could be in a separate branch that only a few
people are allowed to push, for example. To be safest, just put SHA-1
there.

git-fsck and git-prune should learn about this key and protect it from
being pruned.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Hopefully nobody sets core.sharedconfig =3D :path/to/config or similar

 And I should not open $GIT_DIR/config twice. Well, it does not hurt
 much.

 cache.h       |    1 +
 config.c      |   14 ++++++++++++++
 environment.c |    1 +
 3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index e83bc2d..e91ce35 100644
--- a/cache.h
+++ b/cache.h
@@ -559,6 +559,7 @@ extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
+extern const char *core_shared_config;
=20
 enum safe_crlf {
 	SAFE_CRLF_FALSE =3D 0,
diff --git a/config.c b/config.c
index e7a9ff4..735b3f4 100644
--- a/config.c
+++ b/config.c
@@ -883,6 +883,14 @@ int git_config_from_parameters(config_fn_t fn, voi=
d *data)
 	return 0;
 }
=20
+static int get_shared_config(const char *var, const char *value, void =
*dummy)
+{
+	if (!strcmp(var, "core.sharedconfig"))
+		return git_config_string(&core_shared_config, var, value);
+
+	return 0;
+}
+
 int git_config(config_fn_t fn, void *data)
 {
 	int ret =3D 0, found =3D 0;
@@ -910,6 +918,12 @@ int git_config(config_fn_t fn, void *data)
=20
 	repo_config =3D git_pathdup("config");
 	if (!access(repo_config, R_OK)) {
+		git_config_from_file(get_shared_config, repo_config, NULL);
+		if (core_shared_config) {
+			ret +=3D git_config_from_sha1(fn, core_shared_config, data);
+			found +=3D 1;
+		}
+
 		ret +=3D git_config_from_file(fn, repo_config, data);
 		found +=3D 1;
 	}
diff --git a/environment.c b/environment.c
index 913b058..8bfb548 100644
--- a/environment.c
+++ b/environment.c
@@ -55,6 +55,7 @@ enum object_creation_mode object_creation_mode =3D OB=
JECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents =3D 1;
 int core_apply_sparse_checkout;
+const char *core_shared_config;
 struct startup_info *startup_info;
=20
 /* Parallel index stat data preload? */
--=20
1.7.3.3.476.g893a9
