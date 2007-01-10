From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Fix warnings on PowerPC - use C99 printf format if available
Date: Tue, 09 Jan 2007 23:07:11 -0500
Message-ID: <20070110040710.7403.74668.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jan 10 06:08:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Vhb-00063o-Hq
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 06:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbXAJFIe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 00:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbXAJFIe
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 00:08:34 -0500
Received: from c-71-230-131-166.hsd1.pa.comcast.net ([71.230.131.166]:54384
	"EHLO localhost.localdomain" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932557AbXAJFIe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jan 2007 00:08:34 -0500
X-Greylist: delayed 3675 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jan 2007 00:08:33 EST
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l0A47Bxm007412
	for <git@vger.kernel.org>; Tue, 9 Jan 2007 23:07:11 -0500
To: git@vger.kernel.org
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36477>

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 sha1_file.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 095a7e1..53e25f2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -22,6 +22,12 @@
 #endif
 #endif
 
+#ifdef NO_C99_FORMAT
+#define SZ_FMT "lu"
+#else
+#define SZ_FMT "zu"
+#endif
+
 const unsigned char null_sha1[20];
 
 static unsigned int sha1_file_open_flag = O_NOATIME;
@@ -407,9 +413,9 @@ struct packed_git *packed_git;
 void pack_report()
 {
 	fprintf(stderr,
-		"pack_report: getpagesize()            = %10lu\n"
-		"pack_report: core.packedGitWindowSize = %10lu\n"
-		"pack_report: core.packedGitLimit      = %10lu\n",
+		"pack_report: getpagesize()            = %10" SZ_FMT "\n"
+		"pack_report: core.packedGitWindowSize = %10" SZ_FMT "\n"
+		"pack_report: core.packedGitLimit      = %10" SZ_FMT "\n",
 		page_size,
 		packed_git_window_size,
 		packed_git_limit);
@@ -417,7 +423,8 @@ void pack_report()
 		"pack_report: pack_used_ctr            = %10u\n"
 		"pack_report: pack_mmap_calls          = %10u\n"
 		"pack_report: pack_open_windows        = %10u / %10u\n"
-		"pack_report: pack_mapped              = %10lu / %10lu\n",
+		"pack_report: pack_mapped              = "
+			"%10" SZ_FMT " / %10" SZ_FMT "\n",
 		pack_used_ctr,
 		pack_mmap_calls,
 		pack_open_windows, peak_pack_open_windows,
