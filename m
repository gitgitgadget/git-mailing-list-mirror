From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH 5/8] Documentation: move "spurious .sp" code into
 manpage-base.xsl
Date: Tue, 24 Mar 2009 03:04:23 -0500
Message-ID: <1237881866-5497-6-git-send-email-chris_johnsen@pobox.com>
References: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Chris Johnsen <chris_johnsen@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 09:09:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm1gz-00072O-P9
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 09:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756835AbZCXIF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 04:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756846AbZCXIF2
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 04:05:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63956 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbZCXIFY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 04:05:24 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7C78EA4BDB;
	Tue, 24 Mar 2009 04:05:22 -0400 (EDT)
Received: from localhost.localdomain (unknown [75.53.43.147]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 D47A1A4BD6; Tue, 24 Mar 2009 04:05:16 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.214.ge986c
In-Reply-To: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com>
X-Pobox-Relay-ID: 86246D14-184A-11DE-A90F-32B0EBB1AA3C-07245699!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114418>

The "spurious .sp" code should be independent of docbook-xsl
versions.

Testing done with asciidoc 8.3.1 and docbook-xsl 1.74.0.

Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>

---

I do not know why this was only in the non-1.72 variant. Maybe
docbook-xsl 1.72.0 did not need it. But it does not seem like it
would hurt to push it into the shared XSLT. As before, if there
is a good reason to keep it out of the -1.72 processing, then
just drop this patch, none of the rest depend on it.
---
 Documentation/manpage-base.xsl   |   13 +++++++++++++
 Documentation/manpage-normal.xsl |   13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/manpage-base.xsl b/Documentation/manpage-base.xsl
index a264fa6..16e2e40 100644
--- a/Documentation/manpage-base.xsl
+++ b/Documentation/manpage-base.xsl
@@ -32,4 +32,17 @@
 	<xsl:text>br&#10;</xsl:text>
 </xsl:template>
 
+<!-- attempt to work around spurious .sp at the tail of the line
+     that docbook stylesheets seem to add -->
+<xsl:template match="simpara">
+  <xsl:variable name="content">
+    <xsl:apply-templates/>
+  </xsl:variable>
+  <xsl:value-of select="normalize-space($content)"/>
+  <xsl:if test="not(ancestor::authorblurb) and
+                not(ancestor::personblurb)">
+    <xsl:text>&#10;&#10;</xsl:text>
+  </xsl:if>
+</xsl:template>
+
 </xsl:stylesheet>
diff --git a/Documentation/manpage-normal.xsl b/Documentation/manpage-normal.xsl
index be0afc9..0412722 100644
--- a/Documentation/manpage-normal.xsl
+++ b/Documentation/manpage-normal.xsl
@@ -9,17 +9,4 @@
 <xsl:param name="git.docbook.backslash">\</xsl:param>
 <xsl:param name="git.docbook.dot"	>.</xsl:param>
 
-<!-- attempt to work around spurious .sp at the tail of the line
-     that docbook stylesheets seem to add -->
-<xsl:template match="simpara">
-  <xsl:variable name="content">
-    <xsl:apply-templates/>
-  </xsl:variable>
-  <xsl:value-of select="normalize-space($content)"/>
-  <xsl:if test="not(ancestor::authorblurb) and
-                not(ancestor::personblurb)">
-    <xsl:text>&#10;&#10;</xsl:text>
-  </xsl:if>
-</xsl:template>
-
 </xsl:stylesheet>
-- 
1.6.2.1.214.ge986c
