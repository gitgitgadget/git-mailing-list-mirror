From: "Luck, Tony" <tony.luck@intel.com>
Subject: [PATCH] fix warning from pack-objects.c
Date: Thu, 23 Feb 2006 14:42:39 -0800
Message-ID: <200602232242.k1NMgdAJ018406@agluck-lia64.sc.intel.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 23:42:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCPAc-0000DY-QZ
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 23:42:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbWBWWmn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 17:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbWBWWmm
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 17:42:42 -0500
Received: from fmr21.intel.com ([143.183.121.13]:53660 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751774AbWBWWmm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 17:42:42 -0500
Received: from scsfmr101.sc.intel.com (scsfmr101.sc.intel.com [10.3.253.10])
	by scsfmr001.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k1NMgdi6011815
	for <git@vger.kernel.org>; Thu, 23 Feb 2006 22:42:39 GMT
Received: from intel.com (agluck-lia64.sc.intel.com [10.3.52.217])
	by scsfmr101.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id k1NMbSZc004250
	for <git@vger.kernel.org>; Thu, 23 Feb 2006 22:37:28 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [127.0.0.1])
	by intel.com (Postfix) with ESMTP id 9138819F63
	for <git@vger.kernel.org>; Thu, 23 Feb 2006 14:42:39 -0800 (PST)
Received: (from aegl@localhost)
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1/Submit) id k1NMgdAJ018406;
	Thu, 23 Feb 2006 14:42:39 -0800
To: git@vger.kernel.org
X-Scanned-By: MIMEDefang 2.52 on 10.3.253.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16671>

When compiling on ia64 I get this warning (from gcc 3.4.3):

gcc -o pack-objects.o -c -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'  pack-objects.c
pack-objects.c: In function `pack_revindex_ix':
pack-objects.c:94: warning: cast from pointer to integer of different size

A double cast (first to long, then to int) shuts gcc up, but is there
a better way?

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

diff --git a/pack-objects.c b/pack-objects.c
index 8f352aa..c985fab 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -91,7 +91,7 @@ static int reused_delta = 0;
 
 static int pack_revindex_ix(struct packed_git *p)
 {
-	unsigned int ui = (unsigned int) p;
+	unsigned int ui = (unsigned int)(long)p;
 	int i;
 
 	ui = ui ^ (ui >> 16); /* defeat structure alignment */
