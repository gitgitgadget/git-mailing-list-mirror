From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: [PATCH] git-svnimport: clean svn path when accessing SVN repo
Date: Sun, 7 Jan 2007 02:22:10 +0200
Message-ID: <20070107002210.GC16771@sashak.voltaire.com>
References: <1165505193.26874.13.camel@systems03.lan.brontes3d.com> <20061208203230.GA9193@sashak.voltaire.com> <1165847230.13854.2.camel@systems03.lan.brontes3d.com> <20061211204904.GC1003@sashak.voltaire.com> <1166027289.21948.4.camel@systems03.lan.brontes3d.com> <20061214022142.GA14521@sashak.voltaire.com> <1166130300.21982.0.camel@systems03.lan.brontes3d.com> <20061214212033.GG7838@sashak.voltaire.com> <7vejr217v7.fsf@assigned-by-dhcp.cox.net> <20061214214327.GH7838@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 01:14:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3Lgd-0003sG-U2
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 01:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbXAGAOx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 19:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbXAGAOx
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 19:14:53 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:18485 "EHLO
	taurus.voltaire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932272AbXAGAOw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 19:14:52 -0500
Received: from sashak ([172.25.5.176]) by taurus.voltaire.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 7 Jan 2007 02:14:51 +0200
Received: by sashak (sSMTP sendmail emulation); Sun,  7 Jan 2007 02:22:10 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20061214214327.GH7838@sashak.voltaire.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 07 Jan 2007 00:14:51.0454 (UTC) FILETIME=[D98395E0:01C731F0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36107>

Clean svn path from leading '/' when accessing SVN repo.

Signed-off-by: Sasha Khapyorsky <sashak@voltaire.com>
---

This fixes git-svnimport problems reported in this thread ("git-svnimport
breakage as of git-1.4.4"). Finally I forgot to submit this then, sorry
about that.

 git-svnimport.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-svnimport.perl b/git-svnimport.perl
index cbaa8ab..071777b 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -146,6 +146,7 @@ sub file {
 	print "... $rev $path ...\n" if $opt_v;
 	my (undef, $properties);
 	my $pool = SVN::Pool->new();
+	$path =~ s#^/*##;
 	eval { (undef, $properties)
 		   = $self->{'svn'}->get_file($path,$rev,$fh,$pool); };
 	$pool->clear;
@@ -181,6 +182,7 @@ sub ignore {
 	my($self,$path,$rev) = @_;
 
 	print "... $rev $path ...\n" if $opt_v;
+	$path =~ s#^/*##;
 	my (undef,undef,$properties)
 	    = $self->{'svn'}->get_dir($path,$rev,undef);
 	if (exists $properties->{'svn:ignore'}) {
@@ -197,6 +199,7 @@ sub ignore {
 
 sub dir_list {
 	my($self,$path,$rev) = @_;
+	$path =~ s#^/*##;
 	my ($dirents,undef,$properties)
 	    = $self->{'svn'}->get_dir($path,$rev,undef);
 	return $dirents;
@@ -354,6 +357,7 @@ open BRANCHES,">>", "$git_dir/svn2git";
 sub node_kind($$) {
 	my ($svnpath, $revision) = @_;
 	my $pool=SVN::Pool->new;
+	$svnpath =~ s#^/*##;
 	my $kind = $svn->{'svn'}->check_path($svnpath,$revision,$pool);
 	$pool->clear;
 	return $kind;
-- 
1.5.0.rc0.g2484-dirty
