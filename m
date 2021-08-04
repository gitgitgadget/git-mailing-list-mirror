Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E03C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0122060EFD
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbhHDXvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 19:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235810AbhHDXvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 19:51:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05752C06179B
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 16:51:02 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m12so4044926wru.12
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 16:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WBURzoXb32xNA6NDmEzg0TyGL6bP5A+Zkc4bSql3u38=;
        b=fh81W1JbgIHAUJhm9Ulz6nXyc67u3ZtFDId179u0JPCGWtnk17ir8OAB7Tgb1CAqoO
         RQghNWdLbeUUqVdY37UCt/40spltlEpjGspv5KGupdsmQEU0d82qx0wNjEpRMyFSPIIM
         y88ogvf8QsGWlITJU5BeHPhqo7nZcJHT6AsjNp0m0sw/vVRNoWRnpePifkxO4Ji4EOs+
         E/heR9dnT2i3qStkiMqq7qF4KftsuIYzjEaZsojt4qDCyOXBRTjdU2+dGhXjLc8WX+bX
         iYDAwZ2tVEOjmlj5tXAoQI7jqjAXbg96AJzK0lQP8JPNewPMzdz4SfEZpyWBBg/2emy4
         wvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WBURzoXb32xNA6NDmEzg0TyGL6bP5A+Zkc4bSql3u38=;
        b=HT0/rYMj++aanZ9hvs05oQRgRrLwXlXedNdptSoh/HKm2tTgoes3PO5LM0KreuL2OE
         F3NHyuXL6Mm2FaQbiX83JB7kQgaPFyGXcMHvphDtOyLFNDYHd+z1DHVQQpyKJhtR8TC1
         kWJPTzthUjSF8UU+oi7Kr5xifVnLjpnHbC3pRCYvPTxuLgXcQLHe2dli6GqOsG60vrAm
         mx3l0dFcABkUR2fgUD+SY3NPxBFyaR6NRGf7PBBl56Q1OUQtUx89Os7JmtzWM7pf/L1u
         //M0jBOuQWcBIgwcCxRWT56nBvDKy3cmK3n3lV+PFHIEYm1qVP4+9Me3UAoj/olpzODo
         XPNA==
X-Gm-Message-State: AOAM533xPwKvB2XdoIVSSr2ZhiQJaDK4HBCJVZ5DWn/SHemaYe1a0uIk
        3Rm4ldF887+zL6nBfmKexIQ0jYBk1Os=
X-Google-Smtp-Source: ABdhPJyZvOnSONO4cKrDsqKXnn10+nmBHozkuKK2r9IVsmeFv9dO76Kah3Cqx5BYU7Zm4E3yecwJMQ==
X-Received: by 2002:adf:df12:: with SMTP id y18mr1766271wrl.189.1628121060667;
        Wed, 04 Aug 2021 16:51:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b20sm8234586wmj.20.2021.08.04.16.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 16:51:00 -0700 (PDT)
Message-Id: <2c82aacbcbd752e1944605d370e4d8677f778c73.1628121054.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v3.git.git.1628121054.gitgitgadget@gmail.com>
References: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
        <pull.1059.v3.git.git.1628121054.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 23:50:51 +0000
Subject: [PATCH v3 07/10] merge-strategies.txt: fix simple capitalization
 error
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Acked-by: Derrick Stolee <dstolee@microsoft.com>
Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index c3edcb07e3e..cecdcfff47a 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -529,7 +529,7 @@ The `--rebase-merges` mode is similar in spirit to the deprecated
 where commits can be reordered, inserted and dropped at will.
 +
 It is currently only possible to recreate the merge commits using the
-`recursive` merge strategy; Different merge strategies can be used only via
+`recursive` merge strategy; different merge strategies can be used only via
 explicit `exec git merge -s <strategy> [...]` commands.
 +
 See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
-- 
gitgitgadget

