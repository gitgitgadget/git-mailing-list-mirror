From: Johan Herland <johan@herland.net>
Subject: [PATCH 1/4] Incorporate fetched packs in future object traversal
Date: Sun, 15 Jun 2008 16:04:20 +0200
Message-ID: <200806151604.20810.johan@herland.net>
References: <200806151602.03445.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 15 16:06:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7srm-0000Kc-K7
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 16:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760135AbYFOOEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 10:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760126AbYFOOEi
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 10:04:38 -0400
Received: from smtp.getmail.no ([84.208.20.33]:36636 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760124AbYFOOEh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 10:04:37 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K2I00M18CFNP300@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 16:04:35 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2I00HTCCF83820@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 16:04:21 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2I009CXCF8TS30@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 16:04:20 +0200 (CEST)
In-reply-to: <200806151602.03445.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85095>

Immediately after fetching a pack, we should call reprepare_packed_git() to
make sure the objects in the pack are reachable. Otherwise, we will fail to
look up objects that are present only in the fetched pack.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin-fetch-pack.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index de1e8d1..f4dbcf0 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -820,5 +820,6 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 		}
 	}
 
+	reprepare_packed_git();
 	return ref_cpy;
 }
-- 
1.5.6.rc2.128.gf64ae
