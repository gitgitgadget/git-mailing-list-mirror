From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/29] read_raw_ref(): rename symref argument to referent
Date: Wed, 27 Apr 2016 18:57:28 +0200
Message-ID: <db498e789a50d870c42ebdff7b668cd979e466a0.1461768689.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:58:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSnE-0003f6-3Q
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbcD0Q6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:58:23 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:62997 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753451AbcD0Q6W (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:22 -0400
X-AuditID: 1207440f-8bbff700000008e4-15-5720efade54c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id F5.9F.02276.DAFE0275; Wed, 27 Apr 2016 12:58:21 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6O022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:20 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsUixO6iqLv2vUK4wfXHShbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oxfh68yFTRJVHzuiWlg7BHuYuTkkBAwkehsvsPS
	xcjFISSwlVHizMEbzCAJIYHjTBJNjSogNpuArsSinmYmEFtEwEFi+cpf7CANzAJNTBLflzex
	gCSEBTwlfm39wg5iswioSmx685uxi5GDg1cgSuLTuXiIZXISl6c/YAOxOQUsJL60vmWE2GUu
	seTBavYJjDwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6OVmluilppRuYoSEF/8Oxq71
	MocYBTgYlXh4CyQUwoVYE8uKK3MPMUpyMCmJ8i45CxTiS8pPqcxILM6ILyrNSS0+xCjBwawk
	wjv9DVCONyWxsiq1KB8mJc3BoiTOq75E3U9IID2xJDU7NbUgtQgmK8PBoSTBW/4OqFGwKDU9
	tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFP7xxcAIAEnxAO0tBWnnLS5IzAWKQrSeYlSU
	EuddAJIQAElklObBjYUljVeM4kBfCvNOBaniASYcuO5XQIOZgAZfPiQLMrgkESEl1cAot1ni
	ofQEvnMLQzbt7+Va2vDG5f+834lWTJc+TC8Ve/77v6lK/dRfd5ecLthyg9XBKWyxyid7r0Or
	NiZoCxRYyM0y+MvBosp5KTBSb24O89zIdTdyIg/u2iLnwrt91tWNx+bdEg4/9tNw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292748>

After all, it doesn't hold the symbolic reference, but rather the
reference referred to.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 21 +++++++++++----------
 refs/refs-internal.h |  2 +-
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f10c80f..364425c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1393,9 +1393,10 @@ static int resolve_missing_loose_ref(const char *refname,
  *
  * If the ref is a sha1, fill in sha1 and return 0.
  *
- * If the ref is symbolic, fill in *symref with the referrent
- * (e.g. "refs/heads/master") and return 0.  The caller is responsible
- * for validating the referrent.  Set REF_ISSYMREF in type.
+ * If the ref is symbolic, fill in *referent with the name of the
+ * branch to which it refers (e.g. "refs/heads/master") and return 0.
+ * The caller is responsible for validating the referent. Set
+ * REF_ISSYMREF in type.
  *
  * If the ref doesn't exist, set errno to ENOENT and return -1.
  *
@@ -1411,15 +1412,15 @@ static int resolve_missing_loose_ref(const char *refname,
  *
  * sb_path is workspace: the caller should allocate and free it.
  *
- * It is OK for refname to point into symref. In this case:
- * - if the function succeeds with REF_ISSYMREF, symref will be
+ * It is OK for refname to point into referent. In this case:
+ * - if the function succeeds with REF_ISSYMREF, referent will be
  *   overwritten and the memory pointed to by refname might be changed
  *   or even freed.
- * - in all other cases, symref will be untouched, and therefore
+ * - in all other cases, referent will be untouched, and therefore
  *   refname will still be valid and unchanged.
  */
 int read_raw_ref(const char *refname, unsigned char *sha1,
-		 struct strbuf *symref, unsigned int *type)
+		 struct strbuf *referent, unsigned int *type)
 {
 	struct strbuf sb_contents = STRBUF_INIT;
 	struct strbuf sb_path = STRBUF_INIT;
@@ -1469,7 +1470,7 @@ stat_ref:
 		}
 		if (starts_with(sb_contents.buf, "refs/") &&
 		    !check_refname_format(sb_contents.buf, 0)) {
-			strbuf_swap(&sb_contents, symref);
+			strbuf_swap(&sb_contents, referent);
 			*type |= REF_ISSYMREF;
 			ret = 0;
 			goto out;
@@ -1509,8 +1510,8 @@ stat_ref:
 		while (isspace(*buf))
 			buf++;
 
-		strbuf_reset(symref);
-		strbuf_addstr(symref, buf);
+		strbuf_reset(referent);
+		strbuf_addstr(referent, buf);
 		*type |= REF_ISSYMREF;
 		ret = 0;
 		goto out;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 0b047f6..37a1a37 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -210,6 +210,6 @@ int do_for_each_ref(const char *submodule, const char *base,
 		    each_ref_fn fn, int trim, int flags, void *cb_data);
 
 int read_raw_ref(const char *refname, unsigned char *sha1,
-		 struct strbuf *symref, unsigned int *type);
+		 struct strbuf *referent, unsigned int *type);
 
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.8.1
