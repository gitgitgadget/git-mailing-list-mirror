Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A8DC1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932128AbeGBAZx (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:25:53 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:32779 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752863AbeGBAZD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:25:03 -0400
Received: by mail-it0-f66.google.com with SMTP id k17-v6so7443322ita.0
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ru1pOXIjY29SuLloaSgnMN5ed90fL9OGc9AwBy6otOw=;
        b=T5wq3zFNNUdMOhD6ATzP7eKbpnB+/7akn74Me3KI7InoxGU4COzOOS2n9j/ovSDuy0
         Q0dG479twY4xGO63UDeY0VOa9tw+/POdbwHpGxRDSLbecxuecyo8+h9+5ZkSkEmW2dee
         WLW4IgsepGYLkU4u9YZPk3lrUFlHwICOqi5ClnbsTOFw25xncpHlGvy7FWmPA9/VXB2r
         BE0v+HFweFHQ8IG0nJLlyeoygcVch5GEt03KXKg4BJ49LK7isYlUU1Am5QnJsboLsIzP
         WzyNRiGeqyNBzZ9bkujC2JdV7eGP30oUYJcIK1mSExoWSCbO9hUix9ZGm+a53nHz3aRi
         qdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ru1pOXIjY29SuLloaSgnMN5ed90fL9OGc9AwBy6otOw=;
        b=SZniAXRSKY59rebMeXRTxvosyTs/8keCykTLoiwnXV5z9X7F/Jf+kgymLIcux6/cwH
         NXlXb0cnilGo9QmC+B/lQhdv3ndqpMb3hkNrfuucrq5gJWkrvCTRuZbcy3sLVM+z2ru4
         pHrxQbCsUAtrMYgxq04AhUdC3DyZt1xqtlapQEkZkvJMCVXTzTdds5RnzgedfomytBft
         eLl0XLQNe932EbEGkcc/ujkhRb9zRtCNffhc2MgcU586sCKOp6jj0P2tjcbOn41NWIgq
         I5QOZgGdftoOliJU1jiSXIoRBNH+3ERgufv/+FZBXRByWoVn/o1ll/C/pw9JsWRsNiZr
         CuVg==
X-Gm-Message-State: APt69E1a4f/TIQbngzwNzpFyylSypELwDGcx2kHrEyWrbinRmKLA1nYk
        kBW6hL09+44J10JO2XCtuU2fvA==
X-Google-Smtp-Source: AAOMgpcch6wV86HyOacrzp0W2oDv3gF+jtkBVQudQE59xn6yMrl7oqnYC4MB8vBWeb7Skb2nGx6gYA==
X-Received: by 2002:a24:5a53:: with SMTP id v80-v6mr4518270ita.34.1530491102790;
        Sun, 01 Jul 2018 17:25:02 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.25.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:25:02 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 14/25] t9814: simplify convoluted check that command correctly errors out
Date:   Sun,  1 Jul 2018 20:23:54 -0400
Message-Id: <20180702002405.3042-15-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test uses a convoluted method to verify that "p4 help" errors
out when asked for help about an unknown command. In doing so, it
intentionally breaks the &&-chain. Simplify by employing the typical
"! command" idiom and a normal &&-chain instead.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t9814-git-p4-rename.sh | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index e7e0268e98..60baa06e27 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -9,23 +9,11 @@ test_expect_success 'start p4d' '
 '
 
 # We rely on this behavior to detect for p4 move availability.
-test_expect_success 'p4 help unknown returns 1' '
+test_expect_success '"p4 help unknown" errors out' '
 	(
 		cd "$cli" &&
-		(
-			p4 help client >errs 2>&1
-			echo $? >retval
-		)
-		echo 0 >expected &&
-		test_cmp expected retval &&
-		rm retval &&
-		(
-			p4 help nosuchcommand >errs 2>&1
-			echo $? >retval
-		)
-		echo 1 >expected &&
-		test_cmp expected retval &&
-		rm retval
+		p4 help client &&
+		! p4 help nosuchcommand
 	)
 '
 
-- 
2.18.0.203.gfac676dfb9

