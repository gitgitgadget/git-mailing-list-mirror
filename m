From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] write_sha1_from_fd() should make new objects read-only
Date: Sat, 24 Mar 2007 12:02:27 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703241159360.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 24 17:02:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HV8hM-0002VP-Sm
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 17:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982AbXCXQC3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 12:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753156AbXCXQC3
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 12:02:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:62481 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbXCXQC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 12:02:28 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFF005IJ0K3MT70@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 24 Mar 2007 12:02:27 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43008>

... like it is done everywhere else.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/sha1_file.c b/sha1_file.c
index 940bab5..0897b94 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2154,6 +2154,7 @@ int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
 	} while (1);
 	inflateEnd(&stream);
 
+	fchmod(local, 0444);
 	close(local);
 	SHA1_Final(real_sha1, &c);
 	if (ret != Z_STREAM_END) {
