Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577F8C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0404C208B6
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="upxoa41G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgIYRDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgIYRDd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 13:03:33 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DADC0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:03:33 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id k133so3103651pgc.7
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7L3LqwtRHDIKGcMDRkyJCjWFjBrxOj8Sqm02sjxnMX0=;
        b=upxoa41GhIdXKK5TXJylbNnj0nWDuLmoW5PKuhAo02/Sv30OIVzjD+xSsLCXRFTQHX
         VawtGr0jnSEzIs1rNbp9VYQonPNACnR9y9PLvmf0hVako9VGBTRaJco4FP0UGEweP8C3
         vqAdZxGm/QFmZblO97C181jZQ2sPIWPczOUhXEcChHZ1evVWKx8F7PnyxxD2VpBfAgLX
         aQYTkCx7HJ6p/ctO4HWb+WQa+gM3UOD/tCkM3NXNRXDFJpqOyrvzV9qqoH3J+HKGOALT
         pmNOFTPRkQMBLu/q8bG0g4mJSTHoZXfrcxU7t7lBxaXJuTIp17YyRZE2w274LApJPR48
         PEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7L3LqwtRHDIKGcMDRkyJCjWFjBrxOj8Sqm02sjxnMX0=;
        b=WlPXk5w/onTN4OEk6LyoJRIuJh5sGKV3b2ewYCFLx8YFyDSZLYIzmp46PclVpuIS7N
         zPv+O4RxfEAo0sWUT+avEAATYjTInpoDLRp54vKgtJ3CuyyHrz/3GcCSFE6cbKes+OB7
         iqAicn4hdgBEud/XBNFhYrAGm02wo52q9AoI9m9EYvwPME4PpX6OuDbdRnxEhOB+UnZB
         zZiGJBb+XE0NbtxCSwmpIHM77YKgSqMYHfds5X5xSL+ePEgJuEZnQi1VuQKhnvaWXGOp
         KRXY1njZ7CVt4LPxSyrnZt9z8Ec9n+ujXpdP+GSTc4SRsxTl50eiAKuU5T9A3WHFLzfH
         I47w==
X-Gm-Message-State: AOAM531Am7MctMU7CqxIIcPoUFyNmMIkaPu+siHF+KMkvs3Y1YcXQoSi
        t+vL/Naz+K+hxlAhXysGrWojMGC/J50DSQ==
X-Google-Smtp-Source: ABdhPJwt1YIooBbIQ8IwvV0i39d6BXeEtZLBMYMh746/AknoWk15TFG6U+k7AziXqyvWBhkTiSfc6A==
X-Received: by 2002:aa7:9730:0:b029:13e:d13d:a091 with SMTP id k16-20020aa797300000b029013ed13da091mr220763pfg.40.1601053412782;
        Fri, 25 Sep 2020 10:03:32 -0700 (PDT)
Received: from localhost.localdomain ([47.9.163.48])
        by smtp.gmail.com with ESMTPSA id k27sm2822467pgm.29.2020.09.25.10.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 10:03:32 -0700 (PDT)
From:   shubham verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Cc:     Shubham Verma <shubhunic@gmail.com>
Subject: [PATCH 08/11] t7001: put each command on a separate line
Date:   Fri, 25 Sep 2020 22:32:53 +0530
Message-Id: <20200925170256.11490-9-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925170256.11490-1-shubhunic@gmail.com>
References: <20200925170256.11490-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Shubham Verma <shubhunic@gmail.com>

Multiple commands on one line  should be split across multiple lines.

Signed-off-by: shubham verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 728a937eeb..94c5b10f8a 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -143,7 +143,9 @@ test_expect_success 'checking the commit' '
 '
 
 test_expect_success 'do not move directory over existing directory' '
-	mkdir path0 && mkdir path0/path2 && test_must_fail git mv path2 path0
+	mkdir path0 &&
+	mkdir path0/path2 &&
+	test_must_fail git mv path2 path0
 '
 
 test_expect_success 'move into "."' '
-- 
2.25.1

