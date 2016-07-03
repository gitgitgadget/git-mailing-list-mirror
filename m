Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A89C51F728
	for <e@80x24.org>; Sun,  3 Jul 2016 05:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbcGCFpA (ORCPT <rfc822;e@80x24.org>);
	Sun, 3 Jul 2016 01:45:00 -0400
Received: from ns1.signalpunk.com ([74.86.59.106]:32792 "EHLO
	ns1.signalpunk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbcGCFpA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2016 01:45:00 -0400
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Jul 2016 01:45:00 EDT
Received: by ns1.signalpunk.com (Postfix, from userid 1000)
	id 830D858210520; Sun,  3 Jul 2016 05:39:23 +0000 (GMT)
Date:	Sun, 3 Jul 2016 05:39:23 +0000
From:	Christopher Layne <clayne@anodized.com>
To:	git@vger.kernel.org
Cc:	Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: clone: Fail on missing url argument
Message-ID: <20160703053923.GA12956@ns1.signalpunk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

* cmd_clone should detect a missing $url arg before using it otherwise
  an uninitialized value error is emitted in even the simplest case of
  'git svn clone' without arguments.

Signed-off-by: Christopher Layne <clayne@anodized.com>
---
 git-svn.perl | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/git-svn.perl b/git-svn.perl
index 05eced0..f609e54 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -507,7 +507,10 @@ sub init_subdir {
 
 sub cmd_clone {
 	my ($url, $path) = @_;
-	if (!defined $path &&
+	if (!$url) {
+		die "SVN repository location required ",
+		    "as a command-line argument\n";
+	} elsif (!defined $path &&
 	    (defined $_trunk || @_branches || @_tags ||
 	     defined $_stdlayout) &&
 	    $url !~ m#^[a-z\+]+://#) {
-- 
2.7.3

