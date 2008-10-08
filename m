From: Imre Deak <imre.deak@gmail.com>
Subject: [PATCH] builtin-apply: fix typo leading to stack corruption
Date: Thu, 9 Oct 2008 00:24:16 +0300
Message-ID: <48ed30f5.0707d00a.2994.6f1e@mx.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 00:16:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnhKb-00040V-Kx
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 00:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbYJHWPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 18:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752740AbYJHWPV
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 18:15:21 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:8666 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602AbYJHWPU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 18:15:20 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1326666eyi.37
        for <git@vger.kernel.org>; Wed, 08 Oct 2008 15:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:date:subject
         :message-id;
        bh=+fEC7Jguci+FoyuZmqBlU9HDJ+dp/8IttKZCmNZ5I3Y=;
        b=xaWsXu21IS+DFl3d0kDsZSikDKWzAXszJzDV/AodzAvCfruJQ7nEHNRpBQtP5WGmNq
         RTYtKDj/NrAaYFR4u0bcVqEUUAp8LRYXvfOzvFErqDdFu9GmXrK1bKX79EkhzmGeksIP
         bujWjrSy+joIEC72oK59+IBpcSUVucjFQ6eZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:date:subject:message-id;
        b=jW8N0QyWEsQEwQenFw7pY3v34h/WOiBLYs5F/OTHCqb+RXhPuecLoYIUNNZ3sDAqso
         YJIXS2CGReBVomaIEWe7t1YZpmqSmNe1clN0J5lc2nzJ3g8+FbwMAggouq5zxmYzTMLE
         Zb1Mp5WHiPE0YQdbOJ/ElaasJfjyunSsqGdTQ=
Received: by 10.210.90.10 with SMTP id n10mr10603913ebb.49.1223504118780;
        Wed, 08 Oct 2008 15:15:18 -0700 (PDT)
Received: from localhost (teleca.fi [212.213.55.210])
        by mx.google.com with ESMTPS id 7sm17811433eyg.0.2008.10.08.15.15.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Oct 2008 15:15:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97807>

This typo led to stack corruption for lines with whitespace fixes
and length > 1024.
---
 builtin-apply.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 20bef1f..720dc7f 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1696,7 +1696,7 @@ static int match_fragment(struct image *img,
 		fixlen = ws_fix_copy(buf, orig, oldlen, ws_rule, NULL);
 
 		/* Try fixing the line in the target */
-		if (sizeof(tgtfixbuf) < tgtlen)
+		if (sizeof(tgtfixbuf) > tgtlen)
 			tgtfix = tgtfixbuf;
 		else
 			tgtfix = xmalloc(tgtlen);
-- 
1.6.0.2.308.g754c
