From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5/9] gitweb: Cleanup and uniquify error messages
Date: Sat, 05 Aug 2006 13:12:51 +0200
Organization: At home
Message-ID: <eb1ue8$8ti$1@sea.gmane.org>
References: <200608050036.06490.jnareb@gmail.com> <200608050038.20534.jnareb@gmail.com> <7vu04sghr0.fsf@assigned-by-dhcp.cox.net> <eb0oiu$sj1$1@sea.gmane.org> <44d47813.36251c31.2553.3cf7@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Aug 05 13:15:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9K7j-0002XR-3O
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 13:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161594AbWHELPP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 07:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161598AbWHELPP
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 07:15:15 -0400
Received: from main.gmane.org ([80.91.229.2]:58578 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161594AbWHELPN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 07:15:13 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1G9K7S-0002UY-5k
	for git@vger.kernel.org; Sat, 05 Aug 2006 13:15:02 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 13:15:02 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 13:15:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24904>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6f3f465..8773a8d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1464,7 +1464,7 @@ sub git_blame2 {
        die_error(undef, "Permission denied.") if (!git_get_project_config_bool ('blame'));
        die_error('404 Not Found', "File name not defined") if (!$file_name);
        $hash_base ||= git_read_head($project);
-       die_error(undef, "Reading commit failed") unless ($hash_base);
+       die_error(undef, "Couldn't find base commit.") unless ($hash_base);
        my %co = git_read_commit($hash_base)
                or die_error(undef, "Reading commit failed");
        if (!defined $hash) {
@@ -1473,7 +1473,7 @@ sub git_blame2 {
        }
        $ftype = git_get_type($hash);
        if ($ftype !~ "blob") {
-               die_error("400 Bad Request", "object is not a blob");
+               die_error("400 Bad Request", "Object is not a blob");
        }
        open ($fd, "-|", $GIT, "blame", '-l', $file_name, $hash_base)
                or die_error(undef, "Open git-blame failed.");
@@ -1520,9 +1520,9 @@ sub git_blame2 {
 sub git_blame {
        my $fd;
        die_error('403 Permission denied', "Permission denied.") if (!git_get_project_config_bool ('blame'));
-       die_error('404 Not Found', "What file will it be, master?") if (!$file_name);
+       die_error('404 Not Found', "File name not defined.") if (!$file_name);
        $hash_base ||= git_read_head($project);
-       die_error(undef, "Reading commit failed.") unless ($hash_base);
+       die_error(undef, "Couldn't find base commit.") unless ($hash_base);
        my %co = git_read_commit($hash_base)
                or die_error(undef, "Reading commit failed.");
        if (!defined $hash) {
@@ -2113,7 +2113,7 @@ sub git_commitdiff {
        open my $fd, "-|", $GIT, "diff-tree", '-r', $hash_parent, $hash
                or die_error(undef, "Open git-diff-tree failed.");
        my @difftree = map { chomp; $_ } <$fd>;
-       close $fd or die_error(undef, "Reading diff-tree failed.");
+       close $fd or die_error(undef, "Reading git-diff-tree failed.");
 
        # non-textual hash id's can be cached
        my $expires;
@@ -2484,7 +2484,7 @@ sub git_rss {
        open my $fd, "-|", $GIT, "rev-list", "--max-count=150", git_read_head($project)
                or die_error(undef, "Open git-rev-list failed.");
        my @revlist = map { chomp; $_ } <$fd>;
-       close $fd or die_error(undef, "Reading rev-list failed.");
+       close $fd or die_error(undef, "Reading git-rev-list failed.");
        print $cgi->header(-type => 'text/xml', -charset => 'utf-8');
        print "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n".
              "<rss version=\"2.0\" xmlns:content=\"http://purl.org/rss/1.0/modules/content/\">\n";
-- 
1.4.1.1
