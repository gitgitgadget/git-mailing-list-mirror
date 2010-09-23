From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] get_author_ident_from_commit(): remove useless quoting
Date: Thu, 23 Sep 2010 11:22:10 +0200
Message-ID: <1285233730-30611-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100922212302.GA22368@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 23 11:22:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oyi0Y-0003dB-Tf
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 11:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527Ab0IWJWQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 05:22:16 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60208 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124Ab0IWJWP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 05:22:15 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1Oyi0M-0006Vv-Jk; Thu, 23 Sep 2010 11:22:14 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Oyi0K-0007yE-Mp; Thu, 23 Sep 2010 11:22:12 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <20100922212302.GA22368@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156862>

The command 's/'\''/'\''\'\'\''/g' only triples single quotes:

	$ echo "What's up?" | sed 's/'\''/'\''\'\'\''/g'
	What'''s up?

This doesn't hurt as compared to a single single quote it only adds an
empty string, but it makes the script needlessly complicated and hard t=
o
understand.  The useful quoting is done by s/'\''/'\''\\'\'\''/g at the
beginning of the script and only once for all three variables.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 git-sh-setup.sh |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 6131670..8d54b73 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -151,17 +151,14 @@ get_author_ident_from_commit () {
 		s/'\''/'\''\\'\'\''/g
 		h
 		s/^author \([^<]*\) <[^>]*> .*$/\1/
-		s/'\''/'\''\'\'\''/g
 		s/.*/GIT_AUTHOR_NAME=3D'\''&'\''/p
=20
 		g
 		s/^author [^<]* <\([^>]*\)> .*$/\1/
-		s/'\''/'\''\'\'\''/g
 		s/.*/GIT_AUTHOR_EMAIL=3D'\''&'\''/p
=20
 		g
 		s/^author [^<]* <[^>]*> \(.*\)$/\1/
-		s/'\''/'\''\'\'\''/g
 		s/.*/GIT_AUTHOR_DATE=3D'\''&'\''/p
=20
 		q
--=20
1.7.2.3
