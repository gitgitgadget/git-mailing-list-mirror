From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Cleanup in sha1_file.c::cache_or_unpack_entry()
Date: Thu,  9 Oct 2008 02:11:24 +0200
Message-ID: <1223511084-3472-1-git-send-email-vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 02:13:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Knj8k-0006uf-86
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 02:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755766AbYJIALN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 20:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755707AbYJIALN
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 20:11:13 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:51567 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152AbYJIALN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 20:11:13 -0400
Received: from vmobile.example.net (catv-89-132-129-234.catv.broadband.hu [89.132.129.234])
	by yugo.frugalware.org (Postfix) with ESMTPA id 528A5149C60
	for <git@vger.kernel.org>; Thu,  9 Oct 2008 02:11:11 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 34B3319D922; Thu,  9 Oct 2008 02:11:24 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97813>

This patch just removes an unnecessary goto which makes the code easier
to read and shorter.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 sha1_file.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 7515987..ea6bd99 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1571,11 +1571,9 @@ static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
 	struct delta_base_cache_entry *ent = delta_base_cache + hash;
 
 	ret = ent->data;
-	if (ret && ent->p == p && ent->base_offset == base_offset)
-		goto found_cache_entry;
-	return unpack_entry(p, base_offset, type, base_size);
+	if (!ret || ent->p != p || ent->base_offset != base_offset)
+		return unpack_entry(p, base_offset, type, base_size);
 
-found_cache_entry:
 	if (!keep_cache) {
 		ent->data = NULL;
 		ent->lru.next->prev = ent->lru.prev;
-- 
1.6.0.2
