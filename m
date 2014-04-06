From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 13/25] write_packed_entry_fn(): convert cb_data into a (const int *)
Date: Mon,  7 Apr 2014 01:33:55 +0200
Message-ID: <1396827247-28465-14-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:36:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwc1-00074B-Qu
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598AbaDFXfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:35:54 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:61999 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754642AbaDFXfH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:35:07 -0400
X-AuditID: 12074412-f79d46d000002e58-a9-5341e4aaa208
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 56.8D.11864.AA4E1435; Sun,  6 Apr 2014 19:35:06 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbX0011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:35:05 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqLvqiWOwwa6r1hZdV7qZLBp6rzBb
	3F4xn9ni1+En7BY/WnqYLc68aWS06Oz4yujA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx+IHXh6f
	N8l53H62jSWAPYrbJimxpCw4Mz1P3y6BO+PWT5+Ca6wVXbMmsTUwnmTpYuTkkBAwkdj0aB4r
	hC0mceHeerYuRi4OIYHLjBI/bk5khHCOM0ksOTKHGaSKTUBXYlFPMxOILSKgJjGx7RALSBGz
	wA1GiXf7DoONFRYIl/gw9xwbiM0ioCqxvPUk2ApeAVeJc22LodbJSZw8NhnM5gSKr5s8F6xX
	SMAFaM49tgmMvAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrp5WaW6KWmlG5ihISe0A7G
	9SflDjEKcDAq8fCuOOQYLMSaWFZcmXuIUZKDSUmU1/IeUIgvKT+lMiOxOCO+qDQntfgQowQH
	s5II74EbQDnelMTKqtSifJiUNAeLkjjvz8XqfkIC6YklqdmpqQWpRTBZGQ4OJQnevsdAjYJF
	qempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGg2IgvBkYHSIoHaG8ESDtvcUFiLlAUovUU
	o6KUOO/MR0AJAZBERmke3FhYQnnFKA70pTCvAUg7DzAZwXW/AhrMBDS4IcwOZHBJIkJKqoGR
	u1vxhcfxxytl9e5wtvSeNv92usXkuIRmfv6if7mVSoH9ZjnRXx7t1LrU8ld5xwKFCXF3Zmfc
	XT71xdSiVdeLprR3Ttx2ILfLQuvGDPm739/vNQ7wyWd/bbnc5p3S1GW6lcbfeypV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245824>

This makes it obvious that we have no plans to change the integer
pointed to, which is actually the fd field from a struct lock_file.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 64ea2f0..cd471ab 100644
--- a/refs.c
+++ b/refs.c
@@ -2176,7 +2176,7 @@ static void write_packed_entry(int fd, char *refname, unsigned char *sha1,
  */
 static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 {
-	int *fd = cb_data;
+	const int *fd = cb_data;
 	enum peel_status peel_status = peel_entry(entry, 0);
 
 	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
-- 
1.9.1
