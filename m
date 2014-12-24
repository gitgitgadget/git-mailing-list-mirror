From: "Pascal Malaise" <malaise@magic.fr>
Subject: "Stash save" exits with 0 when nothing to stash
Date: Wed, 24 Dec 2014 10:20:30 +0100
Message-ID: <20141224090636.M86902@magic.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 24 11:08:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3irU-0002Mt-5M
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 11:08:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbaLXKIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2014 05:08:07 -0500
Received: from victoria.magic.fr ([188.130.16.15]:52805 "EHLO
	victoria.magic.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbaLXKIG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2014 05:08:06 -0500
X-Greylist: delayed 2738 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Dec 2014 05:08:05 EST
Received: from magic.fr (localhost [127.0.0.1])
	by victoria.magic.fr (8.13.8/8.13.8) with ESMTP id sBO9KUWh006607;
	Wed, 24 Dec 2014 10:20:30 +0100
X-Mailer: WebMail Magic OnLine 7.19
X-MoL: WebMail/Victoria/OWM
X-OriginatingIP: Magic OnLine / 192.54.144.229 / malaise@webmail.magic.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261801>

Hi,

When calling "git stash save" in a clean situation (no change since last
commit), git-stash reports "No local changes to save", which is OK.
But it exits with code 0, despite no stash has been saved.
It would be better to exit with code 1 in this case.

N.B. In a similar situation  "git commit -a -m 'Test'" reports
> On branch master
> nothing to commit, working directory clean
and exits with code 1.

Thanks

diff -u  git-master/git-stash.sh exit1/git-stash.sh 
--- git-master/git-stash.sh	2014-12-22 20:43:48.000000000 +0000
+++ exit1/git-stash.sh	2014-12-24 08:59:00.804150443 +0000
@@ -257,7 +257,7 @@
 	if no_changes
 	then
 		say "$(gettext "No local changes to save")"
-		exit 0
+		exit 1
 	fi
 	test -f "$GIT_DIR/logs/$ref_stash" ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
