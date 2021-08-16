Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F06C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 22:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FBEF60F41
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 22:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhHPWcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 18:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhHPWcP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 18:32:15 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2717C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 15:31:43 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w6so15352395plg.9
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 15:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qXw7uTlY30AfKt6aVVixCMCQRn1VlVMl9hq8heaNFpI=;
        b=kQPMLRbWQPI2ze2s3Spixi3ulA1MeNLpF1/83x2GjRBvwVfgOgJ6yHxidlXRjSVLGA
         32LNNMW2zaPf3D1LK81GiZGthn9fH1qEviCI7Yha0RkXmm0igKCZgr4uveaW1bXgSqVZ
         1/VkjjAKaGp+0qCRjpLSuByssXatVu0zB/8MLF4S4vVtqroYT9GGDhvsrXg1qO3EeK1q
         c3Sf9QgZJuj7yYE+ngn0u9H90nam49OFelkEA/tt6LWtJwWT+VWo5OZkf2/fGcfMbSdK
         Vno5OYm3htu/6tEuSsC2qAbafSguGSEGFK1vPn8M5pmZGSJGwPc3qF4cBvThT3oXqzNI
         L0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qXw7uTlY30AfKt6aVVixCMCQRn1VlVMl9hq8heaNFpI=;
        b=JUaZw6Fpb8lTCm72JSGFFD4NmKlOZmC+JeHJVHyjvdv3Sm2/hvsTXSyqmqkMKWZDQu
         qpb3N3YkrXBa0j6iPfz8lWW+fhhm/E5fdg+22RdFT2gqTuYtUUOkcyeHZIEaNos1zsyx
         XTVPAy17fTirKNNkkVd5dONQNE50oqPDvIiLruG7eHM/pSoGFfSF2mPOVr6P6xsfeMeX
         AqbsV7svS0052/v4MFrUG8hGJN7aTl9pShabQByzJ8tZNuQF5Pf03hJh8qOfheYXGrTI
         n2T2e1v8OjOHcJrFDgFso7EXL+wO++8lLFBHtbAQxTTLEByhlF8VPhmIvSDS8WeikA+v
         TiIQ==
X-Gm-Message-State: AOAM5338oLx9dNhMBuZV5YUrd0/BZoDQp1nQBg3KVJcRSYsPL3KE1BRD
        c99B+syGH84KN7/z0hJwFFVWDHT3WcqbwA==
X-Google-Smtp-Source: ABdhPJzZNW/HPQ/p3ols1mFwJAXBwJMbHjnyRIiMwWxCKsoLX5oKAdhBFoiuNZSVl8LwCDglknEsRw==
X-Received: by 2002:a63:d458:: with SMTP id i24mr291744pgj.289.1629153102943;
        Mon, 16 Aug 2021 15:31:42 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:aa0c:5f92:878f:e03a])
        by smtp.gmail.com with ESMTPSA id x73sm186307pfc.98.2021.08.16.15.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 15:31:42 -0700 (PDT)
Date:   Mon, 16 Aug 2021 15:31:34 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 0/6] config-based hooks restarted
Message-ID: <YRrnRjJxcwyMQY7S@google.com>
References: <20210812004258.74318-1-emilyshaffer@google.com>
 <xmqqa6ln6zi0.fsf@gitster.g>
 <xmqq5ywb6yrm.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq5ywb6yrm.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 11, 2021 at 10:02:53PM -0700, Junio C Hamano wrote:
> 
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Emily Shaffer <emilyshaffer@google.com> writes:
> >
> >> This is the config-based hooks topic rebased onto v4 of Ævar's
> >> branch[1].
> >
> > I have [1] in my tree, but these patches do not seem to apply
> > cleanly; I see a failure in "git hooks list" step.
> >
> > Should I perhaps try merging [1] to one of the v2.33-rc and then
> > queue these on top?
> 
> Ah, I figured it out.  Your 3/6 seems to be stale wrt 4787177b
> (hook: support passing stdin to hooks, 2021-08-03) that came from
> https://lore.kernel.org/git/patch-v4-22.36-639e59e9ed0-20210803T191505Z-avarab@gmail.com/

Ah, I am sorry!

> That patch did this to the early part of builtin/hook.c:
> 
>         diff --git a/builtin/hook.c b/builtin/hook.c
>         index f33db9953c..27dce6a2f0 100644
>         --- a/builtin/hook.c
>         +++ b/builtin/hook.c
>         @@ -7,7 +7,7 @@
>          #include "strvec.h"
> 
>          #define BUILTIN_HOOK_RUN_USAGE \
>         -	N_("git hook run [--ignore-missing] <hook-name> [-- <hook-args>]")
>         +	N_("git hook run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
> 
>          static const char * const builtin_hook_usage[] = {
>                 BUILTIN_HOOK_RUN_USAGE,
> 
> 
> but your [v2 3/6] here expects something entirely different.
> 
>         diff --git a/builtin/hook.c b/builtin/hook.c
>         index 12c9126032..c36b05376c 100644
>         --- a/builtin/hook.c
>         +++ b/builtin/hook.c
>         @@ -8,8 +8,11 @@
> 
>          #define BUILTIN_HOOK_RUN_USAGE \
>                 N_("git hook run [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
>         +#define BUILTIN_HOOK_LIST_USAGE \
>         +	N_("git hook list <hook-name>")
> 
> I've wiggled the patch in, as there wasn't any other funny
> inconsistency like this one, but please double check the result
> after I push it out perhaps tomorrow morning.

I'll take a look and update local accordingly. Sorry for the trouble.

 - Emily
