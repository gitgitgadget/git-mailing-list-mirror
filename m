Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E58FC433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 18:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 024CD60FEF
	for <git@archiver.kernel.org>; Thu, 20 May 2021 18:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhETSKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 14:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbhETSKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 14:10:09 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6B6C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 11:08:46 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id w15so20881551ljo.10
        for <git@vger.kernel.org>; Thu, 20 May 2021 11:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ocfu/7Fbgjb+YOSc99MI/vIquhJV3dA/0lE55NgWrQg=;
        b=ogeFvdYrgZ+msUQUFB7Jk6QIpkBGjH0nw7GhxG/wQGZr2AmlAsvX4+xQe5vebAnfpI
         SUWpVzqjxxJ6k+a/1RDUkPHCt+jj1+mYR22+Nrw1ZoyqaNfSQR38StNZB2rggfCasqqU
         o6cuQMnp0e0+rBl5IWwGD9HUOV1mmycF+SIc+aklHtHOa7ZYpmhxaLfCMq5ZRC7/q2LA
         XwoodBZheNyJvhSTAFOPvjwXbUhK1f9TsuWAN8EM3AhW3G0Q6CQnEdEKJgs+tX2usPFB
         hKsE+gGOBGtHrYo5e/+b1WSNE0M41vewL6DnBWiesbb2Aqbygnzwp6myYRuIgQxetqPM
         nSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ocfu/7Fbgjb+YOSc99MI/vIquhJV3dA/0lE55NgWrQg=;
        b=hks//StjHdgTBESBkHTZqRfUQKV6wbQFrYjazFX80hksXPL2hw36dHvlFPjPDmSjWN
         TxB+1msNdLeytaoccpiCGzRNQkkYzZ3cEl8+JdSbJaTolKVDT3K9gchBnPvjxU2Pqpow
         uVrSZfaG6B3eCKkuUv9bsJ3YoEN+h4Is6OWvngaURZHtwVcRLBEBsGEHSFjNtxuHZ7Kq
         CPDCBSdf1u/EvSFqbkfhJ3yr++Gvc7qPcCoGiFbbM1Rwv1U5BEjoMEVC4fgG/vEnvPbH
         GrFOUpbfnhMHaL85oih4pcf4KPza194+LoolwEo7SC8rM7KOjAekW8A1Arms/ZCdFB/V
         nqjg==
X-Gm-Message-State: AOAM532jf+A4+LiscGZgB9WmtEchihVO9RhgxgsY7cUHzYK8Vy8pq4bC
        XzLvNwP1voPrUdc/xPSKhqsYQ9Z1qKKyimUfw/flgw==
X-Google-Smtp-Source: ABdhPJzt2/LwuBkFLdLhoIo2h7zgZhdDLjiwuDs+LxEo4tYg8viUssCvdpDOR+Tvhx6/DNyEW8G7+3eecTAlwvA8xig=
X-Received: by 2002:a2e:9b11:: with SMTP id u17mr3888251lji.346.1621534125109;
 Thu, 20 May 2021 11:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com>
 <YKViF9OVLeA95JPH@google.com> <20210520071141.GZ8544@kitsune.suse.cz> <YKaaBj0KmJ3K5foC@coredump.intra.peff.net>
In-Reply-To: <YKaaBj0KmJ3K5foC@coredump.intra.peff.net>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Thu, 20 May 2021 11:08:33 -0700
Message-ID: <CAJoAoZknTNNZEvGsm3fjSxsNR4ezv8z=Argj4u6cD=mVtC6E-g@mail.gmail.com>
Subject: Re: Should we do something with #git-devel on Freenode?
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 10:19 AM Jeff King <peff@peff.net> wrote:
> So if there is a critical mass of useful people that will hang out on
> the Matrix equivalent of #git (or whatever other tool), then that may
> become a new place. And people who want to do that should let people
> know where they can be found (whatever happens, I'd appreciate a PR to
> https://github.com/git/git-scm.com updating the "Community" page).

Yep, this was my point, really. git-scm and the MyFirstContribution
doc both have pointers to #git-devel on Freenode for now, and if we
want to move away we should change those.

As for where to go instead, I tend to agree with Junio's statement:
> > > [...] I do not mind
> > > supporting the folks who were at freenode to show appreciation for
> > > the service they gave us so far, by moving to where they are now.
> > >
> > > If all candidates offer similar level of stability and archival,
> > > that is.

 - Emily
