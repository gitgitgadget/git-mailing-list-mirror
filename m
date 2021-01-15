Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E99C433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 20:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0E5523603
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 20:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbhAOUIc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 15:08:32 -0500
Received: from mail-ej1-f51.google.com ([209.85.218.51]:33908 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbhAOUIb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 15:08:31 -0500
Received: by mail-ej1-f51.google.com with SMTP id hs11so12709402ejc.1
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 12:08:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vg54Z8sILYmD1HFvyG2jX1/8/qKRFKj5JQrXGFR42XM=;
        b=qx1U7qc+VhVXSofYhXlCKeaW6fJ0tmDYdUA6AfaAPFw+cwHufiBd06QXWYTFpvyqdk
         Yj9mTWyxgmU+DeafOZwcI9iMN52drw3CbJtwnjgDOa2GFCIGFt0V+2G0VO4QH1/ytS13
         YQI5R23t6DTw98HK3sMwTfhuPQDApqf78CVFbbOvPMNk3Rtq2/LdgiFVF+xiqjuAMKQO
         qgQ6Ki/0yr0xoJ8RG7wAarOgKQ/BFc2o4+Ez3kT+NDWQWHzRhvHimN7Y6JYQJwaa7RVK
         LagcTsKXi5IbN/fZBTsWyLe/qNGdppiymdyWZDSCAUFocs3IdGsFdIMLlkXz+uTZasDk
         4HiA==
X-Gm-Message-State: AOAM532gNtAe3IK+QWHqci+LnL74dKCssJQVjNuLj2olVpHTo1bH2tC4
        PN7dUka29G7MXy7zNVHdokBC+Hnmj10VzQf9r+Y=
X-Google-Smtp-Source: ABdhPJxBexaOcp9SkgDsz2UT3BN9sctdoqmWiaBKy7lDOfyfcjyQV5WPALJvnmCvI9xVY6/fsibZN/YUWO6NjUofqWY=
X-Received: by 2002:a17:906:2617:: with SMTP id h23mr2281390ejc.168.1610741269454;
 Fri, 15 Jan 2021 12:07:49 -0800 (PST)
MIME-Version: 1.0
References: <xmqqk0sevqlh.fsf@gitster.c.googlers.com> <YAH0G+Y4fIxoTeZa@coredump.intra.peff.net>
In-Reply-To: <YAH0G+Y4fIxoTeZa@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 15 Jan 2021 15:07:38 -0500
Message-ID: <CAPig+cSWa_jgUjPXVMeOUwxQV_9Qhv0f-Wyb3odJnb1UpcOcPg@mail.gmail.com>
Subject: Re: [PATCH] ci/install-depends: attempt to fix "brew cask" stuff
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 15, 2021 at 3:00 PM Jeff King <peff@peff.net> wrote:
> > -     brew cask install --no-quarantine perforce || {
> > +     brew install --cask --no-quarantine perforce || {
>
> On a related note, it feels like perforce is a frequent offender for
> triggering spurious failures (both for homebrew setup, but I have
> definitely seen racy/flaky failures from it as well). I am tempted to
> say it is not worth the trouble, but then I do not care at all about
> git-p4 myself in the first place, so I may be biased.

To be fair to 'perforce', though, the fault of this particular problem
is Homebrew, which doesn't seem to be all that concerned about
backward compatibility, at least in my experience. The single
Homebrew-related automation script I wrote for personal use has been
broken by arbitrary Homebrew changes frustratingly often over the last
three years.
