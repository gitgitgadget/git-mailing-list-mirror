From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] print warning/error/fatal messages in one shot
Date: Fri, 09 Nov 2007 14:33:54 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711091430330.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 20:34:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqZcI-00070m-HL
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 20:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbXKITdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 14:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751986AbXKITdz
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 14:33:55 -0500
Received: from relais.videotron.ca ([24.201.245.36]:31546 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbXKITdz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 14:33:55 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JR900BW57OIXXC0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 09 Nov 2007 14:33:54 -0500 (EST)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64253>

Not doing so is likely to create a messed up display when sent over the 
sideband protocol.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/usage.c b/usage.c
index f5e652c..a5fc4ec 100644
--- a/usage.c
+++ b/usage.c
@@ -7,9 +7,9 @@
 
 static void report(const char *prefix, const char *err, va_list params)
 {
-	fputs(prefix, stderr);
-	vfprintf(stderr, err, params);
-	fputs("\n", stderr);
+	char msg[256];
+	vsnprintf(msg, sizeof(msg), err, params);
+	fprintf(stderr, "%s%s\n", prefix, msg);
 }
 
 static NORETURN void usage_builtin(const char *err)
