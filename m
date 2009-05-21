From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] cache-tree.c::cache_tree_find(): simplify inernal API
Date: Wed, 20 May 2009 17:40:11 -0700
Message-ID: <7vab57waok.fsf_-_@alter.siamese.dyndns.org>
References: <4A136C40.6020808@workspacewhiz.com>
	<alpine.LFD.2.00.0905192300070.3906@xanadu.home>
	<20090520032139.GB10212@coredump.intra.peff.net>
	<7vfxezzms0.fsf@alter.siamese.dyndns.org>
	<7vws8by6iz.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 02:40:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6wKc-0006rE-V4
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 02:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755779AbZEUAkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 20:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755247AbZEUAkL
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 20:40:11 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:47419 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754921AbZEUAkK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 20:40:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090521004011.CYYV20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 20 May 2009 20:40:11 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id u0gB1b00D4aMwMQ040gBnk; Wed, 20 May 2009 20:40:11 -0400
X-Authority-Analysis: v=1.0 c=1 a=vTwp5Sfy4l0A:10 a=7ihouLK4gf0A:10
 a=ybZZDoGAAAAA:8 a=ec7ICQJVDLLWZ3m8dxEA:9 a=33_a3gQRluOfj0BM_WbB1qKsdZ0A:4
 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <7vws8by6iz.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 20 May 2009 11\:27\:00 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119642>

Earlier cache_tree_find() needs to be called with a valid cache_tree,
but repeated look-up may find an invalid or missing cache_tree in between.
Help simplify the callers by returning NULL to mean "nothing appropriate
found" when the input is NULL.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is a preliminary clean-up patch.  What comes next is much bigger.

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
1.6.3.1.56.gd00e3.dirty
