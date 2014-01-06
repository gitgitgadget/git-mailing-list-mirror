From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 01/17] safe_create_leading_directories(): fix format of "if" chaining
Date: Mon,  6 Jan 2014 14:45:19 +0100
Message-ID: <1389015935-21936-2-git-send-email-mhagger@alum.mit.edu>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 14:46:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0AVc-0005p1-AS
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 14:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851AbaAFNqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 08:46:16 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:50962 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751482AbaAFNqN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 08:46:13 -0500
X-AuditID: 1207440e-b7fbc6d000004ad9-f4-52cab3a4917c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 4C.39.19161.4A3BAC25; Mon,  6 Jan 2014 08:46:12 -0500 (EST)
Received: from michael.fritz.box (p57A25457.dip0.t-ipconnect.de [87.162.84.87])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s06DjfP2021935
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 6 Jan 2014 08:46:11 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqLtk86kggwW7zSy6rnQzWTT0XmG2
	eHtzCaPF7RXzmS12T1vA5sDq8ff9ByaPnbPusntcvKTs8XjiCVaPz5vkAlijuG2SEkvKgjPT
	8/TtErgzNp+dylawla1iX8cclgbGZyxdjBwcEgImEq9OqHcxcgKZYhIX7q1n62Lk4hASuMwo
	8atrC5RzjEni3+Y7bCBVbAK6Eot6mplAbBEBNYmJbYdYQIqYBRYzSnRN+8YIkhAWiJCYcLGP
	FcRmEVCVaN91gx3E5hVwkTjfuYkRYrOCxOrrQiBhTgFXiWnTDoPNFwIqWXPoEcsERt4FjAyr
	GOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9XIzS/RSU0o3MUJCim8HY/t6mUOMAhyMSjy8Hx6f
	DBJiTSwrrsw9xCjJwaQkysu5+lSQEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRFergVAOd6UxMqq
	1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBG/OJqBGwaLU9NSKtMycEoQ0Ewcn
	iOAC2cADtCEOpJC3uCAxtzgzHaLoFKOilDjvFJCEAEgiozQPbgAs+l8xigP9I8xrA1LFA0wc
	cN2vgAYzAQ0OjQMbXJKIkJJqYEwNuf/j25QZXVtiz0/d3b1l8dvzU4qiez3ll6r+vviloOhQ
	Ptue60pTl/jvn7TnYEfDnsnR/WIXFswsTHRlaN943kf5w8W6h/4Gc9MkFqpb/LE81JdeUpSz
	tX7Gye8KTkqHIguP6glYps9O/6V9O3dxS+EpNj7PY0yykxq/7pblD807sTFhxnol 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239995>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 sha1_file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index daacc0c..c9245a6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -125,8 +125,7 @@ int safe_create_leading_directories(char *path)
 				*pos = '/';
 				return -3;
 			}
-		}
-		else if (mkdir(path, 0777)) {
+		} else if (mkdir(path, 0777)) {
 			if (errno == EEXIST &&
 			    !stat(path, &st) && S_ISDIR(st.st_mode)) {
 				; /* somebody created it since we checked */
@@ -134,8 +133,7 @@ int safe_create_leading_directories(char *path)
 				*pos = '/';
 				return -1;
 			}
-		}
-		else if (adjust_shared_perm(path)) {
+		} else if (adjust_shared_perm(path)) {
 			*pos = '/';
 			return -2;
 		}
-- 
1.8.5.2
