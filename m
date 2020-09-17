Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0F6C433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 08:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3B2120770
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 08:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="C4mPBrhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgIQIUO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 04:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgIQIUI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 04:20:08 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C43AC06174A
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 01:20:07 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id c8so1592454edv.5
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 01:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Q5ZwYoCXdREZOAOqQT0k+3V1e1PELrRrPe/XSa/jJ9s=;
        b=C4mPBrhY91w3Hzhk2WKfvlBAsRXR3M2PCQp83fspcVb1CRMzCvZCtawmgEyzuuCgCB
         PPfF3IfBEKmD+NKcZtIALXLGyyIqNbeVOCg+OYXQaY1aPOhhVfTx4ZVe23dOMOlPyItP
         b/3bQnhAcPOkxlvb6F+rtKZsHX73a5/P9usXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Q5ZwYoCXdREZOAOqQT0k+3V1e1PELrRrPe/XSa/jJ9s=;
        b=GUtditk4/Bn7o1sg24G7lTQ3QBkkwTC4BfzQkr/gbc4COt3CwUgRW16uKdhFDMowlG
         MYc0uL0vRcD2yebbWxPeWNdOVzCg+zpJ2DzlfNAQ0AoFLbnnopBC+26kWYA/0LO7isyJ
         5N2eCrECrC58T5KFWGTp1wEaydzkjKmAPYXuR3g1KH//SuKGMO4aBjgGvq9SIwki388i
         FBDC4Y7NBznPsml+H/LL93ZtJj9yiGFrhqCtcncMe/4OemZlZ7uAUBdtlAhYHvM1h1pM
         MXbQ89WwbaRmp+KkdVwtXouuos7IVYk7zfyoO7/2T7OeCk9GuqV6Zx4YbD1bRMhAFr9F
         4gvw==
X-Gm-Message-State: AOAM532SNlY4rxdcjbk0oihSz5ZNY2l5QDBsXSMH6UNC9qmQKA/A4vS1
        xsykr/qQ2fX1g/KpKCo0vOOzSA==
X-Google-Smtp-Source: ABdhPJwBI5Z7nsJiwllb9JtIiv9W7Xv+zs2V+6jnQc8XR6BLzp3TFNFf1iRn6pRKEwB++GGu6NGsRQ==
X-Received: by 2002:aa7:d15a:: with SMTP id r26mr32095645edo.181.1600330805511;
        Thu, 17 Sep 2020 01:20:05 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id h5sm14351502ejk.41.2020.09.17.01.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 01:20:04 -0700 (PDT)
To:     Git Mailing List <git@vger.kernel.org>
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: approximate_object_count_valid never set?
Cc:     Jeff King <peff@peff.net>, Stefan Beller <stefanbeller@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Message-ID: <4a018cb9-da40-a98f-a1b9-73be30ae79ec@rasmusvillemoes.dk>
Date:   Thu, 17 Sep 2020 10:20:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

While poking around the code, I noticed that it seems
->approximate_object_count_valid is never set to 1, and it never has
been, not even back when it was a global variable. So perhaps it can
just be removed and the logic depending on it simplified? Or am I
missing some preprocessor trickery.

Nobody seems to have noticed the lack of caching - and actually setting
it to 1 after the count has been computed might be a little dangerous
unless one takes care to invalidate the cache anywhere that might be
relevant.

Rasmus
