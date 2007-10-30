From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 5/5] add throughput display to index-pack
Date: Tue, 30 Oct 2007 14:57:35 -0400
Message-ID: <1193770655-20492-6-git-send-email-nico@cam.org>
References: <1193770655-20492-1-git-send-email-nico@cam.org>
 <1193770655-20492-2-git-send-email-nico@cam.org>
 <1193770655-20492-3-git-send-email-nico@cam.org>
 <1193770655-20492-4-git-send-email-nico@cam.org>
 <1193770655-20492-5-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 19:59:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImwIo-0001oE-GK
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 19:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943AbXJ3S6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 14:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753837AbXJ3S6S
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 14:58:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37695 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410AbXJ3S6K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 14:58:10 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQQ0021VNC05WB0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 30 Oct 2007 14:57:39 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.4.1463.gf79ad2
In-reply-to: <1193770655-20492-5-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62734>

... and call it "Receiving objects" when over stdin to look clearer
to end users.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 index-pack.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index 879ea15..61ea762 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -87,6 +87,8 @@ static void *fill(int min)
 				die("early EOF");
 			die("read error on input: %s", strerror(errno));
 		}
+		if (from_stdin)
+			display_throughput(progress, ret);
 		input_len += ret;
 	} while (input_len < min);
 	return input_buffer;
@@ -406,7 +408,9 @@ static void parse_pack_objects(unsigned char *sha1)
 	 * - remember base (SHA1 or offset) for all deltas.
 	 */
 	if (verbose)
-		progress = start_progress("Indexing objects", nr_objects);
+		progress = start_progress(
+				from_stdin ? "Receiving objects" : "Indexing objects",
+				nr_objects);
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
 		data = unpack_raw_entry(obj, &delta->base);
-- 
1.5.3.4.1463.gf79ad2
