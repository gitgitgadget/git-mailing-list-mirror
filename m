From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] cg-commit -p tries to remove a non-existent file
Date: Thu, 1 Jun 2006 17:14:27 +0200
Message-ID: <20060601151427.G51985817@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 01 17:14:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Flosl-0004iZ-Hn
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 17:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbWFAPOh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 11:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWFAPOg
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 11:14:36 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:45185 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1030194AbWFAPOg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jun 2006 11:14:36 -0400
Received: from leonov.stosberg.net (p213.54.79.85.tisdip.tiscali.de [213.54.79.85])
	by ncs.stosberg.net (Postfix) with ESMTP id C7D22AEBA005;
	Thu,  1 Jun 2006 17:14:26 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 2CFDD10637B; Thu,  1 Jun 2006 17:14:28 +0200 (CEST)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
Received: from leonov ([unix socket]) by leonov (Cyrus v2.1.18-IPv6-Debian-2.1.18-1+sarge2) with LMTP; Thu, 01 Jun 2006 16:57:06 +0200
X-Sieve: CMU Sieve 2.2
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21116>

This produces an error message when the user aborts the commit:

$ cg init -m "Initial commit"
$ echo "some text" >file
$ cg add file
$ EDITOR=/bin/false cg commit -p
Log message unchanged or not specified
Abort or commit? [ac] a
rm: cannot remove `/tmp/gitci.zdAHil/patch2.diff': No such file or \
directory
Commit message not modified, commit aborted
---
 cg-commit |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cg-commit b/cg-commit
index 4ec2b33..c636b1a 100755
--- a/cg-commit
+++ b/cg-commit
@@ -442,7 +442,7 @@ cp "$LOGMSG" "$LOGMSG2"
 if tty -s; then
 	if [ "$editor" ] && ! editor $commitalways commit c; then
 		rm "$LOGMSG" "$LOGMSG2"
-		[ "$review" ] && rm "$PATCH" "$PATCH2"
+		[ "$review" ] && rm "$PATCH"
 		echo "Commit message not modified, commit aborted" >&2
 		if [ "$merging" ]; then
 			cat >&2 <<__END__
-- 
1.3.3+git20060531-dest1
