From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 1/6] worktree.c: add find_worktree()
Date: Mon, 13 Jun 2016 19:18:21 +0700
Message-ID: <20160613121826.21631-2-pclouds@gmail.com>
References: <20160603121944.28980-1-pclouds@gmail.com>
 <20160613121826.21631-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 14:19:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCQpp-0004My-NU
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 14:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbcFMMTI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2016 08:19:08 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36316 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964790AbcFMMTG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 08:19:06 -0400
Received: by mail-pa0-f66.google.com with SMTP id fg1so10432126pad.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 05:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W8bXN8GZkAi/t1eYiOQT+/TpSMPlOM34zPHzwc7h1Xg=;
        b=hYAQSXMq/NIl0UNbEADsfuE+sZyrHJ1pk6TeZc6ItHeUzAIuW9KH+LZpwVBa5TcPLG
         t8BQChQeRCN9CZqAgz6YTA/LjRFYlGwhLxcvtNhjCNiNHTXqP9DRMX4Zq0P8YEZYNcEF
         swa3ziOR/nnX5qnOMZLc25wboXpaL4/W2vIQ7fJNUWoW6K8YHvRkOFv2dYxB/jSrodj0
         2QkC7gYkeNg07oYxgzxN4/M+CvG9+QkLkb9A8xkDfJX6r15FIyskAGnnbK9XEV5T20Jt
         W4fdn+9ud+JZO329tau3CCHI1EfOHnbvVhjjPoLEDH4+Za5q6PKNUZSYiGsNH8uqz/TE
         O0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W8bXN8GZkAi/t1eYiOQT+/TpSMPlOM34zPHzwc7h1Xg=;
        b=PcKhS3CiPm1vOGZax0QizeREk8q+tt13A6wQDHTi09+Ut5YJy8c8avWah+m0jnUdDd
         QByrZ6byxn933Iwge1LTz3Yr3v6vhn0Lm3IvUHCjykKWX+3NTYKHWIVVHgNDubrVE7y6
         CvAmwfyahSiEEzsS80he9NpzhCjoBPafxQ1a+HaIQr+6Ld+nmqCQC24XTBuIQPc1ArpW
         X+myNDXIjM5Dng9AX23rWtYyqMhv5ls+0QT+3rBQbZQF9Zg+/AIbqWHLa/BKKAj8ml2H
         Rz9n/b+OSO0Kk6V5B4qQiWhnB0V7PmalniSlJosIXx438MJ25Dz1RTa23XdZJZ1uY1HN
         R4mA==
X-Gm-Message-State: ALyK8tKtRnmf0bgnx4Eh18cYtvvG4piXCNZiIpE50dDlgpHd0CDOvuxPAtdbcPuP34rCMA==
X-Received: by 10.66.132.103 with SMTP id ot7mr21902039pab.60.1465820345668;
        Mon, 13 Jun 2016 05:19:05 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id 7sm8139944pfa.28.2016.06.13.05.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jun 2016 05:19:04 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 13 Jun 2016 19:19:01 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160613121826.21631-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297181>

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
