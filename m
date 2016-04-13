From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 25/26] upload-pack: add get_reachable_list()
Date: Wed, 13 Apr 2016 19:55:09 +0700
Message-ID: <1460552110-5554-26-git-send-email-pclouds@gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:57:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKMW-0004n9-5Q
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758198AbcDMM53 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 08:57:29 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36119 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757586AbcDMM50 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:57:26 -0400
Received: by mail-pa0-f68.google.com with SMTP id k3so3877807pav.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G+xbBRTHWAM0Vstcbm2ChPxOZIi2y/+i7zjmyN6sqf4=;
        b=rzWc4lN046m6S7eBzQ0ImWPBAjLBj7Z0S/pZC9kWjEUUw9T8c7Jt2YfcKxflo9wBxw
         jnkRPkd2g6jXYGP7vx7bxHSPx11L5IqN+RFVuMz69IWJh7ItnY8LXqWugyLNjUM7fBd7
         yKvuDP605aRlwX6JNiPlR99z3UtErY+fC+IMtvPEdUrFC46HPrAWe/8oW2pOxxY12CPE
         Y7925GR6MZBHPn/AZp5SADjNEXi66TohUIctxn5EgzB5zICjwmbWKmOnurgzoqiV/LuB
         DRqT4k9kWGoQ+wtQAH6BuHAYBHLsUJjn9dUFXT1e/Xu5RtDie2xnVX2VGOutJt50H18S
         TOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G+xbBRTHWAM0Vstcbm2ChPxOZIi2y/+i7zjmyN6sqf4=;
        b=UR1Miun5xdnH7xgzBCVWFfKMNhJE7BhMjVT+VOEyW9e36PAWkYbNRWOe6R5XvgqDa4
         Pgd9ZDwLz2dKFwu3x4/h1t8WFVJSui8TN1OSEa5vZPM04Ma+254eA+a8v6Ahio40nEkR
         6FrtP+JWIvrYkBax4qslhjqSWoIvTrhyfALa2gnGJViu2qCdhn+Vqd0xpHpNV+ykkMIb
         ZNDzjQMPJBRgEKEinY7Xd/WM9YT4rhupogmLydpvO9nMYvCtgdNT5yN3KhtmgXbG+6FN
         3TV+Uktk+03TUXLD6ImAmvWL1KbXxoKtVHHPdbjxEZ9hijq2z7/zDJ7S161PvK/toLL/
         cHCA==
X-Gm-Message-State: AOPr4FUlk00GlgQZBRNgWgVl7AmNUm4y14hrKMNhytSP25ScLAlSUpbfcE9KGit5lrLeqw==
X-Received: by 10.66.193.202 with SMTP id hq10mr12467845pac.6.1460552246296;
        Wed, 13 Apr 2016 05:57:26 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id a11sm51175899pat.6.2016.04.13.05.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 05:57:25 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 19:57:32 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291419>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 object.h      |  2 +-
 upload-pack.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++--=
-
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/object.h b/object.h
index f8b6442..614a006 100644
--- a/object.h
+++ b/object.h
@@ -31,7 +31,7 @@ struct object_array {
  * revision.h:      0---------10                                26
  * fetch-pack.c:    0---4
  * walker.c:        0-2
- * upload-pack.c:               11----------------19
+ * upload-pack.c:       4       11----------------19
  * builtin/blame.c:               12-13
  * bisect.c:                               16
  * bundle.c:                               16
diff --git a/upload-pack.c b/upload-pack.c
index 9e4a4fa..9bd590c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -453,7 +453,8 @@ static int is_our_ref(struct object *o)
 }
=20
 static int do_reachable_revlist(struct child_process *cmd,
-				struct object_array *src)
+				struct object_array *src,
+				struct object_array *reachable)
 {
 	static const char *argv[] =3D {
 		"rev-list", "--stdin", NULL,
@@ -484,6 +485,8 @@ static int do_reachable_revlist(struct child_proces=
s *cmd,
 		o =3D get_indexed_object(--i);
 		if (!o)
 			continue;
+		if (reachable && o->type =3D=3D OBJ_COMMIT)
+			o->flags &=3D ~TMP_MARK;
 		if (!is_our_ref(o))
 			continue;
 		memcpy(namebuf + 1, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
@@ -493,8 +496,13 @@ static int do_reachable_revlist(struct child_proce=
ss *cmd,
 	namebuf[40] =3D '\n';
 	for (i =3D 0; i < src->nr; i++) {
 		o =3D src->objects[i].item;
-		if (is_our_ref(o))
+		if (is_our_ref(o)) {
+			if (reachable)
+				add_object_array(o, NULL, reachable);
 			continue;
+		}
+		if (reachable && o->type =3D=3D OBJ_COMMIT)
+			o->flags |=3D TMP_MARK;
 		memcpy(namebuf, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
 		if (write_in_full(cmd->in, namebuf, 41) < 0)
 			return -1;
@@ -505,10 +513,48 @@ static int do_reachable_revlist(struct child_proc=
ess *cmd,
 	return 0;
 }
=20
+static int get_reachable_list(struct object_array *src,
+			      struct object_array *reachable)
+{
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
+	int i, ret =3D do_reachable_revlist(&cmd, src, reachable);
+	struct object *o;
+	char namebuf[42]; /* ^ + SHA-1 + LF */
+
+	if (ret < 0)
+		return -1;
+
+	while ((i =3D read_in_full(cmd.out, namebuf, 41)) =3D=3D 41) {
+		struct object_id sha1;
+
+		if (namebuf[40] !=3D '\n' || get_oid_hex(namebuf, &sha1))
+			break;
+
+		o =3D lookup_object(sha1.hash);
+		if (o && o->type =3D=3D OBJ_COMMIT) {
+			o->flags &=3D ~TMP_MARK;
+		}
+	}
+	for (i =3D get_max_object_index(); 0 < i; i--) {
+		o =3D get_indexed_object(i - 1);
+		if (o && o->type =3D=3D OBJ_COMMIT &&
+		    (o->flags & TMP_MARK)) {
+			add_object_array(o, NULL, reachable);
+				o->flags &=3D ~TMP_MARK;
+		}
+	}
+	close(cmd.out);
+
+	if (finish_command(&cmd))
+		return -1;
+
+	return 0;
+}
+
 static int check_unreachable(struct object_array *src)
 {
 	struct child_process cmd =3D CHILD_PROCESS_INIT;
-	int i, ret =3D do_reachable_revlist(&cmd, src);
+	int i, ret =3D do_reachable_revlist(&cmd, src, NULL);
 	char buf[1];
=20
 	if (ret < 0)
--=20
2.8.0.rc0.210.gd302cd2
