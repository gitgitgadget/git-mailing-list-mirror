From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] bisect view: check for MinGW32 and MacOSX in addition to
 X11
Date: Thu, 14 Feb 2008 12:29:58 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802141228300.30505@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com, sector3@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 14 13:30:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPdET-0000Gt-2K
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 13:30:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761006AbYBNM3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 07:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760630AbYBNM3y
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 07:29:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:40359 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760225AbYBNM3y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 07:29:54 -0500
Received: (qmail invoked by alias); 14 Feb 2008 12:29:52 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp006) with SMTP; 14 Feb 2008 13:29:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18M01ISHxkMM02ZiZLnRtyZguM+yZ/9Cyad1Y3dh7
	C6JH6wKcfCH6oL
X-X-Sender: gene099@racer.site
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73873>


When deciding if gitk or git-log should be used to visualize the current
state, the environment variable DISPLAY was checked.  Now, we check
MSYSTEM (for MinGW32/MSys) and SECURITYSESSIONID (for MacOSX) in addition.

Note that there is currently no way to ssh into MinGW32, and that
SECURITYSESSIONID is not set automatically on MacOSX when ssh'ing into it.  
So this patch should be safe.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Technically, we do not even support MinGW32 yet in git.git,
	but does it really hurt?  After all, you can call cygwin's git
	from MinGW32 as well...

 git-bisect.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 6594a62..74715ed 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -331,9 +331,9 @@ bisect_visualize() {
 
 	if test $# = 0
 	then
-		case "${DISPLAY+set}" in
+		case "${DISPLAY+set}${MSYSTEM+set}${SECURITYSESSIONID+set}" in
 		'')	set git log ;;
-		set)	set gitk ;;
+		set*)	set gitk ;;
 		esac
 	else
 		case "$1" in
-- 
1.5.4.1.1353.g0d5dd
