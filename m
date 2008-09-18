From: Chris Frey <cdfrey@foursquare.net>
Subject: [PATCH] Documentation: clarify the details of overriding LESS via core.pager
Date: Thu, 18 Sep 2008 19:22:07 -0400
Message-ID: <20080918232207.GA31193@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 19 01:28:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgSva-0002TK-SY
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 01:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715AbYIRX1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 19:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754235AbYIRX1i
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 19:27:38 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:50122 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbYIRX1i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 19:27:38 -0400
X-Greylist: delayed 312 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Sep 2008 19:27:37 EDT
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id m8INM7Fw000561
	for <git@vger.kernel.org>; Thu, 18 Sep 2008 19:22:07 -0400
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-16.8, required 5,
	autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: <cdfrey@netdirect.ca>
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96253>

The process of overriding the default LESS options using only
git-specific methods is rather obscure.  Show the end user how
to do it in a step-by-step manner.

Signed-off-by: Chris Frey <cdfrey@foursquare.net>
---

I recently upgraded to 1.6.0.2, and ran into the LESS problem again.
I usually just hacked the code, but figured this was sub-par, expecially
with the documentation recently upgraded to show me how to do it
with core.pager.

Unfortunately, it took me much longer than I would have expected.

I'm assuming others will have run into this as well, so here's
an update to the docs.

The most interesting feature I discovered while looking into this,
was that setting command line options in core.pager ends up using
the shell, which allows for additional trickery to make this
override truly git-specific.

Now I can have different less behaviour when using it myself vs.
using it through git.  In the same shell.  Regardless of how I
setup LESS.

- Chris


 Documentation/config.txt |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 922ac7b..9493621 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -363,8 +363,17 @@ core.pager::
 	variable.  Note that git sets the `LESS` environment
 	variable to `FRSX` if it is unset when it runs the
 	pager.  One can change these settings by setting the
-	`LESS` variable to some other value or by giving the
-	`core.pager` option a value such as "`less -+FRSX`".
+	`LESS` variable to some other value.  Alternately,
+	these settings can be overridden on a project or
+	global basis by setting the `core.pager` option.
+	Setting `core.pager` has no affect on the `LESS`
+	environment variable behaviour above, so if you want
+	to override git's default settings this way, you need
+	to be explicit.  For example, to disable the S option
+	in a backward compatible manner, set `core.pager`
+	to "`less -+$LESS -FRX`".  This will be passed to the
+	shell by git, which will translate the final command to
+	"`LESS=FRSX less -+FRSX -FRX`".
 
 core.whitespace::
 	A comma separated list of common whitespace problems to
-- 
1.6.0.2
