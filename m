From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH/RFH] Mark user-manual as UTF-8
Date: Tue, 24 Jul 2007 00:46:35 -0700
Message-ID: <7vwswqgs6c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@citi.umich.edu>,
	"H. Peter Anvin" <hpa@zytor.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 24 09:46:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDF6V-0006t5-8K
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 09:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbXGXHqh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 03:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbXGXHqh
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 03:46:37 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:64150 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbXGXHqg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 03:46:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070724074635.PPZS1428.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 24 Jul 2007 03:46:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TKmb1X0081kojtg0000000; Tue, 24 Jul 2007 03:46:36 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53531>

There have been several complaints against k.org's user-manual
page.  The document is generated in ISO-8859-1 by the xsltproc
toolchain (I suspect this is because released docbook.xsl we use
has xsl:output element that says the output is ISO-8859-1) but
server delivers it with "charset=UTF-8", and all h*ll breaks
loose.

This attempts to force UTF-8 on the generating end.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I have to warn that I do not really think I know what I am
   doing, but this seems to "work for me".

 Documentation/Makefile    |    2 +-
 Documentation/docbook.xsl |    5 +++++
 2 files changed, 6 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/docbook.xsl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b062757..3bc5357 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -131,7 +131,7 @@ clean:
 user-manual.xml: user-manual.txt user-manual.conf
 	$(ASCIIDOC) -b docbook -d book $<
 
-XSLT = http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl
+XSLT = docbook.xsl
 XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
 
 user-manual.html: user-manual.xml
diff --git a/Documentation/docbook.xsl b/Documentation/docbook.xsl
new file mode 100644
index 0000000..9a6912c
--- /dev/null
+++ b/Documentation/docbook.xsl
@@ -0,0 +1,5 @@
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
+		version='1.0'>
+ <xsl:import href="http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl"/>
+ <xsl:output method="html" encoding="UTF-8" indent="no" />
+</xsl:stylesheet>
