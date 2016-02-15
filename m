From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/4] dir.c: support tracing exclude
Date: Mon, 15 Feb 2016 16:03:37 +0700
Message-ID: <1455527019-7787-3-git-send-email-pclouds@gmail.com>
References: <1455527019-7787-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 10:03:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVF4L-00067t-Gv
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 10:03:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbcBOJDj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 04:03:39 -0500
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34730 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498AbcBOJDf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 04:03:35 -0500
Received: by mail-pa0-f67.google.com with SMTP id yy13so6948200pab.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 01:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=f95feFNw8LgLXPYqk3Re8haQh45tM8mAnwuaWiYbPco=;
        b=Vwei9KrKiLbotQHPq366IGIfFFEJXpLcnObgrSNLQSrJRViCFSloRHCA0iWo1M0eWY
         ZUCwFGpYR5wu71/Oac1LcZnV8d6QDRnsb85LzbhB3oT/k8b3w7Hk8hsfML/l1bwm6sO3
         2N0FUz13OJ3m6I1OUA4b13EOzw7tjf4KBTLKlYm5tDLE09tm7B78XWOD746V4LORH0fy
         bkVL9eTJnLRJhZylO+p8764adjH4oahMbdJ8dptkqfdhTASWjbWHk/JZXqOAfM00EBxS
         Qr4YbSdozVgW9SedwaabaDg2yRR3Iw8HIUjDorLdfwZSSDwDvubPLEHgCbzwSQRcTAb6
         iN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=f95feFNw8LgLXPYqk3Re8haQh45tM8mAnwuaWiYbPco=;
        b=A8cBckdhfnIWFutyzWqBYaWSMSWybb98AgIBTLb52eZdoKlbNfhqnyq99sTATFZgDY
         lxIRJx8B8A9XdlkgSbxunkb34hkLMv65t9UkzrnnHi//RksB0gxOvQaWecpOd64IC3q2
         GRapr5jkeSmzK2OSsSXeUefgzs31sqOtkN/pFqNeCRp3kR6DNTmgmDsypQMbH1ra22BV
         6MVnWwXxOzdRzGw+t3zhdFNRl15n25GMLJd1p6fPDl3R8qUBYB9CpptiZrezUENVDdhs
         LsB56ptkPZP7VGQNuV+t7ui96otmloSO9QI2QgWgTPDK9aBgdOApW8iqa+ut6vLY4oLS
         mG6Q==
X-Gm-Message-State: AG10YORu/wdjmLwBjRL3yGXHO5OwZDgajUsIMZeBcSQhomjcahFXceFAZIinALSUCxVl1A==
X-Received: by 10.66.193.131 with SMTP id ho3mr21542505pac.154.1455527014643;
        Mon, 15 Feb 2016 01:03:34 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id lq10sm36836740pab.36.2016.02.15.01.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 01:03:33 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 15 Feb 2016 16:03:57 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455527019-7787-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286185>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-check-ignore.txt |  1 +
 Documentation/git.txt              |  5 +++++
 dir.c                              | 20 ++++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-che=
ck-ignore.txt
index e94367a..f60ee05 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -114,6 +114,7 @@ SEE ALSO
 linkgit:gitignore[5]
 linkgit:gitconfig[5]
 linkgit:git-ls-files[1]
+GIT_TRACE_EXCLUDE in linkgit:git[1]
=20
 GIT
 ---
diff --git a/Documentation/git.txt b/Documentation/git.txt
index d987ad2..2c4f0f2 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1064,6 +1064,11 @@ of clones and fetches.
 	cloning of shallow repositories.
 	See 'GIT_TRACE' for available trace output options.
=20
+'GIT_TRACE_EXCLUDE'::
+	Enables trace messages that can help debugging .gitignore
+	processing. See 'GIT_TRACE' for available trace output
+	options.
+
 'GIT_LITERAL_PATHSPECS'::
 	Setting this variable to `1` will cause Git to treat all
 	pathspecs literally, rather than as glob patterns. For example,
diff --git a/dir.c b/dir.c
index bcaafac..0be7cf1 100644
--- a/dir.c
+++ b/dir.c
@@ -53,6 +53,8 @@ static enum path_treatment read_directory_recursive(s=
truct dir_struct *dir,
 	int check_only, const struct path_simplify *simplify);
 static int get_dtype(struct dirent *de, const char *path, int len);
=20
+static struct trace_key trace_exclude =3D TRACE_KEY_INIT(EXCLUDE);
+
 /* helper string functions with support for the ignore_case flag */
 int strcmp_icase(const char *a, const char *b)
 {
@@ -905,6 +907,8 @@ static struct exclude *last_exclude_matching_from_l=
ist(const char *pathname,
 	if (!el->nr)
 		return NULL;	/* undefined */
=20
+	trace_printf_key(&trace_exclude, "exclude: from %s\n", el->src);
+
 	for (i =3D el->nr - 1; 0 <=3D i; i--) {
 		struct exclude *x =3D el->excludes[i];
 		const char *exclude =3D x->pattern;
@@ -936,6 +940,16 @@ static struct exclude *last_exclude_matching_from_=
list(const char *pathname,
 			break;
 		}
 	}
+
+	if (!exc) {
+		trace_printf_key(&trace_exclude, "exclude: %.*s =3D> n/a\n",
+				 pathlen, pathname);
+		return NULL;
+	}
+
+	trace_printf_key(&trace_exclude, "exclude: %.*s vs %s at line %d =3D>=
 %s\n",
+			 pathlen, pathname, exc->pattern, exc->srcpos,
+			 exc->flags & EXC_FLAG_NEGATIVE ? "no" : "yes");
 	return exc;
 }
=20
@@ -1683,9 +1697,13 @@ static enum path_treatment read_directory_recurs=
ive(struct dir_struct *dir,
 	struct cached_dir cdir;
 	enum path_treatment state, subdir_state, dir_state =3D path_none;
 	struct strbuf path =3D STRBUF_INIT;
+	static int level =3D 0;
=20
 	strbuf_add(&path, base, baselen);
=20
+	trace_printf_key(&trace_exclude, "exclude: [%d] enter '%.*s'\n",
+			 level++, baselen, base);
+
 	if (open_cached_dir(&cdir, dir, untracked, &path, check_only))
 		goto out;
=20
@@ -1749,6 +1767,8 @@ static enum path_treatment read_directory_recursi=
ve(struct dir_struct *dir,
 	}
 	close_cached_dir(&cdir);
  out:
+	trace_printf_key(&trace_exclude, "exclude: [%d] leave '%.*s'\n",
+			 --level, baselen, base);
 	strbuf_release(&path);
=20
 	return dir_state;
--=20
2.7.0.377.g4cd97dd
