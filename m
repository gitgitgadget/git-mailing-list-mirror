From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Make rebase save ORIG_HEAD if using current branch
Date: Tue, 6 May 2008 01:19:20 -0400
Message-ID: <20080506051920.GA9165@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 06 07:20:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtFb2-0008Vp-Hy
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 07:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbYEFFTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 01:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbYEFFTX
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 01:19:23 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:37688 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbYEFFTW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 01:19:22 -0400
Received: from localhost.localdomain (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	by silverinsanity.com (Postfix) with ESMTP id 7DDD11FFC250;
	Tue,  6 May 2008 05:19:10 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81330>

This makes rebase act a little more like merge when working on the
current branch.  This is particularly useful for `git pull --rebase`

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 I was trying to figure out why reviewing the new changes in git was so
 hard using my `git log ORIG_HEAD..` alias.  Turns out my ORIG_HEAD
 hadn't been updated since Feburary, which is when I set
 branch.master.rebase to true.

 I think ORIG_HEAD should be set every time a pull changes HEAD, whether
 by a merge or rebase.  Making rebase act like merge seemed more elegant
 than having git-pull set ORIG_HEAD iff using rebase.

 git-rebase.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 9b13b83..8d54d9f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -342,6 +342,7 @@ case "$#" in
 		branch_name=HEAD ;# detached
 	fi
 	branch=$(git rev-parse --verify "${branch_name}^0") || exit
+	echo "$branch" > "$GIT_DIR/ORIG_HEAD"
 	;;
 esac
 orig_head=$branch
-- 
1.5.5.1.242.g558e8
