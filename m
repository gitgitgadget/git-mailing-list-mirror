From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH TOPGIT] tg export: implement skipping empty patches for collapse driver
Date: Tue, 23 Dec 2008 15:32:22 +0100
Message-ID: <1230042744-24675-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20081223143035.GA24087@cassiopeia.tralala>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "martin f. krafft" <madduck@debian.org>, Petr Baudis <pasky@ucw.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 23 15:34:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF8KU-00067B-Tg
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 15:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbYLWOcc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Dec 2008 09:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbYLWOcc
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 09:32:32 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55270 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbYLWOcb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 09:32:31 -0500
Received: from ukl by metis.ext.pengutronix.de with local (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LF8J8-0006MT-4f; Tue, 23 Dec 2008 15:32:30 +0100
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <20081223143035.GA24087@cassiopeia.tralala>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on
	metis.extern.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=4.5 tests=AWL,BAYES_00,NO_RELAYS
	shortcircuit=no autolearn=ham version=3.2.4
X-SA-Exim-Version: 4.2.1 (built Tue, 09 Jan 2007 17:23:22 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103822>

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 README       |    1 -
 tg-export.sh |   10 +++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/README b/README
index c19985f..8be0d17 100644
--- a/README
+++ b/README
@@ -414,7 +414,6 @@ tg export
 	TODO: Make stripping of non-essential headers configurable
 	TODO: Make stripping of [PATCH] and other prefixes configurable
 	TODO: --mbox option for other mode of operation
-	TODO: prevent exporting of empty patches by the collapse driver
 	TODO: -a option to export all branches
 	TODO: For quilt exporting, use a temporary branch and remove it when
 	      done - this would allow producing conflict-less series
diff --git a/tg-export.sh b/tg-export.sh
index afb6f95..95aa346 100644
--- a/tg-export.sh
+++ b/tg-export.sh
@@ -91,9 +91,13 @@ collapsed_commit()
 			$(for p in $parent; do echo -p $p; done))"
 	fi
=20
-	(printf '%s\n\n' "$SUBJECT"; cat "$playground/^msg") |
-	git stripspace |
-	git commit-tree "$(pretty_tree "$name")" -p "$parent"
+	if branch_empty "$name"; then
+		echo "$parent";
+	else
+		(printf '%s\n\n' "$SUBJECT"; cat "$playground/^msg") |
+		git stripspace |
+		git commit-tree "$(pretty_tree "$name")" -p "$parent"
+	fi;
=20
 	echo "$name" >>"$playground/^ticker"
 }
--=20
1.5.6.5
