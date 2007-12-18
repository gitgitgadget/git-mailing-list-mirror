From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Fix segfault in diff-delta.c when FLEX_ARRAY is 1
Date: Tue, 18 Dec 2007 02:39:57 +0100
Message-ID: <1197941997-11421-1-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: gitster@pobox.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Dec 18 02:40:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4RRe-0000xH-Mb
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 02:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763298AbXLRBkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 20:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765132AbXLRBkC
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 20:40:02 -0500
Received: from pan.madism.org ([88.191.52.104]:39341 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932736AbXLRBkA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 20:40:00 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 5CAD730AC5;
	Tue, 18 Dec 2007 02:39:58 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 20B8A37E438; Tue, 18 Dec 2007 02:39:57 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc0.1153.gb1b3d-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68683>

aka don't do pointer arithmetics on structs that have a FLEX_ARRAY member,
or you'll end up believing your array is 1 cell off its real address.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 diff-delta.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index 9e440a9..601b49e 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -264,7 +264,7 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 	index->src_size = bufsize;
 	index->hash_mask = hmask;
 
-	mem = index + 1;
+	mem = index->hash;
 	packed_hash = mem;
 	mem = packed_hash + (hsize+1);
 	packed_entry = mem;
-- 
1.5.4.rc0.1153.gb1b3d-dirty
