From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] Fix off-by-one error: don't read the byte before a malloc'd buffer.
Date: Sat, 08 Dec 2007 16:48:05 +0100
Message-ID: <87hcitgpca.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 16:48:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J11vA-0004cS-Vr
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 16:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbXLHPsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 10:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbXLHPsI
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 10:48:08 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:47387 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790AbXLHPsH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 10:48:07 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 14EF717B53F
	for <git@vger.kernel.org>; Sat,  8 Dec 2007 16:48:06 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 0306017B528
	for <git@vger.kernel.org>; Sat,  8 Dec 2007 16:48:06 +0100 (CET)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 95A0F35BD0; Sat,  8 Dec 2007 16:48:05 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67557>


* config.c (store_write_pair): Don't read value[-1].

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 config.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/config.c b/config.c
index ed96213..6031b38 100644
--- a/config.c
+++ b/config.c
@@ -652,7 +652,7 @@ static int store_write_pair(int fd, const char* key, const char* value)
 	for (i = 0; value[i]; i++)
 		if (value[i] == ';' || value[i] == '#')
 			quote = 1;
-	if (value[i-1] == ' ')
+	if (i && value[i-1] == ' ')
 		quote = 1;

 	if (write_in_full(fd, "\t", 1) != 1 ||
--
1.5.3.7.1116.gae2a9
