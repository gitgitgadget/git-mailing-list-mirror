From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH] new-workdir: handle rev-parse --git-dir not always giving
	full path
Date: Tue, 19 Jun 2007 12:44:43 +0100
Message-ID: <20070619114456.10962.31845.julian@quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 13:48:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0cBw-0002jK-AX
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 13:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756273AbXFSLsK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 07:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756194AbXFSLsJ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 07:48:09 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:51487 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755572AbXFSLsI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jun 2007 07:48:08 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id C656BC6143
	for <git@vger.kernel.org>; Tue, 19 Jun 2007 12:48:06 +0100 (BST)
Received: (qmail 8580 invoked by uid 103); 19 Jun 2007 12:48:04 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.3/3458. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.024556 secs); 19 Jun 2007 11:48:04 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 19 Jun 2007 12:48:04 +0100
X-git-sha1: c5b34e0888799927ec62ee0478d16b0be38f4c5c 
X-Mailer: git-mail-commits v0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50472>

rev-parse --git-dir outputs a full path - except for the single case
of when the path would be $(pwd)/.git, in which case it outputs simply
.git.  Check for this special case and handle it.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---

I tried to use new-workdir yesterday for the first time in a while, and found that it worked provided I gave a path inside the base repo, but not the path of the repo itself.

Turns out to be an oddity in rev-parse --git-dir output.  Since the rev-parse code explicitly does something different, I assume there is a reason for it.

 contrib/workdir/git-new-workdir |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
index f2a3615..709b2a3 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -24,6 +24,11 @@ git_dir=$(cd "$orig_git" 2>/dev/null &&
   git rev-parse --git-dir 2>/dev/null) ||
   die "\"$orig_git\" is not a git repository!"
 
+if test "$git_dir" == ".git"
+then
+	git_dir="$orig_git/.git"
+fi
+
 # don't link to a workdir
 if test -L "$git_dir/config"
 then
-- 
1.5.2.2
