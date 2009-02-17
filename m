From: Ward Wouts <ward@wouts.nl>
Subject: git-svn error: Unable to parse date
Date: Tue, 17 Feb 2009 10:48:50 +0100
Message-ID: <20090217094850.GQ7504@wouts.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 11:01:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZMlj-00071n-9c
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 11:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbZBQKAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 05:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbZBQKAG
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 05:00:06 -0500
Received: from mailhost.tue.nl ([131.155.3.8]:57711 "EHLO mailhost.tue.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090AbZBQKAF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 05:00:05 -0500
X-Greylist: delayed 669 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Feb 2009 05:00:04 EST
Received: from localhost (localhost [127.0.0.1])
	by mailhost.tue.nl (Postfix) with ESMTP id 4802F6D44E
	for <git@vger.kernel.org>; Tue, 17 Feb 2009 10:48:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at tue.nl
Received: from mailhost.tue.nl ([131.155.3.8])
	by localhost (kweetal.tue.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EbHFfFUxpBvc for <git@vger.kernel.org>;
	Tue, 17 Feb 2009 10:48:51 +0100 (CET)
Received: from umta.win.tue.nl (umta.win.tue.nl [131.155.71.100])
	by mailhost.tue.nl (Postfix) with ESMTP id 14A816D447
	for <git@vger.kernel.org>; Tue, 17 Feb 2009 10:48:51 +0100 (CET)
Received: from sandcat.nl (pcwin165 [131.155.69.121])
	by umta.win.tue.nl (Postfix) with ESMTP id C5F5E4BC124
	for <git@vger.kernel.org>; Tue, 17 Feb 2009 10:48:50 +0100 (CET)
Received: by sandcat.nl (Postfix, from userid 1104)
	id F330E11407C; Tue, 17 Feb 2009 10:48:50 +0100 (CET)
Content-Disposition: inline
X-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110348>

Hello,

I got the following error message while trying to fetch a subversion
repository:

$ git svn init file:///home/mg/svn/mg git-svn-test
Initialized empty Git repository in /home/ward/worktrees/git-svn-test/.git/
$ cd git-svn-test
$ git svn fetch

r59 = c20f5b6c61bb8b2babc1b3644b6372e023d9d428 (git-svn)
W: +empty_dir: CFE
r60 = 1b8ad7c39dd60897319545c9f3f08b3b2b82b863 (git-svn)
        A       CFE/Makefile
Unable to parse date: 2004-03-09T09:44:33.Z
 at /usr/bin/git-svn line 3995


The message goes away with this one character patch:

$ diff -bru git-svn*
--- git-svn     2009-02-17 10:23:24.000000000 +0100
+++ git-svn.orig        2009-02-17 10:20:30.000000000 +0100
@@ -2387,7 +2387,7 @@
 sub parse_svn_date {
        my $date = shift || return '+0000 1970-01-01 00:00:00';
        my ($Y,$m,$d,$H,$M,$S) = ($date =~ /^(\d{4})\-(\d\d)\-(\d\d)T
-                                           (\d\d)\:(\d\d)\:(\d\d).\d*Z$/x) or
+                                           (\d\d)\:(\d\d)\:(\d\d).\d+Z$/x) or
                                         croak "Unable to parse date: $date\n";
        "+0000 $Y-$m-$d $H:$M:$S";
 }



As the matching digits get ignored I don't see how this patch could introduce a
problem. Then again, I'm just starting with git and don't know anything about
the internals of either git or subversion.

Ward
