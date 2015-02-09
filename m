From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 8/8] reflog_expire(): lock symbolic refs themselves, not their referent
Date: Mon,  9 Feb 2015 10:12:44 +0100
Message-ID: <1423473164-6011-9-git-send-email-mhagger@alum.mit.edu>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 10:20:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKkWH-0002IX-44
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 10:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932928AbbBIJU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 04:20:28 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:60317 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932621AbbBIJU0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Feb 2015 04:20:26 -0500
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Feb 2015 04:20:26 EST
X-AuditID: 1207440e-f79bc6d000000c43-14-54d87a1fec42
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 95.4E.03139.F1A78D45; Mon,  9 Feb 2015 04:13:03 -0500 (EST)
Received: from michael.fritz.box (p4FC971C1.dip0.t-ipconnect.de [79.201.113.193])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t199CnQe026231
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 9 Feb 2015 04:13:02 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqCtfdSPE4O9CDYuuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLXr7PrFabN7czuLA7vH3/Qcmj52z7rJ7LNhU6nHxkrLH501yAaxR
	3DZJiSVlwZnpefp2CdwZ96enFixgq1jbfpyxgbGVtYuRg0NCwETiylfPLkZOIFNM4sK99Wxd
	jFwcQgKXGSV2vn/CAuGcYJJ48noPO0gVm4CuxKKeZiYQW0RATWJi2yEWEJtZYDWTxNa7bCC2
	sEC4xJyjExlBbBYBVYlD524xg9i8As4SJ/evZYTYJidx/vhPsDingIvEu3NzwHqFgGpmT97H
	PIGRdwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXWO93MwSvdSU0k2MkBDj28HYvl7mEKMA
	B6MSD2/Fx+shQqyJZcWVuYcYJTmYlER5FyTeCBHiS8pPqcxILM6ILyrNSS0+xCjBwawkwvs9
	AyjHm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLgnVMB1ChYlJqeWpGW
	mVOCkGbi4AQZziUlUpyal5JalFhakhEPiov4YmBkgKR4gPbuAGnnLS5IzAWKQrSeYtTlWNC+
	fyaTEEtefl6qlDhvP0iRAEhRRmke3ApYQnnFKA70sTBvH0gVDzAZwU16BbSECWhJQQHYkpJE
	hJRUA2Op845V57RC58w9Ny1XxV3Iq9BV7FaY2cqt9qcPvf14wK2gwV3s6Ow+c83GV0Ub/snu
	zJQ/4DDZzaX1tMAtQ2/do6ZaPyZuzAspXsPHaXvfyUz/Y8Iljvht/7xcbWexCp1d 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263555>

When processing the reflog of a symbolic ref, hold the lock on the
symbolic reference itself, not on the reference that it points to.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 1b2a497..3fcf342 100644
--- a/refs.c
+++ b/refs.c
@@ -4037,7 +4037,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_sha1_basic(refname, sha1, NULL, 0, &type);
+	lock = lock_ref_sha1_basic(refname, sha1, NULL, REF_NODEREF, &type);
 	if (!lock)
 		return error("cannot lock ref '%s'", refname);
 	if (!reflog_exists(refname)) {
-- 
2.1.4
