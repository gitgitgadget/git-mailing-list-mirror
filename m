From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] [TOPGIT] make tg remote idempotent
Date: Wed, 14 Jan 2009 22:27:22 +0100
Message-ID: <1231968443-13960-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "martin f. krafft" <madduck@debian.org>, Petr Baudis <pasky@ucw.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 22:29:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNDIV-0001jy-UN
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 22:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758191AbZANV1b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jan 2009 16:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758036AbZANV1a
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 16:27:30 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57918 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758010AbZANV13 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 16:27:29 -0500
Received: from ukl by metis.ext.pengutronix.de with local (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LNDGm-0001iM-KQ; Wed, 14 Jan 2009 22:27:27 +0100
X-Mailer: git-send-email 1.5.6.5
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105705>

Before this patch each call to tg remote added three config entries
no matter if they already existed.  After some time my .git/config was
crowded.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 tg-remote.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tg-remote.sh b/tg-remote.sh
index c3e8bd3..7f7a1b0 100644
--- a/tg-remote.sh
+++ b/tg-remote.sh
@@ -27,9 +27,9 @@ git config "remote.$name.url" >/dev/null || die "unkn=
own remote '$name'"
=20
 ## Configure the remote
=20
-git config --add "remote.$name.fetch" "+refs/top-bases/*:refs/remotes/=
$name/top-bases/*"
-git config --add "remote.$name.push" "+refs/top-bases/*:refs/top-bases=
/*"
-git config --add "remote.$name.push" "+refs/heads/*:refs/heads/*"
+git config --replace-all "remote.$name.fetch" "+refs/top-bases/*:refs/=
remotes/$name/top-bases/*" "+refs/top-bases/*:refs/remotes/$name/top-ba=
ses/*"
+git config --replace-all "remote.$name.push" "+refs/top-bases/*:refs/t=
op-bases/*" "+refs/top-bases/*:refs/top-bases/*"
+git config --replace-all "remote.$name.push" "+refs/heads/*:refs/heads=
/*" "+refs/heads/*:refs/heads/*"
=20
 info "Remote $name can now follow TopGit topic branches."
 if [ -z "$populate" ]; then
--=20
1.5.6.5
