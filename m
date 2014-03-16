From: ubuntu2012@126.com
Subject: [PATCH] Rewrite the diff-no-index.c
Date: Sun, 16 Mar 2014 20:44:18 +0800
Message-ID: <1394973858-16505-1-git-send-email-ubuntu2012@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=E6=B2=88=E6=89=BF=E6=81=A9?= <ubuntu2012@126.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 16 14:15:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPAuw-0004LK-0p
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 14:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbaCPNPZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Mar 2014 09:15:25 -0400
Received: from m15-114.126.com ([220.181.15.114]:49433 "EHLO m15-114.126.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbaCPNPY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 09:15:24 -0400
X-Greylist: delayed 1858 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Mar 2014 09:15:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6g1C4
	RZ2TZlebU1fcJe25PcfqdCGqy46uCeQdVIAUfE=; b=NoTAi8roLfihkmzlJWI2R
	ovIwL9GbZokYeCp9ekMdZrao/oNO2BlWNmKTa0x3cMrEgUn9xCxtMIPbK6vgwgHG
	L3bi4xMmEaDze7IvJlCSjJCIzIjAiz1m2mWjXvOqX9P7XJiHjLybHKs2z41kxjU5
	9kbxEFoc1NnDokZcfvxZB0=
Received: from localhost (unknown [182.148.251.140])
	by smtp7 (Coremail) with SMTP id DsmowEAp90KjnCVTvS0NAQ--.923S2;
	Sun, 16 Mar 2014 20:44:19 +0800 (CST)
X-Mailer: git-send-email 1.7.9.5
X-CM-TRANSID: DsmowEAp90KjnCVTvS0NAQ--.923S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw17WF1xJr4DZw4DCF15Jwb_yoW8Cr4UpF
	s3Cw1YkrW8JF43u3s7XF47CwnxK3yqgr4xCrW8u3s8Zr1ag3yUXFWFgF1akF15GrZ8u347
	uF4YqrnYva15Cr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UbAw-UUUUU=
X-Originating-IP: [182.148.251.140]
X-CM-SenderInfo: hxex03jxsqija6rslhhfrp/1tbicwRQqFD61PaidgAAsT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244193>

=46rom: =E6=B2=88=E6=89=BF=E6=81=A9 <ubuntu2012@126.com>

I am sorry for that I send this agian.Last patch I have some error.(May=
be this time will like the previous).It is apply for GSOC

Signed-off-by: =E6=B2=88=E6=89=BF=E6=81=A9 <ubuntu2012@126.com>
---
 diff-no-index.c |    5 +++--
 dir.h           |    3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 8e10bff..1fb0c0f 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -3,13 +3,14 @@
  * Copyright (c) 2007 by Johannes Schindelin
  * Copyright (c) 2008 by Junio C Hamano
  */
-
+#define EXIT
 #include "cache.h"
 #include "color.h"
 #include "commit.h"
 #include "blob.h"
 #include "tag.h"
 #include "diff.h"
+#include "dir.h"
 #include "diffcore.h"
 #include "revision.h"
 #include "log-tree.h"
@@ -25,7 +26,7 @@ static int read_directory(const char *path, struct st=
ring_list *list)
 		return error("Could not open directory %s", path);
=20
 	while ((e =3D readdir(dir)))
-		if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
+		if (is_dot_or_dotdot(e->d_name))
 			string_list_insert(list, e->d_name);
=20
 	closedir(dir);
diff --git a/dir.h b/dir.h
index 55e5345..c0e45c8 100644
--- a/dir.h
+++ b/dir.h
@@ -138,8 +138,9 @@ extern int match_pathspec(const struct pathspec *pa=
thspec,
 extern int within_depth(const char *name, int namelen, int depth, int =
max_depth);
=20
 extern int fill_directory(struct dir_struct *dir, const struct pathspe=
c *pathspec);
+#ifndef EXIT
 extern int read_directory(struct dir_struct *, const char *path, int l=
en, const struct pathspec *pathspec);
-
+#endif
 extern int is_excluded_from_list(const char *pathname, int pathlen, co=
nst char *basename,
 				 int *dtype, struct exclude_list *el);
 struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *=
pathname, int len);
--=20
1.7.9.5
