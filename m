From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Documentation: Replace @@GIT_VERSION@@ in documentation
Date: Sun, 25 Mar 2007 22:45:50 -0700
Message-ID: <7v3b3s1rsh.fsf@assigned-by-dhcp.cox.net>
References: <7vircqe389.fsf@assigned-by-dhcp.cox.net>
	<11748238102228-git-send-email-frank@lichtenheld.de>
	<7v7it41scp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Mon Mar 26 07:46:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVi1q-0006d9-AP
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 07:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbXCZFpw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 01:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752670AbXCZFpw
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 01:45:52 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:34059 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbXCZFpv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 01:45:51 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070326054551.SYLS748.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 26 Mar 2007 01:45:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id fHlr1W0041kojtg0000000; Mon, 26 Mar 2007 01:45:51 -0400
In-Reply-To: <7v7it41scp.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 25 Mar 2007 22:33:42 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43113>

Junio C Hamano <junkio@cox.net> writes:

> Ideally if we can persuade asciidoc to output to its stdout, we
> could do this:
>
> 	rm -f $@+ $@
>         $(ASCIIDOC) --to-stdout ... | sed -e $(script) >$@+
>         mv $@+ $@

like this perhaps.

---

 Documentation/Makefile |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index de6cc6e..e82596d 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -100,16 +100,20 @@ clean:
 	rm -f $(cmds_txt)
 
 %.html : %.txt
-	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf $(ASCIIDOC_EXTRA) $<
-	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' $@ >$@+
+	rm -f $@+ $@
+	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf \
+		$(ASCIIDOC_EXTRA) -o - $< | \
+		sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' >$@+
 	mv $@+ $@
 
 %.1 %.7 : %.xml
 	xmlto -m callouts.xsl man $<
 
 %.xml : %.txt
-	$(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf $<
-	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' $@ >$@+
+	rm -f $@+ $@
+	$(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf \
+		$(ASCIIDOC_EXTRA) -o - $< | \
+		sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' >$@+
 	mv $@+ $@
 
 user-manual.xml: user-manual.txt user-manual.conf
