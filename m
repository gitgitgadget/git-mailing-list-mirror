Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB31C00140
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 16:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239108AbiGZQ2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 12:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiGZQ2O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 12:28:14 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E4122B00
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 09:28:14 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o21-20020a17090a9f9500b001f0574225faso10215855pjp.6
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 09:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date:from:to
         :cc;
        bh=gE3mJ0jgLP1NuZkBVoeLIS5jZ9+RGN70bF3AMTKZBsc=;
        b=BHrs9XJt9KeHj5y1VdYQ3mwAs++oCXQ5ALq0T73Wh70D8ATM+22ZDummIE+8C4jA+l
         fJw1inGZ67O4jJ1JJhnkBqrMzG2CnQe7Gmp8uAnxuS0Fno8mkW47sw/bHldScSWtUFYY
         wwNfDPUkBe9XRg1LXEmSXa31gEnMVFQXzaXPCopef8PoBd82xGZCmSanpjhTFIOnRtWl
         V29EQoypgopp8TVo8KjmMrX2aAfM6xfZQbd1r4VmgVvTixByRlJysBQZAu0QuhxKD19t
         W6xy7ytPz28hW4b/R0hJpan/5hwI/R3xCCXRkmJizSvc3ZV0YiTpLVB3JahbJV1EHKLj
         j0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc;
        bh=gE3mJ0jgLP1NuZkBVoeLIS5jZ9+RGN70bF3AMTKZBsc=;
        b=TfQ8Cq51SB55X7pN61hHiigdjNUM3AjVDd4DtnRLoWQlLJUeRXSD9/OhcqgmrAe2uP
         PmkM6fZClAnCbU/x/+BPDknAB88JUZukwazNnXMuNbYFkT1zJ2MxnuiiULRTB4TqR0yC
         UHjojKU5BM959r2SaEKKGlE7Pm8vJ7N2mKSydBjv2dVfsNt04RN4/klIJOZ1rjmrxcry
         f3fWk5KpTjUK3rv9UCBPOFrtu3dPEX50SpcALRHTdI/tpeQgfcKeheJx3Q6ppMux9U1s
         AJP7cf728qcKXeosjVM+0uC7s+C62VMQA9Ms9tB6It5nc5nn4NheZauKAENPsR0jnlYj
         6NGg==
X-Gm-Message-State: AJIora+gyLA0iuJc6qX45vNbXz8I1ceVcH3BxjrtoNvfWoPhQ6n+c7BP
        FgLI3gq/th34o7x4JoM3gIsFwo6Lzyv+5lvIZSEn
X-Google-Smtp-Source: AGRyM1uxryZdz5thv6GbYveBGbXVBb118ocJoV7t1TVbwIADVfC9WjGlyoQdhksS4n4clXLTQKogFgd/y+5JANQZuZ58
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:15d2:b0:52b:8dc:6cd4 with
 SMTP id o18-20020a056a0015d200b0052b08dc6cd4mr18058642pfu.68.1658852893787;
 Tue, 26 Jul 2022 09:28:13 -0700 (PDT)
Date:   Tue, 26 Jul 2022 09:28:11 -0700
In-Reply-To: <xmqqtu753tti.fsf@gitster.g>
Message-Id: <20220726162811.1778322-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: Re: [PATCH v2] fetch-pack: write effective filter to trace2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> After waiting for a week, I still haven't seen any correction to
> this patch, but do you want to give the helper function a bit more
> sensible name in an updated patch, perhaps say "send_filter()" or
> something?
> 
> Otherwise the topic looked good.
> 
> Thanks.

Thanks. Your proposed name looks good. I've sent out a v3.
