From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 7] gitweb: Cleanup - chomp @lines in consistent style
Date: Sun, 30 Jul 2006 14:58:11 +0200
Message-ID: <200607301458.13848.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jul 30 14:58:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7As9-0007DW-6S
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 14:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWG3M6L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 08:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWG3M6L
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 08:58:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:20652 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932306AbWG3M6J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jul 2006 08:58:09 -0400
Received: by ug-out-1314.google.com with SMTP id m3so358181ugc
        for <git@vger.kernel.org>; Sun, 30 Jul 2006 05:58:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=F51eUbfBClwlum053lMGBcskW8C0VL7whk3HWUYlhBYUSHXJ1RL0te91SlWtnWK9L+CDLDeRimSkYiDGGKyQsyc80nOAe/ovJ4dc1VBwIrZsWO4A+w8Pioa/O3Er9+brIIVD43dyuhXOL9K0gocbY4l3r5wST8Rx9fAd8xtYreQ=
Received: by 10.66.221.19 with SMTP id t19mr1520902ugg;
        Sun, 30 Jul 2006 05:58:08 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id j1sm4115270ugf.2006.07.30.05.58.07;
        Sun, 30 Jul 2006 05:58:08 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607292239.11034.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24452>

Use 'my @lines = map { chomp; $_ } <$fd>;' form to read all lines of
git command output into array without trailing newlines.

It has advantage over 'chomp (my (@lines) = <$fd>);' in that it does
not modify array.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.cgi |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 86b9547..d5248fe 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -1064,7 +1064,7 @@ sub git_summary {
 	      "</table>\n";
 	open my $fd, "-|", $GIT, "rev-list", "--max-count=17", git_read_head($project) 
 		or die_error(undef, "Open git-rev-list failed.");
-	my (@revlist) = map { chomp; $_ } <$fd>;
+	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
 	print "<div>\n" .
 	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog"), -class => "title"}, "shortlog") .
@@ -1709,7 +1709,7 @@ sub git_tree {
 	$/ = "\0";
 	open my $fd, "-|", $GIT, "ls-tree", '-z', $hash 
 		or die_error(undef, "Open git-ls-tree failed.");
-	chomp (my (@entries) = <$fd>);
+	my @entries = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading tree failed.");
 	$/ = "\n";
 
@@ -1791,7 +1791,7 @@ sub git_rss {
 	# http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
 	open my $fd, "-|", $GIT, "rev-list", "--max-count=150", git_read_head($project) 
 		or die_error(undef, "Open git-rev-list failed.");
-	my (@revlist) = map { chomp; $_ } <$fd>;
+	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading rev-list failed.");
 	print $cgi->header(-type => 'text/xml', -charset => 'utf-8');
 	print "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n".
@@ -1900,7 +1900,7 @@ sub git_log {
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
 	open my $fd, "-|", $GIT, "rev-list", $limit, $hash 
 		or die_error(undef, "Open git-rev-list failed.");
-	my (@revlist) = map { chomp; $_ } <$fd>;
+	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
 
 	if ($hash ne $head || $page) {
@@ -1983,14 +1983,13 @@ sub git_commit {
 	my %ad = date_str($co{'author_epoch'}, $co{'author_tz'});
 	my %cd = date_str($co{'committer_epoch'}, $co{'committer_tz'});
 
-	my @difftree;
 	my $parent = $co{'parent'};
 	if (!defined $parent) {
 		$parent = "--root";
 	}
 	open my $fd, "-|", $GIT, "diff-tree", '-r', '-M', $parent, $hash 
 		or die_error(undef, "Open git-diff-tree failed.");
-	@difftree = map { chomp; $_ } <$fd>;
+	my @difftree = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading git-diff-tree failed.");
 
 	# non-textual hash id's can be cached
@@ -2237,7 +2236,7 @@ sub git_commitdiff {
 	}
 	open my $fd, "-|", $GIT, "diff-tree", '-r', $hash_parent, $hash
 		or die_error(undef, "Open git-diff-tree failed.");
-	my (@difftree) = map { chomp; $_ } <$fd>;
+	my @difftree = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading diff-tree failed.");
 
 	# non-textual hash id's can be cached
@@ -2328,14 +2327,14 @@ sub git_commitdiff_plain {
 	mkdir($git_temp, 0700);
 	open my $fd, "-|", $GIT, "diff-tree", '-r', $hash_parent, $hash 
 		or die_error(undef, "Open git-diff-tree failed.");
-	my (@difftree) = map { chomp; $_ } <$fd>;
+	my @difftree = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading diff-tree failed.");
 
 	# try to figure out the next tag after this commit
 	my $tagname;
 	my $refs = read_info_ref("tags");
 	open $fd, "-|", $GIT, "rev-list", "HEAD";
-	chomp (my (@commits) = <$fd>);
+	my @commits = map { chomp; $_ } <$fd>;
 	close $fd;
 	foreach my $commit (@commits) {
 		if (defined $refs->{$commit}) {
@@ -2622,7 +2621,7 @@ sub git_shortlog {
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
 	open my $fd, "-|", $GIT, "rev-list", $limit, $hash 
 		or die_error(undef, "Open git-rev-list failed.");
-	my (@revlist) = map { chomp; $_ } <$fd>;
+	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
 
 	if ($hash ne $head || $page) {
-- 
1.4.0
