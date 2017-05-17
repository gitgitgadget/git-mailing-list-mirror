Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD42F201A7
	for <e@80x24.org>; Wed, 17 May 2017 12:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753654AbdEQMGb (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:06:31 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:45819 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753599AbdEQMG1 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 08:06:27 -0400
X-AuditID: 1207440e-797ff70000007d8a-13-591c3cc1bf9d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 58.B5.32138.1CC3C195; Wed, 17 May 2017 08:06:26 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HC5pg7000430
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 08:06:24 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 16/23] should_pack_ref(): new function, extracted from `files_pack_refs()`
Date:   Wed, 17 May 2017 14:05:39 +0200
Message-Id: <2e104ca5ff7112bc00e0a482b02a496585eee77d.1495014840.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsUixO6iqHvIRibSYO1CZou1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfG761fmAu+CVR8enqTrYHxOG8XIyeHhICJ
        xPr5Sxi7GLk4hAR2MEm8ntPEDuGcYJJ48OYBI0gVm4CuxKKeZiYQW0RATWJi2yEWkCJmgcdM
        En+XdQM5HBzCAlESq3YXg5gsAqoS/79KgpTzAkXnPfzODLFMXmJX20VWEJtTwELi/vtH7CDl
        QgLmEtuvV05g5FnAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdYLzezRC81pXQTIyTM+HYw
        tq+XOcQowMGoxMM7gUs6Uog1say4MvcQoyQHk5Io7/4HQCG+pPyUyozE4oz4otKc1OJDjBIc
        zEoivDdNZSKFeFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvFOsgRoF
        i1LTUyvSMnNKENJMHJwgw3mAhnOB1PAWFyTmFmemQ+RPMSpKifMeAEkIgCQySvPgemFp4BWj
        ONArwrx5IFU8wBQC1/0KaDAT0OBmkI94i0sSEVJSDYzM7nzPLJ00X79Z0Xn5zVJ9pll6payv
        OxbK7FQJ+nXzetVug2sL57NENJzdbMHK4nyrV9a+pvEJ9731CbzilxkLDtu1n92lf8njThq/
        UemdVa/mWgYKeIlNEP96M9d/i4evdq1W9t4iy5RrWw/OflLlOveQ60Xebykll4+vW5MievYO
        72WthW+UWIozEg21mIuKEwGAnnzL3gIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract a function for deciding whether a reference should be packed.
It is a self-contained bit of logic, so splitting it out improves
readability.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index d7596b5222..c549a8d956 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1467,6 +1467,32 @@ static void prune_refs(struct files_ref_store *refs, struct ref_to_prune *r)
 	}
 }
 
+/*
+ * Return true if the specified reference should be packed.
+ */
+static int should_pack_ref(const char *refname,
+			   const struct object_id *oid, unsigned int ref_flags,
+			   unsigned int pack_flags)
+{
+	/* Do not pack per-worktree refs: */
+	if (ref_type(refname) != REF_TYPE_NORMAL)
+		return 0;
+
+	/* Do not pack non-tags unless PACK_REFS_ALL is set: */
+	if (!(pack_flags & PACK_REFS_ALL) && !starts_with(refname, "refs/tags/"))
+		return 0;
+
+	/* Do not pack symbolic refs: */
+	if (ref_flags & REF_ISSYMREF)
+		return 0;
+
+	/* Do not pack broken refs: */
+	if (!ref_resolves_to_object(refname, oid, ref_flags))
+		return 0;
+
+	return 1;
+}
+
 static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 {
 	struct files_ref_store *refs =
@@ -1488,21 +1514,9 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 		 * pruned, also add it to refs_to_prune.
 		 */
 		struct ref_entry *packed_entry;
-		int is_tag_ref = starts_with(iter->refname, "refs/tags/");
-
-		/* Do not pack per-worktree refs: */
-		if (ref_type(iter->refname) != REF_TYPE_NORMAL)
-			continue;
-
-		/* ALWAYS pack tags */
-		if (!(flags & PACK_REFS_ALL) && !is_tag_ref)
-			continue;
-
-		/* Do not pack symbolic or broken refs: */
-		if (iter->flags & REF_ISSYMREF)
-			continue;
 
-		if (!ref_resolves_to_object(iter->refname, iter->oid, iter->flags))
+		if (!should_pack_ref(iter->refname, iter->oid, iter->flags,
+				     flags))
 			continue;
 
 		/*
-- 
2.11.0

