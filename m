From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 1/1] lockfile.c: store absolute path
Date: Sat,  6 Sep 2014 12:31:29 +0200
Message-ID: <1409999489-25193-2-git-send-email-mhagger@alum.mit.edu>
References: <1409999489-25193-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Yue Lin Ho <yuelinho777@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 12:31:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQDHf-0000cH-65
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 12:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbaIFKbt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Sep 2014 06:31:49 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:60427 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751156AbaIFKbq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 06:31:46 -0400
X-AuditID: 1207440f-f79156d000006a5c-1f-540ae2923a3d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 58.3D.27228.292EA045; Sat,  6 Sep 2014 06:31:46 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s86AVdBU013096
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 06:31:44 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409999489-25193-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsUixO6iqDvpEVeIwYc3HBZdV7qZLBp6rzBb
	PJl7l9ni9or5zBbdU94yWuyetoDNom3nESYHdo+/7z8weeycdZfd4+GrLnaPi5eUPR5PPMHq
	8XmTXABbFLdNUmJJWXBmep6+XQJ3xoRJM9gK9ohVPNjbxdrAuF+oi5GDQ0LAROLi+fQuRk4g
	U0ziwr31bF2MXBxCApcZJf6s72aBcI4xSbx4N5MFpIpNQFdiUU8zE4gtIqAmMbHtEFgRs8Ai
	Jokli7vAEsIC5hKfrr8Ea2ARUJXY8XMrWJxXwEWis+UFG8Q6OYkNu/8zgticAq4Sh/dPZAWx
	hYBq2o5+ZYSoF5Q4OfMJC8ilzALqEuvnCYGEmQXkJZq3zmaewCgwC0nVLISqWUiqFjAyr2KU
	S8wpzdXNTczMKU5N1i1OTszLSy3SNdHLzSzRS00p3cQICX/+HYxd62UOMQpwMCrx8BY4cIUI
	sSaWFVfmHmKU5GBSEuVVuQ0U4kvKT6nMSCzOiC8qzUktPsQowcGsJMLbMRkox5uSWFmVWpQP
	k5LmYFES51Vfou4nJJCeWJKanZpakFoEk5Xh4FCS4E17CNQoWJSanlqRlplTgpBm4uAEGc4l
	JVKcmpeSWpRYWpIRD4rT+GJgpIKkeID2fngAsre4IDEXKArReopRl2Nd57d+JiGWvPy8VClx
	3qsgOwRAijJK8+BWwJLdK0ZxoI+FefeCjOIBJkq4Sa+AljABLTFP5wRZUpKIkJJqYGRlbQ9+
	/IrzkVX1p89XWB8+6Wyp/dy0bKHx8dvsK6uOHX4TMcHrw9WbjGyWoaKTowyWXHhh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256585>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Locked paths can be saved in a linked list so that if something wrong
happens, *.lock are removed. For relative paths, this works fine if we
keep cwd the same, which is true 99% of time except:

- update-index and read-tree hold the lock on $GIT_DIR/index really
  early, then later on may call setup_work_tree() to move cwd.

- Suppose a lock is being held (e.g. by "git add") then somewhere
  down the line, somebody calls real_path (e.g. "link_alt_odb_entry"),
  which temporarily moves cwd away and back.

During that time when cwd is moved (either permanently or temporarily)
and we decide to die(), attempts to remove relative *.lock will fail,
and the next operation will complain that some files are still locked.

Avoid this case by turning relative paths to absolute before storing
the path in "filename" field.

Reported-by: Yue Lin Ho <yuelinho777@gmail.com>
Helped-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Adapted-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c                    | 14 +++++++++++---
 t/t2107-update-index-basic.sh | 15 +++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index e54d260..31b63bb 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -172,9 +172,17 @@ static int lock_file(struct lock_file *lk, const c=
har *path, int flags)
 		lock_file_list =3D lk;
 	}
=20
-	strbuf_addstr(&lk->filename, path);
-	if (!(flags & LOCK_NODEREF))
-		resolve_symlink(&lk->filename);
+	if (flags & LOCK_NODEREF) {
+		strbuf_add_absolute_path(&lk->filename, path);
+	} else {
+		struct strbuf resolved_path =3D STRBUF_INIT;
+
+		strbuf_addstr(&resolved_path, path);
+		resolve_symlink(&resolved_path);
+		strbuf_add_absolute_path(&lk->filename, resolved_path.buf);
+		strbuf_release(&resolved_path);
+	}
+
 	strbuf_addstr(&lk->filename, LOCK_SUFFIX);
 	lk->fd =3D open(lk->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (lk->fd < 0) {
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic=
=2Esh
index 1bafb90..dfe02f4 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -65,4 +65,19 @@ test_expect_success '--cacheinfo mode,sha1,path (new=
 syntax)' '
 	test_cmp expect actual
 '
=20
+test_expect_success '.lock files cleaned up' '
+	mkdir cleanup &&
+	(
+	cd cleanup &&
+	mkdir worktree &&
+	git init repo &&
+	cd repo &&
+	git config core.worktree ../../worktree &&
+	# --refresh triggers late setup_work_tree,
+	# active_cache_changed is zero, rollback_lock_file fails
+	git update-index --refresh &&
+	! test -f .git/index.lock
+	)
+'
+
 test_done
--=20
2.1.0
