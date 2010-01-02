From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] Use warning function instead of fprintf(stderr, "Warning: ...").
Date: Sat,  2 Jan 2010 15:24:46 -0500
Message-ID: <1262463886-8956-1-git-send-email-tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 02 21:25:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRAXJ-0003SG-2G
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 21:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599Ab0ABUY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 15:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446Ab0ABUY4
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 15:24:56 -0500
Received: from mail-qy0-f192.google.com ([209.85.221.192]:53290 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab0ABUYz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 15:24:55 -0500
Received: by qyk30 with SMTP id 30so6524688qyk.33
        for <git@vger.kernel.org>; Sat, 02 Jan 2010 12:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=y2uVGYiGb6PWTSAxfQRULWU6VQU1iqPhdPh2oEdNYjQ=;
        b=vZoegpNCnNITfPb5K6LSyV6e6KOSt1csrSgbLI7wCmt4Mdj310TTCeitf779I9NLXN
         f/JCVTClsZ0rR4MIsGydFZFCRtBtUJyCnOT8lsf3evKLJllOCRXrGMVXZXq4W6F8We9F
         APyk/KbAZIMAQ/+Tfacse+B2I+gFFK6rDBuhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=KJ2u1dRWnGigh6+PLhOBTEesPISbO4sXVa8NUSVsKqovzCpXx5pthz3NPQ+IDKIQh0
         E13oTAvQUyYXaFOFYzX5enUu+kORnwoxciDh0MA3ascOgZeFT8MVLHkYC1vdDqn3tKhH
         8iQaRyvwU6rzkRVuTKWULTdoZsqcww8emTzSU=
Received: by 10.224.44.40 with SMTP id y40mr7448760qae.197.1262463894718;
        Sat, 02 Jan 2010 12:24:54 -0800 (PST)
Received: from localhost ([201.53.2.165])
        by mx.google.com with ESMTPS id 6sm44924075qwd.16.2010.01.02.12.24.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 Jan 2010 12:24:54 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136044>

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 bisect.c     |    2 +-
 builtin-mv.c |    4 +---
 http.c       |    2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/bisect.c b/bisect.c
index dc18db8..d1f8c42 100644
--- a/bisect.c
+++ b/bisect.c
@@ -813,7 +813,7 @@ static void handle_skipped_merge_base(const unsigned char *mb)
 	char *bad_hex = sha1_to_hex(current_bad_sha1);
 	char *good_hex = join_sha1_array_hex(&good_revs, ' ');
 
-	fprintf(stderr, "Warning: the merge base between %s and [%s] "
+	warning("the merge base between %s and [%s] "
 		"must be skipped.\n"
 		"So we cannot be sure the first bad commit is "
 		"between %s and %s.\n"
diff --git a/builtin-mv.c b/builtin-mv.c
index f633d81..8ad7245 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -169,9 +169,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				 * check both source and destination
 				 */
 				if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)) {
-					fprintf(stderr, "Warning: %s;"
-							" will overwrite!\n",
-							bad);
+					warning("%s; will overwrite!\n", bad);
 					bad = NULL;
 				} else
 					bad = "Cannot overwrite";
diff --git a/http.c b/http.c
index ed6414a..afce7c3 100644
--- a/http.c
+++ b/http.c
@@ -1244,7 +1244,7 @@ int finish_http_object_request(struct http_object_request *freq)
 	process_http_object_request(freq);
 
 	if (freq->http_code == 416) {
-		fprintf(stderr, "Warning: requested range invalid; we may already have all the data.\n");
+		warning("requested range invalid; we may already have all the data.\n");
 	} else if (freq->curl_result != CURLE_OK) {
 		if (stat(freq->tmpfile, &st) == 0)
 			if (st.st_size == 0)
-- 
1.6.6.rc3
