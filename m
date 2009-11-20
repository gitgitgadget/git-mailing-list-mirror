From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH v2] git-count-objects: Fix a disk-space under-estimate on
 Cygwin
Date: Fri, 20 Nov 2009 23:27:11 +0000
Message-ID: <4B0725CF.8030805@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 21 21:51:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBwsE-00041R-Mz
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 21:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499AbZKUSys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 13:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753373AbZKUSys
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 13:54:48 -0500
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:49890 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753219AbZKUSyr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Nov 2009 13:54:47 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1NBv6i-000356-p6; Sat, 21 Nov 2009 18:54:53 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133402>


On Cygwin, the st_blocks field in 'struct stat' counts in blocks
of st_blksize bytes. At least on NTFS, the st_blksize field is
not 512 bytes, as required by the code, which leads to an under
estimate of the disk-space used.

Setting the build variable NO_ST_BLOCKS_IN_STRUCT_STAT, switches
to an algorithm that only uses the st_size field to compute the
disk-space estimate.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Changed since v1:
    - a commit message!
    - removed comment.

ATB,
Ramsay Jones

 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 5d5976f..8902dba 100644
--- a/Makefile
+++ b/Makefile
@@ -783,6 +783,7 @@ ifeq ($(uname_O),Cygwin)
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
 	NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
 	OLD_ICONV = UnfortunatelyYes
+	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	# There are conflicting reports about this.
 	# On some boxes NO_MMAP is needed, and not so elsewhere.
 	# Try commenting this out if you suspect MMAP is more efficient
-- 
1.6.5
