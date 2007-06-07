From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] gitweb: change filename/directory name of snapshots
Date: Thu, 7 Jun 2007 11:27:08 +0200
Message-ID: <20070607092708.GA25097@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 11:27:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwEH6-0001x4-Iy
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 11:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbXFGJ1N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 05:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbXFGJ1N
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 05:27:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:42841 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750932AbXFGJ1M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 05:27:12 -0400
Received: (qmail invoked by alias); 07 Jun 2007 09:27:10 -0000
Received: from pD9EBB5EA.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.234]
  by mail.gmx.net (mp032) with SMTP; 07 Jun 2007 11:27:10 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX190U7sHpZh083aMmkSqIfvolLnAxCgb7wCeWN19sc
	qA0kgFuqhwBsa6
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49363>

/.git or .git is removed from the project name and the
basename of the remaining path is used as the beginning of
the filename and as the directory in the archive.

The regexp will actually not strip off /.git or .git if there
wouldn't be anything left after removing it.

Currently the full project name is used as directory in the
archive and the basename is used as filename.  For example a
repository named foo/bar/.git will have a archive named
.git-<version>.* and extract to foo/bar/.git.  With this patch
the file is named bar-<version>.* and extracts to bar.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
Imho the old behaviour does not make much sense but perhaps there are
users out there relying on the old behaviour.  OTOH relying on
a web interface not to change is quite bad, especially if you
could do the same using the git repository which would be much
more reliable.
---

 gitweb/gitweb.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e92596c..1777393 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4001,8 +4001,10 @@ sub git_snapshot {
 
 	my $git = git_cmd_str();
 	my $name = $project;
+	$name =~ s,([^/])/*\.git$,$1,;
+	$name = basename($name);
+	my $filename = to_utf8($name);
 	$name =~ s/\047/\047\\\047\047/g;
-	my $filename = to_utf8(basename($project));
 	my $cmd;
 	if ($suffix eq 'zip') {
 		$filename .= "-$hash.$suffix";
-- 
1.5.2.1.888.gd5e4e
