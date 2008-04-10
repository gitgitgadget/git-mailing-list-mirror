From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] revision.c: make --date-order overriddable
Date: Thu, 10 Apr 2008 22:06:52 +0200
Message-ID: <200804102206.52464.barra_cuda@katamail.com>
References: <alpine.LNX.1.10.0804101342090.8765@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jan Engelhardt <jengelh@computergmbh.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 22:08:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jk32C-00033U-Li
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 22:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757075AbYDJUF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 16:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757078AbYDJUF2
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 16:05:28 -0400
Received: from smtp.katamail.com ([62.149.157.154]:34726 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1756980AbYDJUF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 16:05:28 -0400
Received: (qmail 3131 invoked by uid 89); 10 Apr 2008 20:04:53 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=RDNS_NONE autolearn=disabled
	version=3.2.3
Received: from unknown (HELO host181-57-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.57.181)
  by smtp2-pc with SMTP; 10 Apr 2008 20:04:52 -0000
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.LNX.1.10.0804101342090.8765@fbirervta.pbzchgretzou.qr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79247>

Jan Engelhardt noticed that while --topo-order can be overridden by a
subsequent --date-order, the reverse was not possible. That's because
setup_revisions() failed to set revs->lifo properly.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
On Thursday 10 April 2008, Jan Engelhardt wrote:
> git-rev-list --topo-order (the default) can be overriden by specifying 
> --date-order, but --date-order cannot be overriden by passing in 
> --topo-order again. Having it work would be really nice because it 
> allows extra programs to default to --date-order in some way.

This should do.

 revision.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 196fedc..ffbed3f 100644
--- a/revision.c
+++ b/revision.c
@@ -1083,6 +1083,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				continue;
 			}
 			if (!strcmp(arg, "--topo-order")) {
+				revs->lifo = 1;
 				revs->topo_order = 1;
 				continue;
 			}
-- 
1.5.5
