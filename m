From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] t7700: do not use "touch -r"
Date: Thu, 23 Jan 2014 14:55:18 -0500
Message-ID: <20140123195518.GB31871@sigill.intra.peff.net>
References: <20140123195404.GA31314@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 23 20:55:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6QN5-0005VN-JA
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 20:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209AbaAWTzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 14:55:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:37692 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753040AbaAWTzT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 14:55:19 -0500
Received: (qmail 27152 invoked by uid 102); 23 Jan 2014 19:55:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jan 2014 13:55:19 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jan 2014 14:55:18 -0500
Content-Disposition: inline
In-Reply-To: <20140123195404.GA31314@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240933>

Some versions of touch (such as /usr/ucb/touch on Solaris)
do not know about the "-r" option. This would make sense as
a feature of test-chmtime, but fortunately this fix is even
easier. The test does not care about the timestamp of the
.keep file it creates at all, only that it exists. So we can
simply drop the use of "-r".

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7700-repack.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index d954b84..f9f9014 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -17,7 +17,7 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	# The second pack will contain the excluded object
 	packsha1=$(git rev-list --objects --all | grep file2 |
 		git pack-objects pack) &&
-	touch -r pack-$packsha1.pack pack-$packsha1.keep &&
+	touch pack-$packsha1.keep &&
 	objsha1=$(git verify-pack -v pack-$packsha1.idx | head -n 1 |
 		sed -e "s/^\([0-9a-f]\{40\}\).*/\1/") &&
 	mv pack-* .git/objects/pack/ &&
-- 
1.8.5.2.500.g8060133
