From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-reset --hard: tell the user what the HEAD was reset to
Date: Thu, 21 Dec 2006 15:26:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612211525070.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <emcf17$esj$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 15:27:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxOso-0007F6-6B
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 15:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbWLUO0i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 09:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbWLUO0i
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 09:26:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:44078 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964994AbWLUO0h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 09:26:37 -0500
Received: (qmail invoked by alias); 21 Dec 2006 14:26:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 21 Dec 2006 15:26:36 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
In-Reply-To: <emcf17$esj$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35072>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	On Wed, 20 Dec 2006, Han-Wen Nienhuys wrote:

	> It would be nice if git-reset printed 
	> 
	>  HEAD is now <sha1> - <excerpt of commit message>

	This patch does that, but only for --reset.

	Without reset, HEAD is _not_ changed, just the contents of the
	working directory and/or the index.

 git-reset.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/git-reset.sh b/git-reset.sh
index 8d95e37..2379db0 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -86,7 +86,12 @@ update_ref_status=$?
 
 case "$reset_type" in
 --hard )
-	;; # Nothing else to do
+	test $update_ref_status = 0 && {
+		echo -n "HEAD is now at "
+		GIT_PAGER= git log --max-count=1 --pretty=oneline \
+			--abbrev-commit HEAD
+	}
+	;;
 --soft )
 	;; # Nothing else to do
 --mixed )
-- 
1.4.4.3.gdb8fb-dirty
