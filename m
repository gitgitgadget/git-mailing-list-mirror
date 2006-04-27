From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Fix cg-status with recent git versions
Date: Thu, 27 Apr 2006 18:38:26 -0400
Message-ID: <20060427223826.10772.55883.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Apr 28 00:38:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZF89-0001TD-6s
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 00:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbWD0Wid (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 18:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbWD0Wid
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 18:38:33 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:56023 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751733AbWD0Wic
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Apr 2006 18:38:32 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FZF83-0000XR-Fp
	for git@vger.kernel.org; Thu, 27 Apr 2006 18:38:31 -0400
Received: from localhost.roinet.com ([127.0.0.1] helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.61)
	(envelope-from <proski@gnu.org>)
	id 1FZF7y-0002nr-St; Thu, 27 Apr 2006 18:38:26 -0400
To: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19250>

From: Pavel Roskin <proski@gnu.org>

git-diff-index checks the arguments by lstat(), so an empty string would
fail to be recognized as a file.  Use "--" to separate files from
revisions, and also use "." instead of the empty string.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 cg-status |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cg-status b/cg-status
index d11762e..0529ba2 100755
--- a/cg-status
+++ b/cg-status
@@ -233,7 +233,7 @@ if [ "$workstatus" ]; then
 		commitignore=
 		[ -s "$_git/commit-ignore" ] && commitignore=1
 
-		git-diff-index HEAD "$basepath" | cut -f5- -d' ' | 
+		git-diff-index HEAD -- "${basepath:-.}" | cut -f5- -d' ' | 
 		while IFS=$'\t' read -r mode file; do
 			if [ "$mode" = D ]; then
 				[ "$(git-diff-files "$file")" ] && mode=!
