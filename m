Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 933042023D
	for <e@80x24.org>; Mon, 22 May 2017 14:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934739AbdEVOT2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:19:28 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:42984 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934721AbdEVOS4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:18:56 -0400
X-AuditID: 12074413-0c9ff70000001dc3-d4-5922f34b458a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 89.20.07619.B43F2295; Mon, 22 May 2017 10:18:51 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI24R023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:18:49 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 18/25] should_pack_ref(): new function, extracted from `files_pack_refs()`
Date:   Mon, 22 May 2017 16:17:48 +0200
Message-Id: <b7786f0cc9664fe86580f4296b4916f450b068d0.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqOv9WSnS4O4Tfou1z+4wWTxff4Ld
        outKN5NFQ+8VZosnc+8yW9xeMZ/ZYsnD18wW3VPeMlr8aOlhtti8uZ3Fgcvj7/sPTB47Z91l
        91iwqdTj4asudo+u9iNsHs969zB6XLyk7PF5k1wARxSXTUpqTmZZapG+XQJXxusd+9gKvglU
        /Jv0ib2B8ThvFyMnh4SAicSVjj9sILaQwA4micY9Ql2MXED2KSaJjWd6wRJsAroSi3qamUBs
        EQE1iYlth1hAipgFNjBLvJm+GiwhLBArce/iI2YQm0VAVaLrw06wOK9AlMSiI0uZIbbJS+xq
        u8gKYnMKWEj8nnWACWKzuUTvv9UsExh5FjAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdfL
        zSzRS00p3cQICUThHYy7TsodYhTgYFTi4dV4rBQpxJpYVlyZe4hRkoNJSZT36BugEF9Sfkpl
        RmJxRnxRaU5q8SFGCQ5mJRFe7btAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQi
        mKwMB4eSBK/eJ6BGwaLU9NSKtMycEoQ0EwcnyHAeoOFrPoAMLy5IzC3OTIfIn2JUlBLn3QGS
        EABJZJTmwfXCEsUrRnGgV4R5C0FW8ACTDFz3K6DBTECDrZ/JgwwuSURISTUwCjx0mXPrt+mX
        PXxLbz9+FJMmYMP8aM3fmRevWgr+uL3K/Km57cePh3U8ldOjpuze8mblBqXzt6aeNpHKady6
        Md9Q6qOJ56bZF4UFP0jq9PBu0/Ndwc+2qEjiyO36iJVtqyYJfHwVGnvh9bwjMrvL15S4MDQq
        2H7YHHX34UtZnz8d39mmBSad+6DEUpyRaKjFXFScCADUFC7N7wIAAA==
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
index 8d0ce739a6..29514392b0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1455,6 +1455,32 @@ static void prune_refs(struct files_ref_store *refs, struct ref_to_prune *r)
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
@@ -1476,21 +1502,9 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
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

