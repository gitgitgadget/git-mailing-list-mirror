From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH/RFC] git-svn: use path accessor for Git::SVN objects
Date: Tue, 18 Sep 2012 00:09:31 +0000
Message-ID: <20120918000931.GB17939@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca,
	"Michael G. Schwern" <schwern@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 02:09:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDlNk-0005uC-Ve
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 02:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755639Ab2IRAJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 20:09:32 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40116 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755481Ab2IRAJc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 20:09:32 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 934DD1F546;
	Tue, 18 Sep 2012 00:09:31 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205772>

The accessors should improve maintainability and enforce
consistent access to Git::SVN objects.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
  (RFC since I could've missed something)

  Eric Wong <normalperson@yhbt.net> wrote:
  > I'll apply the following (on top of a patch which fixes some
  > {path} usages):

 git-svn.perl       | 2 +-
 perl/Git/SVN/Ra.pm | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0d77ffb..bd5266c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1314,7 +1314,7 @@ sub get_svnprops {
 	$path = $cmd_dir_prefix . $path;
 	fatal("No such file or directory: $path") unless -e $path;
 	my $is_dir = -d $path ? 1 : 0;
-	$path = join_paths($gs->{path}, $path);
+	$path = join_paths($gs->path, $path);
 
 	# canonicalize the path (otherwise libsvn will abort or fail to
 	# find the file)
diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 90ec30b..049c97b 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -416,7 +416,7 @@ sub gs_fetch_loop_common {
 		}
 		$SVN::Error::handler = $err_handler;
 
-		my %exists = map { $_->{path} => $_ } @$gsv;
+		my %exists = map { $_->path => $_ } @$gsv;
 		foreach my $r (sort {$a <=> $b} keys %revs) {
 			my ($paths, $logged) = @{$revs{$r}};
 
-- 
1.7.12.441.g0590587.dirty
