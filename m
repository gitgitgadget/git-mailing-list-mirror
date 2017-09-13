Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EC2220286
	for <e@80x24.org>; Wed, 13 Sep 2017 17:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751431AbdIMRQx (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:16:53 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:59507 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751279AbdIMRQq (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Sep 2017 13:16:46 -0400
X-AuditID: 12074412-1e5ff7000000748d-8d-59b967fdb4e1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id E4.27.29837.DF769B95; Wed, 13 Sep 2017 13:16:45 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC855.dip0.t-ipconnect.de [87.188.200.85])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8DHGIiZ001379
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 13 Sep 2017 13:16:43 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/20] mmapped_ref_iterator_advance(): no peeled value for broken refs
Date:   Wed, 13 Sep 2017 19:16:05 +0200
Message-Id: <d34d2cbde67e9ef0b0b11910de19c7f722c2314c.1505319366.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505319366.git.mhagger@alum.mit.edu>
References: <cover.1505319366.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqPs3fWekQfc2Xou1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj2e9exg9
        Ll5S9vi8SS6ALYrLJiU1J7MstUjfLoErY/qko6wFZ9grnv2YxNbA2MPWxcjJISFgInHn3xqm
        LkYuDiGBHUwSny5/YYRwTjJJTFh/FayKTUBXYlFPMxOILSKgJjGx7RALSBGzwFMmiZ0n77KC
        JIQFwiTuthxjBrFZBFQlzh+7yghi8wpESTTcu8IOsU5e4tyD22A1nAIWEht3PAGrERIwl2ic
        s5NxAiPPAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Znq5mSV6qSmlmxghISa0g3H9SblD
        jAIcjEo8vA8sd0YKsSaWFVfmHmKU5GBSEuXdqwsU4kvKT6nMSCzOiC8qzUktPsQowcGsJMIb
        FAWU401JrKxKLcqHSUlzsCiJ8/5crO4nJJCeWJKanZpakFoEk5Xh4FCS4HUCxpKQYFFqempF
        WmZOCUKaiYMTZDgP0PALaSDDiwsSc4sz0yHypxiNOW48vP6HiaPj5t0/TEIsefl5qVLivH9T
        gUoFQEozSvPgpsHSxCtGcaDnhHlZQJbyAFMM3LxXQKuYgFadOb0DZFVJIkJKqoGx1TrZdUXu
        Tc9XUq2RC/8wrp00OT0oW/V32QmVk6m/TsyVtU4u2nigdqtmMNfSaebSb9hXbTs08/vsScX3
        1rDLz/MLndtqOtdo12JL4c8X4uJ/8cZZ8rJOX/e+7EDl+9KwvVwBTzgVwl5NnbnDdsOvmTsz
        zSa0fQt90WpfxWfE4XhVTfuAapKhEktxRqKhFnNRcSIAdKwueu4CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a reference is broken, suppress its peeled value.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 312116a99d..724c88631d 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -234,9 +234,15 @@ static int mmapped_ref_iterator_advance(struct ref_iterator *ref_iterator)
 
 		/*
 		 * Regardless of what the file header said, we
-		 * definitely know the value of *this* reference:
+		 * definitely know the value of *this* reference. But
+		 * we suppress it if the reference is broken:
 		 */
-		iter->base.flags |= REF_KNOWS_PEELED;
+		if ((iter->base.flags & REF_ISBROKEN)) {
+			oidclr(&iter->peeled);
+			iter->base.flags &= ~REF_KNOWS_PEELED;
+		} else {
+			iter->base.flags |= REF_KNOWS_PEELED;
+		}
 	} else {
 		oidclr(&iter->peeled);
 	}
-- 
2.14.1

