Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFBFFA373D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 22:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiJYWmb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 18:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiJYWm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 18:42:28 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24C7D7E0D
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 15:42:27 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s196so13006262pgs.3
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 15:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3orJ7gB49ct1er7qxPTy46ynalNvG50lY+chrUSNuew=;
        b=WvlXy++EZoBYXQV5WtpaQODs9QBYWioIqRHU6byVbFJ2c4DeuFuv2m4/kHfqw/K9Hj
         HmP4Ley8qX6tH7OlVn5Rbmy+ies7aMPvsWLgHE1P2JL9XkkvyczetQYu8b6kLbyPAt2T
         d89r9iAfspy3DeY+P6dLWBNjbSp5MRSsQA2p3kP9LHTVRwc6YHY6/z439LVoKUeTPyi4
         iwbdBoMpciRgN8iAcq4nWJUJUfHTvF8jalpBcZRrb+GaifsTk7USjkqwCVFBEXGaVeNB
         C4X9kIi6AOVqgOxw0DV39WgT0GvUR03Z3DDR1jI+6LivL2rda+iA5oAGKlqC3dWnEG2o
         y/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3orJ7gB49ct1er7qxPTy46ynalNvG50lY+chrUSNuew=;
        b=yhBklA596UjgwP3pIa2JrcIamHCRJLpolXQ7t4eyVxI7mNcY1xadDa5qGfuv/NpOMy
         /gRhgh+xhq0d3nSEIjostgLTX+7uEF7f2ufkAiqNll9PxWoUa4DqiAOTVwKCK1rVndi6
         n1TKMoqaidQwIUCCp2UBw6Ah9n+/DtTlu0VW+/Dia1oAr0Tw5CJzsrX8GBkvuyW7R7dd
         Vt4X6fzuPR+/lEcvADCNlvdftZVqZTMY35ACGo2cFiRQapghKHKiMguK/FJhDKPFBmcz
         UJq/nuyNOcy87XaiHU4p8t3GuAzpW8XBhRlnkKrkO2ePh7kBzi/Ui1/gSKseIVIwk0+6
         ULKg==
X-Gm-Message-State: ACrzQf1OLm1KyN+QSI6uVWpQrSq1ZvP3aPXNsc2FbX2eoYCi1xYzol2U
        ZNYBcoKBK/iBG/VP1roMqsGXi+nrgP8=
X-Google-Smtp-Source: AMsMyM5/wEzMh6OzpvVxLCXEg4w806oIRTraY8JwdsaRcOsOC/KMG61SbrmtW+ASp4V9/DSTM9/WEQ==
X-Received: by 2002:a63:5422:0:b0:466:41b5:77d4 with SMTP id i34-20020a635422000000b0046641b577d4mr33630963pgb.547.1666737747256;
        Tue, 25 Oct 2022 15:42:27 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b129-20020a62cf87000000b0056bd59eaef0sm1876513pfg.4.2022.10.25.15.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:42:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
Subject: [PATCH v3 2/4] fsck: remove the unused MISSING_TREE_OBJECT
Date:   Tue, 25 Oct 2022 15:42:22 -0700
Message-Id: <20221025224224.2352979-3-gitster@pobox.com>
X-Mailer: git-send-email 2.38.1-359-g84c4c6d5a5
In-Reply-To: <20221025224224.2352979-1-gitster@pobox.com>
References: <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
 <20221025224224.2352979-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This error type has never been used since it was introduced at
159e7b08 (fsck: detect gitmodules files, 2018-05-02).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fsck.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fsck.h b/fsck.h
index 7d99f6ea33..1d7c38f268 100644
--- a/fsck.h
+++ b/fsck.h
@@ -39,7 +39,6 @@ enum fsck_msg_type {
 	FUNC(MISSING_TAG, ERROR) \
 	FUNC(MISSING_TAG_ENTRY, ERROR) \
 	FUNC(MISSING_TREE, ERROR) \
-	FUNC(MISSING_TREE_OBJECT, ERROR) \
 	FUNC(MISSING_TYPE, ERROR) \
 	FUNC(MISSING_TYPE_ENTRY, ERROR) \
 	FUNC(MULTIPLE_AUTHORS, ERROR) \
-- 
2.38.1-359-g84c4c6d5a5

