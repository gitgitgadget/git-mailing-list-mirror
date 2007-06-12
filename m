From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] Don't dereference a strdup-returned NULL
Date: Tue, 12 Jun 2007 22:59:21 +0200
Message-ID: <87abv4ubx2.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 22:59:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyDSZ-0003Gf-JI
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 22:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbXFLU7X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 16:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbXFLU7X
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 16:59:23 -0400
Received: from mx.meyering.net ([82.230.74.64]:40731 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778AbXFLU7W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 16:59:22 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id A498D265F5; Tue, 12 Jun 2007 22:59:21 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49998>

There are only a dozen or so uses of strdup in all of git.
Of those, most seem ok, but this one isn't:

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 remote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/remote.c b/remote.c
index 33c8e50..ed62a62 100644
--- a/remote.c
+++ b/remote.c
@@ -542,7 +542,7 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 			strcpy(dst_name, pat->dst);
 			strcat(dst_name, src->name + strlen(pat->src));
 		} else
-			dst_name = strdup(src->name);
+			dst_name = xstrdup(src->name);
 		dst_peer = find_ref_by_name(dst, dst_name);
 		if (dst_peer && dst_peer->peer_ref)
 			/* We're already sending something to this ref. */
--
1.5.2.1.159.g8d11
