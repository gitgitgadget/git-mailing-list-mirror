From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH v2 03/13] Move cleanup code into it's own function
Date: Mon, 14 Apr 2008 02:20:59 +0200
Message-ID: <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 02:53:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlCww-0004J2-QF
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 02:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830AbYDNAwH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2008 20:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753924AbYDNAwG
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 20:52:06 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1639 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753617AbYDNAv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 20:51:56 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 8ED644880A2; Mon, 14 Apr 2008 02:51:54 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCRZ-0006IJ-Ra; Mon, 14 Apr 2008 02:21:10 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCRZ-0006tX-AS; Mon, 14 Apr 2008 02:21:09 +0200
X-Mailer: git-send-email 1.5.5
In-Reply-To: <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79437>


Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 git-rebase--interactive.sh |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 8aa7371..531ee94 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -104,8 +104,12 @@ die_with_patch () {
 	die "$2"
 }
=20
-die_abort () {
+cleanup_before_quit () {
 	rm -rf "$DOTEST"
+}
+
+die_abort () {
+	cleanup_before_quit
 	die "$1"
 }
=20
@@ -352,7 +356,7 @@ do_next () {
 		test ! -f "$DOTEST"/verbose ||
 			git diff-tree --stat $(cat "$DOTEST"/head)..HEAD
 	} &&
-	rm -rf "$DOTEST" &&
+	cleanup_before_quit &&
 	git gc --auto &&
 	warn "Successfully rebased and updated $HEADNAME."
=20
@@ -414,7 +418,7 @@ do
 			;;
 		esac &&
 		output git reset --hard $HEAD &&
-		rm -rf "$DOTEST"
+		cleanup_before_quit
 		exit
 		;;
 	--skip)
--=20
1.5.5
