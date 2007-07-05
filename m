From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add -v|--verbose to git remote to show remote url
Date: Thu, 5 Jul 2007 23:57:30 +0200
Message-ID: <20070705215730.GC8751@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 05 23:57:35 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6ZKR-0002A2-4H
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 23:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760373AbXGEV5d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 17:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760449AbXGEV5c
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 17:57:32 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:11416 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759822AbXGEV5c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 17:57:32 -0400
Received: from tigra.home (Fa824.f.strato-dslnet.de [195.4.168.36])
	by post.webmailer.de (klopstock mo50) (RZmta 8.3)
	with ESMTP id z01c11j65HhCoK ; Thu, 5 Jul 2007 23:57:30 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 92559277BD;
	Thu,  5 Jul 2007 23:57:30 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 646BBC164; Thu,  5 Jul 2007 23:57:29 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTYT9w==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51696>

Many other commands already have such an option, and I find it
practical to see where all the remotes actually come from.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

The $VERBOSE may be even used by some of the subcommands
later.

 git-remote.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index b59cafd..449d97b 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -319,9 +319,14 @@ sub add_usage {
 	exit(1);
 }
 
+local $VERBOSE = 0;
+@ARGV = grep { $VERBOSE=1,0 if $_ eq '-v' or $_ eq '--verbose' } @ARGV;
+
 if (!@ARGV) {
 	for (sort keys %$remote) {
-		print "$_\n";
+		print "$_";
+		print "\t$remote->{$_}->{URL}" if $VERBOSE;
+		print "\n";
 	}
 }
 elsif ($ARGV[0] eq 'show') {
-- 
1.5.3.rc0.56.g6b87
