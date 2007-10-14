From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] parse-options: Allow abbreviated options when unambiguous
Date: Sun, 14 Oct 2007 19:02:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710141901450.25221@racer.site>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org>
 <20071014091855.GA17397@soma> <20071014095755.GF1198@artemis.corp>
 <Pine.LNX.4.64.0710141751530.25221@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Oct 14 20:02:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih7ne-0008C3-Rf
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 20:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285AbXJNSCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 14:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753904AbXJNSCj
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 14:02:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:50663 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753373AbXJNSCj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 14:02:39 -0400
Received: (qmail invoked by alias); 14 Oct 2007 18:02:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 14 Oct 2007 20:02:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18t4l91gGYtsmecQgPbJ9Ywo7PrTo3xrg8U1ErA74
	DL4Jf6z0K486Z1
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0710141751530.25221@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60885>

Hi,

On Sun, 14 Oct 2007, Johannes Schindelin wrote:

> When there is an option "--amend", the option parser now recognizes 
> "--am" for that option, provided that there is no other option beginning 
> with "--am".

And an amend for ultra-abbreviated options (as you noticed on IRC):

diff --git a/parse-options.c b/parse-options.c
index afc6c89..acabb98 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -137,6 +137,11 @@ is_abbreviated:
 				abbrev_flags = flags;
 				continue;
 			}
+			/* negated and abbreviated very much? */
+			if (!prefixcmp("no-", arg)) {
+				flags |= OPT_UNSET;
+				goto is_abbreviated;
+			}
 			/* negated? */
 			if (strncmp(arg, "no-", 3))
 				continue;
