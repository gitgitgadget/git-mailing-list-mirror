Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFB7C6FA99
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 20:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjCLUQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 16:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjCLUQK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 16:16:10 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56672BEEE
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:15:35 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id da10so40920860edb.3
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678652134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQExbRQZKm3tG9C0lSv5cVADHSsXEU7dJ1PmSdH9dJ0=;
        b=nIKyCROu8DCoaIISmzO27Tsm9TKzxRtjQiRxCxqG6F5pcpMbzHAKabIs3kBoN6+jOo
         SC/NwB3mf0GFANJTXbXnVtRInk4oxchlXgmc7RE4AVRiMBYlEWY8fK4UhPxkSVB3BO6G
         Z9WJW5+0bRf34Xd78Me8dH5xPA8ugY+dcWODi1MYco1MjvlU8blscf1QUms+7wc4TITi
         xeQbiKzQSn3vB8iekFo/GFCz1e+TBAUSWQG2H81ocw5EaE6ByWLl5adDY4+4OCDuHDSW
         LLPVpt1QsBmiVQiOgOZ49OB5xBxS7gd+Pwa6fVIBWF0wk22sF4QnNid6QZNsUTkcSLiY
         6L9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678652134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQExbRQZKm3tG9C0lSv5cVADHSsXEU7dJ1PmSdH9dJ0=;
        b=TfqzMF1q0mRXC2egkjbNrrA96J/NxsC9lodOqbT9An9ZOqLaVXsJD41ALlRk0tacoM
         L4BsA3W7DcNwswovyC3tux2+rTwzJbQ20U4GLMvAhX0NHCpJQDsnOTXqWGVfX8qtCaQz
         ao+CbNLmSWV2Qm4MDhaaOHkhE0x7PaWO+6vE0KGByKd6d5D/jzeqFEWT08qgXw9CbNB6
         b28WCGIIQkBB2+A3G39G70m1dDrSmOrUX/lV1C9SVDYbMDK2zvxazR8BJimA606ILaoC
         yKnvaZXPjrLMHPOwossmz5c8q4csjcA4eZU+PWUPjWhsmCplKX4icOb/9VOyftOrtQ9X
         TPWQ==
X-Gm-Message-State: AO0yUKUndQr84L027cGrs7DtQAPHS0p5Cs0+vL+iOU6SCWeDlnkmO/bI
        m7UE6uexAjVNqdPoYgDDiyL7qKILdyzL0w==
X-Google-Smtp-Source: AK7set8nFFj+NCU+MxMJ7gujFzeufKgD52fRtFDZFznRJhfNQZDsYsNTswQaepDE8zi83AzWdHI2wQ==
X-Received: by 2002:a17:907:8a0c:b0:8b1:800b:d2e9 with SMTP id sc12-20020a1709078a0c00b008b1800bd2e9mr39715222ejc.56.1678652134060;
        Sun, 12 Mar 2023 13:15:34 -0700 (PDT)
Received: from titov.fritz.box ([216.24.216.227])
        by smtp.gmail.com with ESMTPSA id hz17-20020a1709072cf100b008dceec0fd4csm2570344ejc.73.2023.03.12.13.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:15:33 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v1 6/7] t1404: don't create unused file
Date:   Sun, 12 Mar 2023 21:15:19 +0100
Message-Id: <20230312201520.370234-8-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312201520.370234-1-rybak.a.v@gmail.com>
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some tests in file t1404-update-ref-errors.sh create file "unchanged" as
the expected side for a test_cmp assertion at the end of the test for
output of "git for-each-ref".  The filename conveys the expectation that
the output won't change between two invocations of "git for-each-ref".

Test 'no bogus intermediate values during delete' also creates a file
named "unchanged".  However, in this test the reference is being
deleted, i.e. it _does change_.  The file itself isn't used for any
assertions in the test.

Don't create the unused and slightly misleading file "unchanged".

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1404-update-ref-errors.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index b5606d93b5..937ae0d733 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -551,7 +551,6 @@ test_expect_success REFFILES 'no bogus intermediate values during delete' '
 	git update-ref $prefix/foo $C &&
 	git pack-refs --all &&
 	git update-ref $prefix/foo $D &&
-	git for-each-ref $prefix >unchanged &&
 	# Now try to update the reference, but hold the `packed-refs` lock
 	# for a while to see what happens while the process is blocked:
 	: >.git/packed-refs.lock &&
-- 
2.39.2

