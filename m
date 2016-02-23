From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 24/25] upload-pack: add get_reachable_list()
Date: Tue, 23 Feb 2016 20:45:02 +0700
Message-ID: <1456235103-26317-25-git-send-email-pclouds@gmail.com>
References: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 14:47:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYDJO-0001TM-88
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 14:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbcBWNrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 08:47:25 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34200 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbcBWNrV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 08:47:21 -0500
Received: by mail-pa0-f44.google.com with SMTP id fy10so110575774pac.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 05:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+2bJ/qWyuPuFLh9jP18nrFRDw8JE8aNu8oBfeJhogKc=;
        b=sbMwcLAHYp7FWPurt4e0e7aErXSJKED0hQFbWG48EITbRScquvylWMgfJcuxLWwERZ
         iR8b5sfXWPkjp5aomLNF7p3S2WMq+cU4hbI6MzDLudiydBmZ+Vf4xzUpgVNO5lnG1cOD
         Odamtfo0avNnm43hZZJwOSob8Cz3Ybmu57rx5Bic0BrW5x9JXouctkadd/NoQdpS8GaA
         XyUVnycTz41qXyh12YDXVzsCArd7ipbVbU7vL5MQHM6hnj/OO5nsXoMTMVGI9wPFmq4u
         JwY4mJr0oc0f3y4BLa6bZDKn3zGgYMwp+xWvqx7x+eLvzRbaZzEJJbwbgnws6i1DuoA1
         8HfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=+2bJ/qWyuPuFLh9jP18nrFRDw8JE8aNu8oBfeJhogKc=;
        b=Vmlt1Ks45bDFYi4DLe/Mo0JYUGApbU3pwmJTvur/9eaD6PSUW7Lwj1eJDmf8Qdn0aM
         AZVe84pfAlEcac8nthvVjAJcdEzx4geSxDZnrBcGqY87EepKsKrWdmUgCEHb7kuPG1aD
         NyWzv0sZs8vDk2mxBSO/P/tQr+yyHblaAcfng24i/rQpUsCYCbWfH/kuBXw2V0S5aCRv
         1RtAPuXKMo1P8fwG/edMykeE73c+bDlLGcqSGEI4vAMn9O7oxpxsmC/n0ENnZrJ1TUX/
         lg3uzzxL0crCRmm+MrRArl54aUlCHTp2t0ejjEXsoS9ugJZHm6RnL27HUqRz/R5o20v0
         FBDA==
X-Gm-Message-State: AG10YOSk82uQAVbOIMZXgCof6wqVSpOGOWTLX7f5EFktVw+pKbhubmQYcrVZWblRwCg0MA==
X-Received: by 10.66.144.4 with SMTP id si4mr46425272pab.0.1456235240546;
        Tue, 23 Feb 2016 05:47:20 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id 3sm44417047pfn.59.2016.02.23.05.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 05:47:19 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 23 Feb 2016 20:47:49 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
In-Reply-To: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287075>

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
2.7.1.532.gd9e3aaa
