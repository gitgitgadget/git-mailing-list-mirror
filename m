Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63A5C2023D
	for <e@80x24.org>; Mon, 22 May 2017 14:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934610AbdEVOTX (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:19:23 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:44019 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934710AbdEVOS7 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:18:59 -0400
X-AuditID: 12074412-a4fff70000003a21-41-5922f352a8ff
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id A0.87.14881.253F2295; Mon, 22 May 2017 10:18:58 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI24U023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:18:56 -0400
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
Subject: [PATCH v2 21/25] read_packed_refs(): report unexpected fopen() failures
Date:   Mon, 22 May 2017 16:17:51 +0200
Message-Id: <2b8f4e4bbfaca8f6d3d828bcb0e7ff1779778061.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqBv0WSnS4N5xRYu1z+4wWTxff4Ld
        outKN5NFQ+8VZosnc+8yW9xeMZ/ZYsnD18wW3VPeMlr8aOlhtti8uZ3Fgcvj7/sPTB47Z91l
        91iwqdTj4asudo+u9iNsHs969zB6XLyk7PF5k1wARxSXTUpqTmZZapG+XQJXxpIvy5gKPnNW
        nNtQ2sD4k72LkZNDQsBEYveav6xdjFwcQgI7mCRatt5ignBOMUnM79nGAlLFJqArsainmQnE
        FhFQk5jYdogFpIhZYAOzxJvpq4ESHBzCAgES2/p5QGpYBFQljm2ZxAZi8wpESTz6+g9qm7zE
        rraLrCA2p4CFxO9ZB8BmCgmYS/T+W80ygZFnASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJd
        M73czBK91JTSTYyQMBTawbj+pNwhRgEORiUe3oanSpFCrIllxZW5hxglOZiURHmPvgEK8SXl
        p1RmJBZnxBeV5qQWH2KU4GBWEuHVvguU401JrKxKLcqHSUlzsCiJ8/5crO4nJJCeWJKanZpa
        kFoEk5Xh4FCS4NX7BNQoWJSanlqRlplTgpBm4uAEGc4DNHzNB5DhxQWJucWZ6RD5U4yKUuK8
        BiDNAiCJjNI8uF5YmnjFKA70ijBvIUgVDzDFwHW/AhrMBDTY+pk8yOCSRISUVAPj4aR3l48w
        6W/reW97w+vM+e1Sqz9HxnXWLjzPIHVbMpwvqWjj/cBTTsnhyWdX7Tgp/cDjuvIBwSlc65zu
        P2NjO/l37qlzTzM6T99SzTl799lti1U7f38t9Wfa5Vp0rd/u4/yTKV379IzMp7+3YGfzWb0/
        +tLVa9K2D19d29bjxpa22YSldUaFsBJLcUaioRZzUXEiAH3cOYXuAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old code ignored any errors encountered when trying to fopen the
"packed-refs" file, treating all such failures as if the file didn't
exist. But it could be that there is some other error opening the
file (e.g., permissions problems), and we don't want to silently
ignore such problems. So report any failures that are not due to
ENOENT.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b4fa745cd7..dbfd03f989 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -251,8 +251,18 @@ static struct packed_ref_cache *read_packed_refs(const char *packed_refs_file)
 	packed_refs->cache->root->flag &= ~REF_INCOMPLETE;
 
 	f = fopen(packed_refs_file, "r");
-	if (!f)
-		return packed_refs;
+	if (!f) {
+		if (errno == ENOENT) {
+			/*
+			 * This is OK; it just means that no
+			 * "packed-refs" file has been written yet,
+			 * which is equivalent to it being empty.
+			 */
+			return packed_refs;
+		} else {
+			die_errno("couldn't read %s", packed_refs_file);
+		}
+	}
 
 	stat_validity_update(&packed_refs->validity, fileno(f));
 
-- 
2.11.0

