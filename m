From: Theodore Tso <tytso@mit.edu>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Tue, 16 Oct 2007 15:57:44 -0400
Message-ID: <20071016195744.GB32132@closure.lan>
References: <20071016060456.GC13801@spearce.org> <Pine.LNX.4.64.0710161209480.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 16 22:33:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iht6s-0008AG-Q8
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 22:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbXJPUcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 16:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbXJPUcx
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 16:32:53 -0400
Received: from thunk.org ([69.25.196.29]:37301 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964893AbXJPUcw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 16:32:52 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IhtFd-0006C5-7z; Tue, 16 Oct 2007 16:42:53 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1Iht5l-00014s-Aj; Tue, 16 Oct 2007 16:32:41 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710161209480.25221@racer.site>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61250>

On Tue, Oct 16, 2007 at 12:16:28PM +0100, Johannes Schindelin wrote:
> 
> first let me thank you for being the interim maintainer.  I know it is 
> much work, and I frankly do not have the time, or nerve, to do it.  Out of 
> curiousity: did you use the scripts in "todo" to send these emails?

I've recently started trying to use some of the scripts in "todo" to
send similar "What's cooking" messages, and started wondering if they
were what Junio actually used in production to send his notes.  For
example, the scripts don't work particularly well if the refs have
been packed.  So I had to make changes such as these so they would
work for me.

I was waiting for Junio to get back from vacation to ask if he was
interested in accepting such changes, and/or changes to make the
scripts more general purpose, and possibly useful for other projects.

		     	      	     	       - Ted

diff --git a/PU b/PU
index 4b4be2b..4643a42 100755
--- a/PU
+++ b/PU
@@ -26,8 +26,8 @@ case "$#" in
 0)
 	# interactive ;-)
 	shift
-	HH=`cd .git/refs/heads && find -type f |
-	sed -e 's/^\.\///' \
+	HH=`git-show-ref --heads | awk '{print $2}' |\
+	sed -e 's;refs/heads/;;' \
 	    -e '/^naster$/d' -e '/^master$/d' -e '/^maint$/d' -e '/^pu$/d'`
 	while test "$HH"
 	do
diff --git a/RB b/RB
index 918a372..a890cfd 100755
--- a/RB
+++ b/RB
@@ -3,9 +3,9 @@
 master_sha1=`git rev-parse --verify refs/heads/master`
 LF='
 '
-(cd .git/refs/heads && find -type f) |
+git-show-ref --heads | awk '{print $2}' |
 sed -n \
-    -e 's/^\.\///' \
+    -e 's;refs/heads/;;' \
     -e '/^[^\/][^\/]\//p' |
 while read topic
 do
