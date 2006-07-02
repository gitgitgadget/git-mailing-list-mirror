From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Makefile: replace ugly and unportable sed invocation
Date: Sun, 2 Jul 2006 11:31:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607021109540.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vr7145u17.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 11:31:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwyIh-0002qo-9u
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 11:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932800AbWGBJbc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 05:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932802AbWGBJbc
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 05:31:32 -0400
Received: from mail.gmx.de ([213.165.64.21]:48048 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932800AbWGBJbb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jul 2006 05:31:31 -0400
Received: (qmail invoked by alias); 02 Jul 2006 09:31:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 02 Jul 2006 11:31:30 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7145u17.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23097>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
	Re: What's in git.git

	On Sun, 2 Jul 2006, Junio C Hamano wrote:

	>  - instaweb by Eric Wong.

	This breaks make on _all_ platforms I have.

	First of all, it is _ugly_ (three invocations of sed, where one 
	really is sufficient). Then, it uses the non-portable ';' 
	operator, and then, the non-at-all-portable 'T'.

	And worst: it is unnecessary.

 Makefile |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 7481ad9..90ad991 100644
--- a/Makefile
+++ b/Makefile
@@ -562,11 +562,11 @@ git-instaweb: git-instaweb.sh gitweb/git
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
 	    -e 's/@@NO_PYTHON@@/$(NO_PYTHON)/g' \
-	    $@.sh | sed \
-	    -e 's|@@GITWEB_CGI@@|#!$(PERL_PATH_SQ)|; T; r gitweb/gitweb.cgi' \
-	    | sed \
-	    -e 's|@@GITWEB_CSS@@||; T; r gitweb/gitweb.css' \
-	    > $@+
+	    -e '/@@GITWEB_CGI@@/rgitweb/gitweb.cgi' \
+	    -e '/@@GITWEB_CGI@@/d' \
+	    -e '/@@GITWEB_CSS@@/rgitweb/gitweb.css' \
+	    -e '/@@GITWEB_CSS@@/d' \
+	    $@.sh > $@+
 	chmod +x $@+
 	mv $@+ $@
 
-- 
1.4.1.g1089
