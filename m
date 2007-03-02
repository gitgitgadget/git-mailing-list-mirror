From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] print_wrapped_text: fix output for negative indent
Date: Fri, 2 Mar 2007 15:28:00 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703021526210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702271621120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0702280258200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LRH.0.82.0702272147590.29426@xanadu.home>
 <Pine.LNX.4.63.0702281343200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vslcoghcd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Simon Josefsson <simon@josefsson.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 02 15:28:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN8jw-0005Kn-Vj
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 15:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992485AbXCBO2F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 09:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992484AbXCBO2F
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 09:28:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:33588 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992485AbXCBO2D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 09:28:03 -0500
Received: (qmail invoked by alias); 02 Mar 2007 14:28:01 -0000
X-Provags-ID: V01U2FsdGVkX1/hneRDxDfhtZVaHKLKPAYyVk9Ph0d7UrNarpvkmJ
	Jg5v+McgWgi1ka
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vslcoghcd.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41209>


When providing a negative indent, it means that -indent columns were
already printed. Fix a bug where the function ate the first character
if already the first word did not fit into the first line.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
	On Fri, 2 Mar 2007, Junio C Hamano wrote:

	> Is it just me or is your word wrapper misbehaving?

	It was. It separated printing of the file name and of the comma. 
	This is fixed with my next reply, but it triggered this small
	bug.

 utf8.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/utf8.c b/utf8.c
index ea23a6e..9e1a6d4 100644
--- a/utf8.c
+++ b/utf8.c
@@ -268,7 +268,7 @@ int print_wrapped_text(const char *text, int indent, int indent2, int width)
 			}
 			else {
 				putchar('\n');
-				text = bol = space + 1;
+				text = bol = space + isspace(*space);
 				space = NULL;
 				w = indent = indent2;
 			}
-- 
1.5.0.2.780.g57e5-dirty
