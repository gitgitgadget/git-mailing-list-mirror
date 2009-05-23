From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] cache-tree.c::cache_tree_find(): simplify inernal API
Date: Sat, 23 May 2009 12:24:35 -0700
Message-ID: <1243106678-6343-3-git-send-email-gitster@pobox.com>
References: <1243106678-6343-1-git-send-email-gitster@pobox.com>
 <1243106678-6343-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 21:24:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7wpv-0001xr-Ss
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 21:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588AbZEWTYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 15:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754134AbZEWTYp
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 15:24:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62472 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753782AbZEWTYn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 15:24:43 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B544EB56B7
	for <git@vger.kernel.org>; Sat, 23 May 2009 15:24:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3B1E0B56B6 for
 <git@vger.kernel.org>; Sat, 23 May 2009 15:24:43 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.1.145.gb74d77
In-Reply-To: <1243106678-6343-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5F1ABFA2-47CF-11DE-BAA1-F6BA321C86B1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119789>

Earlier cache_tree_find() needs to be called with a valid cache_tree,
but repeated look-up may find an invalid or missing cache_tree in between.
Help simplify the callers by returning NULL to mean "nothing appropriate
found" when the input is NULL.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache-tree.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 6dd8411..5481e43 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -514,6 +514,8 @@ struct cache_tree *cache_tree_read(const char *buffer, unsigned long size)
 
 static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *path)
 {
+	if (!it)
+		return NULL;
 	while (*path) {
 		const char *slash;
 		struct cache_tree_sub *sub;
-- 
1.6.3.1.145.gb74d77
