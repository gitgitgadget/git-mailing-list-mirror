From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Do not skip prefix_filename() when there is no prefix
Date: Sun, 22 May 2016 18:12:03 +0700
Message-ID: <20160522111203.26193-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 13:13:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4RJx-0008AB-4d
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 13:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbcEVLNO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2016 07:13:14 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34667 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbcEVLNN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 07:13:13 -0400
Received: by mail-pf0-f194.google.com with SMTP id 145so15963121pfz.1
        for <git@vger.kernel.org>; Sun, 22 May 2016 04:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f47p8M0Leo1qJiMBk3xX59hjWdK8CKXquLFMcac1wLk=;
        b=Gpl+G6KFgBowaZysICVfABMc/1w+v1OguMqn1i9Rd9AxPsioVX5FPqfNtlB/y2kdbi
         nuilaPoH4DNhbrq8OhQJedYBUcH+cE8/l80CccBEisXi7qu3Jrc7W3StiHeCY1ZDS6wj
         6DCIp0EALYL0I6Rk08q6kgr4hynbIVHX2KXOMajoQ+66QDJiDIaUJcQKLJIY2jQBHYqe
         rsjTJZ+HSG3AH5CxT2Tb/aNnfmPXdA6b+cSD7o/WcZztu1+GKzX1VuHncuZjJ8RvkIjV
         ob59WlrEnd0pA+38w661zGYpakpHsosGtLu4jMnIws4XE/XY10igH++ATpaZvW/3UYgf
         zbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f47p8M0Leo1qJiMBk3xX59hjWdK8CKXquLFMcac1wLk=;
        b=OdMO16/EOJ0uewyDWoiQ0WKCblYN2RmeRcDvIQ5yM9rfyBJPq5VyxpSD0VfnWb49kI
         wEhTq+W9sholwuxXCus5F+3AGve+gesc+cVegXtYrww0yEf6bROYOgGxN1RiLz6vNdcV
         xwpHqRzvVpUkxfncTVYpZGP77NJJKZJYvuyn32UCjV9Q3BUgRsRb7cpga2fpLlQGK3Oh
         uCG6ng8yTGVeZ3GKGFbeU3CZNCibxGZmFcwrmMqADrFJuqgCcQrHFkp5wpATDQX/SAnO
         UgvuEUpO0lpjoUEJC+M/ik5LAZU7bAC5Th3XDf8XDLpNos29jGkAWhvj7OZqbHx2/F3b
         Isaw==
X-Gm-Message-State: AOPr4FXquLg8aTzvH0dugwI4ztWqwFRZHNkKDNe3/ZadQWVuiB0ZqTfJWLVWORr7TGB4Gw==
X-Received: by 10.98.97.67 with SMTP id v64mr18787759pfb.149.1463915591995;
        Sun, 22 May 2016 04:13:11 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id dh4sm39206817pad.37.2016.05.22.04.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2016 04:13:11 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 22 May 2016 18:13:07 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295280>

On UNIX, when there is no prefix, prefix_filename() returns the input s=
tring
as-is. Avoiding it only makes sense before 9e5f5d4 (prefix_filename():
safely handle the case where pfx_len=3D0 - 2010-10-17) because the func=
tion
back then could try to dereference a NULL pointer.

On Windows, even when there is no prefix, prefix_filename() can still d=
o
some slash conversion. Arguably it's not the best place for that (too
subtle and probably can't cover all paths) but it's how it is.

Let's always call prefix_filename() to make Windows users a tiny bit ha=
ppier.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I left out worktree.c on purpose because that call site is handled
 separately [1]. In fact this patch is the result of Junio's comment
 on [1] (its earlier iteration).

 [1] http://mid.gmane.org/20160522093356.22389-7-pclouds@gmail.com

 builtin/apply.c       | 2 +-
 builtin/hash-object.c | 2 +-
 diff-no-index.c       | 2 +-
 parse-options.c       | 9 ++++++---
 setup.c               | 8 ++++----
 5 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 8e4da2e..08f8db3 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4615,7 +4615,7 @@ int cmd_apply(int argc, const char **argv, const =
char *prefix_)
 			errs |=3D apply_patch(0, "<stdin>", options);
 			read_stdin =3D 0;
 			continue;
-		} else if (0 < prefix_length)
+		} else
 			arg =3D prefix_filename(prefix, prefix_length, arg);
=20
 		fd =3D open(arg, O_RDONLY);
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index f7d3567..45be93a 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -110,7 +110,7 @@ int cmd_hash_object(int argc, const char **argv, co=
nst char *prefix)
 	if (flags & HASH_WRITE_OBJECT) {
 		prefix =3D setup_git_directory();
 		prefix_length =3D prefix ? strlen(prefix) : 0;
-		if (vpath && prefix)
+		if (vpath)
 			vpath =3D prefix_filename(prefix, prefix_length, vpath);
 	}
=20
diff --git a/diff-no-index.c b/diff-no-index.c
index 1f8999b..76cc80c 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -268,7 +268,7 @@ void diff_no_index(struct rev_info *revs,
 			 * path that is "-", spell it as "./-".
 			 */
 			p =3D file_from_standard_input;
-		else if (prefixlen)
+		else
 			p =3D xstrdup(prefix_filename(prefix, prefixlen, p));
 		paths[i] =3D p;
 	}
diff --git a/parse-options.c b/parse-options.c
index 47a9192..8b54317 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -37,10 +37,13 @@ static int get_arg(struct parse_opt_ctx_t *p, const=
 struct option *opt,
=20
 static void fix_filename(const char *prefix, const char **file)
 {
-	if (!file || !*file || !prefix || is_absolute_path(*file)
-	    || !strcmp("-", *file))
+	int prefix_length;
+
+	if (!file || !*file || is_absolute_path(*file) || !strcmp("-", *file)=
)
 		return;
-	*file =3D xstrdup(prefix_filename(prefix, strlen(prefix), *file));
+
+	prefix_length =3D prefix ? strlen(prefix) : 0;
+	*file =3D xstrdup(prefix_filename(prefix, prefix_length, *file));
 }
=20
 static int opt_command_mode_error(const struct option *opt,
diff --git a/setup.c b/setup.c
index c86bf5c..291385e 100644
--- a/setup.c
+++ b/setup.c
@@ -141,10 +141,10 @@ int check_filename(const char *prefix, const char=
 *arg)
 		if (arg[2] =3D=3D '\0') /* ":/" is root dir, always exists */
 			return 1;
 		name =3D arg + 2;
-	} else if (prefix)
-		name =3D prefix_filename(prefix, strlen(prefix), arg);
-	else
-		name =3D arg;
+	} else {
+		int prefix_length =3D prefix ? strlen(prefix) : 0;
+		name =3D prefix_filename(prefix, prefix_length, arg);
+	}
 	if (!lstat(name, &st))
 		return 1; /* file exists */
 	if (errno =3D=3D ENOENT || errno =3D=3D ENOTDIR)
--=20
2.8.2.524.g6ff3d78
