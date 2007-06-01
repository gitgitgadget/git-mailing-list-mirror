From: =?utf-8?q?Kristian_H=C3=B8gsberg?= <hoegsberg@gmail.com>
Subject: [PATCH] Use =20 when rfc2047 encoding spaces.
Date: Fri,  1 Jun 2007 17:08:12 -0400
Message-ID: <11807320922292-git-send-email-hoegsberg@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian_H=C3=B8gsberg?= <hoegsberg@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 01 23:08:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuEMD-00025K-8t
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 23:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764245AbXFAVIU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 17:08:20 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762327AbXFAVIU
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 17:08:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38203 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764269AbXFAVIU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 17:08:20 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l51L8ImT013092;
	Fri, 1 Jun 2007 17:08:18 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l51L8HX5016664;
	Fri, 1 Jun 2007 17:08:17 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l51L8HTr004764;
	Fri, 1 Jun 2007 17:08:17 -0400
X-Mailer: git-send-email 1.5.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48887>

Encode ' ' using '=3D20' even though rfc2047 allows using '_' for
readability.  Unfortunately, much software doesn't understand this and =
just
leaves the underscore in place.  Using '=3D20' seems to work better.

Signed-off-by: Kristian H=C3=B8gsberg <hoegsberg@gmail.com>
---
 commit.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index bee066f..92b46f1 100644
--- a/commit.c
+++ b/commit.c
@@ -511,12 +511,14 @@ static int add_rfc2047(char *buf, const char *lin=
e, int len,
 	bp +=3D i;
 	for (i =3D 0; i < len; i++) {
 		unsigned ch =3D line[i] & 0xFF;
-		if (is_rfc2047_special(ch)) {
+		/* We encode ' ' using '=3D20' even though rfc2047
+		 * allows using '_' for readability.  Unfortunately,
+		 * doesn't understand this and just leaves the
+		 * underscore in place. */
+		if (is_rfc2047_special(ch) || ch =3D=3D ' ') {
 			sprintf(bp, "=3D%02X", ch);
 			bp +=3D 3;
 		}
-		else if (ch =3D=3D ' ')
-			*bp++ =3D '_';
 		else
 			*bp++ =3D ch;
 	}
--=20
1.5.0.6
