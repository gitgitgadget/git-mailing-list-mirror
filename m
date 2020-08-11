Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB74BC433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 15:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87A2E2076C
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 15:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="KQg6UaKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgHKPld (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbgHKPlc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 11:41:32 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9C9C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 08:41:31 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b14so12051018qkn.4
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 08:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sGFMVWJVhe7Yu6JyThwitX2+jnCCSSaLdnDH4vLcaeY=;
        b=KQg6UaKVJVTBU3Ka0vctbKRspbaoAYn7tccdydshMXEj3NHwsltqWQskxvl9PgSkJz
         FnRXTPRpXlDTfVYQ7h4LU60xKZxCCuV0N702dFTC9xo2f6tQEJs1PdGduFaAiqqXb7R6
         vZHQ6Djy2Ugk7yRlCn+wBajC1krH5X05yRl3p7ShfD5ZDxkl239S8QfzPOXSv5WEKYBf
         vDLCHrjrdJ/dCwrZ812ztpUkO+RyZSO9cNEn1JNYolYF2Yirl2dOfN6WnsMpMFrYKyl5
         iAMGbyPHSsP7bF6Lva6C2ItvZKVU2t1IBw2YPOmoDgaOa84NVtcGKxIhX0JuGKrIPS7e
         qAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sGFMVWJVhe7Yu6JyThwitX2+jnCCSSaLdnDH4vLcaeY=;
        b=r8+FjwH3+i/JfReop3UhxL1+H6HlmzsprF5ABhdhjB+Na8O/gKnuGdfO5P0p1mXk3d
         H4M+mPwoUuReAzGyNmrpDkXChiIJkjCPfT8i4AlpmCoVsUorM7poKZLhKnHxrKWYn+kY
         5rKdaZOhCBAXZPJVRIGT+Iwryg6mNSX+QO4oha4PSYspFI0k5HILyDMrEHd/SLnoUvQG
         3iE0UUL+YOQ2XpO8Qt8DRhTdi2vAxDkQp4EuhON3vOgbrMsyjHGI66KQZMoAT6UBpyZR
         8dVRZmqTqPhALn3zJb9X1HziQdUQ//XnvBgJgGce/moDZOcqelUq5yIE6WOV6ToYgNm7
         H3vg==
X-Gm-Message-State: AOAM531ATaiXpFvkIqOLwe1tPG3sfy+rtcfzpZAwePNjQym/R36dzrRX
        e3HBL+ZHx02bqmsP6y4S8iycv3H5fjlTxA==
X-Google-Smtp-Source: ABdhPJzDynPOIng/QVKpKFxPLMVW121Ne6ctJ9Zum3cpGltz/nXyeI58dtVR33QRzn/GA4wLBb9+Pw==
X-Received: by 2002:a37:a64a:: with SMTP id p71mr1788172qke.296.1597160490787;
        Tue, 11 Aug 2020 08:41:30 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id r18sm20468884qtc.90.2020.08.11.08.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 08:41:30 -0700 (PDT)
Date:   Tue, 11 Aug 2020 11:41:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] progress: don't dereference before checking for NULL
Message-ID: <20200811154128.GE19871@syl.lan>
References: <20200810194748.1483784-1-martin.agren@gmail.com>
 <CAPig+cTsxAW=s1iXcK_-Kn+xiSNCm_u_o_Q2xm-0+a_v4qc5_w@mail.gmail.com>
 <CAN0heSotdXH50ssd01b7fFuqEuOs+X0f1Zpj+nhxuO=TRNStUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSotdXH50ssd01b7fFuqEuOs+X0f1Zpj+nhxuO=TRNStUg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 06:28:30AM +0200, Martin Ågren wrote:
> On Mon, 10 Aug 2020 at 23:27, Eric Sunshine <sunshine@sunshineco.com> wrote:
> >
> > On Mon, Aug 10, 2020 at 3:48 PM Martin Ågren <martin.agren@gmail.com> wrote:
> > >  void stop_progress(struct progress **p_progress)
> > >  {
> > > +       if (!p_progress)
> > > +               BUG("don't provide NULL to stop_progress");
> > > +
> > >         finish_if_sparse(*p_progress);
> >
> > I'm wondering what this really buys us over simply crashing due to the
> > NULL dereference (aside from the slightly more informative diagnostic
> > message). Either way, it's going to crash, as it should because
> > passing NULL is indeed a programmer error for these two functions. I'm
> > pretty sure that it is more common in this project simply to allow a
> > programmer error like this simply to crash on its own rather than
> > adding code to make it crash explicitly.
>
> I'm not a big fan of undefined behavior. In general, I don't buy the
> "but in practice it will do what we want" argumentation.

I think that this is good reasoning; having the guard around
'p_progress' being non-NULL makes the implementation have no undefined
behavior, which is worth a lot.

> Before 98a1364740 ("trace2: log progress time and throughput",
> 2020-05-12), we didn't check for NULL in this function. Then that commit
> tried to do so. It would feel wrong for me to say "that commit didn't
> get it quite right -- rip out the check". Then, to be honest, I'd much
> rather just leave it in place. At least that way, someone else might
> spot it a year from now.
>
> I could add an early return (instead of an early BUG). That would
> gracefully handle NULL. Grepping around suggests there are other `if (!p)
> BUG();`. Even Documentation/CodingGuidelines BUGs on a NULL-pointer,
> although in the context of checking for NULL (as opposed to "how to
> BUG").
>
> > > -       if (p_progress && *p_progress) {
> > > +       if (*p_progress) {
> >
> > In other words, I think the entire patch can be reduced to just this
> > change here (and a simplified commit message).
>
> I started with this, but then I felt terrible for just sweeping the
> whole thing under the rug.

Yep, I'm a fan of the direction you ended up taking. Thanks.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

> Martin

Thanks,
Taylor
