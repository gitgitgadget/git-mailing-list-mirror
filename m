From: "martin f. krafft" <madduck@madduck.net>
Subject: [PATCH] git-am: implement --reject option passed to git-apply
Date: Fri, 23 Jan 2009 11:31:21 +1100
Message-ID: <1232670681-25781-1-git-send-email-madduck@madduck.net>
Cc: "martin f. krafft" <madduck@madduck.net>,
	penny leach <penny@mjollnir.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 23 01:33:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ9z4-0000X4-0F
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 01:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397AbZAWAbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 19:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753731AbZAWAbx
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 19:31:53 -0500
Received: from clegg.madduck.net ([193.242.105.96]:34639 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbZAWAbx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 19:31:53 -0500
Received: from lapse.rw.madduck.net (unknown [IPv6:2001:388:a001:1:214:a4ff:fe04:eadc])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 405351D40B1;
	Fri, 23 Jan 2009 01:31:41 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 66FAC80CC; Fri, 23 Jan 2009 13:31:21 +1300 (NZDT)
X-Mailer: git-send-email 1.6.0.1
X-Virus-Scanned: ClamAV 0.94.2/8893/Thu Jan 22 21:18:43 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106809>

With --reject, git-am simply passes the --reject option to git-apply and thus
allows people to work with reject files if they so prefer.

The patch does not touch t/t4252-am-options.sh (yet) because I do not really
understand how the testing system works.

Signed-off-by: martin f. krafft <madduck@madduck.net>

---
 Documentation/git-am.txt |    2 ++
 git-am.sh                |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 5cbbe76..efd311b 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git am' [--signoff] [--keep] [--utf8 | --no-utf8]
 	 [--3way] [--interactive]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
+	 [--reject]
 	 [<mbox> | <Maildir>...]
 'git am' (--skip | --resolved | --abort)
 
@@ -63,6 +64,7 @@ default.   You could use `--no-utf8` to override this.
 -C<n>::
 -p<n>::
 --directory=<dir>::
+--reject::
 	These flags are passed to the 'git-apply' (see linkgit:git-apply[1])
 	program that applies
 	the patch.
diff --git a/git-am.sh b/git-am.sh
index e20dd88..b1c05c9 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -19,6 +19,7 @@ whitespace=     pass it through git-apply
 directory=      pass it through git-apply
 C=              pass it through git-apply
 p=              pass it through git-apply
+reject          pass it through git-apply
 resolvemsg=     override error message when patch failure occurs
 r,resolved      to be used after a patch failure
 skip            skip the current patch
@@ -168,6 +169,8 @@ do
 		git_apply_opt="$git_apply_opt $(sq "$1=$2")"; shift ;;
 	-C|-p)
 		git_apply_opt="$git_apply_opt $(sq "$1$2")"; shift ;;
+	--reject)
+		git_apply_opt="$git_apply_opt $1" ;;
 	--)
 		shift; break ;;
 	*)
-- 
tg: (9a01387..) git-am--reject (depends on: master)
