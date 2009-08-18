From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Tue, 18 Aug 2009 09:15:57 +0200
Message-ID: <4A8A552D.6020407@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: msysGit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 09:16:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdIvX-0004ke-JM
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 09:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbZHRHQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 03:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbZHRHQB
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 03:16:01 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:7901 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbZHRHQB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 03:16:01 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MdIvF-00056j-TQ; Tue, 18 Aug 2009 09:15:58 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 92538A4A1; Tue, 18 Aug 2009 09:15:57 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126355>

From: Johannes Sixt <j6t@kdbg.org>

This is a minimal fix to compile block-sha1 on Windows. I did not do any
benchmarks whether the implementation of ntohl() is actually faster than
bytewise access and shifts.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 I would appreciate if our Windows experts could tell whether the
 implementation of ntohl/htonl is worth its money or whether we should
 go with the generic byte access plus shifts.

 the function call over
 block-sha1/sha1.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index a1228cf..67c1ee8 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -7,7 +7,11 @@
  */

 #include <string.h>
+#ifndef _WIN32
 #include <arpa/inet.h>
+#else
+#include <winsock2.h>
+#endif

 #include "sha1.h"

-- 
1.6.4.1179.g9a91.dirty
