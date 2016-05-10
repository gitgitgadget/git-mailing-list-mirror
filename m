From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/5] worktree.c: add find_worktree_by_path()
Date: Tue, 10 May 2016 21:17:25 +0700
Message-ID: <20160510141729.23063-1-pclouds@gmail.com>
References: <20160510141416.GA22672@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 16:17:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b08Tn-0000DE-W5
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 16:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbcEJORj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 10:17:39 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36039 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbcEJORj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 10:17:39 -0400
Received: by mail-pa0-f68.google.com with SMTP id i5so998818pag.3
        for <git@vger.kernel.org>; Tue, 10 May 2016 07:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dRWyYysnroZbW6P6qb79lQvLROC0N9HIegL4KY0t+cA=;
        b=JihqUsS20QZzfGP0YwKwLhxdbn8sblUC+7qa/orZPkP4F4sIR9is4Tz7aslSGu3vzQ
         QSA2ZqbExdxff8ZchfM/nc1PzMDSLL6N4TG1Itxqoyx6o7VhQ2miEgNaBwiYoWuabBx7
         Dxv+AR1F/iboi5VeqN/l+8cox4ehHpO+qk8j3EXvPHQEMN9MB18h+xw8hj406nNx2327
         ENvyl4F5dVGQNII6K3g2X3xYwjHLvEzzfb6RApG7YYpWPJt2xkfUe+W2e8L/JgQhqATs
         DNagrWRx/SKPLGBf+KeukoGlCg+8lSaiQC9do4uiyohYSgnu5lcS3Fct1UjSuQbVW1mc
         7YZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dRWyYysnroZbW6P6qb79lQvLROC0N9HIegL4KY0t+cA=;
        b=RGgdcRefl1Qt+TzfSkNVuCpul1gsNmdYDWW4Nt4HDNu4LzA46cvMc+We8xreOmstTL
         h4s6BTbzFY95J0tZI59SYEBm9/pj4bgqTZKTPe8IFjcMuKnxPHWNOx3qb3CXued8t8Rt
         i5o53cAG9A5iG/LJny6FOJE49/DVYG8tD26EX9PTvcTBYI2k0QKdGJ6XALETsskWwldd
         SHeSuEkcAR1VGLUcqgXT1rOGx/YdZUkzYhLqshSUPtGXsxwINPdIRv3082bW9nCxexCq
         p8cNdMzoj441IEKrQsWV/z1MdiV9N71JVngbTwKAIGoFW8yhdoCjSNAOMToAwISx701F
         8kNQ==
X-Gm-Message-State: AOPr4FWPgvAd85APk3ZbxpVz7nE6za6MQWKhkq8P7I73lWikYK0dKjvO1F9yyuCj357hIA==
X-Received: by 10.66.156.232 with SMTP id wh8mr58937000pab.153.1462889858350;
        Tue, 10 May 2016 07:17:38 -0700 (PDT)
Received: from lanh ([115.76.164.133])
        by smtp.gmail.com with ESMTPSA id dr4sm5001605pac.11.2016.05.10.07.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2016 07:17:37 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 10 May 2016 21:17:40 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160510141416.GA22672@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294143>

So far we haven't needed to identify an existing worktree from command
line. Future commands such as lock or move will need it. There are of
course other options for identifying a worktree, for example by branch
or even by internal id. They may be added later if proved useful.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 16 ++++++++++++++++
 worktree.h |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/worktree.c b/worktree.c
index 335c58f..a6d1ad1 100644
--- a/worktree.c
+++ b/worktree.c
@@ -222,6 +222,22 @@ const char *get_worktree_git_dir(const struct work=
tree *wt)
 		return git_common_path("worktrees/%s", wt->id);
 }
=20
+struct worktree *find_worktree_by_path(struct worktree **list,
+				       const char *path_)
+{
+	char *path =3D xstrdup(real_path(path_));
+	struct worktree *wt =3D NULL;
+
+	while (*list) {
+		wt =3D *list++;
+		if (!fspathcmp(path, real_path(wt->path)))
+			break;
+		wt =3D NULL;
+	}
+	free(path);
+	return wt;
+}
+
 int is_worktree_being_rebased(const struct worktree *wt,
 			      const char *target)
 {
diff --git a/worktree.h b/worktree.h
index 7430a4e..7775d1b 100644
--- a/worktree.h
+++ b/worktree.h
@@ -29,6 +29,12 @@ extern struct worktree **get_worktrees(void);
  */
 extern const char *get_worktree_git_dir(const struct worktree *wt);
=20
+/*
+ * Search a worktree by its path. Paths are normalized internally.
+ */
+extern struct worktree *find_worktree_by_path(struct worktree **list,
+					      const char *path_);
+
 /*
  * Free up the memory for worktree
  */
--=20
2.8.2.524.g6ff3d78
