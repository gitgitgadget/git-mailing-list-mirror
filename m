From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 1/2] Documentation: Add asciidoc.conf file and gitlink: macro
Date: Mon, 19 Sep 2005 14:10:14 +0400
Message-ID: <20050919101014.GB28095@master.mivlgu.local>
References: <20050919100914.GA28095@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 12:11:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHIbP-0003dY-94
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 12:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbVISKKS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 06:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbVISKKS
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 06:10:18 -0400
Received: from mivlgu.ru ([81.18.140.87]:9943 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S932404AbVISKKQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 06:10:16 -0400
Received: by master.mivlgu.local (Postfix, from userid 1000)
	id 7AE0F180110; Mon, 19 Sep 2005 14:10:14 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20050919100914.GA28095@master.mivlgu.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8851>

Introduce an asciidoc.conf file with the purpose of adding a gitlink:
macro which will improve the manpage output.

Original cogito patch by Jonas Fonseca <fonseca@diku.dk>;
asciidoc.conf from that patch was further enhanced to use the proper
DocBook tag <citerefentry> for references to man pages.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>


---

 Documentation/Makefile      |    4 ++--
 Documentation/asciidoc.conf |   21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/asciidoc.conf

9cd024949ba411edbb041faf03bdc03c825e76b4
diff --git a/Documentation/Makefile b/Documentation/Makefile
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -57,13 +57,13 @@ clean:
 	rm -f *.xml *.html *.1 *.7 howto-index.txt howto/*.html
 
 %.html : %.txt
-	asciidoc -b xhtml11 -d manpage $<
+	asciidoc -b xhtml11 -d manpage -f asciidoc.conf $<
 
 %.1 %.7 : %.xml
 	xmlto man $<
 
 %.xml : %.txt
-	asciidoc -b docbook -d manpage $<
+	asciidoc -b docbook -d manpage -f asciidoc.conf $<
 
 git.html: git.txt ../README
 
diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
new file mode 100644
--- /dev/null
+++ b/Documentation/asciidoc.conf
@@ -0,0 +1,21 @@
+## gitlink: macro
+#
+# Usage: gitlink:command[manpage-section]
+#
+# Note, {0} is the manpage section, while {target} is the command.
+#
+# Show GIT link as: <command>(<section>); if section is defined, else just show
+# the command.
+
+ifdef::backend-docbook[]
+[gitlink-inlinemacro]
+{0%{target}}
+{0#<citerefentry>}
+{0#<refentrytitle>{target}</refentrytitle><manvolnum>{0}</manvolnum>}
+{0#</citerefentry>}
+endif::backend-docbook[]
+
+ifdef::backend-xhtml11[]
+[gitlink-inlinemacro]
+<a href="{target}.html">{target}{0?({0})}</a>
+endif::backend-xhtml11[]
