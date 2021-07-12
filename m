Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B98C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 685C8611F1
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhGLU62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 16:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhGLU62 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 16:58:28 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C38C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 13:55:39 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l11so10845900pji.5
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 13:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=B3ci8uhbXCBtF0XB6JB39Mz6gxUARcTPeEo4J0UPgjM=;
        b=f5YmpymAd0yZANwJ+EHIZXte18V6Wv+TTHq5cfk3JqWROlThS7Ty5ML+414pUT1z1k
         Ag+s7MFKprUVbE7HkU1LZKssEGAfiLcglG3GBIZDU7/77UJH4x4vCmViTQOSDKqcoOjy
         MKK+W6JnGklUsC0lTMev1k/zfRcA8EdRX5QYCJ6hVs5uW39FGQkjr/RW/1j6Qh9L7LEr
         cwuQHM4Q4M3VgEzSJNwWGPzE8nLMu6yxRJnIockHc6n9lYtQNaF4QY/2QHpm2kiiRF34
         uMwSW06gdQV3uUukNo6UEm546Uiu8bX9LdCOd+/p4quzcwZ9n8WTFP4inrWmR2uvWW5P
         +t4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=B3ci8uhbXCBtF0XB6JB39Mz6gxUARcTPeEo4J0UPgjM=;
        b=rFzk1ZYqLeKKteT0PkZ8p99W84xSo65lLf2UaHdo1xcxDRiM9iJbURBAdVnl9doP9g
         z1cc9owb8+J6xnzTZrP1WpUphtEuqtsTdC9Ame6v4g3xpI03jR6jKvONzedniHeQULFc
         RXOwo0UXMByf1QutFEspsFwoxJgNIyQsiQK7Y0tyRASIvxZyNvyZEzbx0u3VaI87Ty9k
         jj+JiPgoCpkJTobvlpRc7b3GC9G29zff9GuPg0Tz+HILmHlPeqpczA20iWRd5T9cvQqz
         kJCU2L0BPz90FH+om6/l0e7rC8Z2wLySzvtmQaI19XYN9ExmqlVh4bbS2eCiBGf15bhA
         9tMg==
X-Gm-Message-State: AOAM530EERvI6AhuWPXC0mTkZIn4LBpYEFTLHEaVQp9DU3k++ER+UKkv
        QgjgGwVnWyXQ2EcPuIJzYhVj4A==
X-Google-Smtp-Source: ABdhPJzCrFbxMFZFi9nbokiVSljovq4BMxmMrcgJIwpPDnvqLSTdGXKZlQkrHF3wIcEcM/tVISVlbg==
X-Received: by 2002:a17:90a:564a:: with SMTP id d10mr807551pji.120.1626123338741;
        Mon, 12 Jul 2021 13:55:38 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cbec:4d98:fea3:cded])
        by smtp.gmail.com with ESMTPSA id s2sm16481594pgr.12.2021.07.12.13.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 13:55:37 -0700 (PDT)
Date:   Mon, 12 Jul 2021 13:55:31 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 3/3] hook-list.h: add a generated list of hooks, like
 config-list.h
Message-ID: <YOysQ7ewkpLZMP2I@google.com>
References: <cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com>
 <cover-0.3-0000000000-20210629T183325Z-avarab@gmail.com>
 <patch-3.3-ba7f01f4f6-20210629T183325Z-avarab@gmail.com>
 <YOixxZQDVDKIM8bo@google.com>
 <87wnpy4jyb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wnpy4jyb.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 10, 2021 at 11:03:50AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Fri, Jul 09 2021, Emily Shaffer wrote:
> 
> > On Tue, Jun 29, 2021 at 08:54:02PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >>  const char *find_hook(const char *name)
> >>  {
> >>  	static struct strbuf path = STRBUF_INIT;
> >>  
> >> +	if (!known_hook(name))
> >> +		die(_("the hook '%s' is not known to git, should be in hook-list.h via githooks(5)"),
> >> +		    name);
> >> +
> >
> > I'm not sure that it's necessary to require this, to be honest. I see a
> > use case for wrappers to want to store and run hooks in an idiomatic
> > way, and doing so by instructing their users to stick in
> > .git/hooks/wrapper-clone (for example) and then calling 'git hook run
> > wrapper-clone'. That's doubly compelling in a later config-based-hooks
> > world where 'git hook run' gets you free multihook features like
> > ordering and parallelism. I will likely want to remove this when
> > rebasing my config-based hooks work on top of your restart.
> 
> Indeed, FWIW this was part of my general approach of narrowly supporting
> existing git behavior only with 'git hook run', i.e. there's no general
> "run this thing like a hook for me" now, so we're not losing anything by
> not having it support that.
> 
> But yes, I can see how "run this script for me as if though it were a
> hook" would be useful, will be trivial to support it & still somehow
> assert typos/that hook-list.h / githooks.txt is a source of truth about
> our known hooks.

Hm, I see - you're using the BUG() to gently remind people that they
should go and update githooks.txt if they call find_hook("new-hook").
Ok, I'll add a flag or a wrapper or something in my own rebase - so 'git
hook run' doesn't check but internal calls do.

Thanks for explaining the intent better.
 - Emily
