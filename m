Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109B3C4320A
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 22:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB37E608FE
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 22:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhGXV0c (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jul 2021 17:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhGXV01 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jul 2021 17:26:27 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308A0C061757
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 15:06:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j2so6302048wrx.9
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 15:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=651mikC42NqdxBURBS08LfDrQ3pmYpSkSnti8dRktRs=;
        b=SWSDv1MQFPbfGKppCalaNCZWtfyZYSckRcBMYvKgfgsVI3mSj8AlM3LKFGdWcrwKh2
         fGBsaSsXCqKlwz4eOCRhjLTB59GVQeu70lpjN8ItKmgbJ5nRPf2giOyuDWTwZ+qVG6u+
         eay/OMfrY5s4ScZOmePOZerqke3qBaSU6oWnaAxd3gXd1l5ZYXnWnJmcDoetqoyVvx+1
         WdULKaiaEsSnTGrLOs//GXin57cjURLiMNY8/KnWfkObyv+IlTUTooRkNFQA00iLMhNC
         LOP8rsbehWzdqDgXc+PCIuMGfWoSJ9Tnhp7Sqg2hlB2cxb0KA8MW08/Hc8WhxFYCRnfq
         9PTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=651mikC42NqdxBURBS08LfDrQ3pmYpSkSnti8dRktRs=;
        b=H0PYHaTH/ycasXVCPQ5UIgYQNilnGo/C2yfGrv5rJ7tdMCRJGTLtjvrv59VWIF2IiC
         VY6dKunv9FY3FILPjiiOB8oWbolghwwtc9Hvh8gl4dCN40wWwKYWqeOlulUW4EZwiKF2
         h93oOQpOVTSHOgDNGxs3MtnSIrfoLAsJczvjgMTgq4aer6bLekYDVEN5VKXkhMytp2zH
         0ktlrqUCEVhzDey9tP9Iqtf5TMJyPxVSbdZNti2vE4KDYBAmVJ0AYuYYL5jmWgMJIhm0
         dp7kdx6z0tmdSh4dnFdWMlQVaIy4YOVUKvXKW2Nyqo4kNZJQFFKYiwCAvq1++OHQEYPe
         /uNg==
X-Gm-Message-State: AOAM5303JzItB5PhWrseMcHU4ZPBY8CcpF0fx8GY3mrQt27F6SwepDxY
        boay/VST4O6t5978eeDfYuTExsUHkJY=
X-Google-Smtp-Source: ABdhPJw/r3m9R5c2rdMQA014EtJiSnUkUwpNALl1e5wIPNpKROqrQqok3FFwph+1tFt4ckFeXPg9dg==
X-Received: by 2002:a05:6000:1042:: with SMTP id c2mr11600181wrx.355.1627164416881;
        Sat, 24 Jul 2021 15:06:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm30239481wrp.80.2021.07.24.15.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 15:06:56 -0700 (PDT)
Message-Id: <a4ff3a461bc42d11e5ef9e40deeb90d17919943d.1627164413.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.66.v3.git.1627164413.gitgitgadget@gmail.com>
References: <pull.66.v2.git.1625155388.gitgitgadget@gmail.com>
        <pull.66.v3.git.1627164413.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 24 Jul 2021 22:06:50 +0000
Subject: [PATCH v3 2/5] expand_user_path(): remove stale part of the comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 395de250d9d (Expand ~ and ~user in core.excludesfile,
commit.template, 2009-11-17), the `user_path()` function was refactored
into the `expand_user_path()`. During that refactoring, the `buf`
parameter was lost, but the code comment above said function still talks
about it. Let's remove that stale part of the comment.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 path.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/path.c b/path.c
index 7bccd830e95..3318ad24336 100644
--- a/path.c
+++ b/path.c
@@ -719,9 +719,8 @@ static struct passwd *getpw_str(const char *username, size_t len)
 }
 
 /*
- * Return a string with ~ and ~user expanded via getpw*.  If buf != NULL,
- * then it is a newly allocated string. Returns NULL on getpw failure or
- * if path is NULL.
+ * Return a string with ~ and ~user expanded via getpw*. Returns NULL on getpw
+ * failure or if path is NULL.
  *
  * If real_home is true, strbuf_realpath($HOME) is used in the expansion.
  */
-- 
gitgitgadget

