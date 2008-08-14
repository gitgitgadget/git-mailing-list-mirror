From: Marcus Griep <marcus@griep.us>
Subject: [PATCH v2 1/3] count-objects: Add total pack size to verbose output
Date: Thu, 14 Aug 2008 18:18:26 -0400
Message-ID: <1218752308-3173-2-git-send-email-marcus@griep.us>
References: <1218752308-3173-1-git-send-email-marcus@griep.us>
Cc: Junio C Hamano <gitster@pobox.com>, Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 00:19:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTlAN-00017M-1n
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 00:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbYHNWSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 18:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbYHNWSa
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 18:18:30 -0400
Received: from boohaunt.net ([209.40.206.144]:40225 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390AbYHNWS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 18:18:29 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id 88E201878A72; Thu, 14 Aug 2008 18:18:28 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.rc2.6.g8eda3
In-Reply-To: <1218752308-3173-1-git-send-email-marcus@griep.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92417>

Adds the total pack size (including indexes) the verbose count-objects
output, floored to the nearest kilobyte.

Signed-off-by: Marcus Griep <marcus@griep.us>
---
 builtin-count-objects.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index 91b5487..249040b 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -104,6 +104,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 	if (verbose) {
 		struct packed_git *p;
 		unsigned long num_pack = 0;
+		unsigned long size_pack = 0;
 		if (!packed_git)
 			prepare_packed_git();
 		for (p = packed_git; p; p = p->next) {
@@ -112,12 +113,14 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 			if (open_pack_index(p))
 				continue;
 			packed += p->num_objects;
+			size_pack += p->pack_size + p->index_size;
 			num_pack++;
 		}
 		printf("count: %lu\n", loose);
 		printf("size: %lu\n", loose_size / 2);
 		printf("in-pack: %lu\n", packed);
 		printf("packs: %lu\n", num_pack);
+		printf("size-pack: %lu\n", size_pack / 1024);
 		printf("prune-packable: %lu\n", packed_loose);
 		printf("garbage: %lu\n", garbage);
 	}
-- 
1.6.0.rc2.6.g8eda3
