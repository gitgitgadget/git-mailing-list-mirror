From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/4] get_remote_group(): eliminate superfluous call to strcspn()
Date: Tue, 28 Jul 2015 23:08:20 +0200
Message-ID: <441622b3d894ab73de159d55176f485d7c56b147.1438117334.git.mhagger@alum.mit.edu>
References: <cover.1438117334.git.mhagger@alum.mit.edu>
Cc: =?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 23:08:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKC7G-000342-EC
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 23:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373AbbG1VIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 17:08:45 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:48461 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753204AbbG1VIo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2015 17:08:44 -0400
X-AuditID: 1207440e-f79516d0000012b3-b6-55b7ef4f3d01
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 49.BD.04787.F4FE7B55; Tue, 28 Jul 2015 17:08:31 -0400 (EDT)
Received: from michael.fritz.box (p4FC97CAD.dip0.t-ipconnect.de [79.201.124.173])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6SL8PUD021490
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 28 Jul 2015 17:08:30 -0400
X-Mailer: git-send-email 2.4.6
In-Reply-To: <cover.1438117334.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqOv/fnuoQfMUXYv5xxYzW3Rd6Way
	aOi9wmxxe8V8ZgcWj7/vPzB57Jx1l93j4iVlj8+b5AJYorhtkhJLyoIz0/P07RK4M9Z83cpU
	0MFe8erWStYGxv2sXYycHBICJhItu9tYIGwxiQv31rN1MXJxCAlcZpRY+mEqI4Rzkkni96z7
	zCBVbAK6Eot6mplAbBEBNYmJbYdYQIqYBdoYJS6s2QVWJCwQIPHw2HywsSwCqhKLbnYA2Rwc
	vAJREj0PrCC2yUlcO7sV7ApOAQuJy99bwEqEBMwlvu31msDIu4CRYRWjXGJOaa5ubmJmTnFq
	sm5xcmJeXmqRrrFebmaJXmpK6SZGSPjw7WBsXy9ziFGAg1GJh3fCum2hQqyJZcWVuYcYJTmY
	lER5Z9zbHirEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhLfhIVCONyWxsiq1KB8mJc3BoiTOq7ZE
	3U9IID2xJDU7NbUgtQgmK8PBoSTBO+EtUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJp
	SUY8KDLii4GxAZLiAdpbB9LOW1yQmAsUhWg9xajLseDH7bVMQix5+XmpUuK870CKBECKMkrz
	4FbAksUrRnGgj4V5094BVfEAEw3cpFdAS5iAlnj2bAFZUpKIkJJqYEx9ER429SdHStFXt9WT
	7C2/Lpd9+d196vXJS22+yX/KjFRw//OZUetL/nQJyR2FfSeZ5k4sagrRes20qLy/UFY2aunf
	Xpmz+4ufBLqEF0VtF5vXNflm0E3ngglev+MLr+vofMzyC07NbzNrzvk+f17qu73b 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274849>

There is no need to call it if value is the empty string. This also
eliminates code duplication.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index d0d267b..bd945d0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -978,13 +978,13 @@ static int get_remote_group(const char *key, const char *value, void *priv)
 	if (starts_with(key, "remotes.") &&
 			!strcmp(key + 8, g->name)) {
 		/* split list by white space */
-		size_t wordlen = strcspn(value, " \t\n");
 		while (*value) {
+			size_t wordlen = strcspn(value, " \t\n");
+
 			if (wordlen >= 1)
 				string_list_append(g->list,
 						   xstrndup(value, wordlen));
 			value += wordlen + (value[wordlen] != '\0');
-			wordlen = strcspn(value, " \t\n");
 		}
 	}
 
-- 
2.4.6
