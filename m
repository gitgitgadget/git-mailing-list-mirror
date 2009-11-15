From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 3/3] rebase: refuse to rebase with -s ours
Date: Sun, 15 Nov 2009 19:25:32 +0100
Message-ID: <efd7770d166a97481e8e31e407b9c2da02a341e5.1258309432.git.trast@student.ethz.ch>
References: <cover.1258309432.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Baz <brian.ewins@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 15 19:26:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9joH-0003jh-Gi
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 19:26:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbZKOS0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 13:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753312AbZKOS0T
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 13:26:19 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:7158 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753437AbZKOS0O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 13:26:14 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 19:26:16 +0100
Received: from localhost.localdomain (129.132.210.10) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 19:26:16 +0100
X-Mailer: git-send-email 1.6.5.2.420.gf6c057.dirty
In-Reply-To: <cover.1258309432.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132949>

Using the "ours" strategy with rebase just discards all changes,
turning <branch> into <upstream> (or <newbase> if given).  This is
unlikely to be what the user wants, so simply refuse to do it.

Also document what would happen near the -s option, and point the user
at it with the error message.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-rebase.txt |    3 ++-
 git-rebase--interactive.sh   |    4 ++++
 git-rebase.sh                |    4 ++++
 3 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 5fa9100..2203e63 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -241,7 +241,8 @@ rebased series, starting with <upstream>.
 +
 Due to the peculiarities of 'git-rebase' (see \--merge above), using
 the 'ours' strategy simply discards all patches from the <branch>,
-which makes little sense.
+which makes little sense.  Thus 'git-rebase' does not accept this
+strategy.
 
 -q::
 --quiet::
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 53ad248..c6bc156 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -584,6 +584,10 @@ first and then run 'git rebase --continue' again."
 			STRATEGY="-s $2"
 			shift ;;
 		esac
+		if test "$STRATEGY" = "-s ours"
+		then
+			die "Refusing to rebase with 'ours' strategy; see git help rebase."
+		fi
 		;;
 	-m)
 		# we use merge anyway
diff --git a/git-rebase.sh b/git-rebase.sh
index 6ec155c..2d7d566 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -306,6 +306,10 @@ do
 			strategy="$2"
 			shift ;;
 		esac
+		if test $strategy = ours
+		then
+			die "Refusing to rebase with 'ours' strategy; see git help rebase."
+		fi
 		do_merge=t
 		;;
 	-n|--no-stat)
-- 
1.6.5.2.420.gf6c057.dirty
