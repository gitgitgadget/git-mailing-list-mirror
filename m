From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT] [PATCH] Handle empty patches and patches with only a header.
Date: Mon, 30 Apr 2012 12:29:55 +0200
Message-ID: <87haw1342k.fsf@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon Apr 30 12:30:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOnrs-0005HN-HB
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 12:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756097Ab2D3KaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 06:30:01 -0400
Received: from smtp.opera.com ([213.236.208.81]:46569 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755944Ab2D3KaB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 06:30:01 -0400
Received: from centurion.linkoping.osa (oslo.jvpn.opera.com [213.236.208.46])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id q3UATux7015610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Apr 2012 10:29:56 GMT
Received: by centurion.linkoping.osa (Postfix, from userid 1000)
	id 5B388B9A07F; Mon, 30 Apr 2012 12:29:55 +0200 (CEST)
CC: ceder@lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196549>

"git apply --numstat" in Git 1.7.10 gives an error message unless the
patch contains a diff, so don't attempt to apply it unless we find a

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 guilt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/guilt b/guilt
index 5d619c5..66a671a 100755
--- a/guilt
+++ b/guilt
@@ -622,7 +622,7 @@ push_patch()
 		cd_to_toplevel
 
 		# apply the patch if and only if there is something to apply
-		if [ `git apply --numstat "$p" | wc -l` -gt 0 ]; then
+		if grep -q '^diff ' "$p" && [ `git apply --numstat "$p" | wc -l` -gt 0 ]; then
 			if [ "$bail_action" = abort ]; then
 				reject=""
 			fi
-- 
1.7.10
