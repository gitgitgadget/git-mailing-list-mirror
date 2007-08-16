From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] pack-objects: remove bogus arguments to delta_cacheable()
Date: Wed, 15 Aug 2007 22:46:01 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0708152241430.16727@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Aug 16 04:46:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILVNa-0005RD-GX
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 04:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760089AbXHPCqJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 22:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757814AbXHPCqI
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 22:46:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43155 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbXHPCqH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 22:46:07 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JMU00DQ8ICPGSF0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 15 Aug 2007 22:46:01 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55976>

Not only are they unused, but the order in the function declaration
and the actual usage don't match.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 51a850e..24926db 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1273,9 +1273,8 @@ struct unpacked {
 	unsigned depth;
 };
 
-static int delta_cacheable(struct unpacked *trg, struct unpacked *src,
-			    unsigned long src_size, unsigned long trg_size,
-			    unsigned long delta_size)
+static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
+			   unsigned long delta_size)
 {
 	if (max_delta_cache_size && delta_cache_size + delta_size > max_delta_cache_size)
 		return 0;
@@ -1397,7 +1396,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	trg_entry->delta_size = delta_size;
 	trg->depth = src->depth + 1;
 
-	if (delta_cacheable(src, trg, src_size, trg_size, delta_size)) {
+	if (delta_cacheable(src_size, trg_size, delta_size)) {
 		trg_entry->delta_data = xrealloc(delta_buf, delta_size);
 		delta_cache_size += trg_entry->delta_size;
 	} else
