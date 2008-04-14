From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH v2 02/13] Don't append default merge message to -m message
Date: Mon, 14 Apr 2008 02:20:58 +0200
Message-ID: <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 02:52:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlCw8-00049R-JT
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 02:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833AbYDNAv7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2008 20:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753001AbYDNAv5
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 20:51:57 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1627 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753251AbYDNAvy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 20:51:54 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 654BD48809E; Mon, 14 Apr 2008 02:51:53 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCRZ-0006IH-Fy; Mon, 14 Apr 2008 02:21:09 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCRZ-0006tQ-55; Mon, 14 Apr 2008 02:21:09 +0200
X-Mailer: git-send-email 1.5.5
In-Reply-To: <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79436>

Picked from <7vabko3dm2.fsf@gitster.siamese.dyndns.org>
=46rom: gitster@pobox.com (Junio C Hamano)
Date: Sun, 23 Mar 2008 22:17:09 -0700

Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 git-merge.sh |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 7dbbb1d..bd9699d 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -250,17 +250,19 @@ else
 	# We are invoked directly as the first-class UI.
 	head_arg=3DHEAD
=20
-	# All the rest are the commits being merged; prepare
-	# the standard merge summary message to be appended to
-	# the given message.  If remote is invalid we will die
-	# later in the common codepath so we discard the error
-	# in this loop.
-	merge_name=3D$(for remote
-		do
-			merge_name "$remote"
-		done | git fmt-merge-msg
-	)
-	merge_msg=3D"${merge_msg:+$merge_msg$LF$LF}$merge_name"
+	if test -z "$merge_msg"
+	then
+		# All the rest are the commits being merged; prepare
+		# the standard merge summary message to be appended to
+		# the given message.  If remote is invalid we will die
+		# later in the common codepath so we discard the error
+		# in this loop.
+		merge_msg=3D$(for remote
+			do
+				merge_name "$remote"
+			done | git fmt-merge-msg
+		)
+	fi
 fi
 head=3D$(git rev-parse --verify "$head_arg"^0) || usage
=20
--=20
1.5.5
