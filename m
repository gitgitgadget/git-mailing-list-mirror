Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF929C74A4B
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 20:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjCLUQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 16:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjCLUQK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 16:16:10 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D112BF06
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:15:36 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y4so11365278edo.2
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678652135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dahJb6X3XDb5sqiV9zJ908D8eprzKYpu55scL5EAGRE=;
        b=Qd3D0WBtBzP6o/flojT8/H67gRQRp2L2zyMPV2B8kEdf+YUgROHXeTy/jbyKva2y7u
         iPQPGtURMFCAtRs8S7ed/mIcKZCuKuIP+dZDk2F4t9mM804DVmWmyX+UtwFHZBoY4oei
         sggdfZeNX0xUjezV+ImGTS1AzuYiZ1mjmJpuS2gobIpVL5Nk07h53c3muUfjDxEDN7SU
         C8laGSA8WLo2XPa/iUlWNcWHaTRXStrlGJXo46JvOAinCfHaig7nkyGnaKeeX4Vkjqe6
         pM56Q7O0U2PFB8yfDjXEvdB3sPuR/vrbmB04D+CmjFI181RPthPD+3v5TNwLUlKu3AUI
         7umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678652135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dahJb6X3XDb5sqiV9zJ908D8eprzKYpu55scL5EAGRE=;
        b=vMqRJVT1tkU/D+Cx7B13hdGy0Up7dr2u0jRHv47WzmjVRvU8dCVlzgqb0aTcoqyVIE
         iqhOoNH+iIFiddaRmQ/0LWbk5hGNAHtVflaPUis51NFL2Jg5/HpIJrHjy4N/aBNHbNTR
         S61gEELWlKirqgFS4kHF0cebG5th89TLWYCr89H5fft1gn8ENU3IGC2ihM5CumgRC4aH
         8SNeSQfi/TyTjmjE2CfXEG98/RNEUoZUpl7g4pri0SxYsQIGOBDtjjwiwoZrGxRdg08p
         Iec9eBk2sWHwBq84ad3P3DDP5gUIFahet1fNWtxMPdj8HqJZqnGyYFUeISc/2tKUIZRH
         M4XQ==
X-Gm-Message-State: AO0yUKXyhC/OPd/07cNWsyfCGOxUfqrziif13+kYSMGpcAWGyVYsdMlI
        stoAIoVcntThPF808qg6mb6v6QZFgrTiqA==
X-Google-Smtp-Source: AK7set/A6twFyWXKsYOoyVDdpoTM9Ly3kL83ZW/MM6p0vif85vyy2poAX7GZY0O+/Oxc3ImTfQX6bw==
X-Received: by 2002:a17:906:6a1f:b0:91f:1e81:89d9 with SMTP id qw31-20020a1709066a1f00b0091f1e8189d9mr6470802ejc.43.1678652135416;
        Sun, 12 Mar 2023 13:15:35 -0700 (PDT)
Received: from titov.fritz.box ([216.24.216.227])
        by smtp.gmail.com with ESMTPSA id hz17-20020a1709072cf100b008dceec0fd4csm2570344ejc.73.2023.03.12.13.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:15:35 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v1 7/7] t1507: assert output of rev-parse
Date:   Sun, 12 Mar 2023 21:15:20 +0100
Message-Id: <20230312201520.370234-9-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312201520.370234-1-rybak.a.v@gmail.com>
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests in t1507-rev-parse-upstream.sh compare files "expect" and "actual"
to assert the output of "git rev-parse", "git show", and "git log".
However, two of the tests '@{reflog}-parsing does not look beyond colon'
and '@{upstream}-parsing does not look beyond colon' don't inspect the
contents of the created files.

Assert output of "git rev-parse" in tests in t1507-rev-parse-upstream.sh
to improve test coverage.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1507-rev-parse-upstream.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index c34714ffe3..4458820168 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -258,7 +258,8 @@ test_expect_success '@{reflog}-parsing does not look beyond colon' '
 	git add @{yesterday} &&
 	git commit -m "funny reflog file" &&
 	git hash-object @{yesterday} >expect &&
-	git rev-parse HEAD:@{yesterday} >actual
+	git rev-parse HEAD:@{yesterday} >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success '@{upstream}-parsing does not look beyond colon' '
@@ -266,7 +267,8 @@ test_expect_success '@{upstream}-parsing does not look beyond colon' '
 	git add @{upstream} &&
 	git commit -m "funny upstream file" &&
 	git hash-object @{upstream} >expect &&
-	git rev-parse HEAD:@{upstream} >actual
+	git rev-parse HEAD:@{upstream} >actual &&
+	test_cmp expect actual
 '
 
 test_done
-- 
2.39.2

