From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Rosen?= <jeremy.rosen@openwide.fr>
Subject: [PATCH 1/2] git-subtree: make sure the SHA saved as ancestor is a commit
Date: Wed, 13 Mar 2013 17:17:31 +0100
Message-ID: <1363191452-28804-2-git-send-email-jeremy.rosen@openwide.fr>
References: <1363191452-28804-1-git-send-email-jeremy.rosen@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: greened@obbligato.org, pcampbell@kemitix.net, gitster@pobox.com,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Rosen?= <jeremy.rosen@openwide.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 13 17:20:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFoQ8-00031W-V4
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 17:20:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933884Ab3CMQUS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Mar 2013 12:20:18 -0400
Received: from zimbra3.corp.accelance.fr ([213.162.49.233]:33617 "EHLO
	zimbra3.corp.accelance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932610Ab3CMQUP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 12:20:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 83DE3280B1;
	Wed, 13 Mar 2013 17:20:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0O4QHMZ5BTQv; Wed, 13 Mar 2013 17:20:13 +0100 (CET)
Received: from pcrosen.daviel.openwide.fr. (unknown [193.56.60.160])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTPSA id 2AC62280A6;
	Wed, 13 Mar 2013 17:20:13 +0100 (CET)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1363191452-28804-1-git-send-email-jeremy.rosen@openwide.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218065>

When adding or merging the first parameter might not be a commit, it ca=
n also be a tag SHA.
This needs to be fixed by using the underlying commit or the ancestor f=
inding code will croak at split time


Signed-off-by: J=C3=A9r=C3=A9my Rosen <jeremy.rosen@openwide.fr>
---
 contrib/subtree/git-subtree.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtr=
ee.sh
index 8a23f58..8b9d114 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -531,7 +531,7 @@ cmd_add_repository()
=20
 cmd_add_commit()
 {
-	revs=3D$(git rev-parse $default --revs-only "$@") || exit $?
+	revs=3D$(git rev-parse $default --revs-only "$1^{commit}") || exit $?
 	set -- $revs
 	rev=3D"$1"
 =09
@@ -655,7 +655,7 @@ cmd_split()
=20
 cmd_merge()
 {
-	revs=3D$(git rev-parse $default --revs-only "$@") || exit $?
+	revs=3D$(git rev-parse $default --revs-only "$1^{commit}") || exit $?
 	ensure_clean
 =09
 	set -- $revs
--=20
1.7.10.4
