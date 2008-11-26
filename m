From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] tg export: implement skipping empty patches for quilt mode
Date: Wed, 26 Nov 2008 13:13:00 +0100
Message-ID: <1227701580-9762-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Wed Nov 26 13:14:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5JHk-0002N1-SA
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 13:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbYKZMNJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Nov 2008 07:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbYKZMNH
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 07:13:07 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35892 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbYKZMNF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 07:13:05 -0500
Received: from themisto.ext.pengutronix.de ([92.198.50.58] helo=localhost.localdomain)
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <u.kleine-koenig@pengutronix.de>)
	id 1L5JGP-0002tl-HI; Wed, 26 Nov 2008 13:13:04 +0100
X-Mailer: git-send-email 1.5.6.5
X-SA-Exim-Connect-IP: 92.198.50.58
X-SA-Exim-Mail-From: u.kleine-koenig@pengutronix.de
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on
	metis.extern.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=4.5 tests=BAYES_00,HELO_LH_LD,
	RCVD_IN_PBL shortcircuit=no autolearn=no version=3.2.4
X-SA-Exim-Version: 4.2.1 (built Tue, 09 Jan 2007 17:23:22 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101728>

addionally fix the README item for skipping the export of empty patches
not to need an option (-n) as this should be the default.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 README       |    2 +-
 tg-export.sh |   12 ++++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/README b/README
index 5bfe3ee..9b92d43 100644
--- a/README
+++ b/README
@@ -414,7 +414,7 @@ tg export
 	TODO: Make stripping of non-essential headers configurable
 	TODO: Make stripping of [PATCH] and other prefixes configurable
 	TODO: --mbox option for other mode of operation
-	TODO: -n option to prevent exporting of empty patches
+	TODO: prevent exporting of empty patches
 	TODO: -a option to export all branches
 	TODO: For quilt exporting, use a temporary branch and remove it when
 	      done - this would allow producing conflict-less series
diff --git a/tg-export.sh b/tg-export.sh
index 52af88d..f133fb8 100644
--- a/tg-export.sh
+++ b/tg-export.sh
@@ -140,10 +140,14 @@ quilt()
 		return
 	fi
=20
-	echo "Exporting $_dep"
-	mkdir -p "$(dirname "$filename")"
-	$tg patch "$_dep" >"$filename"
-	echo "$_dep.diff -p1" >>"$output/series"
+	if branch_empty "$_dep"; then
+		echo "Skip empty patch $_dep";
+	else
+		echo "Exporting $_dep"
+		mkdir -p "$(dirname "$filename")"
+		$tg patch "$_dep" >"$filename"
+		echo "$_dep.diff -p1" >>"$output/series"
+	fi
 }
=20
=20
--=20
1.5.6.5
