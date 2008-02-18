From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 01/12] read_object_with_reference: don't read beyond the buffer
Date: Mon, 18 Feb 2008 21:47:52 +0100
Message-ID: <12033676833730-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:49:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRCvd-0000iE-LL
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 21:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701AbYBRUsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 15:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755764AbYBRUsQ
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 15:48:16 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:40262 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760892AbYBRUsF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 15:48:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id B60AB680CDAA;
	Mon, 18 Feb 2008 21:48:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WnE+MXCYKc9M; Mon, 18 Feb 2008 21:48:03 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 91ED4680BF87; Mon, 18 Feb 2008 21:48:03 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74348>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 sha1_file.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 4179949..d9da7c8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1943,7 +1943,8 @@ void *read_object_with_reference(const unsigned char *sha1,
 		}
 		ref_length = strlen(ref_type);
 
-		if (memcmp(buffer, ref_type, ref_length) ||
+		if (ref_length + 40 > isize ||
+		    memcmp(buffer, ref_type, ref_length) ||
 		    get_sha1_hex((char *) buffer + ref_length, actual_sha1)) {
 			free(buffer);
 			return NULL;
-- 
1.5.4.1.g96b77
