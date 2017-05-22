Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F0342023D
	for <e@80x24.org>; Mon, 22 May 2017 14:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934686AbdEVOS0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:18:26 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:51806 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934681AbdEVOSV (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:18:21 -0400
X-AuditID: 1207440c-9c1ff70000001412-2f-5922f32b596f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id A5.C0.05138.B23F2295; Mon, 22 May 2017 10:18:19 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI24E023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:18:17 -0400
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
Subject: [PATCH v2 05/25] prefix_ref_iterator: don't trim too much
Date:   Mon, 22 May 2017 16:17:35 +0200
Message-Id: <f2f73adae931939e4335967872a1182bd3c8562b.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqKv9WSnS4HajgcXaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8WTuXeZLW6vmM9sseTha2aL7ilvGS1+tPQwW2ze3M7iwOXx9/0HJo+ds+6y
        eyzYVOrx8FUXu0dX+xE2j2e9exg9Ll5S9vi8SS6AI4rLJiU1J7MstUjfLoEr42j/f+aCPv6K
        I38bGRsYO3m6GDk4JARMJF4fSupi5OIQEtjBJNFy7jQThHOKSWLJv5uMXYycHGwCuhKLepqZ
        QGwRATWJiW2HWECKmAU2MEu8mb4aLCEs4CRx7/QsMJtFQFXi5/Eb7CA2r0CUxOflT8AGSQjI
        S+xqu8gKYnMKWEj8nnUArF5IwFyi999qlgmMPAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW
        6Rrq5WaW6KWmlG5ihAQizw7Gb+tkDjEKcDAq8fA2PFWKFGJNLCuuzD3EKMnBpCTKe/QNUIgv
        KT+lMiOxOCO+qDQntfgQowQHs5IIr/ZdoBxvSmJlVWpRPkxKmoNFSZxXdYm6n5BAemJJanZq
        akFqEUxWhoNDSYJX7xNQo2BRanpqRVpmTglCmomDE2Q4D9DwNR9AhhcXJOYWZ6ZD5E8xKkqJ
        8xqANAuAJDJK8+B6YYniFaM40CvCvCYgVTzAJAPX/QpoMBPQYOtn8iCDSxIRUlINjL5yAgGe
        ne8C/4XUV0wuuXDRYtPnd4ddI3O67iwUzbX+c9T3btKBzc53W16dXzr511915/0HcvO/sCQZ
        cx3/XhrCPotdvX8N0/+ljFdP826qfHuap63u/k3h3xOW7dOSnnnog1NocWa2GavqjVkRc/TN
        p/SFe85hNjTSML178sK8+T8fHIpbXazEUpyRaKjFXFScCAD7QWQQ7wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `trim` parameter can be set independently of `prefix`. So if some
caller were to set `trim` to be greater than `strlen(prefix)`, we
could end up pointing the `refname` field of the iterator past the NUL
of the actual reference name string.

That can't happen currently, because `trim` is always set either to
zero or to `strlen(prefix)`. But even the latter could lead to
confusion, if a refname is exactly equal to the prefix, because then
we would set the outgoing `refname` to the empty string.

And we're about to decouple the `prefix` and `trim` arguments even
more, so let's be cautious here. Report a bug if ever asked to trim a
reference whose name is not longer than `trim`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/iterator.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/refs/iterator.c b/refs/iterator.c
index bce1f192f7..4cf449ef66 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -292,7 +292,23 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		if (!starts_with(iter->iter0->refname, iter->prefix))
 			continue;
 
-		iter->base.refname = iter->iter0->refname + iter->trim;
+		if (iter->trim) {
+			/*
+			 * It is nonsense to trim off characters that
+			 * you haven't already checked for via a
+			 * prefix check, whether via this
+			 * `prefix_ref_iterator` or upstream in
+			 * `iter0`). So if there wouldn't be at least
+			 * one character left in the refname after
+			 * trimming, report it as a bug:
+			 */
+			if (strlen(iter->iter0->refname) <= iter->trim)
+				die("BUG: attempt to trim too many characters");
+			iter->base.refname = iter->iter0->refname + iter->trim;
+		} else {
+			iter->base.refname = iter->iter0->refname;
+		}
+
 		iter->base.oid = iter->iter0->oid;
 		iter->base.flags = iter->iter0->flags;
 		return ITER_OK;
-- 
2.11.0

