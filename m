From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 15/20] try_remove_empty_parents(): don't accommodate consecutive slashes
Date: Tue, 16 Feb 2016 14:22:28 +0100
Message-ID: <bed4fca10afe9414c9c8faddd3a9f212abf6369f.1455626201.git.mhagger@alum.mit.edu>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 14:32:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfji-0004PL-1z
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbcBPNcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 08:32:05 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:45677 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932350AbcBPNa3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 08:30:29 -0500
X-AuditID: 12074413-f03ff7000000516b-82-56c322bfd5aa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id C3.2E.20843.FB223C65; Tue, 16 Feb 2016 08:23:11 -0500 (EST)
Received: from michael.fritz.box (p548D6919.dip0.t-ipconnect.de [84.141.105.25])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1GDMfOb028717
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Feb 2016 08:23:09 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1455626201.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSbUgTcRjA/d/dtpvbxXXTPFdMOkmhmC8QeFGZHyLukxbpKL+s051utN3G
	3SazPjRxJawNCv0UpCOKmTg/DMxSYTF7mWWUohAaiYE6VuBSP9iL0Z1D/fbw/J7n+fH8/w8K
	ExlEj9p4NyfwrJ1S5iKE6vxRY5yaMFX0JtV0XywJ6MDsXYj2hWZhOhNNKOlQd0hBL/T3wfSW
	PwjXqJjttQzELI/0wEzqo5dZCY0DZnqmmAmvLqqYjZjhoqpRc6aJdbddtrXy5dXXNNY3L38p
	XR0q78D3OcgHoooAUKMkfpIcnhoHAZCLEvgwIAfffoZlQOBJiIzHSuVYiRvJR8FOSI7z8BLy
	/p0EIjfA+DdABuIjQAY6/Ao5GBhTyjGCHyNfjM3vGDC8kYyszIOszUD6t8Z28mqcJif9ISQr
	qyK/bI5D94A2DHIGgIG1exxGB2uzi1yzUWxmeZ4TjFVlDpu7jLN4YiD7YrrnYHTSkAA4Cigt
	hjIJE6Fg28R2RwIUohCVj2k1EybiQJPT0m5lRatZ8Ng5MQFIFKbysH9pqRyzsO03OMG5iw6j
	CFWAlTwurSXwVtbNXec4Fyfs0iMoSpHY+lFp6EGBa+W8LTa7ex9DqFoenqvPEznewgmsx201
	yz9gFqUvkJFW8rbI7ZjoYh1SNtv6DhjR8NZCFCIQ3slz+gIsLhfhcpHVw+8pdg8lDQqkjXVY
	vnQvhFY6o71JaUkCSRL7jLyc6Gb3kd4HXE9/XPJrNt6D9e21OawhM9WlS9Xg8+WZPzWBSCp5
	wV/X63fUnSCv9vgKi7/efrWoGHr2IRIr5kxdozmbHUW1wddL5yr7jV54Gf4b/I2k 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286398>

"refname" has already been checked by check_refname_format(), so it
cannot have consecutive slashes.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 897ff4c..0a9f330 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2212,15 +2212,14 @@ static void try_remove_empty_parents(const char *refname)
 	for (i = 0; i < 2; i++) { /* refs/{heads,tags,...}/ */
 		while (*p && *p != '/')
 			p++;
-		/* tolerate duplicate slashes; see check_refname_format() */
-		while (*p == '/')
+		if (*p == '/')
 			p++;
 	}
 	q = buf.buf + buf.len;
 	while (1) {
 		while (q > p && *q != '/')
 			q--;
-		while (q > p && *(q-1) == '/')
+		if (q > p && *(q-1) == '/')
 			q--;
 		if (q == p)
 			break;
-- 
2.7.0
