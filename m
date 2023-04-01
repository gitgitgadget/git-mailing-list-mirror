Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB917C77B6E
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 21:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjDAV3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 17:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjDAV3H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 17:29:07 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FB1A26A
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 14:29:07 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso17515153wms.1
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 14:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680384545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPA6VephNu4ae9tYi/0aHGAe7CNAeibjD4ifce3lHUg=;
        b=kk3teSVZPWiIVX2xSPVMH4p2juVQgA2138L1TwdMhtaMf/AbuDUS/Fa+EgHFhQKV8V
         UgqahSAdtF5qaCJakHTNzIT0wjwket+998L4uR+oMsfRppq6q608U5NFLAeB5u9QIHKa
         R2Bb0PWidUjaV4xGpLzeDl1Fi+z4d64JPiWPmogMx6HFnhWmfTcRKoNw3ABNd0COB4mv
         iQUTYXPdWTaqWdbQlNmsDtVLoN+aVQ+bE/PHgEynzl3awd3Bgj3ax+gmpIGcxPC9EFFw
         NPO0QaFDbGe1LlQ/LVnymTAJLpjHx2CiJS1FL9QcWTDdUn7rNkLIFXs/wr2PM3RFabxf
         v3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680384545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPA6VephNu4ae9tYi/0aHGAe7CNAeibjD4ifce3lHUg=;
        b=Hdxp/SfLXgPbzsniXJ+SjxU6vGVVU5+l4wTnSbcPavTiZbjxLQNlIOSRqIKJt3fUhX
         y+I4CpJTpep46+uBUkdQo0dpjTdJTopchCRry7e0y+0jZtLcIRRiKkrikWaFYSGK1KUv
         e7lYp6Brevz3J5zOuOUq9sM4oEJ4a1caQeh2tr/8twAEArBMPuGvfKlvsgGbY9LvP0Ay
         iXyBzsG2yJzvHHzEkLVq/6AKX4CoPqVYToVCfmp8MyWFfk8MqAsP6qmZR26yy6Dq9AQx
         h1uwBCInRx1xqJnvPElh+jyZ/UGI66efusO+vnzYgHtrlpLztLooXwaPRZ5YsH4FfJ27
         8naw==
X-Gm-Message-State: AAQBX9fKL2E+I6UYSz4OK2p/XlSPpIyaCQ+dhp0EnLp4+N6aBACOF/kq
        kN7bTPmzq1AhFUpV6uPth4VS0suFbmMtw3/o
X-Google-Smtp-Source: AKy350ZxYbkYAfps72rvqE9NJDp9giR7xgfHaSyVjiQs/EnRXOcyxu45OYiTT85Joey/wmkowcKyGg==
X-Received: by 2002:a7b:c001:0:b0:3f0:3d41:bda3 with SMTP id c1-20020a7bc001000000b003f03d41bda3mr6100343wmb.5.1680384545189;
        Sat, 01 Apr 2023 14:29:05 -0700 (PDT)
Received: from titov.fritz.box ([212.102.57.24])
        by smtp.gmail.com with ESMTPSA id i12-20020a5d55cc000000b002c3f81c51b6sm5738364wrw.90.2023.04.01.14.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 14:29:04 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Martin Stenberg <martin@gnutiken.se>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v1 6/6] t2019: don't create unused files
Date:   Sat,  1 Apr 2023 23:28:58 +0200
Message-Id: <20230401212858.266508-7-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230401212858.266508-1-rybak.a.v@gmail.com>
References: <20230401212858.266508-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests in t2019-checkout-ambiguous-ref.sh redirect two invocations of
"git checkout" to files "stdout" and "stderr".  Several assertions are
made using file "stderr".  File "stdout", however, is unused.

Don't redirect standard output of "git checkout" to file "stdout" in
t2019-checkout-ambiguous-ref.sh to avoid creating unnecessary files.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t2019-checkout-ambiguous-ref.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t2019-checkout-ambiguous-ref.sh b/t/t2019-checkout-ambiguous-ref.sh
index 2c8c926b4d..9540588664 100755
--- a/t/t2019-checkout-ambiguous-ref.sh
+++ b/t/t2019-checkout-ambiguous-ref.sh
@@ -16,7 +16,7 @@ test_expect_success 'setup ambiguous refs' '
 '
 
 test_expect_success 'checkout ambiguous ref succeeds' '
-	git checkout ambiguity >stdout 2>stderr
+	git checkout ambiguity 2>stderr
 '
 
 test_expect_success 'checkout produces ambiguity warning' '
@@ -37,7 +37,7 @@ test_expect_success 'checkout reports switch to branch' '
 '
 
 test_expect_success 'checkout vague ref succeeds' '
-	git checkout vagueness >stdout 2>stderr &&
+	git checkout vagueness 2>stderr &&
 	test_set_prereq VAGUENESS_SUCCESS
 '
 
-- 
2.40.0

