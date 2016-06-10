From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 26/27] upload-pack: add get_reachable_list()
Date: Fri, 10 Jun 2016 19:27:13 +0700
Message-ID: <20160610122714.3341-27-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:31:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLZl-00025G-Ie
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933021AbcFJMaD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 08:30:03 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35541 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933004AbcFJMaA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:30:00 -0400
Received: by mail-pa0-f66.google.com with SMTP id gp3so5026390pac.2
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5pfqsD8//Guzb0Pqee49EQwBADJGizD9gHAPctqq8bU=;
        b=Jtt+ngFW8yV0uAafrLeXEKQKOmyB6h9gn3G1aEumJgLgjtau1q0iCN8nWwcFzCrCQO
         qRHyoJ72MB6LYpkY2uoomBPTaBvtkL8qoIZwkQ+9IatSST3ZFDgq9Ur+qkDCAsiubWWc
         ArQfb2gmx53vuDjVAX2voSRHE2AFwBszjspo3Cr6FGgv5ETiUaVxRTjyOLl5TgdS5SpI
         UcDtCacDTe4lsMHYkOJANLbNsJqDNXFtyzEquZLWCMeTqANUsU6dVoiuwQwbh9untKuL
         EMmNSo0dJRFVVhwqzaJu8JzMsnI+nXi9kf5Edkmf+kMRf3IEuvyB4xF/42TURtBLZlfA
         FJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5pfqsD8//Guzb0Pqee49EQwBADJGizD9gHAPctqq8bU=;
        b=P6l98I+VIMbCY2Y9E4y4otkzI3/mfI8pEERncPnEPyo/bNj8t1lDVZaZdcuqtjIA3Z
         PuRi8H+O0kMjEBMIKADb5fynLXMS/CQpNcQ/EF2F2Skj+BAbNrvRAWU/WPa4wmaHW+bh
         b/Shy/Tc4/v+0ruf021bXsXxxS7dDWgcURkm72onwd/fo99/F9BdhJ1/Z4ce6Ktf7Eld
         ir/Va9EmkgZjk39eQ5DjLH2GP3+pUJ55TVSIS25D5SC27Nx/7kjhBLiqtWMlLEmnhl7x
         JSgqwVF8eiOxTQQ2OshEBkOvW5rS+BpirEGxBI6M2+AZ9Q4HLyi98H7Vbg3T9/pX63wG
         gIOg==
X-Gm-Message-State: ALyK8tKJ9aHcY8FSUDtmvNCyxVmbIUWF6ksx8JR+JRKhLEBq7kAKealVfXp6laaD20oJHg==
X-Received: by 10.66.178.139 with SMTP id cy11mr1988424pac.157.1465561800007;
        Fri, 10 Jun 2016 05:30:00 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id y205sm17591065pfb.13.2016.06.10.05.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 05:29:59 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 19:29:55 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296994>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index 5942f99..1d4f914 100644
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
@@ -495,8 +498,13 @@ static int do_reachable_revlist(struct child_proce=
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
 		if (write_in_full(cmd->in, namebuf, 41) < 0) {
 			sigchain_pop(SIGPIPE);
@@ -517,13 +525,51 @@ error:
 	return -1;
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
 	char buf[1];
 	int i;
=20
-	if (do_reachable_revlist(&cmd, src) < 0)
+	if (do_reachable_revlist(&cmd, src, NULL) < 0)
 		return 0;
=20
 	/*
--=20
2.8.2.524.g6ff3d78
