From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Clarify kind of conflict in merge-one-file helper
Date: Wed, 29 Apr 2009 23:40:50 +0200
Message-ID: <20090429214050.GA13794@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 23:41:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzHWj-0005HQ-8d
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 23:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840AbZD2VlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 17:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754379AbZD2VlB
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 17:41:01 -0400
Received: from mout4.freenet.de ([195.4.92.94]:34154 "EHLO mout4.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753637AbZD2VlA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 17:41:00 -0400
Received: from [195.4.92.21] (helo=11.mx.freenet.de)
	by mout4.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #91)
	id 1LzHWS-00045U-ML; Wed, 29 Apr 2009 23:40:56 +0200
Received: from x6432.x.pppool.de ([89.59.100.50]:49195 helo=tigra.home)
	by 11.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #79)
	id 1LzHWS-0006tz-1M; Wed, 29 Apr 2009 23:40:56 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id EF8AC277D8;
	Wed, 29 Apr 2009 23:40:50 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id B4FB336D28; Wed, 29 Apr 2009 23:40:50 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117954>

Not as verbose as the recursive merge driver, but better still.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

 git-merge-one-file.sh |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index e1eb963..9c2c1b7 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -113,6 +113,10 @@ case "${1:-.}${2:-.}${3:-.}" in
 	src1=`git-unpack-file $2`
 	git merge-file "$src1" "$orig" "$src2"
 	ret=$?
+	msg=
+	if [ $ret -ne 0 ]; then
+		msg='content conflict'
+	fi
 
 	# Create the working tree file, using "our tree" version from the
 	# index, and then store the result of the merge.
@@ -120,7 +124,10 @@ case "${1:-.}${2:-.}${3:-.}" in
 	rm -f -- "$orig" "$src1" "$src2"
 
 	if [ "$6" != "$7" ]; then
-		echo "ERROR: Permissions conflict: $5->$6,$7."
+		if [ -n "$msg" ]; then
+			msg="$msg, "
+		fi
+		msg="${msg}permissions conflict: $5->$6,$7"
 		ret=1
 	fi
 	if [ "$1" = '' ]; then
@@ -128,7 +135,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 	fi
 
 	if [ $ret -ne 0 ]; then
-		echo "ERROR: Merge conflict in $4"
+		echo "ERROR: $msg in $4"
 		exit 1
 	fi
 	exec git update-index -- "$4"
-- 
1.6.3.rc3.39.g49fd5
