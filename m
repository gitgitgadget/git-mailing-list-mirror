Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAEBC74A4B
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 20:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjCLUQQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 16:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjCLUQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 16:16:09 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51D623DB9
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:15:28 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r15so13634191edq.11
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678652127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dahJb6X3XDb5sqiV9zJ908D8eprzKYpu55scL5EAGRE=;
        b=FLR1GA1KW+HB8CK1w9kYb9JsIbZw5nNaOkfk/K2LlEy69ipHzc/SX0fvSIQr/eUly9
         lWoPwClMe16Sr2OcdoON14AE/aQcOD5Tb3dHtEcwZtsos1me3/D7ykB3ljDsbR26FExI
         AJfTW2KkssNKmxBb1vDag1wYTca9TPKB6xDasZ8OrRH2nkmnfsxAc1bEkUS7+AfoFngn
         SLvMx4cPFiwoC5GE/EhqtBGIpe+MPBKthvDP38Xv7odWXsySU94hqOcoAHTrRC/ELRzk
         l1Rj8CT56dEaXiOV1mZhAoMdjAskcfa5n1fSE4hfeuqPTKIXlDZ5y06z3z+Y0nC9JhEk
         Np8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678652127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dahJb6X3XDb5sqiV9zJ908D8eprzKYpu55scL5EAGRE=;
        b=oTI/3ju5ao9o+ZFxMKniM1QL0TljACP70EUhJCR5bjvru4uIZs7XdpOSBrO3bsdIHt
         2QP+IQQTaKtVl6/Q4Cvk30AzUaIahqycN00wqhSLb0CKYjoJiFHHVUAFn+wgQrisDgOH
         AhBPCbdZZL0zANAkfLtUStOIM2bxb7TQdumHdP1cr6l1va1k+0jyMe0arQrjfb77SRVP
         wA0EStAoirtuwxJTdTOqZxyfXCKwu0UecI1ERM9q3GeAziDdSn9eI17fiPIsnEm7aLRS
         /Fn14S6VK37Mo2ccR7DwIts0FfhlHSQsqPAGvXCpFJXtUay1WfNDtpRONp2w98hdjd2q
         KEvw==
X-Gm-Message-State: AO0yUKUKZqzZZIHa70h0trYeukizpqtnw6OoiExYnyMdPhJajoXNzKV2
        aME2BsS9zuQ6oaRgpwVr5eoa45byMQg=
X-Google-Smtp-Source: AK7set9I0K7si4oOPjUW3/A3WQqWax32RDJdpsYSUN6v/QC8YlsK82DJ+0Y7dygYu0D5BCRdh3zUjw==
X-Received: by 2002:a17:907:a602:b0:8f1:939b:9701 with SMTP id vt2-20020a170907a60200b008f1939b9701mr32861814ejc.66.1678652127246;
        Sun, 12 Mar 2023 13:15:27 -0700 (PDT)
Received: from titov.fritz.box ([216.24.216.227])
        by smtp.gmail.com with ESMTPSA id hz17-20020a1709072cf100b008dceec0fd4csm2570344ejc.73.2023.03.12.13.15.26
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:15:26 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v1 1/1] t1507: assert output of rev-parse
Date:   Sun, 12 Mar 2023 21:15:14 +0100
Message-Id: <20230312201520.370234-3-rybak.a.v@gmail.com>
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

