Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FCB820209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbdGASby (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:31:54 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:48713 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752059AbdGASbx (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:31:53 -0400
X-AuditID: 1207440e-8a7ff70000006f9a-d3-5957ea9810c8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 59.A9.28570.89AE7595; Sat,  1 Jul 2017 14:31:52 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBT010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:31:49 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 16/30] packed_peel_ref(): new function, extracted from `files_peel_ref()`
Date:   Sat,  1 Jul 2017 20:30:54 +0200
Message-Id: <6e52008a0556f80e48ab17a6db1cc0d328c4f539.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqDvjVXikwc47fBZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntljy8DWzRfeUt4wWP1p6mC02b25nceD0+Pv+A5PHzll32T0WbCr1
        6Go/wubxrHcPo8fFS8oenzfJBbBHcdmkpOZklqUW6dslcGXcn/GerWAzd8WuDXNZGhgncXYx
        cnJICJhINP0+xtjFyMUhJLCDSWLlrT/sEM5JJolHJ1czglSxCehKLOppZgKxRQTUJCa2HWIB
        KWIWmMQs8fbaQrCEsECMxPeVv1lAbBYBVYkdG86zgdi8AlESLTtbmCHWyUvsarvICmJzClhI
        /GlbDxYXEjCXaD7YxzKBkWcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1jvdzMEr3UlNJN
        jJCw49vB2L5e5hCjAAejEg/vhpCwSCHWxLLiytxDjJIcTEqivCuvhUYK8SXlp1RmJBZnxBeV
        5qQWH2KU4GBWEuHNfR4eKcSbklhZlVqUD5OS5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQ
        kuCd9BKoUbAoNT21Ii0zpwQhzcTBCTKcB2j4wrsgw4sLEnOLM9Mh8qcYdTleTfj/jUmIJS8/
        L1VKnLcVZJAASFFGaR7cHFi6eMUoDvSWMG/EC6AqHmCqgZv0CmgJE9AS4RkhIEtKEhFSUg2M
        QswPF/QW3Fok+N2iLt+Jf/HzaYxiSlp/5m72Pn5O/M+Lki+Bd65m7v6181lrl/BENheB9hcT
        JXQeOP5bHB+tuURznrpZUHCXd6KeEmPBuYt/jtQv2L1Is0L19qJnZ/iv3HBmXKpYvaWSZ90s
        uSUGicZmTS+Pabe/15X3XPhG5kqWyfd3166vVGIpzkg01GIuKk4EAHNqC0vyAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will later become a method of `packed_ref_store`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index c206791b91..185d05e1d6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1013,6 +1013,18 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	return ret;
 }
 
+static int packed_peel_ref(struct packed_ref_store *refs,
+			   const char *refname, unsigned char *sha1)
+{
+	struct ref_entry *r = get_packed_ref(refs, refname);
+
+	if (!r || peel_entry(r, 0))
+		return -1;
+
+	hashcpy(sha1, r->u.value.peeled.hash);
+	return 0;
+}
+
 static int files_peel_ref(struct ref_store *ref_store,
 			  const char *refname, unsigned char *sha1)
 {
@@ -1043,17 +1055,9 @@ static int files_peel_ref(struct ref_store *ref_store,
 	 * be expensive and (b) loose references anyway usually do not
 	 * have REF_KNOWS_PEELED.
 	 */
-	if (flag & REF_ISPACKED) {
-		struct ref_entry *r =
-			get_packed_ref(refs->packed_ref_store, refname);
-
-		if (r) {
-			if (peel_entry(r, 0))
-				return -1;
-			hashcpy(sha1, r->u.value.peeled.hash);
-			return 0;
-		}
-	}
+	if (flag & REF_ISPACKED &&
+	    !packed_peel_ref(refs->packed_ref_store, refname, sha1))
+		return 0;
 
 	return peel_object(base, sha1);
 }
-- 
2.11.0

