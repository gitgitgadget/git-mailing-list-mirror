From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] [TOPGIT] make tg remote idempotent
Date: Wed, 25 Feb 2009 21:03:58 +0100
Message-ID: <1235592240-12616-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20090225195856.GA12372@pengutronix.de>
 <1235592240-12616-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1235592240-12616-2-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 21:06:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcQ0v-0007ne-Dy
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 21:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758296AbZBYUEJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 15:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758220AbZBYUEJ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 15:04:09 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45154 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758158AbZBYUEC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 15:04:02 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LcPz6-0002lf-A5
	for git@vger.kernel.org; Wed, 25 Feb 2009 21:04:00 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LcPz6-0003Hx-71
	for git@vger.kernel.org; Wed, 25 Feb 2009 21:04:00 +0100
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1235592240-12616-2-git-send-email-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111491>

Before this patch each call to tg remote added three config entries
no matter if they already existed.  After some time my .git/config was
crowded.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 tg-remote.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tg-remote.sh b/tg-remote.sh
index c3e8bd3..3a40081 100644
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
remotes/$name/top-bases/*" "\\+refs/top-bases/\\*:refs/remotes/$name/to=
p-bases/\\*"
+git config --replace-all "remote.$name.push" "+refs/top-bases/*:refs/t=
op-bases/*" "\\+refs/top-bases/\\*:refs/top-bases/\\*"
+git config --replace-all "remote.$name.push" "+refs/heads/*:refs/heads=
/*" "\\+refs/heads/\\*:refs/heads/\\*"
=20
 info "Remote $name can now follow TopGit topic branches."
 if [ -z "$populate" ]; then
--=20
1.5.6.5
