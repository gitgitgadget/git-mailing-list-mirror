From: Marcus Griep <marcus@griep.us>
Subject: [PATCH] count-objects: Add total pack size to verbose output
Date: Wed, 13 Aug 2008 16:05:10 -0400
Message-ID: <1218657910-22096-1-git-send-email-marcus@griep.us>
Cc: Junio C Hamano <gitster@pobox.com>, Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 22:20:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTMbu-0005Kf-V5
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 22:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbYHMUFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 16:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbYHMUFM
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 16:05:12 -0400
Received: from boohaunt.net ([209.40.206.144]:60994 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752523AbYHMUFL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 16:05:11 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id 277ED1878AD5; Wed, 13 Aug 2008 16:05:10 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.rc2.6.g8eda3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92261>

Adds the total pack size (including indexes) the verbose count-objects
output, floored to the nearest kilobyte.

Signed-off-by: Marcus Griep <marcus@griep.us>
---

 I used the pack size including the size of the associated indexes in
 computing total pack size since it more closely represents the disk
 usage of each pack. If separate reporting is preferred, they can be
 split apart.

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
