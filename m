From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Properly force listingblocks to be monospaced in manpages
Date: Sun, 19 Aug 2007 23:03:17 +0200
Organization: glandium.org
Message-ID: <20070819210317.GA3202@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 19 23:04:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMrwR-0008At-3x
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 23:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386AbXHSVDp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 17:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752923AbXHSVDp
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 17:03:45 -0400
Received: from vawad.err.no ([85.19.200.177]:43445 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487AbXHSVDo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 17:03:44 -0400
Received: from aputeaux-153-1-37-169.w82-124.abo.wanadoo.fr ([82.124.129.169] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IMrw0-0002dm-N8
	for git@vger.kernel.org; Sun, 19 Aug 2007 23:03:45 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1IMrvZ-0000q8-1H
	for git@vger.kernel.org; Sun, 19 Aug 2007 23:03:17 +0200
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56147>

Still insert a ".ft C" before and ".ft" after, but do it in a way as to
avoid them to get escaped with "\&", which makes the manpages look pretty
bad. Do it in a more docbook-xsl'ish way.

Reverts 281a53bb79786a6d7e54f9715cc8ad46fc2bdb0e.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 Documentation/asciidoc.conf |    6 ------
 Documentation/callouts.xsl  |    7 +++++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index af5b155..6b6220d 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -27,13 +27,7 @@ ifdef::backend-docbook[]
 [listingblock]
 <example><title>{title}</title>
 <literallayout>
-ifdef::doctype-manpage[]
-&#10;.ft C&#10;
-endif::doctype-manpage[]
 |
-ifdef::doctype-manpage[]
-&#10;.ft&#10;
-endif::doctype-manpage[]
 </literallayout>
 {title#}</example>
 endif::backend-docbook[]
diff --git a/Documentation/callouts.xsl b/Documentation/callouts.xsl
index 6a361a2..e188f5e 100644
--- a/Documentation/callouts.xsl
+++ b/Documentation/callouts.xsl
@@ -27,4 +27,11 @@
   </xsl:if>
 </xsl:template>
 
+<!-- Force listingblocks to be monospaced in manpages -->
+<xsl:template match="literallayout">
+  <xsl:text>&#x2302;ft C&#10;</xsl:text>
+  <xsl:apply-templates/>
+  <xsl:text>&#x2302;ft&#10;</xsl:text>
+</xsl:template>
+
 </xsl:stylesheet>
-- 
1.5.3.rc4
