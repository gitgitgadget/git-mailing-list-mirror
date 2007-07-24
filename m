From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: rewrite only refs which were not 
 excludedbythe options
Date: Tue, 24 Jul 2007 14:46:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241445470.14781@racer.site>
References: <Pine.LNX.4.64.0707231829210.14781@racer.site>  
 <46A5C615.24C24F0F@eudaptics.com> <Pine.LNX.4.64.0707241205480.14781@racer.site>
  <46A5E136.D413D3B7@eudaptics.com> <Pine.LNX.4.64.0707241229170.14781@racer.site>
 <46A5FFBB.2F3B12CF@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 15:47:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDKjM-00025y-3X
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 15:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754663AbXGXNrM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 09:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753212AbXGXNrM
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 09:47:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:33426 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754149AbXGXNrL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 09:47:11 -0400
Received: (qmail invoked by alias); 24 Jul 2007 13:47:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 24 Jul 2007 15:47:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19nGsZXIHpnaiUfrbe69PzzLoM2krdxA8IfZajkzi
	kjFz5sQH/mIiJh
X-X-Sender: gene099@racer.site
In-Reply-To: <46A5FFBB.2F3B12CF@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53593>

Hi,

On Tue, 24 Jul 2007, Johannes Sixt wrote:

> Johannes Schindelin wrote:
> > negatives="$(git rev-parse "$@" | while read line
> >         do
> >                 case "$line" in
> >                 $_x40) ;;
> >                 *) echo "$line";;
> >                 esac
> >         done)"
> 
> Ah, and you must move the definition of _x40 up a couple of lines.

D'oh.  Of course.

When I have more tests, and thought about the problem I hinted at in 
another mail, I'll send a cleaned up patch series.  Promised.  Rebase -i 
is good.

Ciao,
Dscho

---

 git-filter-branch.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 3fa2f63..8107a6c 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -11,6 +11,9 @@
 USAGE="git-filter-branch [-d TEMPDIR] [FILTERS] DESTBRANCH [REV-RANGE]"
 . git-sh-setup
 
+_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+
 warn () {
         echo "$*" >&2
 }
@@ -322,8 +325,6 @@ done < "$tempdir"/heads
 
 # Finally update the refs
 
-_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 count=0
 echo
 while read ref
