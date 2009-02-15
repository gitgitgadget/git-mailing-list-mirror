From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v1 1/2] fix compile error when USE_NSEC is defined
Date: Sun, 15 Feb 2009 20:46:14 +0100
Message-ID: <43e621190d3e766ea650a4c13e33d6976dde64ad.1234720401.git.barvik@broadpark.no>
References: <cover.1234720401.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 20:47:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYmxv-0001UZ-Nc
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 20:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbZBOTqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 14:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752434AbZBOTqU
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 14:46:20 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:37965 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbZBOTqS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 14:46:18 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KF400GLPHL4VQA0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 15 Feb 2009 20:46:16 +0100 (CET)
Received: from localhost.localdomain ([80.202.92.249])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KF4000XQHL3HX70@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 15 Feb 2009 20:46:16 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
In-reply-to: <cover.1234720401.git.barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110045>

'struct cache' does not have a 'usec' member, but a 'unsigned int
nsec' member.  Simmilar 'struct stat' does not have a 'st_mtim.usec'
member, and we should instead use 'st_mtim.tv_nsec'.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 builtin-fetch-pack.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 67fb80e..3b210c7 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -802,14 +802,14 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 
 		mtime.sec = st.st_mtime;
 #ifdef USE_NSEC
-		mtime.usec = st.st_mtim.usec;
+		mtime.nsec = st.st_mtim.tv_nsec;
 #endif
 		if (stat(shallow, &st)) {
 			if (mtime.sec)
 				die("shallow file was removed during fetch");
 		} else if (st.st_mtime != mtime.sec
 #ifdef USE_NSEC
-				|| st.st_mtim.usec != mtime.usec
+				|| st.st_mtim.tv_nsec != mtime.nsec
 #endif
 			  )
 			die("shallow file was changed during fetch");
-- 
1.6.1.349.g99fa5
