From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] git-repack: -b to pass --delta-base-offset
Date: Thu, 12 Oct 2006 22:35:01 -0700
Message-ID: <11607177024171-git-send-email-junkio@cox.net>
References: <11607177011745-git-send-email-junkio@cox.net>
Cc: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 13 07:35:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYFhS-00035N-7L
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 07:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWJMFfF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 01:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbWJMFfE
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 01:35:04 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:36782 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750900AbWJMFfD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 01:35:03 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061013053502.KTLT2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Fri, 13 Oct 2006 01:35:02 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Zhb41V0141kojtg0000100
	Fri, 13 Oct 2006 01:35:05 -0400
To: GIT Mailing List <git@vger.kernel.org>
X-Mailer: git-send-email 1.4.3.rc2.g51ca
In-Reply-To: <11607177011745-git-send-email-junkio@cox.net>
Date: Tue, 10 Oct 2006 01:13:20 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28829>

This new option makes the resulting pack express the delta base
with more compact "offset" format.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-repack.txt |    8 +++++++-
 git-repack.sh                |    1 +
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 49f7e0a..5f5530d 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -9,7 +9,7 @@ objects into pack files.
 
 SYNOPSIS
 --------
-'git-repack' [-a] [-d] [-f] [-l] [-n] [-q] [--window=N] [--depth=N]
+'git-repack' [-a] [-b] [-d] [-f] [-l] [-n] [-q] [--window=N] [--depth=N]
 
 DESCRIPTION
 -----------
@@ -35,6 +35,12 @@ OPTIONS
 	about people fetching via dumb protocols from it.  Use
 	with '-d'.
 
+-b::
+	Pass the `--delta-base-offset` to `git pack-objects`;
+	see gitlink:git-pack-objects[1].  Do not use this option
+	if you want the repository to be accessible by older
+	versions of git.
+
 -d::
 	After packing, if the newly created packs make some
 	existing packs redundant, remove the redundant packs.
diff --git a/git-repack.sh b/git-repack.sh
index b525fc5..25dae5e 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -14,6 +14,7 @@ do
 	-n)	no_update_info=t ;;
 	-a)	all_into_one=t ;;
 	-d)	remove_redundant=t ;;
+	-b)	extra="$extra --delta-base-offset" ;;
 	-q)	quiet=-q ;;
 	-f)	no_reuse_delta=--no-reuse-delta ;;
 	-l)	local=--local ;;
-- 
1.4.3.rc2.g51ca
