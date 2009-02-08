From: Todd Zullinger <tmz@pobox.com>
Subject: [PATCH 1/2] git-web--browse: Fix check for /bin/start
Date: Sun, 8 Feb 2009 18:12:43 -0500
Message-ID: <e44161a223e7ec2cfb1f1b71399b995626c2d208.1234127422.git.tmz@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Feb 09 00:14:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWIqu-0001cr-L4
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 00:14:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbZBHXMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 18:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753394AbZBHXMt
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 18:12:49 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56228 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbZBHXMs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 18:12:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 78CBE98F15;
	Sun,  8 Feb 2009 18:12:46 -0500 (EST)
Received: from inocybe.teonanacatl.org (unknown [71.173.205.56]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E096C98F14; Sun,
  8 Feb 2009 18:12:44 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Pobox-Relay-ID: FF194A14-F635-11DD-BB61-8B21C92D7133-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109024>

The previous check in git-web--browse for /bin/start used test -n
/bin/start, which was always true.  This lead to "start" being tried
first in the browser list.  On systems with upstart installed, "start"
exists and might be in the PATH, but it makes a poor choice for a web
browser.  Instead, test that /bin/start exists and is executable.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

This test is still a bit fragile, as it relies on the start from
upstart not being installed in /bin.  I don't know if that's something
we can count on or not.  If not, the test needs to be extended to
differentiate between the MingW's start and upstart's start.  Does the
MingW start have a --version string or something we could check before
adding start to the list?

 git-web--browse.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index 78d236b..7ed0fad 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -115,7 +115,7 @@ if test -z "$browser" ; then
 	browser_candidates="open $browser_candidates"
     fi
     # /bin/start indicates MinGW
-    if test -n /bin/start; then
+    if test -x /bin/start; then
 	browser_candidates="start $browser_candidates"
     fi

-- 
1.6.1.3

-- 
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Honesty is the best policy, but insanity is a better defense.
