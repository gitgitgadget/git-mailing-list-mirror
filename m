From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/2] add throughput display to index-pack
Date: Mon, 29 Oct 2007 19:25:47 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710291922510.22100@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 00:26:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imdzk-0005Gn-Vs
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 00:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756676AbXJ2XZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 19:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756662AbXJ2XZt
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 19:25:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:32369 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756640AbXJ2XZs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 19:25:48 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQP00ID552Z0310@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 29 Oct 2007 19:25:47 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62632>

... and call it "Receiving objects" when over stdin to look clearer
to end users.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/index-pack.c b/index-pack.c
index 2f149a4..d32c7b9 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -87,6 +87,8 @@ static void *fill(int min)
 				die("early EOF");
 			die("read error on input: %s", strerror(errno));
 		}
+		if (verbose && from_stdin)
+			display_throughput(&progress, ret);
 		input_len += ret;
 	} while (input_len < min);
 	return input_buffer;
@@ -406,7 +408,9 @@ static void parse_pack_objects(unsigned char *sha1)
 	 * - remember base (SHA1 or offset) for all deltas.
 	 */
 	if (verbose)
-		start_progress(&progress, "Indexing objects", nr_objects);
+		start_progress(&progress,
+			       from_stdin ? "Receiving objects" : "Indexing objects",
+			       nr_objects);
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
 		data = unpack_raw_entry(obj, &delta->base);
