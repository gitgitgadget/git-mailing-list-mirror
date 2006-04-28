From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: [PATCH] Properly render asciidoc "callouts" in git man pages.
Date: Fri, 28 Apr 2006 09:15:06 -0400
Message-ID: <BAYC1-PASMTP030E0E35B1984789C397EEAEB20@CEZ.ICE>
References: <1146230106696-git-send-email-seanlkml@sympatico.ca>
Reply-To: Sean Estabrooks <seanlkml@sympatico.ca>
Cc: Sean Estabrooks <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Fri Apr 28 15:19:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZSsp-0004Y7-7B
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 15:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030394AbWD1NTj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Apr 2006 09:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbWD1NTi
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 09:19:38 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:10530 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1030394AbWD1NTg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Apr 2006 09:19:36 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from guru.attic.local ([69.156.138.66]) by BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 28 Apr 2006 06:19:36 -0700
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by guru.attic.local (Postfix) with ESMTP id A244F7001ED;
	Fri, 28 Apr 2006 09:15:06 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <11462301063607-git-send-email-seanlkml@sympatico.ca>
X-Mailer: git-send-email 1.3.1.gc672
In-Reply-To: <1146230106696-git-send-email-seanlkml@sympatico.ca>
X-OriginalArrivalTime: 28 Apr 2006 13:19:36.0541 (UTC) FILETIME=[657D30D0:01C66AC6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Adds an xsl fragment to render docbook callouts when
converting to man page format.  Update the Makefile
to have "xmlto" use it when generating man pages.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>


---

 Documentation/Makefile     |    2 +-
 Documentation/callouts.xsl |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/callouts.xsl

82ee912fb2a58194cac3d65b15abc98190a3359a
diff --git a/Documentation/Makefile b/Documentation/Makefile
index f4cbf7e..c1af22c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -79,7 +79,7 @@ clean:
 	asciidoc -b xhtml11 -d manpage -f asciidoc.conf $<
 
 %.1 %.7 : %.xml
-	xmlto man $<
+	xmlto -m callouts.xsl man $<
 
 %.xml : %.txt
 	asciidoc -b docbook -d manpage -f asciidoc.conf $<
diff --git a/Documentation/callouts.xsl b/Documentation/callouts.xsl
new file mode 100644
index 0000000..ad03755
--- /dev/null
+++ b/Documentation/callouts.xsl
@@ -0,0 +1,16 @@
+<!-- callout.xsl: converts asciidoc callouts to man page format -->
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
+<xsl:template match="co">
+	<xsl:value-of select="concat('\fB(',substring-after(@id,'-'),')\fR')"/>
+</xsl:template>
+<xsl:template match="calloutlist">
+	<xsl:text>.sp&#10;</xsl:text>
+	<xsl:apply-templates/>
+	<xsl:text>&#10;</xsl:text>
+</xsl:template>
+<xsl:template match="callout">
+	<xsl:value-of select="concat('\fB',substring-after(@arearefs,'-'),'. \fR')"/>
+	<xsl:apply-templates/>
+	<xsl:text>.br&#10;</xsl:text>
+</xsl:template>
+</xsl:stylesheet>
-- 
1.3.1.gc672
