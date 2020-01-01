Return-Path: <SRS0=Tp/o=2W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962BAC2D0DC
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 08:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D5F2073D
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 08:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r321FlZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgAAIso (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jan 2020 03:48:44 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37999 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgAAIsn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jan 2020 03:48:43 -0500
Received: by mail-qt1-f194.google.com with SMTP id n15so32877811qtp.5
        for <git@vger.kernel.org>; Wed, 01 Jan 2020 00:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jhbwCMtEj8vKZa8BpSVm7tFXEqn3Bia9KXDua/Ybzww=;
        b=r321FlZLh+EAolN9zTFZJLGB6h+q2Sd6Y9AIrFhhAPeuq20dATUr8Gakl5FdiUKXJL
         xdeIzBbAd76ZOOViwhjm8uQITRpjdyFy4wZqw1J7D5TBDreXCwHvbjVGU6A2nW5AYzX1
         qf3o/QcYBLhC5gUwRBelM3Y3fhX1KipVWhHsWKx+XcU9LN5DzcWBDvHfICXhIl6J735Z
         IDIu2VocvR58m0Uv2tayefbLC1B7Lq5m5bl2g+E3BgK198v7kHxBaq2tKdkRwpgz6ic2
         JLiUWHjxop5Of2PYQCSrzLBwrthQGbnNKe8w+jqAl8Hzkn9XGPg605DzRxD00rbmdmwd
         IeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jhbwCMtEj8vKZa8BpSVm7tFXEqn3Bia9KXDua/Ybzww=;
        b=mE8S6nmCj06J2jvMJpJ6VbPdeuDR+KHRrtMuAUpJrR0eCUBFCSifUP6ipm/yGPLlb2
         AH5Rmqy6CTY5l00k/OvYmQjzxIej2Xgb56DNn0OLjKXD0zLFoy5com1huEjVaIMfC7/9
         Njm0V/47SKi6i/R9mxsxRpLHLvu2HZwXoIKvPT5EM0lt9en6SmKyWcgMEvXRd5cYGV8Z
         MtdSBxOpMZepsX8FCgR2zgjYFCNFUTwq6nhNXCxRREj9TSmAR2d2IYtOSxqAQ6dA2BLa
         A6eOwk2pp6WXBj6YLfW2P9lNnaxyTVX1ZtYCatxgVUEKyaLEvlVQVNyGPDWFlBbSA0Wk
         +BWw==
X-Gm-Message-State: APjAAAXquGlE38ecTAujzAvHmfK1qOX0q1Y1TrIfrst+MSvtXEgtrcxa
        +8YqS24rUWHefWot96+1pLNH7OLO
X-Google-Smtp-Source: APXvYqw4p6rpGXHdeGiG2Ll4/CHyUaw941Vq9ayBH7uY7ga29m8WsfMjNA1iDV2XUAgzUgCoXPZxfQ==
X-Received: by 2002:ac8:7b9a:: with SMTP id p26mr56231624qtu.281.1577868522862;
        Wed, 01 Jan 2020 00:48:42 -0800 (PST)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id c84sm14169520qkg.78.2020.01.01.00.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 00:48:42 -0800 (PST)
Date:   Wed, 1 Jan 2020 03:48:40 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 05/16] t2018: don't lose return code of git commands
Message-ID: <20200101084840.GC5152@generichostname>
References: <cover.1577454401.git.liu.denton@gmail.com>
 <4fe247c09df89ebe908f366ee7c2a4ec1c209d86.1577454401.git.liu.denton@gmail.com>
 <CAPig+cQmO2W7kcqWZwrSsC7-vkk_UVcC5NktY+0dddcyaegr6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQmO2W7kcqWZwrSsC7-vkk_UVcC5NktY+0dddcyaegr6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Fri, Dec 27, 2019 at 04:42:53PM -0500, Eric Sunshine wrote:
> On Fri, Dec 27, 2019 at 8:48 AM Denton Liu <liu.denton@gmail.com> wrote:
> > We had some git commands wrapped in non-assignment command substitutions
> > which would result in their return codes to be lost. Rewrite these
> > instances so that their return codes are now checked.
> 
> Try writing your commit messages in imperative mood:
> 
>     Fix invocations of Git commands so their exit codes are not lost
>     within command substitutions...
> 
> or something. Same comment about several other commit messages in this series.

I thought that the preferred form of commit messages is to introduce the
problem that I'm trying to solve first ("We had some git commands losing
return codes") then, after that, describe the changes I made in
imperative mood ("Rewrite these instances..."). From what I can tell,
all of my commit messages conform to this template.

I'd prefer to keep the "problem statement" introduction in my commit
messages as it primes readers so they know "why" before "what" but I
can't think of any way to phrase the "problem statement" part in a way
that sounds good without resorting to past tense. Any suggestions?

> 
> More below...
> 
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> > diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
> > @@ -23,7 +23,8 @@ do_checkout () {
> >         # if <sha> is not specified, use HEAD.
> > -       exp_sha=${2:-$(git rev-parse --verify HEAD)} &&
> > +       head=$(git rev-parse --verify HEAD) &&
> > +       exp_sha=${2:-$head} &&
> 
> Are you sure this transformation is needed? In my tests, the exit code
> of the Git command is not lost.

Thanks for double checking, it's not needed. I'll drop this in my next
reroll.
