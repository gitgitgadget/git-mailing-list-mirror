From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Rosen?= <jeremy.rosen@openwide.fr>
Subject: [PATCH 2/2] git-subtree: use ls-remote to check the refspec passed to pull and add
Date: Wed, 13 Mar 2013 17:17:32 +0100
Message-ID: <1363191452-28804-3-git-send-email-jeremy.rosen@openwide.fr>
References: <1363191452-28804-1-git-send-email-jeremy.rosen@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: greened@obbligato.org, pcampbell@kemitix.net, gitster@pobox.com,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Rosen?= <jeremy.rosen@openwide.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 13 17:20:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFoQ9-00031W-EY
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 17:20:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933782Ab3CMQUS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Mar 2013 12:20:18 -0400
Received: from zimbra3.corp.accelance.fr ([213.162.49.233]:33626 "EHLO
	zimbra3.corp.accelance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933345Ab3CMQUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 12:20:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 7DDFE280A6;
	Wed, 13 Mar 2013 17:20:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f7WMEag3Mvlp; Wed, 13 Mar 2013 17:20:14 +0100 (CET)
Received: from pcrosen.daviel.openwide.fr. (unknown [193.56.60.160])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTPSA id 63972280B0;
	Wed, 13 Mar 2013 17:20:14 +0100 (CET)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1363191452-28804-1-git-send-email-jeremy.rosen@openwide.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218066>

ls-remote is the correct way to check that a parameter is a valid fetch=
able target


Signed-off-by: J=C3=A9r=C3=A9my Rosen <jeremy.rosen@openwide.fr>
---
 contrib/subtree/git-subtree.sh |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtr=
ee.sh
index 8b9d114..61d4eab 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -503,13 +503,8 @@ cmd_add()
=20
 	    "cmd_add_commit" "$@"
 	elif [ $# -eq 2 ]; then
-	    # Technically we could accept a refspec here but we're
-	    # just going to turn around and add FETCH_HEAD under the
-	    # specified directory.  Allowing a refspec might be
-	    # misleading because we won't do anything with any other
-	    # branches fetched via the refspec.
-	    git rev-parse -q --verify "$2^{commit}" >/dev/null ||
-	    die "'$2' does not refer to a commit"
+		git ls-remote --exit-code "$1" "$2" ||
+		die "'$2' is not a correct reference on '$1'"
=20
 	    "cmd_add_repository" "$@"
 	else
@@ -700,6 +695,8 @@ cmd_merge()
 cmd_pull()
 {
 	ensure_clean
+	git ls-remote --exit-code "$1" "$2" ||
+		die "'$2' is not a correct reference on '$1'"
 	git fetch "$@" || exit $?
 	revs=3DFETCH_HEAD
 	set -- $revs
--=20
1.7.10.4
