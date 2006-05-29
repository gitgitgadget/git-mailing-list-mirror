From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] cg-clean fails on files beginning with a dash
Date: Mon, 29 May 2006 17:06:52 +0200
Message-ID: <20060529150652.G6dba4ec3@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 17:07:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkjKc-0001v9-2r
	for gcvg-git@gmane.org; Mon, 29 May 2006 17:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWE2PGz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 11:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWE2PGz
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 11:06:55 -0400
Received: from v345.ncsrv.de ([89.110.145.104]:43164 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1750943AbWE2PGy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 11:06:54 -0400
Received: from leonov.stosberg.net (p213.54.87.107.tisdip.tiscali.de [213.54.87.107])
	by ncs.stosberg.net (Postfix) with ESMTP id 3CFD2589000C;
	Mon, 29 May 2006 17:06:46 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 493CF10498C; Mon, 29 May 2006 17:06:52 +0200 (CEST)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
Received: from leonov ([unix socket]) by leonov (Cyrus v2.1.18-IPv6-Debian-2.1.18-1+sarge2) with LMTP; Mon, 29 May 2006 14:53:48 +0200
X-Sieve: CMU Sieve 2.2
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20950>

Reproducible with:

$ git init-db
$ echo "some text" >-file
$ cg clean
Removing -file
rm: invalid option -- l
Try `rm --help' for more information.

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---
 cg-clean |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cg-clean b/cg-clean
index 5f438eb..fe611ac 100755
--- a/cg-clean
+++ b/cg-clean
@@ -67,13 +67,13 @@ while read -r file; do
 		if [ "$cleandirhard" ]; then
 			chmod -R 700 "$file"
 		fi
-		$rm -rf "$file"
+		$rm -rf -- "$file"
 		if [ -e "$file" -o -L "$file" ]; then
 			echo "Cannot remove $file"
 		fi
 	elif [ -e "$file" -o -L "$file" ]; then
 		[ "$quiet" ] || echo "Removing $file"
-		"$rm" -f "$file"
+		"$rm" -f -- "$file"
 		# rm would complain itself on failure
 	else
 		echo "File $file has disappeared!"
-- 
1.3.3+git20060528-dest1
