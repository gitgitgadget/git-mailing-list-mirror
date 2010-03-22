From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 1/3] taskd/clone: Don't forget to use 'git config --add' for multivars setup
Date: Mon, 22 Mar 2010 14:07:59 +0300
Message-ID: <9e5d5b9ade49b4b2aa14f67d337961a73b35ae33.1269255835.git.kirr@mns.spb.ru>
References: <20100222085029.GA28744@landau.phys.spbu.ru>
Cc: Miklos Vajna <vmiklos@frugalware.org>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Mar 22 12:13:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtfZQ-000842-3P
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 12:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126Ab0CVLNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 07:13:16 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:40007 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753668Ab0CVLNO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 07:13:14 -0400
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1NtfZC-0000hv-RI; Mon, 22 Mar 2010 14:13:07 +0300
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1NtfVA-0002uT-NU; Mon, 22 Mar 2010 14:08:56 +0300
X-Mailer: git-send-email 1.7.0.2.284.gafe27d
In-Reply-To: <20100222085029.GA28744@landau.phys.spbu.ru>
In-Reply-To: <cover.1269255835.git.kirr@mns.spb.ru>
References: <cover.1269255835.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142918>

Neat Trick suggested by Miklos Vajna setups origin remote as '.' and
also setups 3 refspecs for remotes.origin.fetch.

The trick is nice indeed, but in order to setup config multivar, one
have to use explicit --add option for `git config' (*) or else old var
value is just replaced.

The problem showed in svn-mirror repositories with stale master (was not
updating from trunk) and also as lack of branches -- that's
understandable -- we had '+refs/remotes/tags/*:refs/tags/*' config last,
and tags were working OK.

Fix it.

(*) explicit --add was needed since 89c4afe0 (Add --add option to
    git-repo-config) in git.git, which dates to git v1.4.4.2-225-g89c4afe
---
 taskd/clone.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/taskd/clone.sh b/taskd/clone.sh
index 962c526..0f5d6fa 100755
--- a/taskd/clone.sh
+++ b/taskd/clone.sh
@@ -28,8 +28,8 @@ case "$url" in
 		# Neat Trick suggested by Miklos Vajna
 		GIT_DIR=. git config remote.origin.url .
 		GIT_DIR=. git config remote.origin.fetch +refs/remotes/heads/*:refs/heads/*
-		GIT_DIR=. git config remote.origin.fetch +refs/remotes/trunk:refs/heads/master
-		GIT_DIR=. git config remote.origin.fetch +refs/remotes/tags/*:refs/tags/*
+		GIT_DIR=. git config --add remote.origin.fetch +refs/remotes/trunk:refs/heads/master
+		GIT_DIR=. git config --add remote.origin.fetch +refs/remotes/tags/*:refs/tags/*
 		GIT_DIR=. git fetch
 		;;
 	darcs://*)
-- 
1.7.0.2.284.gafe27d
