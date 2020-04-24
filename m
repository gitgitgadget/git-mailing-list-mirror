Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9334C55191
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 11:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B820520767
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 11:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ui0xnIzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgDXLuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 07:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgDXLt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 07:49:57 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC6BC09B046
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 04:49:56 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x17so9682548wrt.5
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 04:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HYHS38Au6CtTuI2ZgtQFnraejHTl1h/lhxRvcPNe5rs=;
        b=ui0xnIzF9tog8RLriS0lwqPTLIBUe91cGGpZQpapoTziXNvO4CgkrxHj6WOesWTdPM
         Kbte66n9OYe9GhYI9nFLK92UnbpV1E+u3R6ZWzS8N0VA4Vs/q4kgqm0SuC2t8jRHZz8j
         bSkf0FaxavYbem4jEikV1g3v+/XZElK9N5KBf5VOyhJzO+XoBLJltu4Oi933jKb0Ackq
         Kcr89cQA7KTKU92yvpHV8FSpEoMe5ZSKZXPEztYsgQbl9GfbQ4Ruhcp15/EL6BJq0F+x
         BucsESfZVppWU2OxCsn1jBrgiEVhEl6TN4Hb2356wsEiz6dwmBaIKex2UsDB2cGbHwxW
         heYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HYHS38Au6CtTuI2ZgtQFnraejHTl1h/lhxRvcPNe5rs=;
        b=cx8cjunbpfNtu5qwRdQbE3pqlynyePeedFmvW5lZp3nagqJePoJy+OLm2Y5Ynjwx+h
         dGVy5+k0dL7VaV/g5cbVWimMegldfdCfZSiREkOp9DKSHC53T1ehxp05SdcsM1CfuOjK
         TKqa8wg7RoEbOZoECuNuwBeuIz6B5o36QDVSd1uCYvQ7LsJRGVG3jouegavM6nxX28EX
         Nf0vL0+1y+0jEJAwNApGVVLenzIO9iXRx518QYcK8Y0Ga+7ywNOH+nIXwu+BbssfxMBS
         EiGveHHpdBYKTT6z1l0UG96y263Y+vNbOdAjHKVPh0WAQxErcaOkUJL6ZW5891O+icVB
         RYpA==
X-Gm-Message-State: AGi0PuYyOCoq6yEgFhTaGZSiyvTxzJzmh7Yr2KOvojqMr2HTtkGwgj5B
        6te1jhrCImpKc13thxS4YrsnevKg
X-Google-Smtp-Source: APiQypKcj8FaenCswlHu2CotO93qVacv7N5PdjF5mHMRBg+k+UsiZp42J7Q2WMMptIPX52zt28G43Q==
X-Received: by 2002:adf:fecd:: with SMTP id q13mr11325631wrs.12.1587728994503;
        Fri, 24 Apr 2020 04:49:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a125sm2536028wme.3.2020.04.24.04.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 04:49:54 -0700 (PDT)
Message-Id: <2c1c0ae91eba2092b24c392786ca2e7c81ded334.1587728992.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.615.v3.git.1587728992.gitgitgadget@gmail.com>
References: <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>
        <pull.615.v3.git.1587728992.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Apr 2020 11:49:50 +0000
Subject: [PATCH v3 1/3] credential: fix grammar
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

There was a lot going on behind the scenes when the vulnerability and
possible solutions were discussed. Grammar was not a primary focus,
that's why this slipped in.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 credential.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/credential.h b/credential.h
index 122a23cd2f1..5a86502d95c 100644
--- a/credential.h
+++ b/credential.h
@@ -32,7 +32,7 @@ void credential_write(const struct credential *, FILE *);
 /*
  * Parse a url into a credential struct, replacing any existing contents.
  *
- * Ifthe url can't be parsed (e.g., a missing "proto://" component), the
+ * If the url can't be parsed (e.g., a missing "proto://" component), the
  * resulting credential will be empty but we'll still return success from the
  * "gently" form.
  *
-- 
gitgitgadget

