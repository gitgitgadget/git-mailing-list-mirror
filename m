From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH QGit] Fix compiler warning due to ambiguous 'else'
Date: Fri, 12 Jun 2009 14:07:55 +0200
Message-ID: <1244808481-13012-1-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 14:09:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF5ZZ-0007bq-BS
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 14:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334AbZFLMJU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2009 08:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754016AbZFLMJT
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 08:09:19 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:55981 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541AbZFLMJR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 08:09:17 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id D86EA102F0F1A;
	Fri, 12 Jun 2009 14:08:11 +0200 (CEST)
Received: from [89.59.124.123] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MF5YJ-0007lD-00; Fri, 12 Jun 2009 14:08:11 +0200
X-Mailer: git-send-email 1.6.3.2.236.ge505d
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19ZSr6TposHQpaLJ2K+GrFXq6AEkAO9MNpEZyze
	dzHeib/wVTzjQSN09fZ7PxRrx83yJHkiyHJt/FsBcfxb2Q+gj7
	9TlKGh84vBlOdzFxyT8Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121414>

g++ 4.3.2 produced the following warning:

treeview.cpp: In member function =E2=80=98void TreeView::updateTree()=E2=
=80=99:
treeview.cpp:221: warning: suggest explicit braces to avoid ambiguous =E2=
=80=98else=E2=80=99

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 src/treeview.cpp |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/treeview.cpp b/src/treeview.cpp
index 346c577..d391a32 100644
--- a/src/treeview.cpp
+++ b/src/treeview.cpp
@@ -222,7 +222,7 @@ void TreeView::updateTree() {
 	    && treeIsValid
 	    && root
 	    && st->sha() !=3D QGit::ZERO_SHA
-	    && root->treeSha !=3D QGit::ZERO_SHA)
+	    && root->treeSha !=3D QGit::ZERO_SHA) {
 		// root->treeSha could reference a different sha from current
 		// one in case the tree is the same, i.e. has the same files.
 		// so we prefer to use the previous state sha to call isSameFiles()
@@ -233,6 +233,7 @@ void TreeView::updateTree() {
 			newTree =3D !git->isSameFiles(st->sha(false), st->sha(true));
 		else
 			newTree =3D !git->isSameFiles(root->treeSha, st->sha(true));
+	}
=20
 	if (newTree) // ok, we really need to update the tree
 		setTree(st->sha());
--=20
1.6.3.2.236.ge505d
