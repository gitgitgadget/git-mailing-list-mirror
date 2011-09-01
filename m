From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Using git-svn fetch after a directory change with rewrite-root
Date: Thu, 1 Sep 2011 20:54:04 +0000
Message-ID: <20110901205404.GA16835@dcvr.yhbt.net>
References: <CANWsHyfHtr0EaJtNsDK9UTcmb_AbLg-1jUA-0uWJ-nEeNosb7w@mail.gmail.com>
 <20110820191837.GA30509@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: H Krishnan <hetchkay@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 01 22:54:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzEH8-00088n-Nn
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 22:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757959Ab1IAUyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 16:54:08 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59678 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757887Ab1IAUyG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 16:54:06 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9B2F219F1;
	Thu,  1 Sep 2011 20:54:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20110820191837.GA30509@dcvr.yhbt.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180570>

Eric Wong <normalperson@yhbt.net> wrote:
> H Krishnan <hetchkay@gmail.com> wrote:
> > I wonder if commit 3235b7053c45a734c1cdf9b117bda68b7ced29c9 handles
> > rewrite-root correctly. Should the comparison be made with
> > $gs->metadata_url instead of $gs->full_url?
> 
> I think you're right, can you submit a test case?  Current
> tests all pass with  $gs->metadata_url  so I can probably
> push it out in a bit regardless.

I've pushed the following out to git://bogomips.org/git-svn.git

>From 85f022e9c124ffeda31a50cab878e1418d694d87 Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Mon, 29 Aug 2011 00:45:44 +0000
Subject: [PATCH] git-svn: fix fetch with moved path when using rewriteRoot

The matching step in commit 3235b7053c45a734c1cdf9b117bda68b7ced29c9
did not properly account for users of the "rewriteRoot"
configuration parameter.

ref: <CANWsHyfHtr0EaJtNsDK9UTcmb_AbLg-1jUA-0uWJ-nEeNosb7w@mail.gmail.com>

Suggested-by: H Krishnan <hetchkay@gmail.com>
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 96f373f..32792d3 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3022,7 +3022,7 @@ sub other_gs {
 			my (undef, $max_commit) = $gs->rev_map_max(1);
 			last if (!$max_commit);
 			my ($url) = ::cmt_metadata($max_commit);
-			last if ($url eq $gs->full_url);
+			last if ($url eq $gs->metadata_url);
 			$ref_id .= '-';
 		}
 		print STDERR "Initializing parent: $ref_id\n" unless $::_q > 1;
-- 
Eric Wong
