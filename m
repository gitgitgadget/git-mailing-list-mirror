From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH v2] Add description of OFS_DELTA to the pack format description
Date: Sun, 6 Apr 2008 22:19:07 +0200
Message-ID: <20080406201907.GB7075@bohr.gbar.dtu.dk>
References: <20080406134739.GA29815@bohr.gbar.dtu.dk> <20080406190724.GG10274@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 06 22:20:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JibLL-0008Sy-2o
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 22:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbYDFUTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 16:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752497AbYDFUTL
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 16:19:11 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:43460 "HELO bohr.gbar.dtu.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752292AbYDFUTK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 16:19:10 -0400
Received: (qmail 15578 invoked by uid 5842); 6 Apr 2008 22:19:07 +0200
Content-Disposition: inline
In-Reply-To: <20080406190724.GG10274@spearce.org>
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78920>


Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>
---
 Documentation/technical/pack-format.txt |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)


On Sun, Apr 06, 2008 at 03:07:24PM -0400, Shawn O. Pearce wrote:
...
> You are missing the description that the position within _this_
> packfile is determined by:
> 
> 	offset_of_type_byte - n_byte_offset
> 
> The above can still be taken to mean the offset is from the start
> of the packfile or something like that.

Yes, I misunderstood that.

Peter

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index aa87756..953c7ee 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -103,10 +103,24 @@ Pack file entry: <+
      packed object data:
         If it is not DELTA, then deflated bytes (the size above
 		is the size before compression).
-	If it is DELTA, then
+	If it is REF_DELTA, then
 	  20-byte base object name SHA1 (the size above is the
 		size of the delta data that follows).
           delta data, deflated.
+	If it is OFS_DELTA, then
+	  n-byte offset (see below) counted from the type-byte
+                of the header of the ofs-delta entry.
+                (the size above is the size of the delta data
+                that follows).
+          delta data, deflated.
+
+     offset encoding:
+          n bytes with MSB set in all but the last one.
+          The offset is then the number constructed by
+          concatenating the lower 7 bit of each byte, and
+          for n >= 2 adding 2^7 + 2^14 + ... + 2^(7*(n-1))
+          to the result.
+          
 
 
 = Version 2 pack-*.idx files support packs larger than 4 GiB, and
-- 
1.5.5-rc3.GIT
