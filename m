From: Peter Baumann <waste.manager@gmx.de>
Subject: [PATCH] Add test for symlinked .git/packed-refs
Date: Thu, 19 Apr 2007 07:35:18 +0200
Message-ID: <20070419053518.GK5913@xp.machine.xx>
References: <7v7isajfl1.fsf@assigned-by-dhcp.cox.net> <20070418081122.GB32634@xp.machine.xx> <Pine.LNX.4.64.0704181251040.19261@reaper.quantumfyre.co.uk> <7vfy6xird9.fsf@assigned-by-dhcp.cox.net> <20070418174350.GB5913@xp.machine.xx> <7vlkgph7i0.fsf@assigned-by-dhcp.cox.net> <20070418183156.GF5913@xp.machine.xx> <7v647th6cv.fsf@assigned-by-dhcp.cox.net> <20070418210819.GG5913@xp.machine.xx> <7v4pndfjym.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 19 07:35:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HePIx-0007qL-JR
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 07:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993115AbXDSFfS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 01:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993116AbXDSFfS
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 01:35:18 -0400
Received: from magnum.hofmann.stw.uni-erlangen.de ([131.188.23.34]:54362 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S2993115AbXDSFfR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Apr 2007 01:35:17 -0400
Received: (qmail 18581 invoked by uid 0); 19 Apr 2007 05:35:15 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 19 Apr 2007 05:35:15 -0000
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Julian Phillips <julian@quantumfyre.co.uk>
Content-Disposition: inline
In-Reply-To: <7v4pndfjym.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44985>

Signed-off-by: Peter Baumann <waste.manager@gmx.de>
---
On Wed, Apr 18, 2007 at 02:31:29PM -0700, Junio C Hamano wrote:
> 
> Oh, I never questioned that you made that basic case work.  I
> was worried about not making sure the symlink we are looking at
> really is the case we are willing to handle, and not erroring
> out if that is not the case, perhaps like the attached patch on
> top of yours.
> 
> An additional test or two in t/t3210 would be nice to accompany
> this change.
> 

Something like this?

 t/t3210-pack-refs.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index f0c7e22..bf63954 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -105,4 +105,12 @@ test_expect_success 'pack, prune and repack' '
 	diff all-of-them again
 '
 
+test_expect_success \
+	'derefence symlinks for packed-refs' \
+	'mv -f .git/packed-refs .git/real_packed-refs &&
+	ln -s real_packed-refs .git/packed-refs &&
+	git-tag z &&
+	git-pack-refs --all --prune &&
+	diff .git/real_packed-refs .git/packed-refs'
+
 test_done
-- 
1.5.1
