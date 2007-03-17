From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [PATCH] calculate the maximal number of revisions to test
Date: Sat, 17 Mar 2007 15:12:09 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070317141209.GA7838@cepheus>
References: <Pine.LNX.4.63.0703170139110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 15:12:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSZdy-0006j8-60
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 15:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965569AbXCQOMP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 17 Mar 2007 10:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965565AbXCQOMP
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 10:12:15 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:48981 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965569AbXCQOMO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2007 10:12:14 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HSZdk-0003QO-MO
	for git@vger.kernel.org; Sat, 17 Mar 2007 15:12:12 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l2HECA9k012922
	for <git@vger.kernel.org>; Sat, 17 Mar 2007 15:12:10 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l2HECAg7012921
	for git@vger.kernel.org; Sat, 17 Mar 2007 15:12:10 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703170139110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42434>

Up to now the number printed was correct given that the current revisio=
n to
test is bad.

Moreover I think the number printed was always one to high, this is fix=
ed, too.

Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>
---
 git-bisect.sh |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index b1c3a6b..a5b4fdd 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -150,8 +150,14 @@ bisect_next() {
 	    git-diff-tree --pretty $rev
 	    exit 0
 	fi
-	nr=3D$(eval "git-rev-list $rev $good -- $(cat $GIT_DIR/BISECT_NAMES)"=
 | wc -l) || exit
-	echo "Bisecting: $nr revisions left to test after this"
+	nr_bad=3D$(eval "git-rev-list $rev^ $good -- $(cat $GIT_DIR/BISECT_NA=
MES)" | wc -l) || exit
+	nr_good=3D$(eval "git-rev-list $bad^ ^$rev $good -- $(cat $GIT_DIR/BI=
SECT_NAMES)" | wc -l) || exit
+	if test "$nr_bad" -ge "$nr_good"; then
+		nr=3D"$nr_bad";
+	else
+		nr=3D"$nr_good";
+	fi;
+	echo "Bisecting: maximal $nr revisions left to test after this"
 	echo "$rev" > "$GIT_DIR/refs/heads/new-bisect"
 	git checkout -q new-bisect || exit
 	mv "$GIT_DIR/refs/heads/new-bisect" "$GIT_DIR/refs/heads/bisect" &&
--=20
1.5.0.2.260.g2eb065


--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3DPlanck%27s+constant%3D
