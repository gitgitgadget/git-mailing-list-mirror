From: bob@proulx.com (Bob Proulx)
Subject: [PATCH] git-revert: Fix die before git-sh-setup defines it.
Date: Thu, 11 Jan 2007 23:45:38 -0700
Message-ID: <20070112064538.GA3012@dementia.proulx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jan 12 08:16:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Ge2-0000UL-JV
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 08:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbXALHQA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 02:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbXALHP7
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 02:15:59 -0500
Received: from joseki.proulx.com ([216.17.153.58]:36351 "EHLO
	joseki.proulx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161016AbXALHP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 02:15:59 -0500
X-Greylist: delayed 1821 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jan 2007 02:15:59 EST
Received: from dementia.proulx.com (dementia.proulx.com [192.168.1.115])
	by joseki.proulx.com (Postfix) with ESMTP id 40DB8FAC7
	for <git@vger.kernel.org>; Thu, 11 Jan 2007 23:45:38 -0700 (MST)
Received: by dementia.proulx.com (Postfix, from userid 1000)
	id 0BA3073FB4C; Thu, 11 Jan 2007 23:45:38 -0700 (MST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36664>

The code previously checked it's own name and called 'die' upon
an error.  However 'die' was not yet defined because git-sh-setup
had not been sourced yet.  Instead simply write the error message
to stderr and exit with an error as was originally desired.

Signed-off-by: Bob Proulx <bob@proulx.com>
---

I found this by inspection.  I contemplated several different ways of
resolving it but in the end the simplest seemed to be the best.

 git-revert.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-revert.sh b/git-revert.sh
index 50cc47b..5ca894a 100755
--- a/git-revert.sh
+++ b/git-revert.sh
@@ -16,7 +16,7 @@ case "$0" in
 	me=cherry-pick
 	USAGE='[--edit] [-n] [-r] [-x] <commit-ish>'  ;;
 * )
-	die "What are you talking about?" ;;
+	echo "What are you talking about?" 1>&2 ; exit 1 ;;
 esac
 . git-sh-setup
 
-- 
1.4.0
