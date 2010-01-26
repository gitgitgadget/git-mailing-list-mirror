From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH 4/4] Fix integer overflow in unpack_compressed_entry()
Date: Tue, 26 Jan 2010 20:24:15 +0200
Message-ID: <1264530255-4682-5-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1264530255-4682-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 19:25:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZq6Y-0005Wt-KS
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 19:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827Ab0AZSYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 13:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754821Ab0AZSYg
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 13:24:36 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:55330 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793Ab0AZSYW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 13:24:22 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 29AB1EBBC0
	for <git@vger.kernel.org>; Tue, 26 Jan 2010 20:24:21 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A01B5528E26; Tue, 26 Jan 2010 20:24:21 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 1A9D1E51B1
	for <git@vger.kernel.org>; Tue, 26 Jan 2010 20:24:20 +0200 (EET)
X-Mailer: git-send-email 1.6.6.1.439.gf06b6
In-Reply-To: <1264530255-4682-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138067>


Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 sha1_file.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 39f0844..ea2ea75 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1517,8 +1517,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
 	z_stream stream;
 	unsigned char *buffer, *in;
 
-	buffer = xmalloc(size + 1);
-	buffer[size] = 0;
+	buffer = xmallocz(size);
 	memset(&stream, 0, sizeof(stream));
 	stream.next_out = buffer;
 	stream.avail_out = size + 1;
-- 
1.6.6.1.439.gf06b6
