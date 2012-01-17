From: mhagger@alum.mit.edu
Subject: [PATCH 1/4] pack_refs(): remove redundant check
Date: Tue, 17 Jan 2012 06:50:31 +0100
Message-ID: <1326779434-20106-2-git-send-email-mhagger@alum.mit.edu>
References: <1326779434-20106-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 17 06:51:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rn1x2-00064t-IP
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 06:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260Ab2AQFvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 00:51:16 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:50021 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab2AQFvP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 00:51:15 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEDA74.dip.t-dialin.net [84.190.218.116])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q0H5oam3006829;
	Tue, 17 Jan 2012 06:50:39 +0100
X-Mailer: git-send-email 1.7.8.3
In-Reply-To: <1326779434-20106-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188689>

From: Michael Haggerty <mhagger@alum.mit.edu>

handle_one_ref() only adds refs to the cbdata.ref_to_prune list if
(cbdata.flags & PACK_REFS_PRUNE) is set.  So any references in this
list at the end of pack_refs() can be pruned unconditionally.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Trivial simplification, not essential to the rest of this patch
series.

 pack-refs.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/pack-refs.c b/pack-refs.c
index 23bbd00..f09a054 100644
--- a/pack-refs.c
+++ b/pack-refs.c
@@ -143,7 +143,6 @@ int pack_refs(unsigned int flags)
 	packed.fd = -1;
 	if (commit_lock_file(&packed) < 0)
 		die_errno("unable to overwrite old ref-pack file");
-	if (cbdata.flags & PACK_REFS_PRUNE)
-		prune_refs(cbdata.ref_to_prune);
+	prune_refs(cbdata.ref_to_prune);
 	return 0;
 }
-- 
1.7.8.3
