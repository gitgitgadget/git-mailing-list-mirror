From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/9] archimport: first, make sure it still compiles
Date: Wed, 23 Nov 2005 23:47:39 -0800
Message-ID: <20051124074739.GB4789@mail.yhbt.net>
References: <20051112092336.GA16218@Muzzle> <46a038f90511170126l5f04f4e0ta578fc2cb375db68@mail.gmail.com> <20051124074605.GA4789@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Nov 24 08:48:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfBpX-0005aB-QX
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 08:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030517AbVKXHrk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 02:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030556AbVKXHrk
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 02:47:40 -0500
Received: from hand.yhbt.net ([66.150.188.102]:57065 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1030517AbVKXHrj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Nov 2005 02:47:39 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id 258F52DC033; Wed, 23 Nov 2005 23:47:39 -0800 (PST)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <20051124074605.GA4789@mail.yhbt.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12682>

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-archimport.perl |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

applies-to: a17c1f442587b9c7d68b4f7e08c5f6786599c61e
119b07aa2bdb23d5f4977c4d696dd5e7eea56ca6
diff --git a/git-archimport.perl b/git-archimport.perl
index c3bed08..b5f8a2c 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -99,6 +99,7 @@ my %psets  = ();                # the co
 
 my %rptags = ();                # my reverse private tags
                                 # to map a SHA1 to a commitid
+my $TLA = $ENV{'ARCH_CLIENT'} || 'tla';
 
 foreach my $root (@arch_roots) {
     my ($arepo, $abranch) = split(m!/!, $root);
@@ -850,3 +851,18 @@ sub commitid2pset {
 	|| (print Dumper(sort keys %psets)) && die "Cannot find patchset for $name";
     return $ps;
 }
+
+# an alterative to `command` that allows input to be passed as an array
+# to work around shell problems with weird characters in arguments
+sub safe_pipe_capture {
+    my @output;
+    if (my $pid = open my $child, '-|') {
+        @output = (<$child>);
+        close $child or die join(' ',@_).": $! $?";
+    } else {
+	exec(@_) or die $?; # exec() can fail the executable can't be found
+    }
+    return wantarray ? @output : join('',@output);
+}
+
+
---
0.99.9.GIT

-- 
Eric Wong
