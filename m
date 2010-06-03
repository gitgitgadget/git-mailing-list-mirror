From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git svn: fix empty directory creation
Date: Thu, 3 Jun 2010 20:58:50 +0000
Message-ID: <20100603205850.GA1540@dcvr.yhbt.net>
References: <4C07B7E8.10909@genome.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Michael J. Kiwala" <mkiwala@genome.wustl.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 22:58:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKHVB-00057i-Tv
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 22:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756235Ab0FCU6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 16:58:52 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35288 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755967Ab0FCU6v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 16:58:51 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05D331F4E5;
	Thu,  3 Jun 2010 20:58:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4C07B7E8.10909@genome.wustl.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148362>

Hi Junio,

I've acked and pushed this patch out from Michael to

  git://git.bogomips.org/git-svn.git

>From 7c42e390a37a11b1f7a77f5f07c261a8f930663a Mon Sep 17 00:00:00 2001
From: Michael J. Kiwala <mkiwala@genome.wustl.edu>
Date: Tue, 1 Jun 2010 16:24:57 -0500
Subject: [PATCH] git svn: fix empty directory creation

Avoid attempts to stat() the contents of '', which could happen
when the root directory is empty.  Additionally, remove the
unnecessary '_' stat optimization since it was confusing and
possibly throwing off the non-existent case.

[ew: fixed indentation, rewrote commit message]

Acked-by: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Michael J. Kiwala <mkiwala@genome.wustl.edu>
---
 git-svn.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index b3b6964..09c4ca5 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2836,8 +2836,9 @@ sub mkemptydirs {
 	foreach my $d (sort keys %empty_dirs) {
 		$d = uri_decode($d);
 		$d =~ s/$strip//;
+		next unless length($d);
 		next if -d $d;
-		if (-e _) {
+		if (-e $d) {
 			warn "$d exists but is not a directory\n";
 		} else {
 			print "creating empty directory: $d\n";
-- 
Eric Wong
