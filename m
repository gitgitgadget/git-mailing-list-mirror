Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68613C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 07:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 124482078B
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 07:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTKd1doC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgIJHdF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbgIJHcn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 03:32:43 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E6DC061756
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 00:32:43 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id o20so4110276pfp.11
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 00:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y6rcRpyp6oEtNjMcJ5TzPBWNEijRXeIaMMkmND3iSGo=;
        b=KTKd1doCeACEtINOh91wmIwGs32V9IRgNhTw7nwNcjt7UGSghwwsSFMMaSRAttZjP5
         tdFJW8Aju9Gwkhn9e+ku2BXBRWdleqEx61PANS82+ntO+QfybZ5Xa8VfY/fUltJMi6hp
         6M5JWYw+RXod9SI5fwROW/naUlLrkhap04fLrp8L5LnHeRfpFEOR1OCrqCAXiYBtFmJl
         FGHRVKaYLu/SRdL6F6rYVjoasS3Shejr2cBC4/XvWNVx8YWwAZa4AyRKGavg35E1u8WZ
         k5p41hpZnsmPyFe1xMlU2Ceo9sGOAX0qfxq7GBA/B+WkwHxPjBlIhNF8ufXBkNM0uXu0
         Z7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y6rcRpyp6oEtNjMcJ5TzPBWNEijRXeIaMMkmND3iSGo=;
        b=QQQVBKVBP8TpODpZ37i9am1U5w0zVtC6rX9kJMJSR4QJzqOI2rOhIrxgRr+9Ct7pvy
         D04quPspGCdtC7QHuoojCV8elaeXElVmNazdp7uGHmB/5NNX7gmDMQrrMvfd57WWDTym
         tj152/kz7v3rOGG5vnkZbweWEOrjRD2AG8JhkHVyYZI6gaA3/Li/MPCt0jOX8+jh5dRq
         W5BViG03jXCicnFoxMWk6tu59DLH24SjYcuwYMy75L64MEv7U8Sz57qfhJE3NSCo33Tz
         yCcXIcvd9AXgMlmOMhOaPdlOouT7hd2xRnstENOZvgvPPL1I6oSrXlVoJhElNQ01XeE5
         NYuQ==
X-Gm-Message-State: AOAM533nvgjVeCEN/8GAUSwBXG/UBBq9kNkn/TxJHxX5dagD4UhN33D+
        gTKgLiX8GhLgoz+nrGSfjpCxi9J8U38=
X-Google-Smtp-Source: ABdhPJydQ+3f84fFACIHtjgsxMZiXTTxN++nR9X0xWSCKlYUi4jRf68uOq2l9kFV1wMoRZe5sIGbjg==
X-Received: by 2002:a62:7c82:0:b029:13c:1611:6525 with SMTP id x124-20020a627c820000b029013c16116525mr4366954pfc.5.1599723162420;
        Thu, 10 Sep 2020 00:32:42 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:5900:d670::1ab5])
        by smtp.gmail.com with ESMTPSA id q127sm4990550pfb.61.2020.09.10.00.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 00:32:41 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] t4068: remove unnecessary >tmp
Date:   Thu, 10 Sep 2020 00:32:17 -0700
Message-Id: <80e9066a59524ededbb0d0191a93e6e3154c5623.1599723087.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <cover.1599723087.git.liu.denton@gmail.com>
References: <cover.1599332861.git.liu.denton@gmail.com> <cover.1599723087.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The many `git diff` invocations have a `>tmp` redirection even though
the file is not being used afterwards. Remove these unnecessary
redirections.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4068-diff-symmetric.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t4068-diff-symmetric.sh b/t/t4068-diff-symmetric.sh
index 31d17a5af0..60c506c2b2 100755
--- a/t/t4068-diff-symmetric.sh
+++ b/t/t4068-diff-symmetric.sh
@@ -64,27 +64,27 @@ test_expect_success 'diff with two merge bases' '
 '
 
 test_expect_success 'diff with no merge bases' '
-	test_must_fail git diff br2...br3 >tmp 2>err &&
+	test_must_fail git diff br2...br3 2>err &&
 	test_i18ngrep "fatal: br2...br3: no merge base" err
 '
 
 test_expect_success 'diff with too many symmetric differences' '
-	test_must_fail git diff br1...master br2...br3 >tmp 2>err &&
+	test_must_fail git diff br1...master br2...br3 2>err &&
 	test_i18ngrep "usage" err
 '
 
 test_expect_success 'diff with symmetric difference and extraneous arg' '
-	test_must_fail git diff master br1...master >tmp 2>err &&
+	test_must_fail git diff master br1...master 2>err &&
 	test_i18ngrep "usage" err
 '
 
 test_expect_success 'diff with two ranges' '
-	test_must_fail git diff master br1..master br2..br3 >tmp 2>err &&
+	test_must_fail git diff master br1..master br2..br3 2>err &&
 	test_i18ngrep "usage" err
 '
 
 test_expect_success 'diff with ranges and extra arg' '
-	test_must_fail git diff master br1..master commit-D >tmp 2>err &&
+	test_must_fail git diff master br1..master commit-D 2>err &&
 	test_i18ngrep "usage" err
 '
 
-- 
2.28.0.618.gf4bc123cb7

