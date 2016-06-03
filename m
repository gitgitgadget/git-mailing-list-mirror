From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 3/6] worktree.c: add is_worktree_locked()
Date: Fri,  3 Jun 2016 19:19:41 +0700
Message-ID: <20160603121944.28980-4-pclouds@gmail.com>
References: <20160530104939.28407-1-pclouds@gmail.com>
 <20160603121944.28980-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 14:20:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8o5Z-00034l-QY
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 14:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbcFCMUZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 08:20:25 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35843 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbcFCMUY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 08:20:24 -0400
Received: by mail-pf0-f196.google.com with SMTP id 62so11401871pfd.3
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 05:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=log7kiumsOlM6kzmj+E5oZOqcdGdyUMoJViKjACB7GM=;
        b=am+3zHFpp+iEpPvx0Iu2xEXQyaBo1Ejwp9hXJe1+ndq6ix/4/wCVwvWBqHvzYib6f6
         DE+wBChW3bY752BrUcGAsP/gbdqkhry+HcNIRoE3GR3NR8uo0kPiurPiBIx3+y+GxsB+
         wX0ufaKm8/e/gYixvDnS0JJO34XHkVDnOEIFy98a2VG6dr6gilQwVB+QVRmmRnxLkMtp
         +vepmo1O55MK21+d7EC6cJVel4OtMk9DSka/P4SHydg2at0eU4G1abTN6TYtGZ4HCYNb
         stz7TL4N/BsEr3P3GSBt9vylTHOfBCekvXuiQB9H0jiUwImQZYUVz62UTmpyb3jV9b+K
         Htaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=log7kiumsOlM6kzmj+E5oZOqcdGdyUMoJViKjACB7GM=;
        b=Ti9x2vPF1AJNT/6wHm0bAgkAXWn0M6pjBx4WJIkU7A+HKZpGUNxjzLu2vsRzCuNUS9
         50hSROnOUSNF2EEwg5LWxJZwP+z5rc1MLQqWp/Qz9SwsJtbK6CFoHnj5m1Wx3l7m2ZIW
         TvuxV89uv3L+SEqX6MEnrlSH0IAp5GQv+n8A1DnQzrFTJwbENCmUtfidTkmAL46ZogXp
         JD5DyuJ0MwmenqjjEaPJ0rZIMAWSScknV1VU67T6x9CkKp4hZNODHSgmYMh7w7rOAkGj
         gE3GSuMBh1E+7IIkA1NHBUfXNRuWQ126w1eVMucR6EVtiE5poG6SEZ/ok8ZXBZO8Xrfc
         z9HA==
X-Gm-Message-State: ALyK8tKH9Xm8+YEjilmoN7ScRe8oEVh+b5wJHw2uwEDbS1PynjvgnQR0vn/MQ6qRR7S5hw==
X-Received: by 10.98.54.133 with SMTP id d127mr5897817pfa.104.1464956423364;
        Fri, 03 Jun 2016 05:20:23 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id ql1sm5758411pac.2.2016.06.03.05.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jun 2016 05:20:22 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 03 Jun 2016 19:20:17 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160603121944.28980-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296309>

We need this later to avoid double locking a worktree, or unlocking one
when it's not even locked.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 26 ++++++++++++++++++++++++++
 worktree.h |  7 +++++++
 2 files changed, 33 insertions(+)

diff --git a/worktree.c b/worktree.c
index eb3aaaa..ee592a4 100644
--- a/worktree.c
+++ b/worktree.c
@@ -5,6 +5,8 @@
 #include "dir.h"
 #include "wt-status.h"
=20
+static const char *lock_field_uninitialized =3D "value is not importan=
t";
+
 void free_worktrees(struct worktree **worktrees)
 {
 	int i =3D 0;
@@ -13,6 +15,8 @@ void free_worktrees(struct worktree **worktrees)
 		free(worktrees[i]->path);
 		free(worktrees[i]->id);
 		free(worktrees[i]->head_ref);
+		if (worktrees[i]->lock_reason !=3D lock_field_uninitialized)
+			free(worktrees[i]->lock_reason);
 		free(worktrees[i]);
 	}
 	free (worktrees);
@@ -98,6 +102,7 @@ static struct worktree *get_main_worktree(void)
 	worktree->is_detached =3D is_detached;
 	worktree->is_current =3D 0;
 	add_head_info(&head_ref, worktree);
+	worktree->lock_reason =3D (char *)lock_field_uninitialized;
=20
 done:
 	strbuf_release(&path);
@@ -143,6 +148,7 @@ static struct worktree *get_linked_worktree(const c=
har *id)
 	worktree->is_detached =3D is_detached;
 	worktree->is_current =3D 0;
 	add_head_info(&head_ref, worktree);
+	worktree->lock_reason =3D (char *)lock_field_uninitialized;
=20
 done:
 	strbuf_release(&path);
@@ -234,6 +240,26 @@ int is_main_worktree(const struct worktree *wt)
 	return !wt->id;
 }
=20
+const char *is_worktree_locked(struct worktree *wt)
+{
+	if (wt->lock_reason =3D=3D lock_field_uninitialized) {
+		struct strbuf path =3D STRBUF_INIT;
+
+		strbuf_addstr(&path, worktree_git_path(wt, "locked"));
+		if (file_exists(path.buf)) {
+			struct strbuf lock_reason =3D STRBUF_INIT;
+			if (strbuf_read_file(&lock_reason, path.buf, 0) < 0)
+				die_errno(_("failed to read '%s'"), path.buf);
+			strbuf_trim(&lock_reason);
+			wt->lock_reason =3D strbuf_detach(&lock_reason, NULL);
+		} else
+			wt->lock_reason =3D NULL;
+		strbuf_release(&path);
+	}
+
+	return wt->lock_reason;
+}
+
 int is_worktree_being_rebased(const struct worktree *wt,
 			      const char *target)
 {
diff --git a/worktree.h b/worktree.h
index e1c4715..263b61d 100644
--- a/worktree.h
+++ b/worktree.h
@@ -5,6 +5,7 @@ struct worktree {
 	char *path;
 	char *id;
 	char *head_ref;
+	char *lock_reason;	/* internal use */
 	unsigned char head_sha1[20];
 	int is_detached;
 	int is_bare;
@@ -42,6 +43,12 @@ extern struct worktree *find_worktree(struct worktre=
e **list,
  */
 extern int is_main_worktree(const struct worktree *wt);
=20
+/*
+ * Return the reason string if the given worktree is locked or NULL
+ * otherwise.
+ */
+extern const char *is_worktree_locked(struct worktree *wt);
+
 /*
  * Free up the memory for worktree(s)
  */
--=20
2.8.2.524.g6ff3d78
