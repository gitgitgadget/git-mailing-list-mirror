From: Nicolas Pitre <nico@cam.org>
Subject: PATCH/RFC] allow delta data reuse even if base object is a preferred
 base
Date: Wed, 27 Sep 2006 15:42:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609271536470.9349@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 21:42:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSfIT-0006KD-1B
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 21:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030715AbWI0TmS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 15:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030716AbWI0TmS
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 15:42:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27621 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030715AbWI0TmR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 15:42:17 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J69004CPO2GK6B0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 27 Sep 2006 15:42:16 -0400 (EDT)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27924>


Signed-off-by: Nicolas Pitre <nico@cam.org>

---

Any reason why this couldn't be done?

When I reworked that code I preserved the existing logic wrt preferred 
base.  However I could not find a reason why it was that way.  Hence 
this patch.

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 6db97b6..ee5f031 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -989,7 +988,7 @@ static void check_object(struct object_e
 		unuse_packed_git(p);
 		entry->in_pack_header_size = used;
 
-		if (base_entry && !base_entry->preferred_base) {
+		if (base_entry) {
 
 			/* Depth value does not matter - find_deltas()
 			 * will never consider reused delta as the
