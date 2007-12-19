From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] make 'git describe --all --contains' work
Date: Wed, 19 Dec 2007 12:53:16 -0500 (EST)
Message-ID: <alpine.LFD.0.999999.0712191250300.3373@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 18:53:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J536z-0007Pn-L7
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 18:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbXLSRxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 12:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbXLSRxS
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 12:53:18 -0500
Received: from relais.videotron.ca ([24.201.245.36]:38525 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbXLSRxR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 12:53:17 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JTB00DLS5OSPFG0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 19 Dec 2007 12:53:16 -0500 (EST)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 0.999999 (LFD 847 2007-12-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68925>

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/builtin-describe.c b/builtin-describe.c
index 6eeb9b5..7a148a2 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -267,12 +267,14 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 
 	if (contains) {
 		const char **args = xmalloc((4 + argc) * sizeof(char*));
-		args[0] = "name-rev";
-		args[1] = "--name-only";
-		args[2] = "--tags";
-		memcpy(args + 3, argv, argc * sizeof(char*));
-		args[3 + argc] = NULL;
-		return cmd_name_rev(3 + argc, args, prefix);
+		int i = 0;
+		args[i++] = "name-rev";
+		args[i++] = "--name-only";
+		if (!all)
+			args[i++] = "--tags";
+		memcpy(args + i, argv, argc * sizeof(char*));
+		args[i + argc] = NULL;
+		return cmd_name_rev(i + argc, args, prefix);
 	}
 
 	if (argc == 0) {
