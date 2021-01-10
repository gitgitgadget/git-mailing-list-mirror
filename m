Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E73C433DB
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 07:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E9A2239CF
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 07:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbhAJHcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 02:32:53 -0500
Received: from mail-ej1-f53.google.com ([209.85.218.53]:45071 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbhAJHcx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 02:32:53 -0500
Received: by mail-ej1-f53.google.com with SMTP id qw4so20147403ejb.12
        for <git@vger.kernel.org>; Sat, 09 Jan 2021 23:32:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M285HRURDM+J7oXrXqGdjfkWuFaogzTqsGg6dGI/bco=;
        b=SvtKGlyfBU3kS1xNYskfyPmnlgCIFlaK7jBpI/fwEIgcV96NZCBanLLlo8wzrzrTvb
         lwRCOYCSmvwIxL/jOq3Nn1MafUyXqtu27XOJRRLs0/QMPT9YceldXpDW/6vpnjUifvcN
         O5K6Bpk+3nOdvEjDIqd6LLk0c8V+uiXGxuitwoRfso/POK77iE8dflI9FCSo0S8k7vI+
         j93U0cBu2BHQvBoL36I+v4M1xIH9SO1lYhuCzS4FBFwr1jj3nNEFeEPS2JC/oJGA0n+K
         f4BRbvJ2iF+pxsMajpf4S35rBRQfCjPA7ZIzfx3GgZ82lMafQ8qErug3nW0QhrL72bvQ
         bv+A==
X-Gm-Message-State: AOAM533lnCf+C/zixeVSyWqqCMtmbhWliOobbiyWj32hCPmBAmJ4dzXn
        FfXzM97caFSAHeihmhlGEw5zGRxhSh4BWb8OvnckJzMSrLw=
X-Google-Smtp-Source: ABdhPJxKbWXoBdE8i+ZAs7OkfhWlD8PtYwtmxDkPz0BmeKscLhyK3AO/8B+lqv4I5odzrdqFDsc/ScQ2mQN7YMo15Sw=
X-Received: by 2002:a17:906:1ed6:: with SMTP id m22mr7722067ejj.231.1610263931000;
 Sat, 09 Jan 2021 23:32:11 -0800 (PST)
MIME-Version: 1.0
References: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
 <pull.830.v3.git.1610136177.gitgitgadget@gmail.com> <xmqq1retclzr.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1retclzr.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 10 Jan 2021 02:32:00 -0500
Message-ID: <CAPig+cQnZbKRu+iSGDzhMsG6bgEL1NbAu15DR3dNXM-Nfc9w8A@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Remove more index compatibility macros
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 10, 2021 at 2:03 AM Junio C Hamano <gitster@pobox.com> wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > UPDATE: this is now based on ag/merge-strategies-in-c to avoid conflicts in
> > 'seen'. The changes in builtin/rm.c still conflict with
> > mt/rm-sparse-checkout, but that branch seems to be waiting for a clearer
> > plan on some corner cases. I thought about ejecting it, but 'rm' still uses
> > ce_match_stat(), so just dropping the patch gives less of a final stake at
> > the end of the series. (I'm still open to it, if necessary.)
>
> I haven't read this latest iteration myself yet beyond the cover
> letter, but tonight's 'seen' has this queued near its tip.  I expect
> it would either stay there or occasionally ejected, until the base
> topic solidifies a bit more.
>
> >  * Methods that know about the 'repo' pointer no longer also have an
> >    'istate' pointer and instead prefer 'repo->index'
> >
> >  * This includes the callback_data struct which only has a 'repo' member, no
> >    'istate'.
>
> OK.

I looked this version of the series over and did not find anything
else about which to comment.
