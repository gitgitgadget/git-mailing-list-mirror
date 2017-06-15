Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45BED20D1C
	for <e@80x24.org>; Thu, 15 Jun 2017 23:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbdFOXQR (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 19:16:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35358 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752424AbdFOXQM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 19:16:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id d64so2095629wmf.2
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 16:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=4p4efuw0HJBRfqr5NuoS3iwSLOSeYT0vTkBfrYuD5xg=;
        b=Zc8I15q+wkfiIDDrV2BgOH0l8D2le25APzB+y3zxa5II2ouTwAvvjdVE8l7EHTULGY
         h3EGYbmM4aNssFHWPyCQUABpzq7GS/Auch2QprnaRsclVj8HPQjdOhPwtPkaEEymHmMg
         ekjVmEQlvJAn81TjvXOXm/R5c7/a63iKEBoOL1LsSlXzjwgMMbZu2gwrSvyTCM+JL19x
         li0JThUc3wq2Zu1cenBIiqiWEl6LRN6/4xJ5lMFDCXILqZq7+UoReodErFzPlXGMWIEd
         /LI5R3dE6pDQS+28DKTIWElfNYgrruWsdFvPnbNIsy0s0kIFiBX3gFdHKXytjuhzEp5T
         TwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4p4efuw0HJBRfqr5NuoS3iwSLOSeYT0vTkBfrYuD5xg=;
        b=t/1qIMk+3UE8SMNUVoNyXIon/Cc8mSKXnifH3BSIj1uAc7haOoPaDYD+RxZXpUu2oE
         8cWpMRZmhvJIbDU68Atg8dMGqHZGZ+fjhK/KBqxK/vSlRUTwHUNQjEXNim3w7gLZNVSW
         csE9sBdD0l+jcB5llJG/YTWQA7gBdrmWN0r4bPf56bOzc3LDLB/FLBbhoSN8eS2b+2wL
         7qrrUoK6ebbTdWGyra1DIPLD5w/BIgdEkmK1jTSnSxyGq425xSvliA8tF+m8WRUuEblc
         O/ehLB/1YDHEcsPIMTHxArSSVcFdzddWcnA9kqI8Drq65BSGcVqTy3N4Eg/XcR6KHWPm
         Ui2w==
X-Gm-Message-State: AKS2vOxO8z839BD4R1xWMQN7IlurK3/LFVDAd3bi/Gn+xJEGti/xj1US
        yZwWk1qdjDJtxzBNz/o=
X-Received: by 10.80.184.24 with SMTP id j24mr5016315ede.176.1497568569849;
        Thu, 15 Jun 2017 16:16:09 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o15sm305130edo.68.2017.06.15.16.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2017 16:16:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/6] coccinelle: add a rule to make "expression" code use FREE_AND_NULL()
Date:   Thu, 15 Jun 2017 23:15:47 +0000
Message-Id: <20170615231549.20085-5-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc
In-Reply-To: <20170615231549.20085-1-avarab@gmail.com>
References: <20170615231549.20085-1-avarab@gmail.com>
In-Reply-To: <xmqqa858zzb3.fsf@gitster.mtv.corp.google.com>
References: <xmqqa858zzb3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A follow-up to the existing "type" rule added in an earlier
change. This catches some occurrences that are missed by the previous
rule.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/coccinelle/free.cocci | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contrib/coccinelle/free.cocci b/contrib/coccinelle/free.cocci
index 35fb992621..f2d97e755b 100644
--- a/contrib/coccinelle/free.cocci
+++ b/contrib/coccinelle/free.cocci
@@ -17,3 +17,10 @@ T *ptr;
 - free(ptr);
 - ptr = NULL;
 + FREE_AND_NULL(ptr);
+
+@@
+expression E;
+@@
+- free(E);
+- E = NULL;
++ FREE_AND_NULL(E);
-- 
2.13.1.508.gb3defc5cc

