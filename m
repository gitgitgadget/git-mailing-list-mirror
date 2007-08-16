From: Miles Bader <miles@gnu.org>
Subject: [PATCH] Make git-archimport log entries more consistent
Date: Thu, 16 Aug 2007 01:01:19 -0400
Message-ID: <61lkcc2huo.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 06:57:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILXQg-000700-Ug
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 06:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbXHPE5m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 00:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753008AbXHPE5m
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 00:57:42 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:54763 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbXHPE5l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 00:57:41 -0400
Received: from miles by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <miles@gnu.org>)
	id 1ILXTz-0002nZ-O9; Thu, 16 Aug 2007 01:01:19 -0400
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55977>

When appending the "git-archimport-id:" line to the end of log entries,
git-archimport would use two blank lines as a separator when there was no
body in the arch log (only a Summary: line), and zero blank lines when there
was a body (making it hard to see the break between the actual log message
and the git-archimport-id: line).

This patch makes git-archimport generate one blank line as a separator in all
cases.
---
 git-archimport.perl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-archimport.perl b/git-archimport.perl
index b210772..9e38ba5 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -595,8 +595,12 @@ foreach my $ps (@psets) {
     my $pid = open2(*READER, *WRITER,'git-commit-tree',$tree,@par)
         or die $!;
     print WRITER $ps->{summary},"\n\n";
-    print WRITER $ps->{message},"\n";
 
+    # only print message if it's not empty, to avoid a spurious blank line;
+    # also append an extra newline, so there's a blank line before the
+    # following "git-archimport-id:" line.
+    print WRITER $ps->{message},"\n\n" if ($ps->{message} ne "");
+    
     # make it easy to backtrack and figure out which Arch revision this was:
     print WRITER 'git-archimport-id: ',$ps->{id},"\n";
 
-- 
1.5.3.rc3.91.g5c75-dirty
