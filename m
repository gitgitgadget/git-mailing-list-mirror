From: Sam Vilain <sam@vilain.net>
Subject: [PATCH 6/7] revision cache: allow foreign 'start' commits
Date: Fri, 5 Jun 2009 02:05:13 +1200
Message-ID: <14c3b1136cea650af9a3274b260c0a708456a554.1244125128.git.sam@vilain.net>
References: <cover.1244125127.git.sam@vilain.net>
Cc: Nick Edelen <sirnot@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 07:46:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCSF0-0000qI-Bx
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 07:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841AbZFEFpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 01:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754294AbZFEFpD
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 01:45:03 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:57194 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752800AbZFEFpD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 01:45:03 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1003)
	id 14B8821C476; Fri,  5 Jun 2009 17:45:00 +1200 (NZST)
In-Reply-To: <cover.1244125127.git.sam@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120744>

Usually the 'start' commits are always 'interesting' commits in a
revision query, however with the 'newness' bitmaps we can also use
them to mask out objects, ie 'uninteresting' commits.  An index which
was useless, due to an unknown object existing in the 'uninteresting'
commit list can be converted to a useful one by building the bitmap of
'reachable' and 'new' objects for that commit - without having to
insert new objects in the middle of the list, which would require
rebuilding the entire index.  So, there is a use case for storing
information on 'start' objects which aren't actually in the object
list.  Permit this case.

This is currently a work in progress; extension to how this affects
the use cases is not there yet.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 Documentation/technical/revision-cache.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/technical/revision-cache.txt b/Documentation/technical/revision-cache.txt
index e0adb26..0cd7b08 100644
--- a/Documentation/technical/revision-cache.txt
+++ b/Documentation/technical/revision-cache.txt
@@ -33,6 +33,10 @@ A revision cache contains;
     'end' object, but not reachable from the 'start' objects reachable
     from that 'end' object.
 
+  - a list of 'foreign end' objects, for which not all reachable
+    objects are in the object list, but can have reachability or a
+    'newness' bitmap.
+
 
 Start Objects and End Objects
 -----------------------------
-- 
debian.1.5.6.1
