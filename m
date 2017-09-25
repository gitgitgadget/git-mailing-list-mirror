Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0B3A20281
	for <e@80x24.org>; Mon, 25 Sep 2017 08:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934062AbdIYIBF (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 04:01:05 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:58318 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934054AbdIYIBD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Sep 2017 04:01:03 -0400
X-AuditID: 12074412-1fdff7000000748d-d9-59c8b7be8808
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id B1.21.29837.EB7B8C95; Mon, 25 Sep 2017 04:01:02 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDF6.dip0.t-ipconnect.de [87.188.205.246])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8P80N6a027347
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 25 Sep 2017 04:01:00 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 16/21] packed_read_raw_ref(): read the reference from the mmapped buffer
Date:   Mon, 25 Sep 2017 10:00:13 +0200
Message-Id: <71786fa18cbd525de4f4d812c647e02c4654047b.1506325610.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1506325610.git.mhagger@alum.mit.edu>
References: <cover.1506325610.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqLtv+4lIgzUvLSzWPrvDZPF8/Ql2
        i64r3UwWDb1XmC36l3exWdxeMZ/ZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4fPsZ5
        LNhU6vGsdw+jx8VLyh6fN8kFsEdx2aSk5mSWpRbp2yVwZXz8v52loIuzYvuadsYGxm3sXYyc
        HBICJhI/nsxhA7GFBHYwSbx9btLFyAVkn2KS+HbjKgtIgk1AV2JRTzMTiC0ioCYxse0QC0gR
        s8BKZolJW6+wgiSEBaIlZr6axwhiswioSnx//BQozsHBKxAlcXaHIsQyeYlzD24zg9icAhYS
        b84cgVpsLnH+xi3WCYw8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmunlZpbopaaUbmKE
        BJzQDsb1J+UOMQpwMCrx8Eb8Ox4pxJpYVlyZe4hRkoNJSZT3Lt+JSCG+pPyUyozE4oz4otKc
        1OJDjBIczEoivMdWA+V4UxIrq1KL8mFS0hwsSuK8Pxer+wkJpCeWpGanphakFsFkNTg4BHrX
        rL7AKMWSl5+XqiTB+3sb0BDBotT01Iq0zJwShFImDk6QRTxAi5aD1PAWFyTmFmemQ+RPMepy
        dNy8+4dJCGyQlDjvBpAiAZCijNI8uDmwBPKKURzoRWHehSBVPMDkAzfpFdASJqAlvVPBlpQk
        IqSkGhjF1+X2/ncM26VR9r70rch1T1WppXdn+6SYiH74tsiSe2ND29TDcs0TTjGnTgl2LsqY
        vvLwCfHAnjvbBDXELj2LXeJaeFTJc0m/iEnGTt79PqqtBSUL7bcv0rM69O7cmheHbLYz795R
        ZVP1WjpV5XDS/xdsG5s2CZ93Evoz/WnPx5hlB3RCNy9QYinOSDTUYi4qTgQAF4KdifsCAAA=
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
index abf14a1405..be614e79f5 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -876,18 +876,22 @@ static int packed_read_raw_ref(struct ref_store *ref_store,
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

