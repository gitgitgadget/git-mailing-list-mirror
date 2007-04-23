From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t4201-shortlog.sh does bad things to my terminal
Date: Mon, 23 Apr 2007 20:46:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704232042170.8822@racer.site>
References: <20070423170301.GL955MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0704231928270.8822@racer.site> <7vmz0zey30.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sven Verdoolaege <skimo@kotnet.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 23 20:46:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg3Yu-0007rR-UC
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 20:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161371AbXDWSqy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 14:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161383AbXDWSqy
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 14:46:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:40763 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161371AbXDWSqx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 14:46:53 -0400
Received: (qmail invoked by alias); 23 Apr 2007 18:46:52 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 23 Apr 2007 20:46:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Z/LUoqxbZ4BTZWeJ3joZwKf9zUsEwsmSDkvNF5y
	lFSZb0TAKUL8w5
X-X-Sender: gene099@racer.site
In-Reply-To: <7vmz0zey30.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45351>

Hi,

On Mon, 23 Apr 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 23 Apr 2007, Sven Verdoolaege wrote:
> >
> >> It appears that this message is printing a control character to turn off 
> >> echoing, because the terminal appears completely unresponsive 
> >> afterwards. Typing "reset" restores the terminal.
> >> 
> >> Is this really necessary?
> >
> > On both accounts, no. I did not dream of these bytes being interpreted as 
> > control characters.
> >
> > OTOH, you should not need to use --verbose anyway.
> 
> I think it's not Sven but you; you should use --quiet in your
> git commit if the log message has annoying characters.

Ah!

I see where this is coming from: c7263d4d "Display the subject of the 
commit just made".

Here's the fix:

-- snip --
[PATCH] t4201: Do not display weird characters on the terminal

Now that git-commit got chatty, we have to shut it up again.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t4201-shortlog.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index c27e39c..a48733c 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -15,19 +15,19 @@ commit=$( (echo "Test"; echo) | git commit-tree $tree )
 git update-ref HEAD $commit
 
 echo 2 > a1
-git commit -m "This is a very, very long first line for the commit message to see if it is wrapped correctly" a1
+git commit --quiet -m "This is a very, very long first line for the commit message to see if it is wrapped correctly" a1
 
 # test if the wrapping is still valid when replacing all i's by treble clefs.
 echo 3 > a1
-git commit -m "$(echo "This is a very, very long first line for the commit message to see if it is wrapped correctly" | sed "s/i/1234/g" | tr 1234 '\360\235\204\236')" a1
+git commit --quiet -m "$(echo "This is a very, very long first line for the commit message to see if it is wrapped correctly" | sed "s/i/1234/g" | tr 1234 '\360\235\204\236')" a1
 
 # now fsck up the utf8
 git repo-config i18n.commitencoding non-utf-8
 echo 4 > a1
-git commit -m "$(echo "This is a very, very long first line for the commit message to see if it is wrapped correctly" | sed "s/i/1234/g" | tr 1234 '\370\235\204\236')" a1
+git commit --quiet -m "$(echo "This is a very, very long first line for the commit message to see if it is wrapped correctly" | sed "s/i/1234/g" | tr 1234 '\370\235\204\236')" a1
 
 echo 5 > a1
-git commit -m "a								12	34	56	78" a1
+git commit --quiet -m "a								12	34	56	78" a1
 
 git shortlog -w HEAD > out
 
-- 
1.5.2.rc0.2414.g4e945
