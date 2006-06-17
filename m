From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git-1.4.0 make problems
Date: Sat, 17 Jun 2006 23:55:15 +0200
Message-ID: <44947A43.7070909@lsrfire.ath.cx>
References: <200606170218.k5H2I0o0003192@grail.cba.csuohio.edu>	<4493A810.6010706@lsrfire.ath.cx> <7vbqsra4d2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Somos <somos@grail.cba.csuohio.edu>
X-From: git-owner@vger.kernel.org Sat Jun 17 23:55:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrilI-0004Mf-6j
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 23:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWFQVzR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 17:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWFQVzR
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 17:55:17 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:61912
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1750964AbWFQVzP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jun 2006 17:55:15 -0400
Received: from [10.0.1.3] (p508E50CB.dip.t-dialin.net [80.142.80.203])
	by neapel230.server4you.de (Postfix) with ESMTP id 6E82B2E074;
	Sat, 17 Jun 2006 23:55:14 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqsra4d2.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22035>

Junio C Hamano schrieb:
> I've been using (in my non-git related project aka day-job)
> 
> git-tar-tree HEAD^{tree} $(PROJECT)-$(RELNAME) >$(PROJECT)-$(RELNAME).tar
> 
> to avoid this.  Although all of my target machines have gtar that are
> recent enough so I do not need it, but when the tarball has version
> string in its name, there is not much point having the pax header to
> identify the contents (where the pax header shines is when the result
> does not have the version string in its name).
> 
> This might be a sensible thing to do for our dist target as well.
> The product of our dist target is for people who build from the
> source to bootstrap themselves (if they have git, then fetching the
> source using git is preferred anyway), as opposed to using pre-built
> binaries, so being as friendly as we can to different implementations
> of tar is a good thing.

Hrm.  Is the header really that unfriendly?  With a non-POSIX tar you
get an extra file and a nice, if somewhat cryptic, reminder to upgrade
your archiver. ;-)  Seriously, this is way below my annoyance-radar,
but I'm obviously biased.

What do you think about the following patch for starters?  It adds an
example to the git-tar-tree documentation showing your "tree trick"
and corrects two formatting buglets.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

diff --git a/Documentation/git-tar-tree.txt b/Documentation/git-tar-tree.txt
index 831537b..c93a8fe 100644
--- a/Documentation/git-tar-tree.txt
+++ b/Documentation/git-tar-tree.txt
@@ -45,11 +45,16 @@ git tar-tree HEAD | (cd /var/tmp/ && mkd
 	latest commit on the current branch, and extracts it in
 	`/var/tmp/junk` directory.
 
-git tar-tree v2.6.17 linux-2.6.17 | gzip >linux-2.6.17.tar.gz
+git tar-tree v2.6.17 linux-2.6.17 | gzip >linux-2.6.17.tar.gz::
 
 	Create a tarball for v2.6.17 release.
 
-git tar-tree --remote=example.com:git.git v0.99 >git-0.99.tar
+git tar-tree v2.6.17{caret}\{tree\} linux-2.6.17 | gzip >linux-2.6.17.tar.gz::
+
+	Create a tarball for v2.6.17 release, but without a
+	global extended pax header.
+
+git tar-tree --remote=example.com:git.git v0.99 >git-0.99.tar::
 
 	Get a tarball v0.99 from example.com.
 
