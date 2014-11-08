From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 17/22] status: enable untracked cache
Date: Sat,  8 Nov 2014 16:39:50 +0700
Message-ID: <1415439595-469-18-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
 <1415439595-469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 10:41:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn2WN-0001di-7Q
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 10:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685AbaKHJlT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2014 04:41:19 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:38809 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680AbaKHJlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 04:41:16 -0500
Received: by mail-pa0-f47.google.com with SMTP id kx10so5041583pab.6
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 01:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RmCktpphx/Kezb97AiLw//yzuNHlrRvMwaYhQI0uCP8=;
        b=vFf0nBLHDfEhQYCnMLVKx0vpqGsf4Oh8QPcE3GsrFVtAKmUQilDFUYWduQ/nt+JoA8
         zIn6q+LqaX+xQFt3r+QjKTVe3TGXK+jRcUC6LMdXepzvO3mQ4oJRiRmYDpOtSykf8KcE
         JmIVlSRzwT8cvb/e5wv+B4IFWNx56LM8F2YGB77ITGtYkA7DyBwx6Ow9NSA+NUHuHnIU
         rk+08vg5P1gVxiJXV8IIjdlTJ/HpOS+1cjvIAPD+rGPfA+CEudXrZbcaS9OtjQmHe0lc
         YaNm2VJyWN3t8EXZLs0lNJrsMlCh5THsnW0OXCaBADhPsMtOhhbiWObgpRv3PlZB49/J
         5vJA==
X-Received: by 10.66.162.37 with SMTP id xx5mr18335142pab.10.1415439676262;
        Sat, 08 Nov 2014 01:41:16 -0800 (PST)
Received: from lanh ([115.73.197.54])
        by mx.google.com with ESMTPSA id pg2sm11000480pbb.43.2014.11.08.01.41.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Nov 2014 01:41:15 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Nov 2014 16:41:30 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1415439595-469-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

update_index_if_able() is moved down so that the updated untracked
cache could be written out.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c | 5 +++--
 wt-status.c      | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 5ed6036..bdcfa61 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1372,13 +1372,14 @@ int cmd_status(int argc, const char **argv, con=
st char *prefix)
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, &s.pathspec=
, NULL, NULL);
=20
 	fd =3D hold_locked_index(&index_lock, 0);
-	if (0 <=3D fd)
-		update_index_if_able(&the_index, &index_lock);
=20
 	s.is_initial =3D get_sha1(s.reference, sha1) ? 1 : 0;
 	s.ignore_submodule_arg =3D ignore_submodule_arg;
 	wt_status_collect(&s);
=20
+	if (0 <=3D fd)
+		update_index_if_able(&the_index, &index_lock);
+
 	if (s.relative_paths)
 		s.prefix =3D prefix;
=20
diff --git a/wt-status.c b/wt-status.c
index 27da529..8880c3b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -585,6 +585,8 @@ static void wt_status_collect_untracked(struct wt_s=
tatus *s)
 			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
 	if (s->show_ignored_files)
 		dir.flags |=3D DIR_SHOW_IGNORED_TOO;
+	else
+		dir.untracked =3D the_index.untracked;
 	setup_standard_excludes(&dir);
=20
 	fill_directory(&dir, &s->pathspec);
--=20
2.1.0.rc0.78.gc0d8480
