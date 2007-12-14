From: Jing Xue <jingxue@digizenstudio.com>
Subject: [PATCH] Makes 'git-stash show' stay quiet when there are no
	stashes.
Date: Thu, 13 Dec 2007 20:28:38 -0500
Message-ID: <20071214012838.GA8914@fawkes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 14 02:29:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2zMV-0003rm-UO
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 02:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756841AbXLNB2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 20:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755101AbXLNB2s
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 20:28:48 -0500
Received: from k2smtpout03-02.prod.mesa1.secureserver.net ([64.202.189.172]:34757
	"HELO k2smtpout03-02.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754523AbXLNB2r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 20:28:47 -0500
Received: (qmail 30548 invoked from network); 14 Dec 2007 01:28:47 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout03-02.prod.mesa1.secureserver.net (64.202.189.172) with ESMTP; 14 Dec 2007 01:28:47 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id E5AC4100A37
	for <git@vger.kernel.org>; Fri, 14 Dec 2007 01:28:46 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zVWV6ci5S1Cr for <git@vger.kernel.org>;
	Thu, 13 Dec 2007 20:28:40 -0500 (EST)
Received: from fawkes.hq.digizenstudio.com (ip70-187-196-88.dc.dc.cox.net [70.187.196.88])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 01AF1100099
	for <git@vger.kernel.org>; Thu, 13 Dec 2007 20:28:39 -0500 (EST)
Received: by fawkes.hq.digizenstudio.com (Postfix, from userid 1000)
	id BA1E99ACFB; Thu, 13 Dec 2007 20:28:38 -0500 (EST)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68208>


(I tried to send this trivial patch for a couple of times using
git-send-email, but somehow it never turned up.)

Currently when there are no stashes, 'git stash show' basically aborts with an
error message from rev-parse: "fatal: Needed a single revision", which can be
confusing. This patch makes git-stash keep quiet and exit gracefully in that
case.

---
 git-stash.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index f16fd9c..dbdaeaf 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -119,6 +119,10 @@ show_stash () {
 		flags=--stat
 	fi
 	s=$(git rev-parse --revs-only --no-flags --default $ref_stash "$@")
+	if test -z "$s"
+	then
+		exit 0
+	fi
 
 	w_commit=$(git rev-parse --verify "$s") &&
 	b_commit=$(git rev-parse --verify "$s^") &&
-- 
1.5.4.rc0.1.g3696
