From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] builtin/mv: Get rid of the last caller of get_pathspec
Date: Mon,  3 Aug 2015 10:53:02 -0700
Message-ID: <1438624382-31248-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 03 19:53:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMJvI-0006d4-2m
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 19:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225AbbHCRxM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Aug 2015 13:53:12 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35208 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbbHCRxK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 13:53:10 -0400
Received: by pasy3 with SMTP id y3so19594341pas.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 10:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=qwKk4nTR/TkhXzejnzThKNBikjz7qVX4hdMLi4l2Hnc=;
        b=e3h9fB3q0eQk4Wh+Szfv/8WJvmEFwj0RpflOoE7yUdEtjK4N7PdOElO7ELXs1FOuvq
         +FqCurr98yAuRonwI0jp5MAuYKJGuK1jp/frsNSeucowqV+aq8DuemljO1FMh4BsIS0M
         GfoOTvN7Wfk7CFKtSBSTArtxckqnQW+l8+cKtsvocKRPITuteG1xebOCmb/NQjSRO0zu
         BmXmqb7HqdLtF2k9VKJrFff1buwZ1BORaNmZy6rKa1GGPHqChQl3WGNtBtaUo8as/MOd
         lR8fFFNBYzx9poqwQh7AgAD0ptETM9PEkYMry9wvb9U54HAL3xTsJ58tznkrPCKFSMZI
         7jTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=qwKk4nTR/TkhXzejnzThKNBikjz7qVX4hdMLi4l2Hnc=;
        b=OwRMeyBpod+OiFNVUDzy18dA/VojDIptP0TCqxevXQI1NoBLd/q/mkHyvJ9r/D4ez2
         71TsllzsFLLTsetgvpX4L+3oZ+E7WkqWzD/ZmDRdsyoJ4Qdo6KdpWKXb1It2o9z/QnXQ
         E3tf+DqYfKXcYIHhxvGCgUHUA0UWgwXFSfJMwMwuSA4EPilcDmBbVbsQLlYjIPdIvfQ0
         5jdUrVAV8rjU6Dw0nCDO7CjdHQwUhYPel7oSYehLL22ny/nYdvENRnVSfUnfVKe5e2wD
         QfDSO7QtB7fD35gz/bjiZL2YgHHvKwx+/4IIw+uPJGkTUFKT/Xo72EJ9UiCJt4xKyK4M
         Ohhw==
X-Gm-Message-State: ALoCoQlG/stdMZMvzWtyiKGq1inrtb1MlJ/g+DpGM62T4ivl+bW+yXoLL4zDBBdf41NYBRWh7hoW
X-Received: by 10.68.168.161 with SMTP id zx1mr26228015pbb.35.1438624390105;
        Mon, 03 Aug 2015 10:53:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:db:6b60:15e0:f3aa])
        by smtp.gmail.com with ESMTPSA id ss2sm8592250pbc.45.2015.08.03.10.53.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Aug 2015 10:53:09 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.2.g6ffee06.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275185>

`get_pathspec` is deprecated and builtin/mv is its last caller, so gett=
ing
rid of `get_pathspec` is rather easy. By getting rid of `get_pathspec`,
the documentation such as 'technical/api-setup.txt' becomes easier to r=
ead
as the reader doesn't need to bear with the additional fact that
`get_pathspec` is deprecated.

The code in 'builtin/mv' still requires some work to make it less ugly.

CC: Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC: Junio C Hamano <gitster@pobox.com>
CC: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/api-setup.txt |  2 --
 builtin/mv.c                          | 19 ++++++++++++++++---
 cache.h                               |  1 -
 pathspec.c                            | 30 ---------------------------=
---
 4 files changed, 16 insertions(+), 36 deletions(-)

diff --git a/Documentation/technical/api-setup.txt b/Documentation/tech=
nical/api-setup.txt
index 540e455..eb1fa98 100644
--- a/Documentation/technical/api-setup.txt
+++ b/Documentation/technical/api-setup.txt
@@ -27,8 +27,6 @@ parse_pathspec(). This function takes several argumen=
ts:
=20
 - prefix and args come from cmd_* functions
=20
-get_pathspec() is obsolete and should never be used in new code.
-
 parse_pathspec() helps catch unsupported features and reject them
 politely. At a lower level, different pathspec-related functions may
 not support the same set of features. Such pathspec-sensitive
diff --git a/builtin/mv.c b/builtin/mv.c
index d1d4316..b89d90a 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -10,6 +10,7 @@
 #include "string-list.h"
 #include "parse-options.h"
 #include "submodule.h"
+#include "pathspec.h"
=20
 static const char * const builtin_mv_usage[] =3D {
 	N_("git mv [<options>] <source>... <destination>"),
@@ -20,13 +21,19 @@ static const char * const builtin_mv_usage[] =3D {
 #define KEEP_TRAILING_SLASH 2
=20
 static const char **internal_copy_pathspec(const char *prefix,
-					   const char **pathspec,
+					   const char **argv,
 					   int count, unsigned flags)
 {
 	int i;
+	struct pathspec ps;
 	const char **result =3D xmalloc((count + 1) * sizeof(const char *));
-	memcpy(result, pathspec, count * sizeof(const char *));
+	memcpy(result, argv, count * sizeof(const char *));
 	result[count] =3D NULL;
+
+	/*
+	 * NEEDSWORK: instead of preprocessing, pass the right flags to
+	 * parse_pathspec below.
+	 */
 	for (i =3D 0; i < count; i++) {
 		int length =3D strlen(result[i]);
 		int to_copy =3D length;
@@ -42,7 +49,13 @@ static const char **internal_copy_pathspec(const cha=
r *prefix,
 				result[i] =3D it;
 		}
 	}
-	return get_pathspec(prefix, result);
+
+	parse_pathspec(&ps,
+		       PATHSPEC_ALL_MAGIC &
+		       ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
+		       PATHSPEC_PREFER_CWD,
+		       prefix, result);
+	return ps._raw;
 }
=20
 static const char *add_slash(const char *path)
diff --git a/cache.h b/cache.h
index 4f55466..d4e22e2 100644
--- a/cache.h
+++ b/cache.h
@@ -452,7 +452,6 @@ extern void set_git_work_tree(const char *tree);
=20
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
=20
-extern const char **get_pathspec(const char *prefix, const char **path=
spec);
 extern void setup_work_tree(void);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
diff --git a/pathspec.c b/pathspec.c
index 9304ee3..b0e14e5 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -450,36 +450,6 @@ void parse_pathspec(struct pathspec *pathspec,
 	}
 }
=20
-/*
- * N.B. get_pathspec() is deprecated in favor of the "struct pathspec"
- * based interface - see pathspec.c:parse_pathspec().
- *
- * Arguments:
- *  - prefix - a path relative to the root of the working tree
- *  - pathspec - a list of paths underneath the prefix path
- *
- * Iterates over pathspec, prepending each path with prefix,
- * and return the resulting list.
- *
- * If pathspec is empty, return a singleton list containing prefix.
- *
- * If pathspec and prefix are both empty, return an empty list.
- *
- * This is typically used by built-in commands such as add.c, in order
- * to normalize argv arguments provided to the built-in into a list of
- * paths to process, all relative to the root of the working tree.
- */
-const char **get_pathspec(const char *prefix, const char **pathspec)
-{
-	struct pathspec ps;
-	parse_pathspec(&ps,
-		       PATHSPEC_ALL_MAGIC &
-		       ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
-		       PATHSPEC_PREFER_CWD,
-		       prefix, pathspec);
-	return ps._raw;
-}
-
 void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 {
 	*dst =3D *src;
--=20
2.5.0.2.g6ffee06.dirty
