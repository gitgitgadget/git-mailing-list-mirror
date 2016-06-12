From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 26/27] upload-pack: add get_reachable_list()
Date: Sun, 12 Jun 2016 17:54:08 +0700
Message-ID: <20160612105409.22156-27-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
 <20160612105409.22156-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 12:56:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC34c-0004GS-NK
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbcFLK4z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 06:56:55 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34803 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096AbcFLK4y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:56:54 -0400
Received: by mail-pa0-f66.google.com with SMTP id ug1so8417568pab.1
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B5iAcE+EkRRUMNO8NY5qIofKoI9G0A1YJmWftzdtzh8=;
        b=tQ+SCh3f8odEkKgwBsyjE+fy/qMoIHNF5ZeidDUiadCRSIg3Cu+63VYuNiM8D9JbW7
         8To0oH6aiPGdoTPZqGV1yiHxtFRlF7Z1VPrPAjkE/CfyCsToRJ6SdkQ7QhRs+OCFU8Lb
         8n/bsklVrJlF1mHX4T3Sqebasmpm3w4ls9XubzRPzx0tH6whWPEB5HhvZwt+tIJAPYWm
         G046dwC3saCpSMpJejx+iBvSKkp8rOHpzYM91eSCO7bI5pk33yeB+fms4XAvMOfzBofn
         AUSrwovHjvlr/yVPir4/az1BPN2zC/rUsVEBa9rFGOXKQjSyEVoQpW+loPxOvL0V/TmG
         TMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B5iAcE+EkRRUMNO8NY5qIofKoI9G0A1YJmWftzdtzh8=;
        b=V4DQGQYlZmisjPk/TALaYu7weJ1ILrOQBG6q8LmvqEnv0VCow3Cq49f1sngXgA1m+R
         BgbQ1tM/hFIWiH4zCGzaULmn+vrAPl4g0Jz4sI0lc4Y+D9MNbOeCXXXei3blmmX+c/FQ
         cKu86e2HFIsuoVhUtAua2eQFsyfd0AyHRh0VStvaHREBBjV9FG4CMW50ztojzqYB3WAt
         7IS661bV7+Xg8mw+CA23F9HxiohyDsk5nEr7V9vWZyXUqENq6z5xkkX63XE3Bt7aqaME
         9mIPSJDZ9Ya9HgtS2rA9AmMR++SW9DSpl65bnJwB5BuHTAuNURqBTs/ny4Y2J7CG9OMv
         /1Lg==
X-Gm-Message-State: ALyK8tKbBm00BOcrymJEQfFOJHIFv5WBeHUJ4vepmL9qadaqzUrfbKv3cpwl3e7fitLroQ==
X-Received: by 10.66.47.133 with SMTP id d5mr15096694pan.48.1465729013160;
        Sun, 12 Jun 2016 03:56:53 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id h6sm17398001pac.46.2016.06.12.03.56.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 03:56:52 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:56:48 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160612105409.22156-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297133>

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
index adb8e33..3227df8 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -456,7 +456,8 @@ static int is_our_ref(struct object *o)
  * on successful case, it's up to the caller to close cmd->out
  */
 static int do_reachable_revlist(struct child_process *cmd,
-				struct object_array *src)
+				struct object_array *src,
+				struct object_array *reachable)
 {
 	static const char *argv[] =3D {
 		"rev-list", "--stdin", NULL,
@@ -487,6 +488,8 @@ static int do_reachable_revlist(struct child_proces=
s *cmd,
 		o =3D get_indexed_object(--i);
 		if (!o)
 			continue;
+		if (reachable && o->type =3D=3D OBJ_COMMIT)
+			o->flags &=3D ~TMP_MARK;
 		if (!is_our_ref(o))
 			continue;
 		memcpy(namebuf + 1, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
@@ -496,8 +499,13 @@ static int do_reachable_revlist(struct child_proce=
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
 			goto error;
@@ -518,13 +526,51 @@ error:
 	return -1;
 }
=20
+static int get_reachable_list(struct object_array *src,
+			      struct object_array *reachable)
+{
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
+	int i;
+	struct object *o;
+	char namebuf[42]; /* ^ + SHA-1 + LF */
+
+	if (do_reachable_revlist(&cmd, src, reachable) < 0)
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
 static int has_unreachable(struct object_array *src)
 {
 	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	char buf[1];
 	int i;
=20
-	if (do_reachable_revlist(&cmd, src) < 0)
+	if (do_reachable_revlist(&cmd, src, NULL) < 0)
 		return 1;
=20
 	/*
--=20
2.8.2.524.g6ff3d78
