Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90EDE201A7
	for <e@80x24.org>; Wed, 17 May 2017 12:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753814AbdEQMGl (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:06:41 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:55133 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753620AbdEQMGc (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 08:06:32 -0400
X-AuditID: 12074413-0c9ff70000001dc3-f9-591c3cc71c4d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id CE.8E.07619.7CC3C195; Wed, 17 May 2017 08:06:31 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HC5pgA000430
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 08:06:29 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 19/23] read_packed_refs(): report unexpected fopen() failures
Date:   Wed, 17 May 2017 14:05:42 +0200
Message-Id: <5d13d0f0e0a63430a9bf2889e9a9e911382170de.1495014840.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsUixO6iqHvcRibS4P4ybYu1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfGk43bmAp6uCrWfWpgamDs4Ohi5OSQEDCR
        mDLtMWMXIxeHkMAOJomt9/cwQTgnmCQ+Xm5iBaliE9CVWNTTzARiiwioSUxsO8QCUsQs8JhJ
        4u+ybhaQhLCAr8TTti9gRSwCqhIP23YBxTk4eAWiJCbcKYPYJi+xq+0i2ExOAQuJ++8fsYOU
        CAmYS2y/XjmBkWcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1zvdzMEr3UlNJNjJBAE97B
        uOuk3CFGAQ5GJR7eCVzSkUKsiWXFlbmHGCU5mJREefc/AArxJeWnVGYkFmfEF5XmpBYfYpTg
        YFYS4b1pKhMpxJuSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4BWyBmoU
        LEpNT61Iy8wpQUgzcXCCDOcBGs4FUsNbXJCYW5yZDpE/xagoJc4bawWUEABJZJTmwfXCEsEr
        RnGgV4R5V4O08wCTCFz3K6DBTECDm0E+4i0uSURISTUwqk6fKytiIRv41P7VMY+l2+U8w9K1
        7gfNrpyT+bpGPdhHWHUzn3hwaNDynC0yH+ReT8l8m6AWLuHTtWvPOZ+/ZbFSn2a8a3/WvfOv
        EvOPM0um8Yq18Uv6n7ty+eKW11duLvV9nftyr6/0GkfeT4YRDWvbje7WfDl/VvKuWnyBzpuF
        M4LfydjyKrEUZyQaajEXFScCAA7hLgrfAgAA
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
 refs/files-backend.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6a037e1d61..eb74d1119a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -263,8 +263,19 @@ static struct packed_ref_cache *read_packed_refs(const char *packed_refs_file)
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
+			die("couldn't read %s: %s",
+			    packed_refs_file, strerror(errno));
+		}
+	}
 
 	stat_validity_update(&packed_refs->validity, fileno(f));
 
-- 
2.11.0

