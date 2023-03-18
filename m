Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF7DC7618B
	for <git@archiver.kernel.org>; Sat, 18 Mar 2023 15:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjCRPrL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Mar 2023 11:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCRPrC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2023 11:47:02 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031DF2057A
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 08:46:59 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id cy23so31231294edb.12
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 08:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679154417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+A+b3B3UPCEjSrHXwNe8NmkbubLWcX51P1W/Kdr7Rg=;
        b=VXicQKfdy03FFEJKJ4oxylp4w35rzpAk2Ftsrj5s8YP29s0l3/OjgPfKL9EvGNwVT8
         8tbmHb8sARLIOew9ep13QdJC/BCSMGXrh+a/EFXWdAgrZrXEIe07YtsIlHKe2f355piP
         MjRCjZcrVc1GmeECCH3T+9KoNsaRJ3P25HIc0A3DD2swQrPqba77lPoGAJXAcL5RNtRV
         eR7DlZELzLWe7T+6xc58v4s9S1WVssjLUaseT524ZvQ3w+smGOPBpbl+IIOiq92/lqkH
         7oRQr5mpGLpK1WB/hsqJDtEdWh/ImXlksafpFhpxfDqDOzmWaqNd8pnn8vtaTEGlDCov
         R/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679154417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+A+b3B3UPCEjSrHXwNe8NmkbubLWcX51P1W/Kdr7Rg=;
        b=Ywu+JPCNln1neQKAGwnHm0epnHAEkEuiCqDs4kqHZhLnTnujZcUywp6kSGbP6xMUI/
         FPcP7/Os4wKy7cQT3g1iOKt3h0Hkauad75QSYRuLSK3eSrWSUAYN+1rE73eN9Jsz6mvy
         JPSytWdOSMkYZ0LZ88mmIKxDqciQJZO8RNslIO3eM3aJHvxTsvz+yBDGfQ3x8iMJeHK+
         2f8IvZiwxAa6YDmN9ncXejQQX+wKHNOvxCYINmvFZ0P3jadqISC5vt9YEiIqGQ1pDiZd
         MnlqqgwOQs0XFxomyCXdnI/Bu3LbqvYqtr3L+XC8dz+uCk9TZHoJWqHiGyWKtuLjrhNM
         itwQ==
X-Gm-Message-State: AO0yUKVb2f1VRf4jCsPCu/1bDHmteWi2d0IszRJ/5UmQN5mGTwfGgkKi
        x+IeILey5HMeU0y5REKtXsAOlAzDs8A0LeNPnUo=
X-Google-Smtp-Source: AK7set9PVJZ6rzRKT811/qMgAsGhiMhgP6MgHj1OJ7quTOmXPviVSMKMtE47EhvwMPDOAoFYitKpiw==
X-Received: by 2002:a17:906:160f:b0:931:b2ae:116e with SMTP id m15-20020a170906160f00b00931b2ae116emr3206819ejd.64.1679154417284;
        Sat, 18 Mar 2023 08:46:57 -0700 (PDT)
Received: from titov.fritz.box ([216.24.216.227])
        by smtp.gmail.com with ESMTPSA id ha18-20020a170906a89200b0092be4b381b7sm2271200ejb.81.2023.03.18.08.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 08:46:57 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 5/7] t1400: assert output of update-ref
Date:   Sat, 18 Mar 2023 16:46:44 +0100
Message-Id: <20230318154646.131344-6-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230312201520.370234-1-rybak.a.v@gmail.com>
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t1400-update-ref.sh test 'transaction can create and delete' creates
files "expect" and "actual", but doesn't compare them.  Similarly, test
'transaction cannot restart ongoing transaction' redirects output of
"git update-ref" to file "actual", but doesn't check its contents with
any assertions.

Assert output of "git update-ref" in tests to improve test coverage in
t1400-update-ref.sh.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1400-update-ref.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index cf58cf025c..4d66cd7f4a 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1568,6 +1568,7 @@ test_expect_success 'transaction can create and delete' '
 	EOF
 	git update-ref --stdin <stdin >actual &&
 	printf "%s: ok\n" start commit start commit >expect &&
+	test_cmp expect actual &&
 	test_must_fail git show-ref --verify refs/heads/create-and-delete
 '
 
@@ -1595,6 +1596,8 @@ test_expect_success 'transaction cannot restart ongoing transaction' '
 	commit
 	EOF
 	test_must_fail git update-ref --stdin <stdin >actual &&
+	printf "%s: ok\n" start >expect &&
+	test_cmp expect actual &&
 	test_must_fail git show-ref --verify refs/heads/restart
 '
 
-- 
2.40.0

