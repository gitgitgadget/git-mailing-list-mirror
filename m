From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] perl bindings fix compilation errors
Date: Tue, 26 Sep 2006 10:34:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609261031430.25371@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060925100319.GA1655@shadowen.org>
 <Pine.LNX.4.63.0609251223590.25371@wbgn013.biozentrum.uni-wuerzburg.de>
 <4517BEBC.4000002@shadowen.org> <7vfyeftehf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Whitcroft <apw@shadowen.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 10:34:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS8OX-0001Or-2Q
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 10:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWIZIeW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 04:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWIZIeW
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 04:34:22 -0400
Received: from mail.gmx.de ([213.165.64.20]:33963 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750822AbWIZIeV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 04:34:21 -0400
Received: (qmail invoked by alias); 26 Sep 2006 08:34:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 26 Sep 2006 10:34:19 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyeftehf.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27785>

Hi,

On Mon, 25 Sep 2006, Junio C Hamano wrote:

> It is certainly incorrect to say that it is a driver error to
> git-pull (or git-checkout to switch branches) without running
> "make clean" first to get rid of perl/Git.c while your Makefile
> still knows it is a generated file.  Our Makefile should be more
> helpful.

How about this:

diff --git a/Makefile b/Makefile
index d3310ae..a722c5a 100644
--- a/Makefile
+++ b/Makefile
@@ -612,7 +612,14 @@ ### Build rules
 all: $(ALL_PROGRAMS) $(BUILT_INS) git$X gitk gitweb/gitweb.cgi \
 	git-merge-recur$X
 
-all: perl/Makefile
+# work around for left-over files
+.PHONY: perl/check-left-over
+
+perl/check-left-over:
+	(test -f perl/Git.c && test ! -f perl/Git.xs \
+	 && rm perl/{Git.c,Git.bs,Makefile}) || true
+
+all: perl/check-left-over perl/Makefile
 	$(MAKE) -C perl
 	$(MAKE) -C templates
 
