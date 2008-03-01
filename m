From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 1/2] index-pack: allocate NUL byte at the buffer end
Date: Sat,  1 Mar 2008 22:21:21 +0100
Message-ID: <12044064822655-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 22:22:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVZA3-0001nU-NI
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 22:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759038AbYCAVVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 16:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758972AbYCAVVZ
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 16:21:25 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:33847 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757598AbYCAVVY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 16:21:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 233CF6CF006A;
	Sat,  1 Mar 2008 22:21:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Geyw5mYALZs; Sat,  1 Mar 2008 22:21:23 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 04F77680C1C6; Sat,  1 Mar 2008 22:21:22 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75701>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
Other parts of git add a NUL to buffers as safty measure, so why not index-pack/
unpack-objects too?

 index-pack.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index 4bb333f..ff8e93d 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -213,7 +213,8 @@ static void bad_object(unsigned long offset, const char *format, ...)
 static void *unpack_entry_data(unsigned long offset, unsigned long size)
 {
 	z_stream stream;
-	void *buf = xmalloc(size);
+	char *buf = xmalloc(size + 1);
+	buf[size] = 0;
 
 	memset(&stream, 0, sizeof(stream));
 	stream.next_out = buf;
-- 
1.5.4.2.g4b5fd.dirty

