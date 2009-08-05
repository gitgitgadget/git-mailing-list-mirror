From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/4] sequencer: add comments about reset_almost_hard()
Date: Wed, 05 Aug 2009 22:52:58 +0200
Message-ID: <20090805205301.3673.2317.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 23:32:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYo5q-0006vK-Rh
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 23:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbZHEVcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 17:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752222AbZHEVcH
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 17:32:07 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49510 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148AbZHEVcH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 17:32:07 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 2ED39818036;
	Wed,  5 Aug 2009 23:31:57 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 2EEED8180F5;
	Wed,  5 Aug 2009 23:31:55 +0200 (CEST)
X-git-sha1: d6a563b982b7bdb3e05690fc8279a531d0d82f24 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124994>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

	Here is some information about the reset_almost_hard
	function. This is the result of reading the code and
	the documentation of related commands, but as I don't
	know much these areas of git...

 builtin-sequencer--helper.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/builtin-sequencer--helper.c b/builtin-sequencer--helper.c
index 82a830d..a15139c 100644
--- a/builtin-sequencer--helper.c
+++ b/builtin-sequencer--helper.c
@@ -77,8 +77,21 @@ static int reset_index_file(const unsigned char *sha1, int update, int dirty)
 
 /*
  * Realize reset --hard behavior.
- * If allow_dirty is set and there is a dirty working tree,
- * then the changes are to be kept.
+ * If allow_dirty is set and there is a dirty work tree,
+ * then the changes in the work tree are to be kept.
+ *
+ * This should be faster than calling "git reset --hard" because
+ * this calls "unpack_trees()" directly (instead of forking and
+ * execing "git read-tree").
+ *
+ * Unmerged entries in the index will be discarded.
+ *
+ * If allow_dirty is set and fast forwarding the work tree
+ * fails because it is dirty, then the work tree will not be
+ * updated.
+ *
+ * No need to read or discard the index before calling this
+ * function.
  */
 static int reset_almost_hard(const unsigned char *sha)
 {
-- 
1.6.4.133.g8a5c8
