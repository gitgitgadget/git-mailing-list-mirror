From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 1/6] worktree.c: add find_worktree()
Date: Mon, 30 May 2016 17:49:34 +0700
Message-ID: <20160530104939.28407-2-pclouds@gmail.com>
References: <20160522104341.656-1-pclouds@gmail.com>
 <20160530104939.28407-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 12:50:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7Km4-0005G2-5I
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 12:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709AbcE3KuO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2016 06:50:14 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35532 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754616AbcE3KuN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 06:50:13 -0400
Received: by mail-pa0-f65.google.com with SMTP id gp3so14306283pac.2
        for <git@vger.kernel.org>; Mon, 30 May 2016 03:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W8bXN8GZkAi/t1eYiOQT+/TpSMPlOM34zPHzwc7h1Xg=;
        b=AR5lewK7+X+RWpMYGEp1f0L5oEoe2yEErqgJH8wbxyDwfOzFZVsTDY3D+fgGs4un0X
         IjFvWUlO40qnC/4A90pByfdOjsSqAovAw5oo6Kus6Vp1JNp6bzb0hPithDEfcFINOFm4
         C2cJjx4RgoueIjzjPm9ZSezYREfNHJMvtEzeMOW4DE609dj5eNmKde2kY6rz09QpAqYC
         CaMmnMZSbHU65vz8yV6zlbwPagrbCZvs6gaGs4YOPQvLGZ8NNz+hV58bX6O4Dt0MwcEG
         0rfmpIVakLNc2kt1AsdUt06DJ+MZ/a783E5KgDuiH3nbGOLa7wQ8yKcP4DPPpA6BX9q5
         XoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W8bXN8GZkAi/t1eYiOQT+/TpSMPlOM34zPHzwc7h1Xg=;
        b=HW2tZzCIrywbgVEFwYkkd5zwLW2+MVfIfapIe4T1fDrkueEbwDuBU358quv/iQL1ZE
         vRigaDu1vHfy90b6+jiKkLFg1BlLqp/cvEb2wUE1O+waSpoJ61YpEisE7NB1kFLhWN8C
         jgCBt8gL2OC/DL+UE4w8zoK5cmdPnOX9w/ZM7pSQrwTr8gvsKM2/QavGf3fQQyU2+WLj
         2jgw6fVyGL2xKdG/TU24KJEqxgCmFC0acP1Z5Er8tP2eeK1RPB73uFf/FJig1dldp09q
         GQRJGAhGxHnfF3uGbHiXLfGYtFcfzPhlDIHy4UcR2IGXVJ/NB71axrKYJ7yiaTNOZbTJ
         mk3w==
X-Gm-Message-State: ALyK8tJC2LmBusvKQrp//gJRUf1CdLssasc+uFij+iGmy0CMbOODjnDOpH4BU/IXF1irrA==
X-Received: by 10.66.141.76 with SMTP id rm12mr45641357pab.129.1464605412106;
        Mon, 30 May 2016 03:50:12 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id kb15sm46587706pad.28.2016.05.30.03.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 May 2016 03:50:11 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 30 May 2016 17:50:06 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160530104939.28407-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295880>

So far we haven't needed to identify an existing worktree from command
line. Future commands such as lock or move will need it. The current
implementation identifies worktrees by path (*). In future, the functio=
n
could learn to identify by $(basename $path) or tags...

(*) We could probably go cheaper with comparing inode number (and
probably more reliable than paths when unicode enters the game). But no=
t
all systems have good inode that so let's stick to something simple for
now.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 15 +++++++++++++++
 worktree.h |  8 ++++++++
 2 files changed, 23 insertions(+)

diff --git a/worktree.c b/worktree.c
index f4a4f38..0782e00 100644
--- a/worktree.c
+++ b/worktree.c
@@ -214,6 +214,21 @@ const char *get_worktree_git_dir(const struct work=
tree *wt)
 		return git_common_path("worktrees/%s", wt->id);
 }
=20
+struct worktree *find_worktree(struct worktree **list,
+			       const char *prefix,
+			       const char *arg)
+{
+	char *path;
+
+	arg =3D prefix_filename(prefix, strlen(prefix), arg);
+	path =3D xstrdup(real_path(arg));
+	for (; *list; list++)
+		if (!fspathcmp(path, real_path((*list)->path)))
+			break;
+	free(path);
+	return *list;
+}
+
 int is_worktree_being_rebased(const struct worktree *wt,
 			      const char *target)
 {
diff --git a/worktree.h b/worktree.h
index 1394909..7ad15da 100644
--- a/worktree.h
+++ b/worktree.h
@@ -29,6 +29,14 @@ extern struct worktree **get_worktrees(void);
  */
 extern const char *get_worktree_git_dir(const struct worktree *wt);
=20
+/*
+ * Search a worktree that can be unambiguously identified by
+ * "arg". "prefix" must not be NULL.
+ */
+extern struct worktree *find_worktree(struct worktree **list,
+				      const char *prefix,
+				      const char *arg);
+
 /*
  * Free up the memory for worktree(s)
  */
--=20
2.8.2.524.g6ff3d78
