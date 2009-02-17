From: Ward Wouts <ward@wouts.nl>
Subject: [PATCH] Fixes an 'Unable to parse date' error message in git-svn
Date: Tue, 17 Feb 2009 16:16:25 +0100
Message-ID: <20090217151625.GR7504@wouts.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Deskin Miller <deskinm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 16:27:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZRqa-0004Xb-Bw
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 16:26:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbZBQPZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 10:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbZBQPZF
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 10:25:05 -0500
Received: from mailhost.tue.nl ([131.155.2.19]:55957 "EHLO mailhost.tue.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753485AbZBQPZD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 10:25:03 -0500
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Feb 2009 10:25:03 EST
Received: from localhost (localhost [127.0.0.1])
	by mailhost.tue.nl (Postfix) with ESMTP id 65C935C03E;
	Tue, 17 Feb 2009 16:16:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at tue.nl
Received: from mailhost.tue.nl ([131.155.2.19])
	by localhost (pastinakel.tue.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jb03MD+EvJbh; Tue, 17 Feb 2009 16:16:26 +0100 (CET)
Received: from umta.win.tue.nl (umta.win.tue.nl [131.155.71.100])
	by mailhost.tue.nl (Postfix) with ESMTP id 3038C5C03B;
	Tue, 17 Feb 2009 16:16:26 +0100 (CET)
Received: from sandcat.nl (pcwin165 [131.155.69.121])
	by umta.win.tue.nl (Postfix) with ESMTP id F0FA64BC262;
	Tue, 17 Feb 2009 16:16:25 +0100 (CET)
Received: by sandcat.nl (Postfix, from userid 1104)
	id C771411407C; Tue, 17 Feb 2009 16:16:25 +0100 (CET)
Content-Disposition: inline
X-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110399>

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

This patch makes the matching of subseconds optional, which prevents the
error message from showing. Since the subseconds match isn't actually
used this should not be a problem.

Signed-off-by: Ward Wouts <ward@wouts.nl>
Acked-by: Deskin Miller <deskinm@umich.edu>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 83cb36f..8ffadcc 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2526,7 +2526,7 @@ sub get_untracked {
 sub parse_svn_date {
 	my $date = shift || return '+0000 1970-01-01 00:00:00';
 	my ($Y,$m,$d,$H,$M,$S) = ($date =~ /^(\d{4})\-(\d\d)\-(\d\d)T
-	                                    (\d\d)\:(\d\d)\:(\d\d).\d+Z$/x) or
+	                                    (\d\d)\:(\d\d)\:(\d\d).\d*Z$/x) or
 	                                 croak "Unable to parse date: $date\n";
 	my $parsed_date;    # Set next.
 
-- 
1.5.6.6
