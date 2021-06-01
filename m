Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D83C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 12:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE73C61009
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 12:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbhFAMaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 08:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhFAMaP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 08:30:15 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9612C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 05:28:33 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id l1so3323074pgm.1
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 05:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=so83kkV6MtgZgFxG9vGEZPn8J0Iu9S8iTziEMnuOWMw=;
        b=eRy4IlpXmkkNZd6EjOHOzcvC2CyRig6p93Ktd5sw6iV5Q1QnxW/4t7Xyi/Mv9WXruk
         8YIcygmV6op66Ck/I10HCwZ80rIQC77+zyinDQSbWFRx/rUqyoUcdndcFpeTApZeLh23
         bhwMo43orFRolW5waR6HBtOAo2+JouNddGNmUni8XYyP8pVgnjk80VeyS8NUDA8KsUAV
         vAPZEFY9AmcrBVBxFNEfu/l0B208gg7r18I1E5QFyaQq4/ARpkwmShgVvt3WFMjHcouf
         7PAPmrtT1GfJSzs4OHZ2gSIz9DVvJqv/idUVPtdJzh1u/NY6jjL3GUIX4VHesFrqH2kP
         94qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=so83kkV6MtgZgFxG9vGEZPn8J0Iu9S8iTziEMnuOWMw=;
        b=GoBh82JqCq+QAet2z0z9G0OJrDOEyQc3yrwDCnRlabec3T+08m1f1Ms7yK3+H3wlkf
         o0fazjQhhzwBD0P/h1xgFPJPKTKFKy8LkKsx9dgyVOmNmkWzV/FtDUX7ZfkRzJlUq7pD
         DDYkcqdrnAocLSeMdVS0dYh5iyMklRoBHwvutj12GeK3OBUqEuwp7Z6UEJU2LqsWra1f
         WsPBGblVuXVI7vIsNwT794xNbqh7UaZ/bxhAtFmQhB/dDU/FURwH1dK/ctqWJo80KzXq
         pmsBlAc39cR9hBghHkEwm78Fy5OhmdlG0Yt2GeSRRSfBtQZg2cJBmN37yoZDFus+Bmvg
         yEXw==
X-Gm-Message-State: AOAM53380/9XTSslqyydzFKq+VOtrkWP0d38/5TuKKQEJBdPCwHdAVsd
        98aLBiqNfwqzz0L2A2f6HKVMsk+Ge6SrOA==
X-Google-Smtp-Source: ABdhPJxKhktLXrgWpzVUUvRX+thyBb2dPF3rTUnYDaINhPHWqYT2EkEfzGwWBSCnama6yYHJ7fupZw==
X-Received: by 2002:a63:2350:: with SMTP id u16mr27990291pgm.195.1622550513232;
        Tue, 01 Jun 2021 05:28:33 -0700 (PDT)
Received: from localhost ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id v4sm7947402pfn.41.2021.06.01.05.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 05:28:32 -0700 (PDT)
Date:   Tue, 1 Jun 2021 19:28:30 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: The git spring cleanup challenge
Message-ID: <YLYn7iMA+Ne8nbJk@danh.dev>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <YLXl5+ronWhcGh13@danh.dev>
 <60b61089ba63d_e40ca20894@natae.notmuch>
 <YLYcnwZQAEoSQKsG@danh.dev>
 <60b62665df1de_e40952080@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60b62665df1de_e40952080@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-01 07:21:57-0500, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> Đoàn Trần Công Danh wrote:
> > On 2021-06-01 05:48:41-0500, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> > > Đoàn Trần Công Danh wrote:
> > > > Something is essential when working on constantly integration tree,
> > > > I don't want to make my life hard:
> > > > 
> > > > * rerere.enabled = true
> > > > * rerere.autoupdate = true
> > > 
> > > If the defaults make your life hard, then shouldn't we change the
> > > defaults?
> > > 
> > > For starters, which is the command you use? `git merge`? If so, maybe
> > > `git merge` should have a --rerere option to enable rerere. There are
> > > some --rerere-autoupdate, but no --rerere.
> > 
> > I think both pull, merge, rebase, cherry-pick, revert, checkout,
> > switch, apply, am will be affected by rerere.
> 
> Yes, I know, but I am talking about you personally. Where do you
> absolutely need --rerere?

I need rerere in both of merge, rebase, cherry-pick, revert, switch, am
Don't ask me why, I use all of them in a daily basis. And rerere saves
me a lot of trouble.

I don't use git-pull nowaday. But, should I use git-pull,
I'll need rerere there, too (it's a fetch followed by merge/rebase,
anyway).

-- Danh

> > > But fine, this is an exception too. The location of programs is not
> > > something that can be changed by default.
> > > 
> > > > And I would like to try new shiny features:
> > > > 
> > > > * feature.experimental = true
> > > 
> > > Interesting. I didn't know that existed, and I advocated for a
> > > similar configuration: core.mode [2].
> > > 
> > > But if most newcomers can live without it, I'm sure you can too for a
> > > bit.
> > 
> > The point of trying new shiny features is dogfooding ourselves and
> > report bugs early, if any.
> 
> Yes, and more developers should turn this flag on, but it's not
> *essential*, so you can live one month with it off. Either way I don't
> think it matters for the purpose of this experiment if you have it or
> not.
> 
> > > > >   3. Every day you can add 1 additional configuration (and update it the
> > > > >      next day).
> > > > >   4. The moment you add a 4th configuration you lose.
> > > > 
> > > > So, my baseline already requires 8 key-value pairs (ignoring alias and
> > > > pull.rebase). I'm lost already.
> > > 
> > > With the exceptions I think you only need these:
> > > 
> > >  * rerere.enabled = true
> > >  * rerere.autoupdate = true
> > 
> > OK, let's start there.
> 
> Excellent.
> 
> -- 
> Felipe Contreras

-- 
Danh
