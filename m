Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F5EC20A93
	for <e@80x24.org>; Fri,  6 Jan 2017 16:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967494AbdAFQXp (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 11:23:45 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:48260 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967473AbdAFQXe (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 11:23:34 -0500
X-AuditID: 12074414-78bff70000004a85-f5-586fc482cd55
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 48.EF.19077.284CF685; Fri,  6 Jan 2017 11:23:30 -0500 (EST)
Received: from bagpipes.fritz.box (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06GMmXC023262
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 6 Jan 2017 11:23:28 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 22/23] try_remove_empty_parents(): teach to remove parents of reflogs, too
Date:   Fri,  6 Jan 2017 17:22:42 +0100
Message-Id: <2dab5bf3cf9a0da59bf6f10bea32ba4d6d7a0f53.1483719289.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483719289.git.mhagger@alum.mit.edu>
References: <cover.1483719289.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsUixO6iqNt0JD/C4MklCYuuK91MFg29V5gt
        di/uZ7a4vWI+s8WSh6+ZLX609DBbdE6VdWD3+Pv+A5PHzll32T2WL13H6NHVfoTN41nvHkaP
        i5eUPT5vkgtgj+KySUnNySxLLdK3S+DKaP3+jqlgjlDF2e7nTA2M7/m6GDk5JARMJFYt7mXs
        YuTiEBK4zCix7sUWZgjnBJPE7+frWECq2AR0JRb1NDOB2CICahIT2w6xgBQxC3xglPjVOYsd
        JCEsECvxZ8desAYWAVWJ/u+TGUFsXoEoiflHP7JBrJOTuLTtCzOIzSlgIdG46xtYjZCAucSn
        iYeZJzDyLGBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6GXm1mil5pSuokREmIiOxiPnJQ7
        xCjAwajEwxvhlRchxJpYVlyZe4hRkoNJSZQ3zDE/QogvKT+lMiOxOCO+qDQntfgQowQHs5II
        r90hoBxvSmJlVWpRPkxKmoNFSZz322J1PyGB9MSS1OzU1ILUIpisDAeHkgRv42GgRsGi1PTU
        irTMnBKENBMHJ8hwHqDhHSA1vMUFibnFmekQ+VOMilLivFtAtgqAJDJK8+B6YSngFaM40CvC
        vD0g7TzA9AHX/QpoMBPQYEFPsMEliQgpqQZGl+cMk1gWicTG1Udbtv0VPC/FfF6krUCGe1OQ
        f85n2U9z4h+WzT8qphJzis3Q6nux/O8XCmV/VK0e8X3ye9LQkh/ySbhdzXNhamW7zrUVL64K
        HeoIv7EoeZPgMd0+3uDpd6U+XpBatWrNlOUB79/wlC9q1Pp702jW2z0XTp0POdleeUtsm3Sa
        EktxRqKhFnNRcSIAMWjfwdwCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new "flags" parameter that tells the function whether to remove
empty parent directories of the loose reference file, of the reflog
file, or both. The new functionality is not yet used.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 88f8c7a..bce0022 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2280,10 +2280,18 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
+enum {
+	REMOVE_EMPTY_PARENTS_REF = 0x01,
+	REMOVE_EMPTY_PARENTS_REFLOG = 0x02
+};
+
 /*
- * Remove empty parents, but spare refs/ and immediate subdirs.
+ * Remove empty parent directories associated with the specified
+ * reference and/or its reflog, but spare [logs/]refs/ and immediate
+ * subdirs. flags is a combination of REMOVE_EMPTY_PARENTS_REF and/or
+ * REMOVE_EMPTY_PARENTS_REFLOG.
  */
-static void try_remove_empty_parents(const char *refname)
+static void try_remove_empty_parents(const char *refname, unsigned int flags)
 {
 	struct strbuf buf = STRBUF_INIT;
 	char *p, *q;
@@ -2299,7 +2307,7 @@ static void try_remove_empty_parents(const char *refname)
 			p++;
 	}
 	q = buf.buf + buf.len;
-	while (1) {
+	while (flags & (REMOVE_EMPTY_PARENTS_REF | REMOVE_EMPTY_PARENTS_REFLOG)) {
 		while (q > p && *q != '/')
 			q--;
 		while (q > p && *(q-1) == '/')
@@ -2307,8 +2315,12 @@ static void try_remove_empty_parents(const char *refname)
 		if (q == p)
 			break;
 		strbuf_setlen(&buf, q - buf.buf);
-		if (rmdir(git_path("%s", buf.buf)))
-			break;
+		if ((flags & REMOVE_EMPTY_PARENTS_REF) &&
+		    rmdir(git_path("%s", buf.buf)))
+			flags &= ~REMOVE_EMPTY_PARENTS_REF;
+		if ((flags & REMOVE_EMPTY_PARENTS_REFLOG) &&
+		    rmdir(git_path("logs/%s", buf.buf)))
+			flags &= ~REMOVE_EMPTY_PARENTS_REFLOG;
 	}
 	strbuf_release(&buf);
 }
@@ -2334,7 +2346,7 @@ static void prune_ref(struct ref_to_prune *r)
 	}
 	ref_transaction_free(transaction);
 	strbuf_release(&err);
-	try_remove_empty_parents(r->name);
+	try_remove_empty_parents(r->name, REMOVE_EMPTY_PARENTS_REF);
 }
 
 static void prune_refs(struct ref_to_prune *r)
-- 
2.9.3

