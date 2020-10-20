Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54717C433E7
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 00:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC48223FD
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 00:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZfTaxeZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389175AbgJTALL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 20:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgJTALK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 20:11:10 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603DCC0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 17:11:09 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t18so683284plo.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 17:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WwqTjrvknUMDvM4ru9MY8wfH499uyDzrsbQyoE67x14=;
        b=ZfTaxeZRYr2eTKXx8yxnuo6Upl7xnbHMlQx8E0zVVzrRGmV3Aa9n39C0LQGGn2SBXg
         pjtni3DhjnulNXk+d0UCSS195QesGxWEsEf0m2X1fY29xNQisatzvOp8AfStexFDQFKk
         bKBo988F1Gvo6KH0jsHCqFkIx46B2ilLpkxZvuXz39th6+c26l8ewx2iZHUkbaB/dYsU
         C1l8iHVAq+EZoKOHaxcp5V4S8rN8zvHcqAEtSaAD9bNjKjiBDZC/n4fUjGCypW7dp4e3
         Wzyxad4jF691J0raJz6UL2uSpgzxU3aAOGb1Aj0mw2m+zdE08HRWndb5unWyqbZ//3kM
         igTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WwqTjrvknUMDvM4ru9MY8wfH499uyDzrsbQyoE67x14=;
        b=jl7sZlB/NnCzUQwfElP7g63gCMvxA5hKpzx5TWSoVz/ISoCx/D/9jdhTo9vj4VwpOw
         /J0h/CFByT5kVDsW0GxPK1VxH3PRlH9tV8/olgB63EHjZlRVpifs99mzM8l3cAMXF9ic
         sJeW9GMJ2YxCm2VA0eVFgmgpIaHG1JbA0XxsNt+fA99Bh9YADrJBBeW6mc6K+5AkW2xF
         WqNbfRKpPBKYnYRXcSwR8U9xFitYRRinSjru59mYwHC3dMmD+G5aRDUGYKRdEH2kmaNr
         wytEundNUJT+hDk6KvX3l4YsGF5OEUfhQmNA7w+7zaW+hqGHanr4kH6ECiXlvSRuuHz4
         VSKg==
X-Gm-Message-State: AOAM532AH/KbuT9boFZBhTtcI4+giOnl4LQXp0PatDSrRp46WTOvTbLl
        N3+dLWXiVv0qPsOyN/AlqKwFS3wtSpHpig==
X-Google-Smtp-Source: ABdhPJxxil8KjhC2KdrPHdHySYLof2SVzm01C6CNHIOPJzEk24zGAAUq7285gLEj5/7YycGLoN6hwQ==
X-Received: by 2002:a17:90a:468f:: with SMTP id z15mr294199pjf.200.1603152668587;
        Mon, 19 Oct 2020 17:11:08 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id x23sm113109pfc.47.2020.10.19.17.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 17:11:08 -0700 (PDT)
Date:   Mon, 19 Oct 2020 17:11:03 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Joey S <jgsal@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [OUTREACHY][PATCH v1] t7006: Use test_path_is_* functions in
 test script
Message-ID: <20201020001103.GB2774782@google.com>
References: <ERmIkC3rLZ3BAyv2Nq_GK0CjWvEQw6ejl8V-HVvwCsyIv0guQV67nO8KMLi7eA9qO5mo_ZJ8XB360uP_LtP-LY1xsaRBXHsc0F1uSID-KPE=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ERmIkC3rLZ3BAyv2Nq_GK0CjWvEQw6ejl8V-HVvwCsyIv0guQV67nO8KMLi7eA9qO5mo_ZJ8XB360uP_LtP-LY1xsaRBXHsc0F1uSID-KPE=@protonmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 19, 2020 at 04:26:07AM +0000, Joey S wrote:
> 
> Hi everyone,
Hi Joey and welcome.

> 
> Signed-off-by: JoeyS <jgsal@yahoo.com>

One thing missed by other commenters: the Developer's Certificate of
Origin line - which is what this indicates - should have your "full
name". So in my case, I sign my patches 'Emily Shaffer
<emilyshaffer@google.com>'. If I'm wrong that's fine, but JoeyS sounds
like a name and initial rather than a full name.

The rest of the patch looks okay to me, though.

 - Emily
