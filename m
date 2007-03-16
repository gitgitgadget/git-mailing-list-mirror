From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] fix t5300-pack-object.sh
Date: Fri, 16 Mar 2007 13:37:42 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703161329440.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 16 18:37:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSGND-0003dM-Kc
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 18:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965756AbXCPRho (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 13:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965777AbXCPRho
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 13:37:44 -0400
Received: from relais.videotron.ca ([24.201.245.36]:54522 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965756AbXCPRhn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 13:37:43 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF000HU8BMUTXA0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 16 Mar 2007 13:37:42 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42384>

The 'use packed deltified objects' test was flawed as it failed to 
remove the pack and index from the previous test, effectively preventing
the desired pack from being exercised as objects could be found in that
other pack instead.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index f511547..17befde 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -116,7 +116,7 @@ test_expect_success \
     'use packed deltified objects' \
     'GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
-     rm -f .git2/objects/pack/test-?.idx &&
+     rm .git2/objects/pack/test-* &&
      cp test-2-${packname_2}.pack test-2-${packname_2}.idx .git2/objects/pack && {
 	 git-diff-tree --root -p $commit &&
 	 while read object
