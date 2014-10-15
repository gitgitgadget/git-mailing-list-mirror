From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 03/11] resolve_ref_unsafe(): reverse the logic of the symref conditional
Date: Wed, 15 Oct 2014 17:06:15 +0200
Message-ID: <1413385583-4872-4-git-send-email-mhagger@alum.mit.edu>
References: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 17:06:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeQ9z-0002I7-T6
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 17:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbaJOPGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 11:06:40 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:52145 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751512AbaJOPGi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2014 11:06:38 -0400
X-AuditID: 12074413-f79bb6d000001e81-62-543e8d7b71d6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 62.DF.07809.B7D8E345; Wed, 15 Oct 2014 11:06:35 -0400 (EDT)
Received: from michael.fritz.box (p4FC96250.dip0.t-ipconnect.de [79.201.98.80])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s9FF6SNV020034
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 15 Oct 2014 11:06:34 -0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqFvdaxdi0DxBz6LrSjeTRUPvFWaL
	2yvmM1t0T3nLaPFvQo3FmTeNjA5sHn/ff2Dy2DnrLrvHgk2lHhcvKXssfuDl8XmTXABbFLdN
	UmJJWXBmep6+XQJ3xulZ+9gKLvNVnFqX28D4iauLkZNDQsBE4tia1awQtpjEhXvr2boYuTiE
	BC4zSqxcuocJwjnOJDHh5UN2kCo2AV2JRT3NYAkRgQZGiUOvFoK1MAssYpRoX3WFGaRKWCBa
	4tGy+UwgNouAqsTG00sYQWxeAWeJ6b8+MEHsk5PYO3k1C4jNKeAi8evlNrAaIaCaBUsns0xg
	5F3AyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdcLzezRC81pXQTIyTIhHcw7jopd4hRgINR
	iYd3w17bECHWxLLiytxDjJIcTEqivEk9diFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHjnJwDl
	eFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvPYgQwWLUtNTK9Iyc0oQ
	0kwcnCDDuaREilPzUlKLEktLMuJB0RFfDIwPkBQP0F5PkHbe4oLEXKAoROspRkUpcd533UAJ
	AZBERmke3FhY6njFKA70pTBvGEg7DzDtwHW/AhrMBDR4YqgtyOCSRISUVAPjzlNZ8ieZ3x24
	GB+W0Rk2X7F3s+1DowSrCgMXd+EXS/9a8rgfWXbu4Xr/JA6dzYLs1Vx7RSTe5ov3H4vc2rjz
	ytWJaX0equ+PXuyR0NnvnSA6vY497nUzy3y/NskX+dfjlmbciJ4n7XiQWStmjdu7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is clearer if the check whether a loose reference file is a symref
is followed immediately by the code to handle the symref, rather than
the current code, which has the if statement the other way around.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index ceba23c..771941b 100644
--- a/refs.c
+++ b/refs.c
@@ -1497,35 +1497,35 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 			len--;
 		buffer[len] = '\0';
 
-		/*
-		 * Is it a symbolic ref?
-		 */
-		if (!starts_with(buffer, "ref:")) {
-			/*
-			 * Please note that FETCH_HEAD has a second
-			 * line containing other data.
-			 */
-			if (get_sha1_hex(buffer, sha1) ||
-			    (buffer[40] != '\0' && !isspace(buffer[40]))) {
+		if (starts_with(buffer, "ref:")) {
+			/* It is a symbolic ref */
+			if (flag)
+				*flag |= REF_ISSYMREF;
+			buf = buffer + 4;
+			while (isspace(*buf))
+				buf++;
+			if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
 				if (flag)
 					*flag |= REF_ISBROKEN;
 				errno = EINVAL;
 				return NULL;
 			}
-			return refname;
+			refname = strcpy(refname_buffer, buf);
+			continue;
 		}
-		if (flag)
-			*flag |= REF_ISSYMREF;
-		buf = buffer + 4;
-		while (isspace(*buf))
-			buf++;
-		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
+
+		/*
+		 * It must be a normal ref. Please note that
+		 * FETCH_HEAD has a second line containing other data.
+		 */
+		if (get_sha1_hex(buffer, sha1) ||
+		    (buffer[40] != '\0' && !isspace(buffer[40]))) {
 			if (flag)
 				*flag |= REF_ISBROKEN;
 			errno = EINVAL;
 			return NULL;
 		}
-		refname = strcpy(refname_buffer, buf);
+		return refname;
 	}
 }
 
-- 
2.1.1
