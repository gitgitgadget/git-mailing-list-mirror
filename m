From: Jeff King <peff@peff.net>
Subject: [PATCH 13/16] filter-branch: don't use xargs -0
Date: Wed, 12 Mar 2008 17:41:02 -0400
Message-ID: <20080312214102.GN26286@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 22:41:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZYhn-0002UR-7l
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 22:41:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753710AbYCLVlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 17:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753611AbYCLVlF
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 17:41:05 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2688 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753393AbYCLVlE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 17:41:04 -0400
Received: (qmail 3622 invoked by uid 111); 12 Mar 2008 21:41:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Mar 2008 17:41:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2008 17:41:02 -0400
Content-Disposition: inline
In-Reply-To: <cover.1205356737.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77004>

Some versions of xargs don't understand "-0"; fortunately in
this case we can get the same effect by using "git clean".

Signed-off-by: Jeff King <peff@peff.net>
---
 git-filter-branch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 59cf023..efef732 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -281,7 +281,7 @@ while read commit parents; do
 			die "Could not checkout the index"
 		# files that $commit removed are now still in the working tree;
 		# remove them, else they would be added again
-		git ls-files -z --others | xargs -0 rm -f
+		git clean -q -f -x
 		eval "$filter_tree" < /dev/null ||
 			die "tree filter failed: $filter_tree"
 
-- 
1.5.4.4.543.g30fdd.dirty
