From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] reduce delta head inflated size
Date: Wed, 18 Oct 2006 15:56:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610181541280.1971@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 21:56:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaHWf-0006Xm-8E
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 21:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWJRT4Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 15:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWJRT4Y
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 15:56:24 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8359 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030276AbWJRT4X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 15:56:23 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7C00MATKPYH2G0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 18 Oct 2006 15:56:22 -0400 (EDT)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29259>

Supposing that both the base and result sizes were both full size 64-bit 
values, their encoding would occupy only 9.2 bytes each.  Therefore 
inflating 64 bytes is way overkill.  Limit it to 20 bytes instead which 
should be plenty enough for a couple years to come.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/sha1_file.c b/sha1_file.c
index 25c0bf9..e89d24c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -943,7 +943,7 @@ static int packed_delta_info(struct pack
 
 	if (sizep) {
 		const unsigned char *data;
-		unsigned char delta_head[64];
+		unsigned char delta_head[20];
 		unsigned long result_size;
 		z_stream stream;
 		int st;
