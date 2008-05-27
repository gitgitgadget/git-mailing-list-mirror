From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] commit --interactive: properly update the index before
	commiting
Date: Tue, 27 May 2008 08:59:16 +0000
Message-ID: <20080527085916.23645.qmail@8ea7804c723d58.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 27 11:03:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0v2P-0001g7-NH
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 11:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756665AbYE0I7S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 May 2008 04:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756677AbYE0I7S
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 04:59:18 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:43907 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756405AbYE0I7S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 04:59:18 -0400
Received: (qmail 23646 invoked by uid 1000); 27 May 2008 08:59:16 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82996>

When adding files through git commit --interactive, and 'quit'
afterwards, the message in the editor of the commit message indicates
that many (maybe all) files are deleted from the tree.  Dismissing that
and running git commit afterwards does the right thing.  This commit
fixes git commit --interactive to properly update the index before
commiting.

Reported by Ji=C5=99=C3=AD Pale=C4=8Dek through
 http://bugs.debian.org/480429

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 builtin-commit.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 07872c8..b294c1f 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -223,6 +223,8 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix)
=20
 	if (interactive) {
 		interactive_add(argc, argv, prefix);
+		if (read_cache() < 0)
+			die("index file corrupt");
 		commit_style =3D COMMIT_AS_IS;
 		return get_index_file();
 	}
--=20
1.5.5.1
