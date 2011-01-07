From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC/PATCH] t9157-*.sh: Add an svn version check
Date: Fri, 7 Jan 2011 18:02:20 +0000
Message-ID: <20110107180220.GA20031@dcvr.yhbt.net>
References: <4D260A03.90903@ramsay1.demon.co.uk> <20110107173114.GA31376@dcvr.yhbt.net> <AANLkTi=VpHtQ+x5hyfCei-=X=ry4X=+TSGg7EKa7zs4j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Steven Walter <stevenrwalter@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Jan 07 19:02:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbGe2-0003B9-Tb
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 19:02:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120Ab1AGSCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 13:02:25 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:45230 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755138Ab1AGSCV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 13:02:21 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9196A1F794;
	Fri,  7 Jan 2011 18:02:20 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <AANLkTi=VpHtQ+x5hyfCei-=X=ry4X=+TSGg7EKa7zs4j@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164728>

Steven Walter <stevenrwalter@gmail.com> wrote:
> On Fri, Jan 7, 2011 at 12:31 PM, Eric Wong <normalperson@yhbt.net> wrote:
> > Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
> >> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk> ---
> >
> > Consider this
> > Acked-by: Eric Wong <normalperson@yhbt.net>
> 
> Acked-by: Steven Walter <stevenrwalter@gmail.com>

Wait, looking through my backlog, this could fix the problem
Ramsay was having but was lost in the shuffle (my fault) :x

Ramsay: does this fix it?

>From 9a4f35d6ff9a66b7b5e57c7124a7cd6df0adad7b Mon Sep 17 00:00:00 2001
From: Steven Walter <stevenrwalter@gmail.com>
Date: Fri, 22 Oct 2010 21:55:58 -0400
Subject: [PATCH] t9157-git-svn-fetch-merge.sh: remove dependency on subversion 1.5

Specify a revision range to "merge" and manually set the svn:mergeinfo
property.

Acked-by: Eric Wong <normalperson@yhbt.net>
---
 t/t9157-git-svn-fetch-merge.sh |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/t/t9157-git-svn-fetch-merge.sh b/t/t9157-git-svn-fetch-merge.sh
index da582c5..424e1fa 100755
--- a/t/t9157-git-svn-fetch-merge.sh
+++ b/t/t9157-git-svn-fetch-merge.sh
@@ -25,15 +25,19 @@ test_expect_success 'initialize source svn repo' '
 		svn add baz &&
 		svn commit -m x &&
 		svn switch "$svnrepo"/trunk &&
-		svn merge "$svnrepo"/branches/branch1 &&
+		svn merge -r3:7 "$svnrepo"/branches/branch1 &&
+		svn propset svn:mergeinfo "/branches/branch1:4-7" . &&
 		svn commit -m "merge" &&
 		svn switch "$svnrepo"/branches/branch1 &&
 		svn commit -m x &&
 		svn switch "$svnrepo"/branches/branch2 &&
-		svn merge "$svnrepo"/branches/branch1 &&
+		svn merge -r3:8 "$svnrepo"/branches/branch1 &&
+		svn propset svn:mergeinfo "/branches/branch1:4-8" . &&
 		svn commit -m "merge branch1" &&
 		svn switch "$svnrepo"/trunk &&
-		svn merge "$svnrepo"/branches/branch2 &&
+		svn merge -r5:9 "$svnrepo"/branches/branch2 &&
+		svn propset svn:mergeinfo "/branches/branch1:4-8
+/branches/branch2:6-9" . &&
 		svn resolved baz &&
 		svn commit -m "merge branch2"
 	) &&
-- 
Eric Wong
