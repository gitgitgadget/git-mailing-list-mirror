From: pasky@suse.cz
Subject: [PATCH 1/3] git web--browse: Add --stdin option support
Date: Thu, 25 Sep 2008 01:57:35 +0200
Message-ID: <20080925000156.372683193@suse.cz>
References: <20080924235734.697978308@suse.cz>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 02:03:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KieKN-0003We-AG
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 02:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbYIYACM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 20:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752500AbYIYACK
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 20:02:10 -0400
Received: from 132-201.104-92.cust.bluewin.ch ([92.104.201.132]:50388 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752047AbYIYACI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 20:02:08 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id CEBE32AC8FB; Thu, 25 Sep 2008 02:01:56 +0200 (CEST)
User-Agent: quilt/0.46_cvs20080326-19.1
Content-Disposition: inline; filename=t/web--browse/stdin.diff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96718>

This ugly hack seems to be necessary to safely pass URLs containing
query string even in the MinGW environment from TCL (git-gui). I admit
that it is not nice, but I at least did not manage to find any other
way to achieve that even after spending very long time debugging this
mysterious problem.

This patch has been sponsored by Novartis.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 Documentation/git-web--browse.txt |    5 ++++-
 git-web--browse.sh                |    6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 7f7a45b..15d2c25 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -7,7 +7,7 @@ git-web--browse - git helper script to launch a web browser
 
 SYNOPSIS
 --------
-'git web--browse' [OPTIONS] URL/FILE ...
+'git web--browse' [OPTIONS] {--stdin,URL/FILE...}
 
 DESCRIPTION
 -----------
@@ -45,6 +45,9 @@ OPTIONS
 	CONF.VAR is looked up in the git config files. If it's set,
 	then its value specify the browser that should be used.
 
+--stdin::
+	Read the location to open from stdin.
+
 CONFIGURATION VARIABLES
 -----------------------
 
diff --git a/git-web--browse.sh b/git-web--browse.sh
index 384148a..68234fa 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -16,7 +16,7 @@
 # git maintainer.
 #
 
-USAGE='[--browser=browser|--tool=browser] [--config=conf.var] url/file ...'
+USAGE='[--browser=browser|--tool=browser] [--config=conf.var] {--stdin,url/file...}'
 
 # This must be capable of running outside of git directory, so
 # the vanilla git-sh-setup should not be used.
@@ -71,6 +71,10 @@ do
 		    shift ;;
 	    esac
 	    ;;
+	--stdin*)
+	    shift
+	    set "$(cat)"
+	    break ;;
 	--)
 	    break
 	    ;;
-- 
tg: (c427559..) t/web--browse/stdin (depends on: vanilla/master)
