From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH v2] Use warning function instead of fprintf(stderr, "Warning: ...").
Date: Sun,  3 Jan 2010 11:20:30 -0500
Message-ID: <1262535630-3918-1-git-send-email-tfransosi@gmail.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 03 17:22:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRTE8-0005Kn-Ea
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jan 2010 17:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435Ab0ACQUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2010 11:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934Ab0ACQUm
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jan 2010 11:20:42 -0500
Received: from mail-qy0-f192.google.com ([209.85.221.192]:54702 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776Ab0ACQUm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jan 2010 11:20:42 -0500
Received: by qyk30 with SMTP id 30so6700400qyk.33
        for <git@vger.kernel.org>; Sun, 03 Jan 2010 08:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=K+Poa/S7RqX1tbCCPN5gQVA1VUjnwVxWOX8hJvUuBLU=;
        b=GZgGifHBEZ7ojG/fCyUCFIgeDHyNp2yvN7Az092TY/4jW8ZgnzQ/yrBXe+WV+cYVLv
         WuZcNGHQgoS7JlqDwPZEOsbbT3Rd2iId1238qH1fi0mz71J5Vs/t6JZ2y0R7FjsR4HP3
         2Ff4p8j4F0lniyKcTAWtLkS6iDYnKy30xNfGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Xx4dJGl8eITtw4jL8ElsYhI/2RBS0NcS5CL7IlaaRXWeYsqIHr2/BLC331btMctt0J
         R32ck8KhN7aKcPkWMgtwUIpqL3KR8BHan2A5C6/k4Puea5FJmty3ubLKSA0LBTSUS4Q6
         i3lIcU3jTLLlCQbYNkK5clRhbh7jPNhMil69k=
Received: by 10.224.25.205 with SMTP id a13mr10674490qac.202.1262535639113;
        Sun, 03 Jan 2010 08:20:39 -0800 (PST)
Received: from localhost ([201.53.2.165])
        by mx.google.com with ESMTPS id 23sm15709852qyk.3.2010.01.03.08.20.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Jan 2010 08:20:38 -0800 (PST)
X-Mailer: git-send-email 1.6.6.75.g37bae
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136080>

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
Removed the LF from the end of the strings.

 bisect.c     |    4 ++--
 builtin-mv.c |    4 +---
 http.c       |    2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/bisect.c b/bisect.c
index dc18db8..f1a1f84 100644
--- a/bisect.c
+++ b/bisect.c
@@ -813,11 +813,11 @@ static void handle_skipped_merge_base(const unsigned char *mb)
 	char *bad_hex = sha1_to_hex(current_bad_sha1);
 	char *good_hex = join_sha1_array_hex(&good_revs, ' ');
 
-	fprintf(stderr, "Warning: the merge base between %s and [%s] "
+	warning("the merge base between %s and [%s] "
 		"must be skipped.\n"
 		"So we cannot be sure the first bad commit is "
 		"between %s and %s.\n"
-		"We continue anyway.\n",
+		"We continue anyway.",
 		bad_hex, good_hex, mb_hex, bad_hex);
 	free(good_hex);
 }
diff --git a/builtin-mv.c b/builtin-mv.c
index f633d81..8247186 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -169,9 +169,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				 * check both source and destination
 				 */
 				if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)) {
-					fprintf(stderr, "Warning: %s;"
-							" will overwrite!\n",
-							bad);
+					warning("%s; will overwrite!", bad);
 					bad = NULL;
 				} else
 					bad = "Cannot overwrite";
diff --git a/http.c b/http.c
index ed6414a..455732f 100644
--- a/http.c
+++ b/http.c
@@ -1244,7 +1244,7 @@ int finish_http_object_request(struct http_object_request *freq)
 	process_http_object_request(freq);
 
 	if (freq->http_code == 416) {
-		fprintf(stderr, "Warning: requested range invalid; we may already have all the data.\n");
+		warning("requested range invalid; we may already have all the data.");
 	} else if (freq->curl_result != CURLE_OK) {
 		if (stat(freq->tmpfile, &st) == 0)
 			if (st.st_size == 0)
-- 
1.6.6.75.g37bae
