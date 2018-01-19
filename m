Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 317F21F404
	for <e@80x24.org>; Fri, 19 Jan 2018 17:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932512AbeASReV (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 12:34:21 -0500
Received: from sonic307-6.consmr.mail.bf2.yahoo.com ([74.6.134.45]:42727 "EHLO
        sonic307-6.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932393AbeASReU (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jan 2018 12:34:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1516383259; bh=Xa0MGJV891wHWHcfpG4IOBWcT5rhKEUSwxw2HjfWPh4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=PtDPR3mzB8jMTQe1BWuoBg+8y9VajANGaTVVBAAmKGWYQbuqcQXlE39kvzeX543EOerrN9bIJfa02stxaqSrcX0Gz68g0DInRGvbSjdsd+RZibI39V7qc/Don3245YNY1abkFphgbaPBkyB0GHyxSKzO4+1m/x/WPf39YSVc4i9Iz0Y8W5WICAtpiLdDSv9coTN0ltTeRqMDL3WZUA6gx05hV3zbs8mtHN7bdVdIrURSUtTr6SZi05if9jApTm+QoPjQoTOzkHW6UFpdV1MMFdj89b69neFv24CI5KEgw8+KuqC2YxZtVwVIo3ZT5vFjHpahnh2nz+s095pGdB6Ovw==
X-YMail-OSG: dQ8iJWMVM1lFw9R9eZoJ1P5I84SIwmtMD4mMdsL2ucKFD4zj3UBBLh_gJnn_iFe
 vDUUKlN3BFiZWZeYEVbp9_t7gqUfk4kcX4Zb79_KtyjUENHLdUWNgN0Mdka9LxaJ2YZr.vEFuxx9
 KRe1RdHArXwUnAaTZO3nkVXzq4pSkzylG3LL3KTyBBEP6fKnAN7Ms2b_dGmqhq0dX3jaj_zO9Hb1
 3X2wve.n3fOKBgkF0PcQTXwPXUWTCaTvSzoaCaDfS_d89d1Gpnj5nRBNBGmkragsmTxm4pMKKRr9
 Qfm1waolMC2yrI8IkQnejBuB513A2jx2SnrEWoUENGYd9B2KRj7bQAxGfQDtpa.iIlw8CZP6KhkP
 ejqagA.BUNBCQRATNs2I6MoOKTHmXSpEm6haG5Ue.SZ1vfxMb4fmdmc5mFmCIWAnHmRvkg9VZayw
 6lEwSJRcxj3UAH8zcrtSvkO9QImrH1flHHn.U5vm5nMxg0Q.nPIBs02lJfbIBfEFZKlBhlaeO4zb
 y.iQO3zN0LWUOvaH5gJHGEp.eqSu8OBTMe1lneHOZqq3Tv01oxg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Jan 2018 17:34:19 +0000
Received: from smtpgate102.mail.bf1.yahoo.com (EHLO localhost.localdomain) ([72.30.28.113])
          by smtp406.mail.bf1.yahoo.com (JAMES SMTP Server ) with ESMTPA ID e78d06b6c08cf8709c5b5470ad5cf24d;
          Fri, 19 Jan 2018 17:34:19 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v2 1/6] Bypass GCC attributes on NonStop platform where used.
Date:   Fri, 19 Jan 2018 12:34:01 -0500
Message-Id: <20180119173406.13324-3-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180119173406.13324-1-randall.s.becker@rogers.com>
References: <20180119173406.13324-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

* remote.c: force ignoring of GCC __attribute construct not supported
  by c99 by defining it as an empty CPP macro.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 remote.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/remote.c b/remote.c
index 4e93753e1..c18f9de7f 100644
--- a/remote.c
+++ b/remote.c
@@ -11,6 +11,10 @@
 #include "mergesort.h"
 #include "argv-array.h"
 
+#if defined (__TANDEM)
+#define __attribute(a)
+#endif
+
 enum map_direction { FROM_SRC, FROM_DST };
 
 static struct refspec s_tag_refspec = {
-- 
2.16.0.31.gf1a482c

