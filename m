From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git svn: Support multiple branch and tag paths in the
	svn repository.
Date: Thu, 25 Jun 2009 17:33:39 -0700
Message-ID: <20090626003338.GA591@dcvr.yhbt.net>
References: <4A3A4945.6050307@drmicha.warpmail.net> <1245335463-4488-1-git-send-email-git@drmicha.warpmail.net> <4A3F9A44.8070805@xiplink.com> <4A410A90.1090101@xiplink.com> <20090625093602.GA3997@dcvr.yhbt.net> <7v3a9o0x48.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 02:33:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJzO2-0001Cw-P8
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 02:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbZFZAdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 20:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbZFZAdh
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 20:33:37 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39456 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411AbZFZAdh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 20:33:37 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D17D1F7B9;
	Fri, 26 Jun 2009 00:33:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v3a9o0x48.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122262>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Acked and and pushed out to git://git.bogomips.org/git-svn along with a
> > followup patch ...
> 
> Hmmm...
> 
> t9138-git-svn-multiple-branches.sh does not seem to pass for me.
> 
>     ...
>     A    svn_project/tags_A/1.0
>     A    svn_project/tags_A/1.0/a.file
>     Checked out revision 3.
>     ./test-lib.sh: line 329: .: filename argument required
>     .: usage: . filename [arguments]
>     FATAL: Unexpected exit with code 2

Oops, I wasn't reading the test too closely[1], this should fix it:

>From 1ad8ff7b49f508ad37081a709d4230833564eca2 Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Thu, 25 Jun 2009 16:09:59 -0700
Subject: [PATCH] t9138: remove stray "." in tests

This breaks bash and probably some other shells, but worked
fine with dash in my limited testing.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/t9138-git-svn-multiple-branches.sh |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/t/t9138-git-svn-multiple-branches.sh b/t/t9138-git-svn-multiple-branches.sh
index 9725ccf..37ecdb0 100755
--- a/t/t9138-git-svn-multiple-branches.sh
+++ b/t/t9138-git-svn-multiple-branches.sh
@@ -22,7 +22,6 @@ test_expect_success 'setup svnrepo' '
 			  "$svnrepo/project/tags_A/1.0" &&
 	svn co "$svnrepo/project" svn_project &&
 	cd svn_project &&
-		.
 		echo 2 > trunk/a.file &&
 		svn ci -m "Change 1" trunk/a.file &&
 		svn cp -m "Branch 2" "$svnrepo/project/trunk" \
-- 
Eric Wong

[1] - the test should use the new svn_cmd wrapper and avoid cd + cd ..
which is more error prone than (cd ).  I'll try to find time to fix
it later tonight.
