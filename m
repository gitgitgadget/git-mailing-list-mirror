From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] mailinfo: fix 'fatal: cannot convert from utf-8 to utf-8'
Date: Tue, 24 Jul 2007 01:03:26 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707240102390.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 24 02:03:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID7sO-0002F0-7G
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 02:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646AbXGXADl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 20:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756001AbXGXADl
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 20:03:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:55245 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752971AbXGXADk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 20:03:40 -0400
Received: (qmail invoked by alias); 24 Jul 2007 00:03:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 24 Jul 2007 02:03:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18nXvcMtosnntJgl3XWq2+Ch0u93Hk1TGnS4Rrk7D
	EY5qjuxgZm/uza
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53511>


For some reason, I got this error message.  Maybe it does not make sense,
but then we should not really try to convert the text when it is not
necessary.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This bit me when I tried to apply the most recent Japanese 
	translation patch to git-gui-i18n.

 builtin-mailinfo.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index a37a4ff..b4f6e91 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -529,6 +529,8 @@ static void convert_to_utf8(char *line, const char *charset)
 			return;
 	}
 
+	if (!strcmp(metainfo_charset, charset))
+		return;
 	out = reencode_string(line, metainfo_charset, charset);
 	if (!out)
 		die("cannot convert from %s to %s\n",
-- 
1.5.3.rc2.32.g35c5b-dirty
