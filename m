From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v2 0/3] git checkout optimisation - part 3
Date: Thu, 19 Feb 2009 21:08:27 +0100
Message-ID: <cover.1235071656.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 21:10:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaFDe-0003Qc-Oi
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 21:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbZBSUId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 15:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbZBSUId
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 15:08:33 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:52173 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbZBSUIc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 15:08:32 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KFB00FVWXA7LA20@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Thu, 19 Feb 2009 21:08:31 +0100 (CET)
Received: from localhost.localdomain ([80.203.78.205])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KFB00L04XA6CY10@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Thu, 19 Feb 2009 21:08:31 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110738>

Changes sine v1 
(v1 was posted with subject "The ext4 filesystem and racy git")

-- patch 2/3 --
   Added missing timestamp => timestamp.(u)sec update for
   unpack-trees.c

-- patch 3/3 --
   New patch which removes some 14300 lstat(2) calls, and the total is
   now at 41677 calls, or 1.382 calls/unique string to lstat() for the
   reference 'git checkout'-test to Linux tag v2.6.27.

   Total reduction so far for all the lstat/git checkout optimisation
   patches has been 120954 - 41677 = 79277 calls.  Some 14400 fstat(2)
   calls is added, but those should be faster than simmilar lstat()
   calls.

(patch-series based on master)


Kjetil Barvik (3):
  fix compile error when USE_NSEC is defined
  make USE_NSEC work as expected
  verify_uptodate(): add ce_uptodate(ce) test

 builtin-fetch-pack.c |    4 +-
 cache.h              |    6 ++--
 read-cache.c         |   70 ++++++++++++++++++++++++++++++++++++++++----------
 unpack-trees.c       |   10 +++++--
 4 files changed, 68 insertions(+), 22 deletions(-)
