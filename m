From: Jean-Luc Herren <jlh@gmx.ch>
Subject: [PATCH] Make default pre-commit hook less noisy
Date: Mon, 14 Jan 2008 22:47:42 +0100
Message-ID: <478BD87E.7030606@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 22:48:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEXAD-0001Ne-Ud
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 22:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbYANVrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 16:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbYANVrp
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 16:47:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:59301 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750801AbYANVrp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 16:47:45 -0500
Received: (qmail invoked by alias); 14 Jan 2008 21:47:42 -0000
Received: from 70-185.1-85.cust.bluewin.ch (EHLO [192.168.123.202]) [85.1.185.70]
  by mail.gmx.net (mp007) with SMTP; 14 Jan 2008 22:47:42 +0100
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX19mvVAf9cBmpcdSw3s9eC0y3duMzE5NpsyhK/mVLd
	b6AZWjdGDLpdB0
User-Agent: Thunderbird 2.0.0.9 (X11/20071118)
X-Enigmail-Version: 0.95.5
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70481>

This hook thought to have found a conflict marker any time it saw
a 7-character combination of any of the characters '<>=' at the
beginning of a line, whereas it should only look for the *same*
character to appear repeatedly.

Also, restrict it to match exactly 7 times, to avoid matching the
underlining with '='-characters often used in documentation.

Signed-off-by: Jean-Luc Herren <jlh@gmx.ch>
---
As far as I know, this will still properly match all conflict
markers, even those by cvs or svn.

 templates/hooks--pre-commit |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit
index 7092bae..b25dce6 100644
--- a/templates/hooks--pre-commit
+++ b/templates/hooks--pre-commit
@@ -61,7 +61,7 @@ perl -e '
 	    if (/^\s* \t/) {
 		bad_line("indent SP followed by a TAB", $_);
 	    }
-	    if (/^(?:[<>=]){7}/) {
+	    if (/^([<>])\1{6} |^={7}$/) {
 		bad_line("unresolved merge conflict", $_);
 	    }
 	}
-- 
1.5.3.8
