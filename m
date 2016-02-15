From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/4] dir.c: support marking some patterns already matched
Date: Mon, 15 Feb 2016 16:03:38 +0700
Message-ID: <1455527019-7787-4-git-send-email-pclouds@gmail.com>
References: <1455527019-7787-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 10:03:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVF4U-0006DH-Q6
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 10:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbcBOJDt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 04:03:49 -0500
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34745 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498AbcBOJDk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 04:03:40 -0500
Received: by mail-pa0-f68.google.com with SMTP id yy13so6948279pab.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 01:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tnlOCgo+j7xsihyCEpumJh4SOo4oZMrBd1yC2hCUzwk=;
        b=hE5dg0YPR7vALvB4fxEprZ/cdOwJdhGrsoygTWizxPkVjXT0ZWOlwOycFDgFU8SjDL
         avfS8LhIZmMkFJmk5KBmQOaX8D8jBXyoEMESMjTMBvArY/lHl5SNsBlu2uGUrBxXq7Eo
         aeA/kRzhVJwjzl7BrtBgOOQPXZ3Eln5sYwu8dRDsSPDjRWo39nauu2aB7kmScm5EYqs9
         V3WU5cqO3p/7vJ0uVICm5/LT5fhRPQ3VZoRnOMpXWBAOf+pYJwB3iKVdC0bvTfHgZ74X
         ENJi4HyhgRQKx5fbZUp3kf6UYyOHQTLM/aE/OdyxbIb6gDQXgwMw0c92/+OlyzOuC9It
         jRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=tnlOCgo+j7xsihyCEpumJh4SOo4oZMrBd1yC2hCUzwk=;
        b=YS2owkgbfNm0tyn7JnAHJD+To6pxFMrhmylmZCuj4vRLnXttm4WgsXmltHKwTepxxY
         aoVbIgBfwt/5Qw7VUkbdZoP3cSLaFSCPml11jWaKFB0l/6mrLFxsx91b6bLrDBUtWNpl
         HUcZBTGapT79meaM/YUDp/+AAu9oDvypjues63MfUbUIbsqluQSF3LNyPFvoJKmG/6ma
         93dFTs8ndEwC9znCCRxwh5FwGAF9EMJlvWfs422bfE8nFoo2IPYy7x7nUXFu5pbCFwmf
         OzcyuaO5RF1g+nVJqB1kzkEoTu6kTReVKptv3rIJzEphlKRDbFhdAR9FYhhkaL5wMrNT
         UVIw==
X-Gm-Message-State: AG10YORDd5Q7Bq7Y6Hk74MwRUvGoN+b7sRdlCUlg1FU+eudyoSAB3q0jViS5Ib/ZNHFyRA==
X-Received: by 10.66.144.134 with SMTP id sm6mr16803834pab.158.1455527019700;
        Mon, 15 Feb 2016 01:03:39 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id vy6sm36797778pac.38.2016.02.15.01.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 01:03:38 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 15 Feb 2016 16:04:02 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455527019-7787-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286187>

Given path "a" and the pattern "a", it's matched. But if we throw path
"a/b" to pattern "a", the code fails to realize that if "a" matches
"a" then "a/b" should also be matched.

When the pattern is matched the first time, we can mark it "sticky", so
that all files and dirs inside the matched path also matches. This is a
simpler solution than modify all match scenarios to fix that.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++---
 dir.h |  3 +++
 2 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 0be7cf1..8a9d8c0 100644
--- a/dir.c
+++ b/dir.c
@@ -521,6 +521,7 @@ void add_exclude(const char *string, const char *ba=
se,
 	x->baselen =3D baselen;
 	x->flags =3D flags;
 	x->srcpos =3D srcpos;
+	string_list_init(&x->sticky_paths, 1);
 	ALLOC_GROW(el->excludes, el->nr + 1, el->alloc);
 	el->excludes[el->nr++] =3D x;
 	x->el =3D el;
@@ -561,8 +562,10 @@ void clear_exclude_list(struct exclude_list *el)
 {
 	int i;
=20
-	for (i =3D 0; i < el->nr; i++)
+	for (i =3D 0; i < el->nr; i++) {
+		string_list_clear(&el->excludes[i]->sticky_paths, 0);
 		free(el->excludes[i]);
+	}
 	free(el->excludes);
 	free(el->filebuf);
=20
@@ -889,6 +892,44 @@ int match_pathname(const char *pathname, int pathl=
en,
 				 WM_PATHNAME) =3D=3D 0;
 }
=20
+static void add_sticky(struct exclude *exc, const char *pathname, int =
pathlen)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int i;
+
+	for (i =3D exc->sticky_paths.nr - 1; i >=3D 0; i--) {
+		const char *sticky =3D exc->sticky_paths.items[i].string;
+		int len =3D strlen(sticky);
+
+		if (pathlen < len && sticky[pathlen] =3D=3D '/' &&
+		    !strncmp(pathname, sticky, pathlen))
+			return;
+	}
+
+	strbuf_add(&sb, pathname, pathlen);
+	string_list_append_nodup(&exc->sticky_paths, strbuf_detach(&sb, NULL)=
);
+}
+
+static int match_sticky(struct exclude *exc, const char *pathname, int=
 pathlen, int dtype)
+{
+	int i;
+
+	for (i =3D exc->sticky_paths.nr - 1; i >=3D 0; i--) {
+		const char *sticky =3D exc->sticky_paths.items[i].string;
+		int len =3D strlen(sticky);
+
+		if (pathlen =3D=3D len && dtype =3D=3D DT_DIR &&
+		    !strncmp(pathname, sticky, len))
+			return 1;
+
+		if (pathlen > len && pathname[len] =3D=3D '/' &&
+		    !strncmp(pathname, sticky, len))
+			return 1;
+	}
+
+	return 0;
+}
+
 /*
  * Scan the given exclude list in reverse to see whether pathname
  * should be ignored.  The first match (i.e. the last on the list), if
@@ -914,6 +955,16 @@ static struct exclude *last_exclude_matching_from_=
list(const char *pathname,
 		const char *exclude =3D x->pattern;
 		int prefix =3D x->nowildcardlen;
=20
+		if (x->sticky_paths.nr) {
+			if (*dtype =3D=3D DT_UNKNOWN)
+				*dtype =3D get_dtype(NULL, pathname, pathlen);
+			if (match_sticky(x, pathname, pathlen, *dtype)) {
+				exc =3D x;
+				break;
+			}
+			continue;
+		}
+
 		if (x->flags & EXC_FLAG_MUSTBEDIR) {
 			if (*dtype =3D=3D DT_UNKNOWN)
 				*dtype =3D get_dtype(NULL, pathname, pathlen);
@@ -947,9 +998,10 @@ static struct exclude *last_exclude_matching_from_=
list(const char *pathname,
 		return NULL;
 	}
=20
-	trace_printf_key(&trace_exclude, "exclude: %.*s vs %s at line %d =3D>=
 %s\n",
+	trace_printf_key(&trace_exclude, "exclude: %.*s vs %s at line %d =3D>=
 %s%s\n",
 			 pathlen, pathname, exc->pattern, exc->srcpos,
-			 exc->flags & EXC_FLAG_NEGATIVE ? "no" : "yes");
+			 exc->flags & EXC_FLAG_NEGATIVE ? "no" : "yes",
+			 exc->sticky_paths.nr ? " (stuck)" : "");
 	return exc;
 }
=20
@@ -2005,6 +2057,25 @@ static struct untracked_cache_dir *validate_untr=
acked_cache(struct dir_struct *d
 	return root;
 }
=20
+static void clear_sticky(struct dir_struct *dir)
+{
+	struct exclude_list_group *g;
+	struct exclude_list *el;
+	struct exclude *x;
+	int i, j, k;
+
+	for (i =3D EXC_CMDL; i <=3D EXC_FILE; i++) {
+		g =3D &dir->exclude_list_group[i];
+		for (j =3D g->nr - 1; j >=3D 0; j--) {
+			el =3D &g->el[j];
+			for (k =3D el->nr - 1; 0 <=3D k; k--) {
+				x =3D el->excludes[k];
+				string_list_clear(&x->sticky_paths, 0);
+			}
+		}
+	}
+}
+
 int read_directory(struct dir_struct *dir, const char *path, int len, =
const struct pathspec *pathspec)
 {
 	struct path_simplify *simplify;
diff --git a/dir.h b/dir.h
index cd46f30..3ec3fb0 100644
--- a/dir.h
+++ b/dir.h
@@ -4,6 +4,7 @@
 /* See Documentation/technical/api-directory-listing.txt */
=20
 #include "strbuf.h"
+#include "string-list.h"
=20
 struct dir_entry {
 	unsigned int len;
@@ -34,6 +35,8 @@ struct exclude {
 	 * and from -1 decrementing for patterns from CLI args.
 	 */
 	int srcpos;
+
+	struct string_list sticky_paths;
 };
=20
 /*
--=20
2.7.0.377.g4cd97dd
