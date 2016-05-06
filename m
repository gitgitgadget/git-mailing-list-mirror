From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 21/33] delete_branches(): use resolve_refdup()
Date: Fri,  6 May 2016 18:14:02 +0200
Message-ID: <8a4c0c705a4694e54399580eb1abe8a61c556d7d.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:15:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiPy-0000Vy-3V
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758691AbcEFQPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:15:49 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:56566 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758693AbcEFQO7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:14:59 -0400
X-AuditID: 12074412-52fff700000009f7-21-572cc3020c58
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 68.62.02551.203CC275; Fri,  6 May 2016 12:14:58 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHV3031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:14:57 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqMt0WCfcYNNXLYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxq7cDu8ff9ByaPnbPusns8693D6HHxkrLH/qXb2DwW
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8a6Pc9ZC44IVLTP4WxgPMTTxcjJISFgIjF75R7W
	LkYuDiGBrYwSZ1fdZ4ZwjjNJfHl5lhWkik1AV2JRTzMTiC0iECHR8KqFsYuRg4NZ4DOjxEpu
	kLCwgKPEsZOv2UBsFgFViasrTzGBlPAKREm0dWtD7JKTuDz9AVgJp4CFxKHe42AThQTMJTrW
	3mCfwMizgJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGumV5uZoleakrpJkZIcAntYFx/Uu4Q
	owAHoxIPb8ZJ7XAh1sSy4srcQ4ySHExKorzfC3TChfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nw
	XtkHlONNSaysSi3Kh0lJc7AoifP+XKzuJySQnliSmp2aWpBaBJOV4eBQkuBtPgTUKFiUmp5a
	kZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ8K/vhiYPiDpHiA9vKBtPMWFyTmAkUhWk8x6nIc
	2X9vLZMQS15+XqqUOO/cg0BFAiBFGaV5cCtgqeQVozjQx8K8l0GqeIBpCG7SK6AlTEBL3s/V
	BFlSkoiQkmpgnN0rmfvn9sLbUc+E2x44hsoFKP0/uEBdf82x7CzHty6O5ZN2xXts8b8vyjFD
	hSfYpLGi/0X+MbuZ3X8DppyOW1NqJ5l68cmJkvnO2Wxfd2wS4/n8Zt00/W//dvJv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293820>

The return value of resolve_ref_unsafe() is not guaranteed to stay
around as long as we need it, so use resolve_refdup() instead.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/branch.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0adba62..ae55688 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -212,7 +212,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			die(_("Couldn't look up commit object for HEAD"));
 	}
 	for (i = 0; i < argc; i++, strbuf_release(&bname)) {
-		const char *target;
+		char *target = NULL;
 		int flags = 0;
 
 		strbuf_branchname(&bname, argv[i]);
@@ -231,11 +231,11 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			}
 		}
 
-		target = resolve_ref_unsafe(name,
-					    RESOLVE_REF_READING
-					    | RESOLVE_REF_NO_RECURSE
-					    | RESOLVE_REF_ALLOW_BAD_NAME,
-					    sha1, &flags);
+		target = resolve_refdup(name,
+					RESOLVE_REF_READING
+					| RESOLVE_REF_NO_RECURSE
+					| RESOLVE_REF_ALLOW_BAD_NAME,
+					sha1, &flags);
 		if (!target) {
 			error(remote_branch
 			      ? _("remote-tracking branch '%s' not found.")
@@ -248,7 +248,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		    check_branch_commit(bname.buf, name, sha1, head_rev, kinds,
 					force)) {
 			ret = 1;
-			continue;
+			goto next;
 		}
 
 		if (delete_ref(name, is_null_sha1(sha1) ? NULL : sha1,
@@ -258,7 +258,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			      : _("Error deleting branch '%s'"),
 			      bname.buf);
 			ret = 1;
-			continue;
+			goto next;
 		}
 		if (!quiet) {
 			printf(remote_branch
@@ -270,6 +270,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			       : find_unique_abbrev(sha1, DEFAULT_ABBREV));
 		}
 		delete_branch_config(bname.buf);
+
+	next:
+		free(target);
 	}
 
 	free(name);
-- 
2.8.1
