From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 4/5] tag: factor out sig detection for tag display
Date: Sat,  6 Nov 2010 12:04:09 +0100
Message-ID: <581c3740a07c6a9470d7dba13d23721881095d42.1289041051.git.git@drmicha.warpmail.net>
References: <4CAB90EC.1080302@drmicha.warpmail.net>
Cc: Stephan Hugel <urschrei@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 06 12:10:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEger-00043n-4P
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 12:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755383Ab0KFLJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Nov 2010 07:09:58 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:56572 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755328Ab0KFLJ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Nov 2010 07:09:56 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6B3D6625;
	Sat,  6 Nov 2010 07:03:55 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Sat, 06 Nov 2010 07:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=+t/KPTn+iGgpzzXpngKG7kbjSZ8=; b=SnVO3713xLemJXd9jN00P13dNOSpVwFtZRLcagcYHHh7fLap/eaAi3jyrcMz0kSvYgylFA5Z6fitHyRsEpQXHIv+xsVyMW7iY2oOmPLA1GnuVeHUwRcKDjnoqDhcfhM3dbGwgkXXx339T/PEONS+/iyXiUm+B1n0PwRBRKRCyvM=
X-Sasl-enc: CmCJNzZ5ju90Z3hmzDyMR/P80bKHF2HDmA12prQ6TAeA 1289041434
Received: from localhost (p548596E8.dip0.t-ipconnect.de [84.133.150.232])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BD47040244A;
	Sat,  6 Nov 2010 07:03:54 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.2.193.g78bbb
In-Reply-To: <4CAB90EC.1080302@drmicha.warpmail.net>
In-Reply-To: <cover.1289041051.git.git@drmicha.warpmail.net>
References: <cover.1289041051.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160835>

Use the factored out code for sig detection when displaying tags.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/tag.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 66feeb0..617a58f 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -68,9 +68,9 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 			return 0;
 		}
 		/* only take up to "lines" lines, and strip the signature */
+		size = parse_signature(buf, size);
 		for (i = 0, sp += 2;
-				i < filter->lines && sp < buf + size &&
-				prefixcmp(sp, PGP_SIGNATURE "\n");
+				i < filter->lines && sp < buf + size;
 				i++) {
 			if (i)
 				printf("\n    ");
-- 
1.7.3.2.193.g78bbb
