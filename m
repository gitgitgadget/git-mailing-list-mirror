From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Document 'stash clear' recovery via unreachable commits
Date: Sun, 9 Aug 2009 02:47:36 +0200
Message-ID: <9e8ddf7c6c4d4df4150bff0467b461bfff92a401.1249778711.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 02:48:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZwaN-0000p6-4F
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 02:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbZHIAsM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Aug 2009 20:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbZHIAsM
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 20:48:12 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:36607 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753332AbZHIAsL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 20:48:11 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sun, 9 Aug
 2009 02:48:10 +0200
Received: from localhost.localdomain (77.56.221.170) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sun, 9 Aug
 2009 02:47:49 +0200
X-Mailer: git-send-email 1.6.4.195.g3a1c2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125314>

Add an example to the stash documentation that shows how to quickly
find candidate commits among the 'git fsck --unreachable' output.
Unless you have merges of branch names containing WIP, or edit your
merge messages to say WIP, there will be no false positives.

Snippet written by Bj=C3=B6rn "doener" Steinbrink and me after zepolen_
asked on IRC.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-stash.txt |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 1c64a02..2f5ca7b 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -114,7 +114,8 @@ no conflicts.
=20
 clear::
 	Remove all the stashed states. Note that those states will then
-	be subject to pruning, and may be difficult or impossible to recover.
+	be subject to pruning, and may be impossible to recover (see
+	'Examples' below for a possible strategy).
=20
 drop [-q|--quiet] [<stash>]::
=20
@@ -217,6 +218,20 @@ $ edit/build/test remaining parts
 $ git commit foo -m 'Remaining parts'
 ----------------------------------------------------------------
=20
+Recovering stashes that were cleared/dropped erroneously::
+
+If you mistakenly drop or clear stashes, they cannot be recovered
+through the normal safety mechanisms.  However, you can try the
+following incantation to get a list of stashes that are still in your
+repository, but not reachable any more:
++
+----------------------------------------------------------------
+git fsck --unreachable |
+grep commit | cut -d\  -f3 |
+xargs git log --merges --no-walk --grep=3DWIP
+----------------------------------------------------------------
+
+
 SEE ALSO
 --------
 linkgit:git-checkout[1],
--=20
1.6.4.195.g3a1c2
