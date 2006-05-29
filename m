From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Remove unnecessary ouput from t3600-rm.
Date: Mon, 29 May 2006 03:16:46 -0400
Message-ID: <20060529071646.GC6061@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 09:16:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkbzh-0002xq-0h
	for gcvg-git@gmane.org; Mon, 29 May 2006 09:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWE2HQu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 03:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWE2HQu
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 03:16:50 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43154 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750715AbWE2HQu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 03:16:50 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fkbzb-0005X3-Db; Mon, 29 May 2006 03:16:47 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CC6B420E445; Mon, 29 May 2006 03:16:46 -0400 (EDT)
To: Junio Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20928>

Moved the output of the setup commits and the test-file rm check to
file descriptors 3 and 4 hiding their messages unless -v is given.
This makes the test suite look a little cleaner when the rm test-file
setup step fails (and was probably expected to fail).

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/t3600-rm.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index acaa4d6..5b6bf61 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -10,14 +10,14 @@ test_description='Test of the various op
 # Setup some files to be removed, some with funny characters
 touch -- foo bar baz 'space embedded' -q
 git-add -- foo bar baz 'space embedded' -q
-git-commit -m "add normal files"
+git-commit -m "add normal files" >&3 2>&4
 test_tabs=y
 if touch -- 'tab	embedded' 'newline
 embedded'
 then
 git-add -- 'tab	embedded' 'newline
 embedded'
-git-commit -m "add files with tabs and newlines"
+git-commit -m "add files with tabs and newlines" >&3 2>&4
 else
     say 'Your filesystem does not allow tabs in filenames.'
     test_tabs=n
@@ -28,7 +28,7 @@ # git-rm barfs, but if the test is run a
 # arranged.
 : >test-file
 chmod a-w .
-rm -f test-file
+rm -f test-file >&3 2>&4
 test -f test-file && test_failed_remove=y
 chmod 775 .
 rm -f test-file
-- 
1.3.3.g45d8
