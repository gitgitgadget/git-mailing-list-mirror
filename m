From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] qgit4: Add a header and set the font family appropriately to the log message
Date: Thu, 8 Feb 2007 23:31:12 +0000
Message-ID: <200702082331.13095.andyparkins@gmail.com>
References: <200702082158.56463.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 09 00:36:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFIov-0005DR-UR
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 00:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965608AbXBHXgZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 18:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965670AbXBHXgZ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 18:36:25 -0500
Received: (root@vger.kernel.org) by vger.kernel.org id S965608AbXBHXgY
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Feb 2007 18:36:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:21943 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965608AbXBHXeS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 18:34:18 -0500
Received: by ug-out-1314.google.com with SMTP id 44so618870uga
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 15:34:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=e0ZXASjYzCbYpveKFOvScjhLEbRRRoyji/QN8DbSJ8sb5Pc934pqEv8YPgE5orKg6UerQ5DljPNyMjddxFy29WjE6mP0oeBte+Z0ilAwGxxy+c2FAuADdh0NlSxRXQ91Cq+ROtTSNYMg2myFI+MLRis0vkKMEBZxUpq1uxgW668=
Received: by 10.82.148.7 with SMTP id v7mr6842004bud.1170977656831;
        Thu, 08 Feb 2007 15:34:16 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 55sm3973215ugq.2007.02.08.15.34.12;
        Thu, 08 Feb 2007 15:34:14 -0800 (PST)
In-Reply-To: <200702082158.56463.andyparkins@gmail.com>
X-TUID: f7cf2c2ad6e96c06
X-UID: 231
X-Length: 2818
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39126>

I've moved the short log to be the first header row, and highlighted it
more strongly.  I've also set the font family of the log div based on
TYPE_WRITER_FONT as suggested by Marco.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 src/git.cpp |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/src/git.cpp b/src/git.cpp
index 1fa4479..a0873b6 100644
--- a/src/git.cpp
+++ b/src/git.cpp
@@ -979,15 +979,25 @@ const QString Git::getDesc(SCRef sha, QRegExp& shortLogRE, QRegExp& longLogRE) {
 		text = Qt::convertFromPlainText( c->longLog() );
 	else {
 		text = "<html><head><style type=\"text/css\">"
+				"tr.head { background-color: #a0a0e0 }\n"
 				"td.h { font-weight: bold; }\n"
 				"table { background-color: #e0e0f0; }\n"
-				"div.l { white-space: pre; font-family: Monospace; }\n"
-				"</style></head><body>\n";
-		text.append( "<div class='t'><table>\n" );
-		text.append( QString("<tr><td class='h'>Author</th> <td>" + c->author()
-					+ "</td></tr>\n<tr><td class='h'>Date</th><td>") );
+				"span.h { font-weight: bold; font-size: medium; }\n"
+				"div.l { white-space: pre; font-family: ";
+		text.append( TYPE_WRITER_FONT.family() );
+		text.append( "; }\n"
+				"</style></head><body>\n" );
+
+		text.append( "<div class='t'><table border=0 cellspacing=0 cellpadding=2>\n" );
+		text.append("<tr class='head'> <th colspan=2> <span class='h'>" );
+		text.append(colorMatch(c->shortLog(), shortLogRE));
+		text.append("</span></th></tr>\n");
+
+		text.append( QString("<tr><td class='h'>Author</td> <td>" + c->author()
+					+ "</td></tr>\n<tr><td class='h'>Date</td><td>") );
 		text.append(getLocalDate(c->authorDate()));
 		text.append("</td></tr>\n");
+
 		if (!c->isUnApplied && !c->isApplied) {
 			text.append("<tr><td class='h'>Parent</td> <td>").append(c->parents()
 					.join("</td></tr>\n<tr><td class='h'>Parent</td> <td>"));
@@ -1016,8 +1026,7 @@ const QString Git::getDesc(SCRef sha, QRegExp& shortLogRE, QRegExp& longLogRE) {
 			text.append("</td></tr>\n");
 		}
 		text.append( "</table></div>\n" );
-		text.append("\n\n<div class='l'>    " + colorMatch(c->shortLog(), shortLogRE) +
-		            '\n' + colorMatch(c->longLog(), longLogRE));
+		text.append("\n\n<div class='l'>" + colorMatch(c->longLog(), longLogRE));
 		text.append( "</div></body></html>\n" );
 	}
 //	text = Qt::convertFromPlainText(text);
-- 
1.5.0.rc1.gf4b6c
