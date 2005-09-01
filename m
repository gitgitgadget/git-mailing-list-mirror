From: Carl Baldwin <cnb@fc.hp.com>
Subject: [PATCH] unset CDPATH in git-clone
Date: Thu, 1 Sep 2005 09:24:41 -0600
Organization: Hewlett Packard
Message-ID: <20050901152441.GA8694@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Sep 01 17:25:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAqvr-00016k-Ke
	for gcvg-git@gmane.org; Thu, 01 Sep 2005 17:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbVIAPYn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Sep 2005 11:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbVIAPYn
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Sep 2005 11:24:43 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:57510 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1030202AbVIAPYm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Sep 2005 11:24:42 -0400
Received: from smtp1.fc.hp.com (smtp1.fc.hp.com [15.15.136.127])
	by atlrel7.hp.com (Postfix) with ESMTP id C257A2179
	for <git@vger.kernel.org>; Thu,  1 Sep 2005 11:24:41 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP id 912E538778
	for <git@vger.kernel.org>; Thu,  1 Sep 2005 15:24:41 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 7BF8C2AEC4; Thu,  1 Sep 2005 09:24:41 -0600 (MDT)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7996>

Hello,

A colleague was having problems with git clone.  It seemed to work as
expected for me so I went into his environment to see what was causing
it to fail.  I found that he had set the CDPATH environment variable to
something like '.:..:../..:$HOME'.  Try this (using bash) and you'll see
the problem:

export CDPATH=.
git clone (anything local)

The function get_repo_base seems to break with this CDPATH.

Below is how I solved the problem for the short-term.  Use it as you see
fit.  I did not look into other commands to see if there are other
implications to using CDPATH.

Cheers,
Carl

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

---

 git-clone-script |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

50e48b03a5a82bb1e4ca95ef4e04cafc39a96f79
diff --git a/git-clone-script b/git-clone-script
--- a/git-clone-script
+++ b/git-clone-script
@@ -5,6 +5,8 @@
 # 
 # Clone a repository into a different directory that does not yet exist.
 
+unset CDPATH
+
 usage() {
 	echo >&2 "* git clone [-l [-s]] [-q] [-u <upload-pack>] <repo> <dir>"
 	exit 1
