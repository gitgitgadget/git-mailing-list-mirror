From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 17/29] delete_branches(): use resolve_refdup()
Date: Wed, 27 Apr 2016 18:57:34 +0200
Message-ID: <6fd1a07674b903e005a25184d2fef44dcc3f1d2f.1461768690.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:59:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSoI-00047Q-Qc
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596AbcD0Q7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:59:32 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:53611 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753487AbcD0Q6c (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:32 -0400
X-AuditID: 12074414-62bff700000008e6-44-5720efb705aa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 81.72.02278.7BFE0275; Wed, 27 Apr 2016 12:58:31 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6U022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:30 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqLv9vUK4wZ55VhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7ox1e56zFhwRqGifw9nAeIini5GTQ0LARKJnYR9r
	FyMXh5DAVkaJW5uXsUE4x5kkdtzcyAhSxSagK7Gop5kJxBYRcJBYvvIXO0gRs0ATk8T35U0s
	IAlhATuJRZNvgtksAqoSez8+YgaxeQWiJGY+uswCsU5O4vL0B2wgNqeAhcSX1rdgC4QEzCWW
	PFjNPoGRZwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXQu93MwSvdSU0k2MkBAT2cF45KTc
	IUYBDkYlHt4TUgrhQqyJZcWVuYcYJTmYlER5l5wFCvEl5adUZiQWZ8QXleakFh9ilOBgVhLh
	nf4GKMebklhZlVqUD5OS5mBREuf9tljdT0ggPbEkNTs1tSC1CCYrw8GhJMF79B1Qo2BRanpq
	RVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoBuKLgVEAkuIB2lsK0s5bXJCYCxSFaD3FqCgl
	zvsaJCEAksgozYMbC0scrxjFgb4U5g0CqeIBJh247ldAg5mABl8+JAsyuCQRISXVwNgvq6mv
	4b9a96n68S9vfRd0VKoeNpE4azrx07LZ24wZM6x866ZcXHp95u4u1/VKPyYfu/ll6UfPdUL8
	JRmMZqbsf9WfJr/ynb4+Oeky/5584XvBzbZPQ9cE7jrf5nR51dmVa7fa8ZlKenrv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292766>

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
