From: Thomas Schwinge <thomas@schwinge.name>
Subject: [PATCH, TopGit] tg-annihilate: Pass --no-verify when committing.
Date: Thu, 10 Feb 2011 14:39:03 +0100
Message-ID: <1297345143-23788-1-git-send-email-thomas@schwinge.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Schwinge <thomas@schwinge.name>
To: ceder@lysator.liu.se, u.kleine-koenig@pengutronix.de,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 10 14:58:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnX2A-0001Fc-Sr
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 14:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822Ab1BJN6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 08:58:04 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:39551 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147Ab1BJN6D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 08:58:03 -0500
X-Greylist: delayed 1091 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Feb 2011 08:58:03 EST
Received: from [87.180.54.105] (helo=stokes.schwinge.homeip.net)
	by smtprelay01.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <thomas@schwinge.name>)
	id 1PnWkO-0002I8-Pq
	for git@vger.kernel.org; Thu, 10 Feb 2011 14:39:48 +0100
Received: (qmail 26527 invoked from network); 10 Feb 2011 13:39:37 -0000
Received: from hsi-kbw-095-208-175-140.hsi5.kabel-badenwuerttemberg.de (95.208.175.140)
  by stokes.schwinge.homeip.net with QMQP; 10 Feb 2011 13:39:37 -0000
Received: (nullmailer pid 23829 invoked by uid 1000);
	Thu, 10 Feb 2011 13:39:21 -0000
X-Mailer: git-send-email 1.7.1
X-Df-Sender: thomas@schwinge.name
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166484>

This is needed in order to inhibit TopGit's pre-commit hook to run,
which would bark upon missing .top* files.
---

Hallo!

(Yeah, I'm still using TopGit for some things.)  I needed the following
patch to make tg annihilate work if the base is a non-TopGit branch.  I=
s
this the correct approach?


Gr=C3=BC=C3=9Fe,
 Thomas


 tg-annihilate.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/tg-annihilate.sh b/tg-annihilate.sh
index 219b8fe..89d192c 100644
--- a/tg-annihilate.sh
+++ b/tg-annihilate.sh
@@ -34,7 +34,9 @@ baserev=3D"$(git rev-parse --verify "refs/top-bases/$=
name" 2>/dev/null)" ||
 ## Annihilate
 mb=3D"$(git merge-base "refs/top-bases/$name" "$name")"
 git read-tree "$mb^{tree}"
-git commit -m"TopGit branch $name annihilated."
+# Need to pass --no-verify in order to inhibit TopGit's pre-commit hoo=
k to run,
+# which would bark upon missing .top* files.
+git commit --no-verify -m"TopGit branch $name annihilated."
=20
 info 'If you have shared your work, you might want to run `tg push` no=
w.'
 info 'Then you probably want to switch to another branch.'
--=20
1.7.1
