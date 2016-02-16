From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 14/20] try_remove_empty_parents(): don't trash argument contents
Date: Tue, 16 Feb 2016 14:22:27 +0100
Message-ID: <c8897e9f6cb277af1a427b6d8c0dd90b561dd767.1455626201.git.mhagger@alum.mit.edu>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 14:30:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfiK-0003Ac-Cu
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbcBPNak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 08:30:40 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:58880 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932179AbcBPNae (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 08:30:34 -0500
X-AuditID: 1207440c-bf7ff70000002d40-12-56c322bd34b3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 1F.E5.11584.DB223C65; Tue, 16 Feb 2016 08:23:09 -0500 (EST)
Received: from michael.fritz.box (p548D6919.dip0.t-ipconnect.de [84.141.105.25])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1GDMfOa028717
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Feb 2016 08:23:08 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1455626201.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqLtX6XCYwdSdchbzN51gtOi60s1k
	0dB7hdniw9pDbBa9k3tZLW6vmM9s8aOlh9mB3ePv+w9MHk+3T2H2eHG+wuNZ7x5Gj4uXlD0W
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd0bjrD3MBfO5Kz6+tG9gvMfRxcjJISFgIvH+3Gfm
	LkYuDiGBrYwSe27dY4JwTjBJ9N94wgxSxSagK7Gop5kJxBYRUJOY2HaIBaSIWeARo0TX/u2M
	IAlhgQCJTa96gBIcHCwCqhL3VoLV8wpESVzY+ocVYpucRMuP3WA2p4CFxMmWXhYQW0jAXOLO
	lz1MExh5FjAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdTLzSzRS00p3cQICTCeHYzf1skc
	YhTgYFTi4d3geihMiDWxrLgy9xCjJAeTkigvD/fhMCG+pPyUyozE4oz4otKc1OJDjBIczEoi
	vP9eAZXzpiRWVqUW5cOkpDlYlMR5VZeo+wkJpCeWpGanphakFsFkZTg4lCR4PykCDRUsSk1P
	rUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHRUB8MTAGQFI8QHvTQNp5iwsSc4GiEK2nGBWl
	xHn3gyQEQBIZpXlwY2Fp4xWjONCXwrwBIFU8wJQD1/0KaDAT0OCcSyAPFZckIqSkGhi5Fyx+
	tKXr30uZ5Um7EzaE+MtGfjr+Z77iL9PUktTEqRIiNRa7ZpV2LFV4Yl50hjVnm4vbXuNyv31z
	/Z8q3D23KCM+4InNhVMh++ss7uUdXssXGmFTcKOkpXz2I11ORb+TB1+5z1npqX+W 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286379>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7e870fc..897ff4c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2200,13 +2200,15 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 
 /*
  * Remove empty parents, but spare refs/ and immediate subdirs.
- * Note: munges *refname.
  */
-static void try_remove_empty_parents(char *refname)
+static void try_remove_empty_parents(const char *refname)
 {
+	struct strbuf buf = STRBUF_INIT;
 	char *p, *q;
 	int i;
-	p = refname;
+
+	strbuf_addstr(&buf, refname);
+	p = buf.buf;
 	for (i = 0; i < 2; i++) { /* refs/{heads,tags,...}/ */
 		while (*p && *p != '/')
 			p++;
@@ -2214,8 +2216,7 @@ static void try_remove_empty_parents(char *refname)
 		while (*p == '/')
 			p++;
 	}
-	for (q = p; *q; q++)
-		;
+	q = buf.buf + buf.len;
 	while (1) {
 		while (q > p && *q != '/')
 			q--;
@@ -2223,10 +2224,11 @@ static void try_remove_empty_parents(char *refname)
 			q--;
 		if (q == p)
 			break;
-		*q = '\0';
-		if (rmdir(git_path("%s", refname)))
+		strbuf_setlen(&buf, q - buf.buf);
+		if (rmdir(git_path("%s", buf.buf)))
 			break;
 	}
+	strbuf_release(&buf);
 }
 
 /* make sure nobody touched the ref, and unlink */
-- 
2.7.0
