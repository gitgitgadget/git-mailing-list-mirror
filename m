From: Johan Herland <johan@herland.net>
Subject: [PATCH 1/4] Incorporate fetched packs in future object traversal
Date: Mon, 14 Apr 2008 10:02:07 +0200
Message-ID: <200804141002.07648.johan@herland.net>
References: <200803220210.30957.johan@herland.net>
 <alpine.LNX.1.00.0804140205040.19665@iabervon.org>
 <200804141000.09515.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Apr 14 10:03:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlJfC-0007Ex-TA
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 10:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756021AbYDNIC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 04:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755986AbYDNIC5
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 04:02:57 -0400
Received: from smtp.getmail.no ([84.208.20.33]:33200 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755054AbYDNIC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 04:02:56 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JZB000072CTFM00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 14 Apr 2008 10:02:53 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZB009JN2BJRN40@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 14 Apr 2008 10:02:07 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZB00K1H2BJL390@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 14 Apr 2008 10:02:07 +0200 (CEST)
In-reply-to: <200804141000.09515.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79483>

Immediately after fetching a pack, we should call reprepare_packed_git() to
make sure the objects in the pack are reachable. Otherwise, we will fail to
look up objects that are present only in the fetched pack.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin-fetch-pack.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 65350ca..309ae03 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -820,5 +820,6 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 		}
 	}
 
+	reprepare_packed_git();
 	return ref_cpy;
 }
-- 
1.5.5.159.g8c84b
