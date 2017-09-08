Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22B912082D
	for <e@80x24.org>; Fri,  8 Sep 2017 13:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754260AbdIHNwM (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 09:52:12 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:60513 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752923AbdIHNwH (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Sep 2017 09:52:07 -0400
X-AuditID: 1207440e-bf9ff70000007085-2a-59b2a086a4b7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id F4.B1.28805.680A2B95; Fri,  8 Sep 2017 09:52:06 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAEECC.dip0.t-ipconnect.de [84.170.238.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v88Dpvjt002844
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 8 Sep 2017 09:52:04 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 02/11] struct ref_transaction: add a place for backends to store data
Date:   Fri,  8 Sep 2017 15:51:44 +0200
Message-Id: <196665b10584f1865d66d75f0b2d77a8a6416783.1504877858.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1504877858.git.mhagger@alum.mit.edu>
References: <cover.1504877858.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsUixO6iqNu2YFOkwaUTQhZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHs969zB6
        XLyk7PF5k1wAWxSXTUpqTmZZapG+XQJXxt/tPgXzWCqOPGhkaWDcydzFyMkhIWAicezpb/Yu
        Ri4OIYEdTBILrx5hhHBOMkls+XmVFaSKTUBXYlFPMxOILSKgJjGx7RALSBGzwFMmiZ0n74IV
        CQtESKy6vRbMZhFQlfjaMZ8NxOYViJI4+XA/I8Q6eYlzD26DreYUsJB49W8NWI2QgLnE1d2T
        WCcw8ixgZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGusl5tZopeaUrqJERJgfDsY29fLHGIU
        4GBU4uG1CN4YKcSaWFZcmXuIUZKDSUmUV6ZnU6QQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEV7z
        WUA53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IEb8B8oEbBotT01Iq0
        zJwShDQTByfIcB6g4RtBaniLCxJzizPTIfKnGI05bjy8/oeJo+Pm3T9MQix5+XmpUuK8bfOA
        SgVASjNK8+CmwZLEK0ZxoOeEeQ1ABvIAEwzcvFdAq5iAVpU83wCyqiQRISXVwCh0JljgSeuN
        le/Wf95VHeqXuk1v6uvHOlUh8b3BH7UPt/Iwis2anudkumL5YnWFi5nZh/32z8s7oWruLzv9
        343DNnmqS5Yu9vt+1FP/wbdltyIvfHjCuFrvvNrxNr4vZrFnhF9b5V4Xcubfr1/bnieSn74o
        kHsX61mbY48KJ55QYXs9o3eVo50SS3FGoqEWc1FxIgDX2Az07QIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`packed_ref_store` is going to want to store some transaction-wide
data, so make a place for it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/refs-internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index b02dc5a7e3..d7d344de73 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -242,6 +242,7 @@ struct ref_transaction {
 	size_t alloc;
 	size_t nr;
 	enum ref_transaction_state state;
+	void *backend_data;
 };
 
 /*
-- 
2.14.1

