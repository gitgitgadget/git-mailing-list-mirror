Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1939EC54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 05:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiITFHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 01:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiITFHr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 01:07:47 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6F75A81B
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 22:07:45 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id q83so1333298iod.7
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 22:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=jayauuH6TCa9eCBqibMrhTXnWrNVyVmatjiX9d3baLM=;
        b=TxH9syDgB0OA4tQmL4RObBL0/t/igxQBZPrDoX7CheiMOGY1fP5Lv3TdFkkDXfwtNR
         v7JefaHCFzg7Fa8s+jiUSHbWkJ1b3utVBXOzY1scqAxSNMvokjPgjTpAdeK5nZ36tHSn
         D+IpjgyMIOX/PlykScqir2t79TpBHRbpkE8NTdiV2OfuWZHl2qAWzguuuLrQ4VIqs8EO
         ZAhE38F1uouQefyEniNxwlgM54Qe1SVDLIA5Dd4XJ4Y0z57APUvznwfwi7cMSERN18kd
         QyfPOfDvkE0omUpzyjc6urSz1pOboPkF1QNP3/vZ/liqDy43yDxv8vubxMb1BAgv+I42
         9DEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=jayauuH6TCa9eCBqibMrhTXnWrNVyVmatjiX9d3baLM=;
        b=lOt2Cob8Tjv7MoKF4L8Y4Ds/QILeRFcZPu7zMrOFWtsgBGONhQPP311SrtEAyW44bC
         SrVpZfaLMe5pS4IAGvx+uaif78NaFD4CQIAefSK6io9S1LjVwM9t1zG45t78iTyhksV6
         m4CXh7jf1n6ncCL2ZUw4C7l6jJgkqSKaMrlUVonQRonRBQDRCt09WsUSOu3YJWkvx+dZ
         TIxPvK0I9HWX41KvAGtC2FGZi02j1t8IeRFHIi8Ls4CaZo3T14w2jI7R0FhoQLrpdEJv
         EjMqGaqFUPD1hygzbL+VVzbLOnn3CI8I5kP6Z//BZ0rt3tS7HOpTc4SAuopsFLn8Z6JT
         MZ1Q==
X-Gm-Message-State: ACrzQf0841+5cyy7hOdmHmxll6cZGeMKDkJNmPXkrPsAx+jV52cuEzyI
        GFI9R5NbpODWjKDn6saA5eJvAf0cgbc=
X-Google-Smtp-Source: AMsMyM78W6o+IQMEuAksyOnTdh9/WvU2338Ypi5hNcKdI8BM9CDZoZIc2ud8kPcW2lqXyDBuOBK5CQ==
X-Received: by 2002:a05:6638:2056:b0:35a:d11a:e814 with SMTP id t22-20020a056638205600b0035ad11ae814mr4032314jaj.44.1663650464219;
        Mon, 19 Sep 2022 22:07:44 -0700 (PDT)
Received: from xavier.localdomain (75-169-34-129.slkc.qwest.net. [75.169.34.129])
        by smtp.gmail.com with ESMTPSA id w28-20020a056638379c00b0034c14a6ea76sm263766jal.51.2022.09.19.22.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 22:07:43 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] gc: don't translate literal commands
Date:   Mon, 19 Sep 2022 23:07:25 -0600
Message-Id: <20220920050725.326383-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These commands have no placeholders to be translated.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/gc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 0accc02406..2753bd15a5 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1461,7 +1461,7 @@ static char *get_maintpath(void)
 }
 
 static char const * const builtin_maintenance_register_usage[] = {
-	N_("git maintenance register"),
+	"git maintenance register",
 	NULL
 };
 
@@ -1519,7 +1519,7 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 }
 
 static char const * const builtin_maintenance_unregister_usage[] = {
-	N_("git maintenance unregister"),
+	"git maintenance unregister",
 	NULL
 };
 
@@ -2542,7 +2542,7 @@ static int maintenance_start(int argc, const char **argv, const char *prefix)
 }
 
 static const char *const builtin_maintenance_stop_usage[] = {
-	N_("git maintenance stop"),
+	"git maintenance stop",
 	NULL
 };
 
-- 
2.37.3

