From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH v2 5/8] Documentation: move "spurious .sp" code into
 manpage-base.xsl
Date: Fri, 27 Mar 2009 01:44:02 -0500
Message-ID: <1238136245-22853-6-git-send-email-chris_johnsen@pobox.com>
References: <1238136245-22853-1-git-send-email-chris_johnsen@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Chris Johnsen <chris_johnsen@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 07:48:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln5rE-0008Hu-GC
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 07:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbZC0Gpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 02:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbZC0Gpg
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 02:45:36 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45563 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbZC0Gpf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 02:45:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 912489363;
	Fri, 27 Mar 2009 02:45:33 -0400 (EDT)
Received: from localhost.localdomain (unknown [75.53.43.147]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 D3632935B; Fri, 27 Mar 2009 02:45:28 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.401.gc048
In-Reply-To: <1238136245-22853-1-git-send-email-chris_johnsen@pobox.com>
X-Pobox-Relay-ID: DEF9322E-1A9A-11DE-BD63-C5D912508E2D-07245699!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114858>

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
index e36472f..a48f5b1 100644
--- a/Documentation/manpage-normal.xsl
+++ b/Documentation/manpage-normal.xsl
@@ -10,17 +10,4 @@
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
1.6.2.1.401.gc048
