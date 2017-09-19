Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 621E420281
	for <e@80x24.org>; Tue, 19 Sep 2017 06:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751485AbdISGXP (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 02:23:15 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:45753 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751476AbdISGXM (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Sep 2017 02:23:12 -0400
X-AuditID: 1207440e-bf9ff70000007085-f0-59c0b7cf67d6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id CF.66.28805.FC7B0C95; Tue, 19 Sep 2017 02:23:11 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE885.dip0.t-ipconnect.de [84.170.232.133])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8J6MV1n002857
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 19 Sep 2017 02:23:09 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 16/21] packed_read_raw_ref(): read the reference from the mmapped buffer
Date:   Tue, 19 Sep 2017 08:22:24 +0200
Message-Id: <b67c03b2d47ab503e27a2dd3918af42b59766bdb.1505799700.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505799700.git.mhagger@alum.mit.edu>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsUixO6iqHt++4FIg5+9yhZrn91hsni+/gS7
        RdeVbiaLht4rzBb9y7vYLG6vmM9s0T3lLaPFj5YeZovNm9tZHDg9/r7/wOSxc9Zddo8PH+M8
        Fmwq9XjWu4fR4+IlZY/Pm+QC2KO4bFJSczLLUov07RK4Mt72XGIt6OKs+LjpDnsD4zb2LkZO
        DgkBE4llLz4ydzFycQgJ7GCSuLVyIguEc4pJYuPZs0wgVWwCuhKLeprBbBEBNYmJbYfAipgF
        VjJLTNp6hRUkISwQLfF57kVmEJtFQFXiTtsKsDivQJTEpsdLodbJS5x7cBushlPAQqJ5z3ag
        QRxA28wlDhwtnsDIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrrFebmaJXmpK6SZGSMjx
        7WBsXy9ziFGAg1GJh1fg2v5IIdbEsuLK3EOMkhxMSqK8YZsORArxJeWnVGYkFmfEF5XmpBYf
        YpTgYFYS4T20CCjHm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgST1eDgEOhds/oC
        oxRLXn5eqpIEryIw5oQEi1LTUyvSMnNKEEqZODhBFvEALVIBqeEtLkjMLc5Mh8ifYtTl6Lh5
        9w+TENggKXHe+9uAigRAijJK8+DmwFLIK0ZxoBeFeQ1BRvEA0w/cpFdAS5iAlmRvAFtSkoiQ
        kmpgrD74d8vb7gNTe0OW/euW3/r67xQ1vVrtV5XFij93a9t/rY38kZo+Ofb8tMib2jsVc1IO
        dlSaHZNcls+dZCo52W3NJ80bObsfxkmxGZQz1n5mikmb8if01oF9ZnX97RFB6VKtWRwa1vte
        P8o/ayyx1UvWPWNeXc294o6Xj/f8P3FSmH1KydM7SizFGYmGWsxFxYkATwMSVfwCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of reading the reference from the `ref_cache`, read it
directly from the mmapped buffer.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 53d0b7e3d6..2cf2f7f73d 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -875,18 +875,22 @@ static int packed_read_raw_ref(struct ref_store *ref_store,
 {
 	struct packed_ref_store *refs =
 		packed_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
-
-	struct ref_entry *entry;
+	struct packed_ref_cache *packed_refs = get_packed_ref_cache(refs);
+	const char *rec;
 
 	*type = 0;
 
-	entry = get_packed_ref(refs, refname);
-	if (!entry) {
+	rec = find_reference_location(packed_refs, refname, 1);
+
+	if (!rec) {
+		/* refname is not a packed reference. */
 		errno = ENOENT;
 		return -1;
 	}
 
-	hashcpy(sha1, entry->u.value.oid.hash);
+	if (get_sha1_hex(rec, sha1))
+		die_invalid_line(refs->path, rec, packed_refs->eof - rec);
+
 	*type = REF_ISPACKED;
 	return 0;
 }
-- 
2.14.1

