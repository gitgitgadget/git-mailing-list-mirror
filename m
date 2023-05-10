Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A076C7EE22
	for <git@archiver.kernel.org>; Wed, 10 May 2023 23:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbjEJX3P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 19:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjEJX3M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 19:29:12 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161F22693
        for <git@vger.kernel.org>; Wed, 10 May 2023 16:29:11 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-643990c5319so5627465b3a.2
        for <git@vger.kernel.org>; Wed, 10 May 2023 16:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683761350; x=1686353350;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OeJaMBUsiQhV7nO2aArDuAfdSSbeEW54Ot4x5mjU5jw=;
        b=IzjQRHdJlq+Aa1q+224QLv1/T3CuDq21IEdGBrvnIXEl/cTgLXUDbhF4rmDEsyClS1
         1pIPOauM/D/h8ay/7t0IlpEu+ZbGDzSgTp/PZGuP9hLfwRVc6QANdpMEjNHiiat5Nhci
         8ORrLyhbZSIkzHnwKS1751kZIl2L4YzPsjJg6DxKgX/zIbjjo+YTFFrwcqQI7Stkf+/M
         gJXnAtjML5+bJp3Wsj+NuoCYUC4oG9oOrZVEdmG+7/1WC81jN6Tal1HyZXLNyI4YXF8n
         tEel1emZ766oHM52o/UyO2N/sxgXc8HdVmutx9F1XpMP6uJ7x2Dulr6MfksxfvZpmPm6
         cWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683761350; x=1686353350;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OeJaMBUsiQhV7nO2aArDuAfdSSbeEW54Ot4x5mjU5jw=;
        b=FUR+oJ7Dp01MfjLbEgkc7/UEqMJ17S+f6KOp4kmx6SBzlCRTI0TKJiiYbFoC6t9hdG
         cS/pQGA9+JnaGVEhT4dr9stWjZTTrXgrnl1bA+ENfuWJuN+zeXrWdnfiDoFvdg0ruEUt
         llag4V5JcM17J4rLtYgyFqjl8BLiuiNlPfIfr66BdlyHm7tWmVlJagIKn+5aX3zxpa3j
         1KIbRNdWnWeOPg0yQZGzvEBMGE6+mE+RXqUoW2CHsPyxZkbyb6WqWsifycKvqNU2dvhh
         2XGEplUC6e9M7nTATCFH1i44RCzTLvkf3mxPq3eVVQ4c/jlhbe5Q0TViwb0QJ2415aSA
         bH+g==
X-Gm-Message-State: AC+VfDxk6C5vlYrUI1jdkJZPceDlzQLCqAcBQxVu3ZR3f+IxA29L7Ayj
        zkB3znVcjQ7u1TR5Qok0Q0XAz3RSUMsXM9d6ZHq42g==
X-Google-Smtp-Source: ACHHUZ5caew0f5oPxbFm4Ezq4AtXAVwazdrQ1xQbeve6CJjyd+2dfKpRKUP8SfnklKNnxl1x2vH07w==
X-Received: by 2002:a05:6a00:218a:b0:640:defd:a6d5 with SMTP id h10-20020a056a00218a00b00640defda6d5mr22946972pfi.12.1683761350388;
        Wed, 10 May 2023 16:29:10 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:202:8284:9645:b7e6:34b9])
        by smtp.gmail.com with ESMTPSA id 3-20020a630a03000000b0051b930b2b49sm3733355pgk.72.2023.05.10.16.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 16:29:09 -0700 (PDT)
Date:   Wed, 10 May 2023 16:29:05 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        chooglen@google.com
Subject: Re: [PATCH v3] setup: trace bare repository setups
Message-ID: <ZFwop6NTThvLKOU3@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, chooglen@google.com
References: <cb72bca46c6ff2a8cf3196408fb53411f7f91892.1682631601.git.steadmon@google.com>
 <e98be8e7f703fc741e06d9208545abc8c24d1a4a.1682962110.git.steadmon@google.com>
 <xmqqa5yicsxd.fsf@gitster.g>
 <ZFl4UVhoR4Hlm2g3@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFl4UVhoR4Hlm2g3@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023.05.08 18:31, Taylor Blau wrote:
> On Fri, May 05, 2023 at 03:30:38PM -0700, Junio C Hamano wrote:
> > Thanks.  We saw no interest on the list in reviewing this patch
> > further, it seems, but I didn't see anything glaringly wrong, see
> > no reason not to merge it, and this should help noticing potential
> > issues by $corp folks, I would presume, so let's merge it as-is.
> 
> I took a look through this thread and would be fine to see this one
> picked up, though I did have a couple of questions:
> 
>   - Is the plan to eventually disable $GIT_DIR discovery in bare
>     repositories by default in a future version? I am still uncertain
>     of the assumption that most end-users don't interact with bare
>     repositories directly.

I think at some point in the future, we'd like for
`safe.bareRepository=explicit` to be the default. To get to a state
where we're comfortable making that change, we plan in the near-ish
future to flip the default when `feature.experimental` is enabled.

>     Certainly forges touch bare repositories without always setting
>     $GIT_DIR in their environment. But I would imagine that other tools
>     indirectly touch bare repositories on behalf of the user. You
>     mentioned "go" as one such tool that doesn't set $GIT_DIR, I imagine
>     there are many more.
> 
>   - If it is the plan to disable $GIT_DIR discovery in bare repositories
>     in the future, I'm not sure how visible the extra trace line would
>     be. Perhaps that is desirable, since having an advise() call on
>     every Git invocation in a bare repository would be noisy.

Yeah, this is mainly to help us plan for our internal rollout of
`safe.bareRepository=explicit` at $DAYJOB, but we assume it would be
helpful for others who might also be considering this, or for developers
of affected tooling when they receive a bug report that bareRepository
breaks their users.

We also want to add some more detailed tracing in general around
repo/worktree initialization, but that part is not so urgent.
