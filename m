X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: spurious .sp in manpages
Date: Wed, 13 Dec 2006 00:58:28 -0800
Message-ID: <7vodq8kw97.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 08:58:36 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34188>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuPwf-0001tT-1z for gcvg-git@gmane.org; Wed, 13 Dec
 2006 09:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932623AbWLMI6a (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 03:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWLMI6a
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 03:58:30 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:36578 "EHLO
 fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932623AbWLMI63 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 03:58:29 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061213085829.UQUU9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Wed, 13
 Dec 2006 03:58:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id y8xq1V0071kojtg0000000; Wed, 13 Dec 2006
 03:57:50 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This is just a random hack to work around problems people seem
to be seeing in manpage backend of xmlto (it appears we are
getting ".sp" at the end of line without line break).

Could people test this out?

---

diff --git a/Documentation/callouts.xsl b/Documentation/callouts.xsl
index ad03755..6a361a2 100644
--- a/Documentation/callouts.xsl
+++ b/Documentation/callouts.xsl
@@ -13,4 +13,18 @@
 	<xsl:apply-templates/>
 	<xsl:text>.br&#10;</xsl:text>
 </xsl:template>
+
+<!-- sorry, this is not about callouts, but attempts to work around
+ spurious .sp at the tail of the line docbook stylesheets seem to add -->
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
