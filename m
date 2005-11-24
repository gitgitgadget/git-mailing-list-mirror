From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/9] fix -t tmpdir switch
Date: Wed, 23 Nov 2005 23:50:27 -0800
Message-ID: <20051124075027.GD4789@mail.yhbt.net>
References: <20051112092336.GA16218@Muzzle> <46a038f90511170126l5f04f4e0ta578fc2cb375db68@mail.gmail.com> <20051124074605.GA4789@mail.yhbt.net> <20051124074739.GB4789@mail.yhbt.net> <20051124074857.GC4789@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Nov 24 08:52:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfBsE-0006Ut-N2
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 08:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030563AbVKXHu2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 02:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030565AbVKXHu2
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 02:50:28 -0500
Received: from hand.yhbt.net ([66.150.188.102]:58601 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1030564AbVKXHu1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Nov 2005 02:50:27 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id 516432DC033; Wed, 23 Nov 2005 23:50:27 -0800 (PST)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <20051124074857.GC4789@mail.yhbt.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12684>

set TMPDIR env correctly if -t <tmpdir> is passed from the command-line.
setting TMPDIR => 1 as an argument to tempdir() has no effect otherwise

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-archimport.perl |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

applies-to: 015fcfae8cdd564f0993940c5bac303c41913b1a
25aadaf3ebc18fcc3c7948dc831d3f93447b03b6
diff --git a/git-archimport.perl b/git-archimport.perl
index b7e2480..2ed2e3c 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -88,9 +88,8 @@ usage if $opt_h;
 @ARGV >= 1 or usage();
 my @arch_roots = @ARGV;
 
-my ($tmpdir, $tmpdirname) = tempdir('git-archimport-XXXXXX', TMPDIR => 1, CLEANUP => 1);
-my $tmp = $opt_t || 1;
-$tmp = tempdir('git-archimport-XXXXXX', TMPDIR => 1, CLEANUP => 1);
+$ENV{'TMPDIR'} = $opt_t if $opt_t; # $ENV{TMPDIR} will affect tempdir() calls:
+my $tmp = tempdir('git-archimport-XXXXXX', TMPDIR => 1, CLEANUP => 1);
 $opt_v && print "+ Using $tmp as temporary directory\n";
 
 my @psets  = ();                # the collection
---
0.99.9.GIT
