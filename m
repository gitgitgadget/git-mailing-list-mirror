From: David Symonds <dsymonds@gmail.com>
Subject: [PATCH] Prevent purely-numeric ref names from breaking Javascript.
Date: Tue,  2 Oct 2007 01:37:02 +1000
Message-ID: <11912530222348-git-send-email-dsymonds@gmail.com>
Cc: git@vger.kernel.org, David Symonds <dsymonds@gmail.com>
To: pasky@ucw.cz
X-From: git-owner@vger.kernel.org Mon Oct 01 17:42:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcNPa-0002Lx-HX
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 17:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbXJAPmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 11:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbXJAPmN
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 11:42:13 -0400
Received: from ipmail02.adl2.internode.on.net ([203.16.214.141]:21304 "EHLO
	ipmail02.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751733AbXJAPmN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Oct 2007 11:42:13 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Oct 2007 11:42:12 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAH6xAEd5LDtG/2dsb2JhbACBWQ
X-IronPort-AV: E=Sophos;i="4.21,217,1188743400"; 
   d="scan'208";a="198206847"
Received: from ppp121-44-59-70.lns10.syd7.internode.on.net (HELO localhost.localdomain) ([121.44.59.70])
  by ipmail02.adl2.internode.on.net with ESMTP; 02 Oct 2007 01:07:06 +0930
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59622>

When the server reply carrying JSON data to the client browser to render has
a string that looks like a decimal number, it doesn't get quoted. The
client-side Javascript code assumes, however, that all the ref names are
strings, and so calls string functions on decimal number objects if the ref
name is purely numeric (e.g. "2.5"). This patch simply forces the objects that
are escaped for HTML presentation to be coerced into strings, which catches
this case (and possibly others).
---
 by-commit.html |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/by-commit.html b/by-commit.html
index d759c3e..0aa69b9 100644
--- a/by-commit.html
+++ b/by-commit.html
@@ -35,6 +35,7 @@ format_log_date=function( date )
 }
 escape_html=function( s )
 {
+	s=s+"";	// ensure it's a string
 	s=s.replace( /\&/g, "&amp;" );
 	s=s.replace( /\</g, "&lt;" );
 	s=s.replace( /\>/g, "&gt;" );
-- 
1.5.3.1
