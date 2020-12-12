Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54796C4361B
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 15:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AFF5221E8
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 15:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439236AbgLLPTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Dec 2020 10:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLLPTG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Dec 2020 10:19:06 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22CCC0613CF
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 07:18:25 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id q205so906461oig.13
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 07:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=YroVYB66SxbQgg5Sccg3nGdLV+ZP7a+lvUmK5HZcFi4=;
        b=UWazgBOlgxQbIWXSZyDw48ueRPepEyDYuTYCsaiLxIOAAs05jV+JXGtIhipRLP8Lau
         RCN3uzyYAIbZaEr47Zx/V43anrqyoyUS8iFtnpyyVchhSM8D3krk1jfONOXH/AXbXMi7
         lVxPEkzZy0QF6ren4ufHDGSge5sFL/aYFjSHhr0IRaUC/JsexY3kigNjuCgrlxh8wgUf
         IjDGHNexaBzMZpE0D9O3QNavQl9y67bOvWGruK3ctPg5TnVmpr5YcqpWeTbs3Tm26aEY
         bSTc+ER4kLanrIcCOkr23fiEMxyVAtRaSIbnzEXZ5YU2MZEsw8Snl03p388nD6ZVscan
         QAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=YroVYB66SxbQgg5Sccg3nGdLV+ZP7a+lvUmK5HZcFi4=;
        b=U9C7A0I5ZGaAio5ljf57SB9nqqCs4Ky9ea60Xy1Vl+W7qkMjBzhOWjfEVHC/7w93AS
         hqO4uYIBq6MN7Gnq7tKz5lTRD1zNA9CQqSgHRwIlIHrlPi0wT6aQF6IyVvOJNQJ0oZdR
         glelBBIL09DIZXQfrHeptWBZclm7HhDlkQLNBzqvv8ODfbh2edmHZS41Xgu9HLzvmfy5
         6BMeDcqzCPeAGUC8Rv0hZEvzY8ACCvXwjRMVr0V7kCp7GMpnRyytfUcsEwEKsRSw2+rg
         jR/1iIgUjwZf0FyyFYOOeOChG6lok9UFK6z3Ld5FH2UeF+VnizHu4S41LSykVUCUk1VF
         OFcg==
X-Gm-Message-State: AOAM530se90Y7ONuDU/z5IYREXbqmpG5IPMb0M+7UYRV8eDrG8uzgQPb
        0el+EdB6sFIGFUFTP3Itb5Ik0J5Ti7FQdQ==
X-Google-Smtp-Source: ABdhPJx9QK88VZ3U9A+xgcK0i8nDFKEXVyq/xHwJlcLczGv1Q5REMtsSfZRQci4bU9/7N4Vq0LfJ0g==
X-Received: by 2002:a05:6808:993:: with SMTP id a19mr13048055oic.65.1607786305216;
        Sat, 12 Dec 2020 07:18:25 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id i25sm2672449oto.56.2020.12.12.07.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 07:18:24 -0800 (PST)
Date:   Sat, 12 Dec 2020 09:18:23 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>
Message-ID: <5fd4df3f51f40_bc1eb20810@natae.notmuch>
In-Reply-To: <xmqq5z58n88i.fsf@gitster.c.googlers.com>
References: <20201210100538.696787-1-felipe.contreras@gmail.com>
 <20201210100538.696787-2-felipe.contreras@gmail.com>
 <xmqq5z58n88i.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH v5 1/3] pull: refactor fast-forward check
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Just to state that I'm not ignoring this feedback.

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > It's much cleaner this way.
> 
> It is obvious that a focused single purpose helper with less
> indentation is easier to follow both at the calling site and the
> implementation itself.

Yes, but the reader hasn't reached that point of the story yet.

> "It's much cleaner" is not something you need to say.

From the top of my head I can think of a few other reasons to refactor
code: a) it's more logical, b) it's less code, c) it's helps further
changes.

It's not necessary to say, but that's what I want to say; this reason,
and no other reason, is the main reason for this patch's existence.

> > Also, we would like to be able to make this check before the decision to
> > rebase is made.
> 
> ... in a future step.

Right.

It's not necessarily the case (could be an indeterminate future), but it
is the case in this patch series.

> That is something we want to say upfront, not "Also".

Not from my point of view. Even if it didn't help in future steps,
cleaning up code is generally desirable.

Cheers.

-- 
Felipe Contreras
