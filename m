From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH] bisect reset: Allow resetting to any commit, not just a
 branch
Date: Mon, 12 Oct 2009 12:38:49 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0910121237540.2223@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gister@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 12 18:42:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxNyq-0001gi-7Q
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 18:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbZJLQjb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Oct 2009 12:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932833AbZJLQja
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 12:39:30 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:63773 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932775AbZJLQj3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 12:39:29 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n9CGckC8001103;
	Mon, 12 Oct 2009 12:38:47 -0400 (EDT)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n9CGcnqD018596;
	Mon, 12 Oct 2009 12:38:49 -0400 (EDT)
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130031>

=E2=80=98git bisect reset=E2=80=99 could already checkout an arbitrary =
commit if you
were on a detached HEAD before starting the bisection.  This lets you
specify an arbitrary commit to =E2=80=98git bisect reset <commit>=E2=80=
=99.

This also provides a way to clean the bisection state without moving
HEAD: =E2=80=98git bisect reset HEAD=E2=80=99.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 git-bisect.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 6f6f039..d319b9f 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -311,8 +311,7 @@ bisect_reset() {
 	}
 	case "$#" in
 	0) branch=3D$(cat "$GIT_DIR/BISECT_START") ;;
-	1) git show-ref --verify --quiet -- "refs/heads/$1" ||
-	       die "$1 does not seem to be a valid branch"
+	1) git rev-parse --verify "$1^{commit}" || exit
 	   branch=3D"$1" ;;
 	*)
 	    usage ;;
--=20
1.6.5
