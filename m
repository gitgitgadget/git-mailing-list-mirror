From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] tg-remote: don't add push specs but warn about existing ones.
Date: Wed, 13 May 2009 12:04:06 +0200
Message-ID: <1242209046-9416-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20090512090201.GA10150@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Weber <marco-oweber@gmx.de>,
	"martin f. krafft" <madduck@debian.org>, 528442@bugs.debian.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 12:04:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4BK0-00075b-UG
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 12:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758048AbZEMKEM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 06:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758016AbZEMKEL
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 06:04:11 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56414 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756942AbZEMKEK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 06:04:10 -0400
Received: from ukl by metis.ext.pengutronix.de with local (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1M4BJn-0006DP-Av; Wed, 13 May 2009 12:04:10 +0200
X-Mailer: git-send-email 1.6.2.4
In-Reply-To: <20090512090201.GA10150@pengutronix.de>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on
	metis.extern.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=4.5 tests=BAYES_00,NO_RELAYS
	shortcircuit=no autolearn=ham version=3.2.4
X-SA-Exim-Version: 4.2.1 (built Tue, 09 Jan 2007 17:23:22 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119022>

topgit used to add some push specs to assert that topbases are pushed,
too.  This should now be handled by tg-push.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Marc Weber <marco-oweber@gmx.de>
Cc: martin f. krafft <madduck@debian.org>
Cc: 528442@bugs.debian.org
---
 tg-remote.sh |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tg-remote.sh b/tg-remote.sh
index 3a40081..86dcd9a 100644
--- a/tg-remote.sh
+++ b/tg-remote.sh
@@ -28,8 +28,13 @@ git config "remote.$name.url" >/dev/null || die "unk=
nown remote '$name'"
 ## Configure the remote
=20
 git config --replace-all "remote.$name.fetch" "+refs/top-bases/*:refs/=
remotes/$name/top-bases/*" "\\+refs/top-bases/\\*:refs/remotes/$name/to=
p-bases/\\*"
-git config --replace-all "remote.$name.push" "+refs/top-bases/*:refs/t=
op-bases/*" "\\+refs/top-bases/\\*:refs/top-bases/\\*"
-git config --replace-all "remote.$name.push" "+refs/heads/*:refs/heads=
/*" "\\+refs/heads/\\*:refs/heads/\\*"
+
+if git config --get-all "remote.$name.push" "\\+refs/top-bases/\\*:ref=
s/top-bases/\\*" >/dev/null && test "xtrue" !=3D "x$(git config --bool =
--get topgit.dontwarnonoldpushspecs)"; then
+	info "Probably you want to remove the push specs introduced by an old=
 version of topgit:"
+	info '       git config --unset-all "remote.'$name'.push" "\\+refs/to=
p-bases/\\*:refs/top-bases/\\*"'
+	info '       git config --unset-all "remote.'$name'.push" "\\+refs/he=
ads/\\*:refs/heads/\\*"'
+	info '(or use git config --bool --add topgit.dontwarnonoldpushspecs t=
rue to get rid of this warning)'
+fi
=20
 info "Remote $name can now follow TopGit topic branches."
 if [ -z "$populate" ]; then
--=20
1.6.2.4
