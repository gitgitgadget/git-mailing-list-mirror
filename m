From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v2 1/3] fix compile error when USE_NSEC is defined
Date: Thu, 19 Feb 2009 21:08:28 +0100
Message-ID: <42717dc50485756e6153fa07d0b5af2496927f00.1235071656.git.barvik@broadpark.no>
References: <cover.1235071656.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 21:10:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaFDf-0003Qc-Fo
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 21:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbZBSUIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 15:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbZBSUIg
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 15:08:36 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:52173 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbZBSUId (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 15:08:33 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KFB00FW0XA7LA20@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Thu, 19 Feb 2009 21:08:31 +0100 (CET)
Received: from localhost.localdomain ([80.203.78.205])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KFB00L04XA6CY10@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Thu, 19 Feb 2009 21:08:31 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
In-reply-to: <cover.1235071656.git.barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110739>

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
