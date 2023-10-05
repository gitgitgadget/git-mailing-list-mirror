Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44354E92719
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 17:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjJERct (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 13:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjJERcV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 13:32:21 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8C390
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 10:28:29 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4180d962b68so7253371cf.1
        for <git@vger.kernel.org>; Thu, 05 Oct 2023 10:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696526909; x=1697131709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=36Y/j9bRuRZQupdO3vBy0JHMsha2fSOxGRACx7G0aP8=;
        b=M8wARznx/pM3HV57kfCbBvHhdEFiRhHpmDupGlH8gNZd7ojsudIhgrDZl9fKED1Mai
         h92yt+0z9UDlGiQ2QzSKWVqZBRsONLCWZEoeIvmoBSQ4s1U9AKNs99NrKGv/Sxp24fVI
         MoMROoitLMJnYhwcWBHdDcpK4jn1h7byIakMcLeHpGgnaFrL5BjV95L2rqHzhJUocotH
         GmuFDsdwuZ6ikLJ1clyYmtLHPqOx89EWaYRmSANMY59XSfgxrFEdQ3sHrxZgUOOATDBQ
         Ea926Zv/LHIB+wR3JYiaYvxMaTCHSN2Sa92Zsk0MCJWV8URPCoIL909NzOoTeUIXThXV
         K/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696526909; x=1697131709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36Y/j9bRuRZQupdO3vBy0JHMsha2fSOxGRACx7G0aP8=;
        b=DN/xzSFO1jqCWC+7/TXGFzQmgUfXAAojLlxGrvIOCGf/8CGcLHXrpJTIcch2rLuIer
         8NYFC2wD+845bVCem/l8ZWn9KLCawJ/8gA7ybDzzX5bm8rW4N/hMCO7oJzw8qtixju1S
         p12ijIrmdzWDVNBF0HHC/A90wAgCrwFS3hQHVVVWRRDNxaG0QytTwWAB8wIgwWVsLaj3
         t1OI0NkHFHBJXLMAWN/NINA1bjT+tyIguuiO2Tb8MkULZ85hYyVqcAboLl/d9WDmcKAE
         q9s0eyW13++2kt0sgsURyPMQnGYKCiC32oxuESCgxwmFc652KXB6GaB6y8iC9uCCLUjM
         mDaw==
X-Gm-Message-State: AOJu0Yw8k0ykObDTebqYFK7hHW2p/qXtUt3YryiJIC9lm7bHsbKDm18h
        H4Gwk9VE+oAR2N3Jr6yU0oepea/5te1hxPlkwSbOKA==
X-Google-Smtp-Source: AGHT+IGbjVBJ8mPMUHg/bEv/M9HRQXHpZpiNNOdVRtFGbSQMivWuwi/CtxeCbm0yyNvEtnfAn2vVeg==
X-Received: by 2002:a05:622a:1208:b0:419:a2c6:8217 with SMTP id y8-20020a05622a120800b00419a2c68217mr6374534qtx.5.1696526908705;
        Thu, 05 Oct 2023 10:28:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ge26-20020a05622a5c9a00b004181138e0c0sm628050qtb.31.2023.10.05.10.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 10:28:28 -0700 (PDT)
Date:   Thu, 5 Oct 2023 13:28:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/3] builtin/repack.c: parse `--max-pack-size` with
 OPT_MAGNITUDE
Message-ID: <ZR7yOgvk3PCtYIR2@nand.local>
References: <cover.1694123506.git.me@ttaylorr.com>
 <cover.1696293862.git.me@ttaylorr.com>
 <9ec999882d790aa770aba8c0916b9260661af9be.1696293862.git.me@ttaylorr.com>
 <ZR6ednOcuK6qizch@tanuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZR6ednOcuK6qizch@tanuki>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 05, 2023 at 01:31:02PM +0200, Patrick Steinhardt wrote:
> On Mon, Oct 02, 2023 at 08:44:29PM -0400, Taylor Blau wrote:
> > The repack builtin takes a `--max-pack-size` command-line argument which
> > it uses to feed into any of the pack-objects children that it may spawn
> > when generating a new pack.
> >
> > This option is parsed with OPT_STRING, meaning that we'll accept
> > anything as input, punting on more fine-grained validation until we get
> > down into pack-objects.
> >
> > This is fine, but it's wasteful to spend an entire sub-process just to
> > figure out that one of its option is bogus. Instead, parse the value of
> > `--max-pack-size` with OPT_MAGNITUDE in 'git repack', and then pass the
> > knonw-good result down to pack-objects.
>
> Tiny nit: s/knonw/known.
>
> Other than that this patch looks good to me.

Oops, good eyes. Perhaps Junio can tweak this when queuing, but if he
doesn't, I don't think it'd be the end of the world...

Thanks,
Taylor
