From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Quote ' as \(aq in manpages
Date: Wed, 21 Oct 2009 10:24:42 +0200
Message-ID: <ab31eb03b25272341b91e1f1132dab9d8a49e5b6.1256113282.git.trast@student.ethz.ch>
References: <200910151402.56295.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 10:25:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0WVd-0004J4-Vk
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 10:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbZJUIZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 04:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbZJUIZN
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 04:25:13 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:38026 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321AbZJUIZM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 04:25:12 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 21 Oct
 2009 10:25:17 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 21 Oct
 2009 10:25:15 +0200
X-Mailer: git-send-email 1.6.5.1.144.g40216
In-Reply-To: <200910151402.56295.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130900>

The docbook/xmlto toolchain insists on quoting ' as \'.  This does
achieve the quoting goal, but modern 'man' implementations turn the
apostrophe into a unicode "proper" apostrophe (given the right
circumstances), breaking code examples in many of our manpages.

Quote them as \(aq instead, which is an "apostrophe quote" as per the
groff_char manpage.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I've had this around since my last rant, and it actually gives good
results with both setups I can test on, which are:

- asciidoc 8.4.5, docbook-xsl 1.75.2, xmlto 0.0.18
- asciidoc 8.2.7, docbook-xsl 1.73.2, xmlto 0.0.20


 Documentation/manpage-base.xsl |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/manpage-base.xsl b/Documentation/manpage-base.xsl
index a264fa6..bf74bb7 100644
--- a/Documentation/manpage-base.xsl
+++ b/Documentation/manpage-base.xsl
@@ -7,6 +7,15 @@
 <xsl:param name="man.output.quietly" select="1"/>
 <xsl:param name="refentry.meta.get.quietly" select="1"/>
 
+<xsl:template name="escape.apostrophe">
+  <xsl:param name="content"/>
+  <xsl:call-template name="string.subst">
+    <xsl:with-param name="string" select="$content"/>
+    <xsl:with-param name="target">'</xsl:with-param>
+    <xsl:with-param name="replacement">\(aq</xsl:with-param>
+  </xsl:call-template>
+</xsl:template>
+
 <!-- convert asciidoc callouts to man page format;
      git.docbook.backslash and git.docbook.dot params
      must be supplied by another XSL file or other means -->
-- 
1.6.5.1.144.g40216
