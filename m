From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix "apply --reverse" with regard to whitespace
Date: Sun, 8 Jul 2007 13:47:05 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707081344000.4248@racer.site>
References: <Pine.LNX.4.64.0707062155170.6977@iabervon.org>
 <Pine.LNX.4.64.0707071849430.4093@racer.site> <7vd4z32rqc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 14:54:46 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7WHl-0006BQ-NK
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 14:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbXGHMye (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 08:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbXGHMyd
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 08:54:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:47576 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751098AbXGHMyd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 08:54:33 -0400
Received: (qmail invoked by alias); 08 Jul 2007 12:54:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp058) with SMTP; 08 Jul 2007 14:54:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/HSmouUqHHFsoj9Hj4aUQnddyjXB25GhSLhNoLyd
	hH72wqeX14KCBR
X-X-Sender: gene099@racer.site
In-Reply-To: <7vd4z32rqc.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51879>

Hi,

On Sun, 8 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > "git apply" used to take check the whitespace in the wrong
> > direction.
> >
> > Noticed by Daniel Barkalow.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >
> > 	On Fri, 6 Jul 2007, Daniel Barkalow wrote:
> >
> > 	> If you apply in reverse a patch which adds junk (e.g., terminal
> > 	> whitespace), it complains about the junk you're adding, even 
> > 	> though (since it's in reverse) you're actually removing that 
> > 	> junk.
> >
> > 	This fixes it.
> 
> Hmm.  Does this cover the "trailing blank lines removal" as
> well?

-- snip --
diff --git a/TODO b/TODO
index ecd2b85..8935376 100644
--- a/TODO
+++ b/TODO
@@ -1,6 +1,5 @@
+interdiff between commits
 diff with file/symlink
-remote remove <nick>
-libification: setjmp() error handler with xmalloc(), xcalloc(), xfree() handling
 fix diff_filepair() mess in diff.c
 merge -s rebase
 build in ls-remote
diff --git a/t/t4116-apply-reverse.sh b/t/t4116-apply-reverse.sh
index 9ae2b3a..f3f9181 100755
--- a/t/t4116-apply-reverse.sh
+++ b/t/t4116-apply-reverse.sh
@@ -84,6 +84,7 @@ test_expect_success 'apply in reverse without postimage' '
 
 test_expect_success 'reversing a whitespace introduction' '
 	sed "s/a/a /" < file1 > file1.new &&
+	echo >> file1.new &&
 	mv file1.new file1 &&
 	git diff | git apply --reverse --whitespace=error
 '
-- snap --

Apparently.

Or not.  Since a patch adding empty lines does not trigger any error with 
--whitespace=error.  I just tested that.

Ciao,
Dscho
