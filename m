From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 8/9] Fix a bug I introduced in the new log parser
Date: Wed, 23 Nov 2005 23:56:31 -0800
Message-ID: <20051124075631.GI4789@mail.yhbt.net>
References: <20051112092336.GA16218@Muzzle> <46a038f90511170126l5f04f4e0ta578fc2cb375db68@mail.gmail.com> <20051124074605.GA4789@mail.yhbt.net> <20051124074739.GB4789@mail.yhbt.net> <20051124074857.GC4789@mail.yhbt.net> <20051124075027.GD4789@mail.yhbt.net> <20051124075133.GE4789@mail.yhbt.net> <20051124075243.GF4789@mail.yhbt.net> <20051124075355.GG4789@mail.yhbt.net> <20051124075504.GH4789@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Nov 24 08:56:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfBy7-0000GD-58
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 08:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030570AbVKXH4c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 02:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030565AbVKXH4c
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 02:56:32 -0500
Received: from hand.yhbt.net ([66.150.188.102]:4842 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1030570AbVKXH4b (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Nov 2005 02:56:31 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id 1F94D2DC033; Wed, 23 Nov 2005 23:56:31 -0800 (PST)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <20051124075504.GH4789@mail.yhbt.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12689>

This fixes the case (that worked originally in Martin's version)
where the only new/modified files are Arch control files.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-archimport.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

applies-to: db1362fe6567e349ff9dd9d70ce23c88a42a0ff2
ebe0689722f6c1440e680ec9a235b3dd571c7de0
diff --git a/git-archimport.perl b/git-archimport.perl
index 1cf1261..0080850 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -790,7 +790,7 @@ sub parselog {
     # skip Arch control files, unescape pika-escaped files
     foreach my $k (keys %want_headers) {
         next unless (defined $ps->{$k});
-        my @tmp;
+        my @tmp = ();
         foreach my $t (@{$ps->{$k}}) {
            next unless length ($t);
            next if $t =~ m!\{arch\}/!;
@@ -804,7 +804,7 @@ sub parselog {
            }
            push @tmp, $t;
         }
-        $ps->{$k} = \@tmp if scalar @tmp;
+        $ps->{$k} = \@tmp;
     }
 }
 
---
0.99.9.GIT
