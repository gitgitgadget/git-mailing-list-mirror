From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH 3/4] Fix integer overflow in unpack_sha1_rest()
Date: Tue, 26 Jan 2010 20:24:14 +0200
Message-ID: <1264530255-4682-4-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1264530255-4682-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 19:25:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZq6X-0005Wt-H8
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 19:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799Ab0AZSYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 13:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754791Ab0AZSYX
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 13:24:23 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:54746 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786Ab0AZSYV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 13:24:21 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 014D913B2F8
	for <git@vger.kernel.org>; Tue, 26 Jan 2010 20:24:20 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A01FBDACB4A; Tue, 26 Jan 2010 20:24:19 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id E84621C63A7
	for <git@vger.kernel.org>; Tue, 26 Jan 2010 20:24:18 +0200 (EET)
X-Mailer: git-send-email 1.6.6.1.439.gf06b6
In-Reply-To: <1264530255-4682-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138063>


Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 sha1_file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 12478a3..39f0844 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1166,7 +1166,7 @@ static int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned lon
 static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size, const unsigned char *sha1)
 {
 	int bytes = strlen(buffer) + 1;
-	unsigned char *buf = xmalloc(1+size);
+	unsigned char *buf = xmallocz(size);
 	unsigned long n;
 	int status = Z_OK;
 
-- 
1.6.6.1.439.gf06b6
