From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Read cvsimport options from repo-config
Date: Sat, 10 Feb 2007 21:13:53 -0800
Message-ID: <20070211051353.GA9481@localdomain>
References: <3f80363f0702051722x1812228fp1cd7a41dd32b31f3@mail.gmail.com> <7vireflxna.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Bowes <jbowes@dangerouslyinc.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 11 06:14:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HG72I-0000n1-TN
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 06:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbXBKFN4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 00:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752743AbXBKFNz
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 00:13:55 -0500
Received: from hand.yhbt.net ([66.150.188.102]:55375 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752708AbXBKFNz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 00:13:55 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id C754C7DC09A;
	Sat, 10 Feb 2007 21:13:53 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 10 Feb 2007 21:13:53 -0800
Content-Disposition: inline
In-Reply-To: <7vireflxna.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39272>

Junio C Hamano <junkio@cox.net> wrote:
> I find what your patch does quite sensible, although the
> split(/ *(?!:)/) magic might be a bit hard to read for the
> uninitiated.
> 
> > +		my $arg = 'git-repo-config';
> > +		$arg .= ' --bool' if ($o !~ /:$/);
> > +
> > +        chomp(my $tmp = `$arg --get cvsimport.$key`);
> > +		if ($tmp && !($arg =~ / --bool / && $tmp eq 'false')) {
> 
> Can this =~ / --bool / ever match (note the SP after 'l')?

Heh, the same bug has been in git-svn for ages, too.

>From 0bece11c0019a7d2a2dcb71c42536ee45f523c47 Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Sat, 10 Feb 2007 21:07:12 -0800
Subject: [PATCH] git-svn: correctly handle boolean options via git-config

We don't append a space after '--bool', so we can't expect
a regular expression to match the space.

Semi-noticed by Junio C Hamano :)

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 8ebaae9..d792a62 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1610,7 +1610,7 @@ sub read_repo_config {
 			@$v = @tmp if @tmp;
 		} else {
 			chomp(my $tmp = `$arg --get svn.$key`);
-			if ($tmp && !($arg =~ / --bool / && $tmp eq 'false')) {
+			if ($tmp && !($arg =~ / --bool/ && $tmp eq 'false')) {
 				$$v = $tmp;
 			}
 		}
-- 
Eric Wong
