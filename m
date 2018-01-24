Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 487E41F576
	for <e@80x24.org>; Wed, 24 Jan 2018 11:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933338AbeAXLOf (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 06:14:35 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:49222 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933274AbeAXLOd (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Jan 2018 06:14:33 -0500
X-AuditID: 1207440e-1c1ff70000000b4f-33-5a686a94be9f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 06.6B.02895.59A686A5; Wed, 24 Jan 2018 06:14:29 -0500 (EST)
Received: from bagpipes.fritz.box (p54AAE3E5.dip0.t-ipconnect.de [84.170.227.229])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w0OBEIi8004669
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Jan 2018 06:14:27 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kim Gybels <kgybels@infogroep.be>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/6] packed_ref_iterator_begin(): make optimization more general
Date:   Wed, 24 Jan 2018 12:14:14 +0100
Message-Id: <bf6c0c67430b936738f5e8891b82022d0127acb0.1516791909.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <cea5e366-dc95-6f41-6373-f8bbef103561@alum.mit.edu>
References: <cea5e366-dc95-6f41-6373-f8bbef103561@alum.mit.edu>
In-Reply-To: <cover.1516791909.git.mhagger@alum.mit.edu>
References: <cover.1516791909.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqDstKyPK4MMKPouuK91MFg29V5gt
        +pd3sVkc7JzJanF7xXxmix8tPcwObB5/339g8vjwMc6j78gaRo9nvXsYPS5eUvb4vEkugC2K
        yyYlNSezLLVI3y6BK+P1x/nMBY08FTce/2JvYPzB2cXIySEhYCIx7+wBZhBbSGAHk0TLu6Au
        Ri4g+xKTxI0/M1lBEmwCuhKLepqZQGwRATWJiW2HWECKmAVOM0rs2r+MBSQhLBAgsfXzOnYQ
        m0VAVeLa5pNgDbwCURLPpt1lgtgmL/F+wX1GEJtTwEGie8clNojN9hLd1w4BXcEBFLeQuLxI
        C8QUEjCXuPOPZwIj3wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFusZ6uZkleqkppZsYIYHH
        t4Oxfb3MIUYBDkYlHt4bFulRQqyJZcWVuYcYJTmYlER584MyooT4kvJTKjMSizPii0pzUosP
        MUpwMCuJ8OaxApXzpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4/TOB
        hgoWpaanVqRl5pQgpJk4OEGG8wANXwlSw1tckJhbnJkOkT/FqMtx48XrNmYhlrz8vFQpcd4K
        kCIBkKKM0jy4ObCE8YpRHOgtYd7FIFU8wGQDN+kV0BImoCU3alJBlpQkIqSkGhg3h1dHv/x3
        l+sq45wPM1v2vL/ctq1AxXl9zle7fL2ypq7lgaKaoYcyn74SlCpiyBcO12Ar12J0nPtNzZKj
        x3zyLL0LxxfuF46sTdnQyKe9lunQqvaOtTOfKb4uPer1fvsNKVGjwomL58c0l3PXq97Ms7rB
        elHI1lZ997V/WY8bNu+a8+kZ+y8lluKMREMt5qLiRADrYhx28wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can return an empty iterator not only if the `packed-refs` file is
missing, but also if it is empty or if there are no references whose
names succeed `prefix`. Optimize away those cases as well by moving
the call to `find_reference_location()` higher in the function and
checking whether the determined start position is the same as
`snapshot->eof`. (This is possible now because the previous commit
made `find_reference_location()` robust against empty snapshots.)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 361affd7ad..988c45402b 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -927,7 +927,12 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	 */
 	snapshot = get_snapshot(refs);
 
-	if (!snapshot->buf)
+	if (prefix && *prefix)
+		start = find_reference_location(snapshot, prefix, 0);
+	else
+		start = snapshot->start;
+
+	if (start == snapshot->eof)
 		return empty_ref_iterator_begin();
 
 	iter = xcalloc(1, sizeof(*iter));
@@ -937,11 +942,6 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	iter->snapshot = snapshot;
 	acquire_snapshot(snapshot);
 
-	if (prefix && *prefix)
-		start = find_reference_location(snapshot, prefix, 0);
-	else
-		start = snapshot->start;
-
 	iter->pos = start;
 	iter->eof = snapshot->eof;
 	strbuf_init(&iter->refname_buf, 0);
-- 
2.14.2

