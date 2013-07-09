From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 12/15] for-each-ref: introduce %(upstream:track[short])
Date: Tue,  9 Jul 2013 16:02:23 +0530
Message-ID: <1373365946-9230-13-git-send-email-artagnon@gmail.com>
References: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 09 12:36:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwVHv-0007Ep-Ax
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 12:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638Ab3GIKgq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jul 2013 06:36:46 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:40493 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768Ab3GIKgo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 06:36:44 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so5408219pad.16
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 03:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CWthf8sevV71R3ACCfKFziYyXnt9sgi29DMnIS+wMHI=;
        b=V/xXndsXOzV9Md5zuCVBIAUF6KqHheYhENmqDclkNbTS2fCXrlkxzElYDWA8/3lWj5
         nqYX6+uWUdiR4sRhOKQR3HWoyS6HXp+VKedNBeX6NynLke9LsTr0LAzYfU1pBQ4iBOW2
         /RXgA1QjIgv812vAoZPLmuF0wszXfqCyjQY77dFw9+E/XcB7dXGLh3yR2o9J4FguYAdC
         sfCuXmCrC0sUvHUzIOzxj7QLSGxQMHXQC1aEfzrV+Y6Ox/ih+69PXeGGSUQ9g/IeLtuz
         hsHFTndJTvNM06UZXvYMZTBQmdHpwDak3N+hliauqEYk8V6iKeHpw3c8GdsiUlXURHUG
         4zyg==
X-Received: by 10.68.223.225 with SMTP id qx1mr25513724pbc.157.1373366203645;
        Tue, 09 Jul 2013 03:36:43 -0700 (PDT)
Received: from localhost.localdomain ([122.174.59.189])
        by mx.google.com with ESMTPSA id fr1sm27553398pbb.26.2013.07.09.03.36.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Jul 2013 03:36:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.736.g869de25
In-Reply-To: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229939>

Introduce %(upstream:track) to display "[ahead M, behind N]" and
%(upstream:trackshort) to display "=3D", ">", "<", or "<>"
appropriately (inspired by the contrib/completion/git-prompt.sh).

Now you can use the following format in for-each-ref:

  %C(green)%(refname:short)%C(reset)%(upstream:trackshort)

to display refs with terse tracking information.

Note that :track and :trackshort only work with upstream, and error out
when used with anything else.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-for-each-ref.txt |  6 +++++-
 builtin/for-each-ref.c             | 42 ++++++++++++++++++++++++++++++=
++++++--
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for=
-each-ref.txt
index 8d982e3..d666ebd 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -119,7 +119,11 @@ objectname::
 upstream::
 	The name of a local ref which can be considered ``upstream''
 	from the displayed ref. Respects `:short` in the same way as
-	`refname` above.
+	`refname` above.  Additionally respects `:track` to show
+	"[ahead N, behind M]" and `:trackshort` to show the terse
+	version (like the prompt) ">", "<", "<>", or "=3D".  Has no
+	effect if the ref does not have tracking information
+	associated with it.
=20
 HEAD::
 	Useful to indicate the currently checked out branch.  Is '*'
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 3d357a9..72b33ee 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -628,6 +628,7 @@ static void populate_value(struct refinfo *ref)
 	int eaten, i;
 	unsigned long size;
 	const unsigned char *tagged;
+	int upstream_present =3D 0;
=20
 	ref->value =3D xcalloc(sizeof(struct atom_value), used_atom_cnt);
=20
@@ -645,6 +646,7 @@ static void populate_value(struct refinfo *ref)
 		int deref =3D 0;
 		const char *refname;
 		const char *formatp;
+		struct branch *branch;
=20
 		if (*name =3D=3D '*') {
 			deref =3D 1;
@@ -656,7 +658,6 @@ static void populate_value(struct refinfo *ref)
 		else if (!prefixcmp(name, "symref"))
 			refname =3D ref->symref ? ref->symref : "";
 		else if (!prefixcmp(name, "upstream")) {
-			struct branch *branch;
 			/* only local branches may have an upstream */
 			if (prefixcmp(ref->refname, "refs/heads/"))
 				continue;
@@ -666,6 +667,7 @@ static void populate_value(struct refinfo *ref)
 			    !branch->merge[0]->dst)
 				continue;
 			refname =3D branch->merge[0]->dst;
+			upstream_present =3D 1;
 		}
 		else if (!strcmp(name, "flag")) {
 			char buf[256], *cp =3D buf;
@@ -683,6 +685,7 @@ static void populate_value(struct refinfo *ref)
 		} else if (!strcmp(name, "HEAD")) {
 			const char *head;
 			unsigned char sha1[20];
+
 			head =3D resolve_ref_unsafe("HEAD", sha1, 1, NULL);
 			if (!strcmp(ref->refname, head))
 				v->s =3D "*";
@@ -695,11 +698,46 @@ static void populate_value(struct refinfo *ref)
 		formatp =3D strchr(name, ':');
 		/* look for "short" refname format */
 		if (formatp) {
+			int num_ours, num_theirs;
+
 			formatp++;
 			if (!strcmp(formatp, "short"))
 				refname =3D shorten_unambiguous_ref(refname,
 						      warn_ambiguous_refs);
-			else
+			else if (!strcmp(formatp, "track") &&
+				!prefixcmp(name, "upstream")) {
+				char buf[40];
+
+				if (!upstream_present)
+					continue;
+				if (!stat_tracking_info(branch, &num_ours, &num_theirs))
+					v->s =3D "";
+				else if (!num_ours) {
+					sprintf(buf, "[behind %d]", num_theirs);
+					v->s =3D xstrdup(buf);
+				} else if (!num_theirs) {
+					sprintf(buf, "[ahead %d]", num_ours);
+					v->s =3D xstrdup(buf);
+				} else {
+					sprintf(buf, "[ahead %d, behind %d]",
+						num_ours, num_theirs);
+					v->s =3D xstrdup(buf);
+				}
+				continue;
+			} else if (!strcmp(formatp, "trackshort") &&
+				!prefixcmp(name, "upstream")) {
+				if (!upstream_present)
+					continue;
+				if (!stat_tracking_info(branch, &num_ours, &num_theirs))
+					v->s =3D "=3D";
+				else if (!num_ours)
+					v->s =3D "<";
+				else if (!num_theirs)
+					v->s =3D ">";
+				else
+					v->s =3D "<>";
+				continue;
+			} else
 				die("unknown %.*s format %s",
 				    (int)(formatp - name), name, formatp);
 		}
--=20
1.8.3.2.736.g869de25
