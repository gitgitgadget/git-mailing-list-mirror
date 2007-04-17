From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Segmentation fault in git-svn
Date: Tue, 17 Apr 2007 02:55:09 -0700
Message-ID: <20070417095509.GA24800@muzzle>
References: <4623F613.5010108@midwinter.com> <20070417093743.GA9222@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 11:55:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdkP7-0006ma-DK
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 11:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbXDQJzN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 05:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753195AbXDQJzM
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 05:55:12 -0400
Received: from hand.yhbt.net ([66.150.188.102]:54804 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201AbXDQJzL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 05:55:11 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id A5D417DC0A1;
	Tue, 17 Apr 2007 02:55:09 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 17 Apr 2007 02:55:09 -0700
Content-Disposition: inline
In-Reply-To: <20070417093743.GA9222@muzzle>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44753>

This disables some pool allocations, forcing it to use the
global one.

Other than that, my eyes are barely open and my brain is
having trouble functioning at this time of morning.

diff --git a/git-svn.perl b/git-svn.perl
index ac44f60..cff81f7 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2883,7 +2883,7 @@ BEGIN {
 			wantarray ? \@ret : \$ret[0]; }\n";
 	}
 	$e .= "\n1;";
-	eval $e or die $@;
+	# eval $e or die $@;
 }
 
 sub new {
@@ -2925,10 +2925,10 @@ sub DESTROY {
 
 sub get_log {
 	my ($self, @args) = @_;
-	my $pool = SVN::Pool->new;
+	# my $pool = SVN::Pool->new;
 	splice(@args, 3, 1) if ($SVN::Core::VERSION le '1.2.0');
-	my $ret = $self->SUPER::get_log(@args, $pool);
-	$pool->clear;
+	my $ret = $self->SUPER::get_log(@args);
+	# $pool->clear;
 	$ret;
 }
 
-- 
Eric Wong
