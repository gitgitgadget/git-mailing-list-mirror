From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC/PATCH] git-web--browse: don't add start as candidate on Ubuntu
Date: Thu, 01 Jan 2009 21:45:08 +0000
Message-ID: <495D3964.6040006@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 01 23:05:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIVez-000470-Na
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 23:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297AbZAAWDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 17:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbZAAWDg
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 17:03:36 -0500
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:51536 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751530AbZAAWDf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jan 2009 17:03:35 -0500
X-Greylist: delayed 982 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Jan 2009 17:03:35 EST
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1LIVNm-00069R-m7; Thu, 01 Jan 2009 21:47:11 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104332>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi *,

When upgrading to v1.6.1, I noticed that the html help had stopped
working on Linux (Ububtu), viz:

    $ git help -w tag
    start: Need to be root

So, after squinting at git-web--browse.sh, I tried a few things:

    $ ls /bin/start
    ls: /bin/start: No such file or directory
    $ test -n /bin/start; echo $?
    0
    $ which start
    /sbin/start
    $ start fred
    start: Need to be root
    $ ls -l /sbin/start
    lrwxrwxrwx 1 root root 7 2007-06-24 19:45 /sbin/start -> initctl*

So, it would seem that /sbin/start is part of upstart, which would
explain the "Need to be root" ;-)

    $ test -x /bin/start; echo $?
    1
    $ 

So, the patch below fixes the issue for me, but as I don't have MinGW
installed, I can't test this fix works there.

Does anybody else see this issue and can someone test the patch?

ATB,
Ramsay Jones

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
1.6.1
