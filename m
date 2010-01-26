From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH 2/4] Fix integer overflow in patch_delta()
Date: Tue, 26 Jan 2010 20:24:13 +0200
Message-ID: <1264530255-4682-3-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1264530255-4682-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 19:25:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZq6W-0005Wt-VV
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 19:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802Ab0AZSYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 13:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754791Ab0AZSYV
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 13:24:21 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:55324 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187Ab0AZSYU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 13:24:20 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id CE107EBBC0
	for <git@vger.kernel.org>; Tue, 26 Jan 2010 20:24:18 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A01FAB8532C; Tue, 26 Jan 2010 20:24:18 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id BF2744079
	for <git@vger.kernel.org>; Tue, 26 Jan 2010 20:24:17 +0200 (EET)
X-Mailer: git-send-email 1.6.6.1.439.gf06b6
In-Reply-To: <1264530255-4682-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138064>


Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 patch-delta.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/patch-delta.c b/patch-delta.c
index e02e13b..d218faa 100644
--- a/patch-delta.c
+++ b/patch-delta.c
@@ -33,8 +33,7 @@ void *patch_delta(const void *src_buf, unsigned long src_size,
 
 	/* now the result size */
 	size = get_delta_hdr_size(&data, top);
-	dst_buf = xmalloc(size + 1);
-	dst_buf[size] = 0;
+	dst_buf = xmallocz(size);
 
 	out = dst_buf;
 	while (data < top) {
-- 
1.6.6.1.439.gf06b6
