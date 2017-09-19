Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DEF120281
	for <e@80x24.org>; Tue, 19 Sep 2017 06:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbdISGXD (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 02:23:03 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:45145 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751408AbdISGXB (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Sep 2017 02:23:01 -0400
X-AuditID: 12074411-f7dff70000007f0a-dd-59c0b7c32b82
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id E5.50.32522.3C7B0C95; Tue, 19 Sep 2017 02:22:59 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE885.dip0.t-ipconnect.de [84.170.232.133])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8J6MV1i002857
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 19 Sep 2017 02:22:58 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 11/21] mmapped_ref_iterator_advance(): no peeled value for broken refs
Date:   Tue, 19 Sep 2017 08:22:19 +0200
Message-Id: <d34d2cbde67e9ef0b0b11910de19c7f722c2314c.1505799700.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505799700.git.mhagger@alum.mit.edu>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqHtk+4FIg+vtzBZrn91hsni+/gS7
        RdeVbiaLht4rzBb9y7vYLG6vmM9s0T3lLaPFj5YeZovNm9tZHDg9/r7/wOSxc9Zddo8PH+M8
        Fmwq9XjWu4fR4+IlZY/Pm+QC2KO4bFJSczLLUov07RK4MqZPOspacIa94tmPSWwNjD1sXYyc
        HBICJhLTdjczdzFycQgJ7GCS+NDSCOWcYpKYPvsQWBWbgK7Eop5mJhBbREBNYmLbIRaQImaB
        lcwSk7ZeYQVJCAtESix7NBusiEVAVeLq2T52EJtXIEqif95zVoh18hLnHtxmBrE5BSwkmvds
        BxrEAbTNXOLA0eIJjDwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6uVmluilppRuYoSE
        nOAOxhkn5Q4xCnAwKvHwClzbHynEmlhWXJl7iFGSg0lJlDds04FIIb6k/JTKjMTijPii0pzU
        4kOMEhzMSiK8hxYB5XhTEiurUovyYVLSHCxK4rx8S9T9hATSE0tSs1NTC1KLYLIyHBxKEryL
        twE1ChalpqdWpGXmlCCkmTg4QYbzAA0vBqnhLS5IzC3OTIfIn2I05rjx8PofJo6Om3f/MAmx
        5OXnpUqJ894HKRUAKc0ozYObBksbrxjFgZ4T5t0DUsUDTDlw814BrWICWpW9AWxVSSJCSqqB
        kbHjDBvLtZR2oQ1OtvXfuWIPTHSRWi5Yt/HEqc6/StemLlJ8bRMy6Y/3if9CbpwqF2K0uroq
        NrjN2vQmdOPXd5uWM7d8PKjabrH1gl6k2oxbzJxGz1/O/e0WvTZcfNvrPo+d/2vCLacsr+fk
        2s8eph0hq+wflrVmrmGNscjGJ1LTFCfaLVB6oMRSnJFoqMVcVJwIAP6cBD72AgAA
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

