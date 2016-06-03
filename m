From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 1/6] worktree.c: add find_worktree()
Date: Fri,  3 Jun 2016 19:19:39 +0700
Message-ID: <20160603121944.28980-2-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Fri Jun 03 14:20:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8o5Q-0002wQ-9J
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 14:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbcFCMUS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 08:20:18 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35815 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbcFCMUN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 08:20:13 -0400
Received: by mail-pf0-f193.google.com with SMTP id f144so11467659pfa.2
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 05:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YeHR/L++LvGTztYBKbT5VyyD2p14loT15AZk5ah3Hjg=;
        b=ddTcgvYDqw6bffPd3U+45TAR+k/HDK5u3xTKyQrgZKfDH9FJAv9ALm0rdCgWbrw0gq
         gHVgAQcAJOMyWTN42DtmoFZe+4wTi6XxKOlOlCq8aBajQLiB4Cy9o5OPT8TVB88zgnre
         49aj8RtiEakZufhSWBc+0ycQa9gcOC9IemrndlZH8J24ws191lx0xVhH9SeWucSHOMAn
         t4+fCzEPGi/9ya0C036ngGbBmb+FJ9U/ydaDDTHy0Z9+TjSfNKz6Jfe6QGM3oxzoyJsV
         9VY5bnc8J9JPhbIU31KL5rjilUZg1U0oMbYI76XtUNMESty2U74qkljimT26hQ6/4LRg
         iQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YeHR/L++LvGTztYBKbT5VyyD2p14loT15AZk5ah3Hjg=;
        b=WCySjrirlDFdvQkzWmUGI8UOGtHtY9cFgHBjeNGWhbDeCgm9qg/GbcLavyo/CVMGVi
         D6dZYWU2w2OXqmG4Eyh/3QXYOv6jz9BCyZw4p9+fjf1hOiP0qlcFLZzqDy4ciGNGdJWR
         lp1F/pSoAqoaL7OfMGf1RV1vuPXjNbP5cAgJu7POsHh5G0TIvoamimo5kGR18MUOMuGZ
         4tjEPqFBxM+850/ov5y/gfmoQzVkb+/calvIJjEbyCYBH9/bq3PeYcVEFv9XV0JAYmxD
         ORdjjvojNiMFDDpDYQiw9qXMzNYXoXxDQfI9F80XdxwNXRui8vuDbrf2xLte+2HKsPgE
         J8rg==
X-Gm-Message-State: ALyK8tLOoaGbX1t52ttMbwXrcWbtYum/yDyTl9XTxb2ddSPt/LwSWbvl4+oJ92Zgk5ewFg==
X-Received: by 10.98.102.154 with SMTP id s26mr5841914pfj.41.1464956412218;
        Fri, 03 Jun 2016 05:20:12 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id 17sm8084523pfj.96.2016.06.03.05.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jun 2016 05:20:11 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 03 Jun 2016 19:20:06 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160603121944.28980-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296308>

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
index e2a94e0..554f566 100644
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
