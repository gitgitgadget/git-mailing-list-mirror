Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9607EC433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 23:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B77864E20
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 23:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhBVXH1 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 22 Feb 2021 18:07:27 -0500
Received: from mail-ej1-f51.google.com ([209.85.218.51]:37156 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhBVXHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 18:07:25 -0500
Received: by mail-ej1-f51.google.com with SMTP id d8so31882171ejc.4
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 15:07:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e6SdMAQR6KeJcMZJWVQzsLvOyzGmMJRFBS9FIkYvMF4=;
        b=MSlR7191Hl5jEqDRSBV293nhM3MS6mV28cjY/Q8BLSdPfvx/53/JgNgb2TtT5VuLDk
         qAZDy1PNaKovbpPnLmJfNrLPEqfhcUJuXyksxKgguiA2CwDAi5nUPsJXDxdGkG4X1LEr
         9EVLKHRnUjG+DbXhqijY+NeByh6+DEAN24kpO53qcWcO0HCPbh7QN7X/dsnq3X8nsh9I
         1MRpAKF/nxy1dCr0M32ufKWQlpNuSPUvc40zIdK8FnKm2j75DpySCSOGSEjF8tM6unA7
         A5MUaU1QGKglK8YE7RFxoYi2gB9P7tgqZU7TpoH4cRv72jhkTdgLvjLYXs0BH7fdS9EO
         0+6A==
X-Gm-Message-State: AOAM530JAWfJ2kXkJnSNYeAL5+Ntk+33WSo8whKHrReSAvsRsAH213m4
        AXTLvAE7SWgS1FAW4/VqHw4J+6iVnVUQgyl64KvYIuih
X-Google-Smtp-Source: ABdhPJzrS+hxCzqDMANU9MgUvOoymbVSyIrDPr5wxEJlFEOXQ97ReSY95hBrN0SCuMf4Te5te44CKecAD3QTxi8Ho1k=
X-Received: by 2002:a17:907:76c6:: with SMTP id kf6mr15993563ejc.311.1614035203437;
 Mon, 22 Feb 2021 15:06:43 -0800 (PST)
MIME-Version: 1.0
References: <jwvwnwqrqwd.fsf-monnier+gmane.comp.version-control.git@gnu.org>
 <CABPp-BE1QXA0ohB9D-tqKpzDTok0BMsGQjotmcqMxfs9AL5noA@mail.gmail.com>
 <CAPig+cRzXd+zd+xVisaW+HToSaGzAE28acGmxwRxNU4bczHXbw@mail.gmail.com>
 <87wnv688u4.fsf@evledraar.gmail.com> <CAPig+cQ9oqMWjBkyRt-SQFuyfAGkMu1J-U6ZCCJqeL0a_3ynkw@mail.gmail.com>
 <87ft1o8mi0.fsf@evledraar.gmail.com>
In-Reply-To: <87ft1o8mi0.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 22 Feb 2021 18:06:32 -0500
Message-ID: <CAPig+cSkL+5otKUWwm=CLaRR+j71wW61U7LWtmuUHO+7bZaY_g@mail.gmail.com>
Subject: Re: New orphan worktree?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Stefan Monnier <monnier@iro.umontreal.ca>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 22, 2021 at 4:45 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Sun, Feb 21 2021, Eric Sunshine wrote:
> > Rather than making --orphan a boolean flag, we'd probably want to
> > mirror the behavior of the other commands and have <branch> be an
> > argument consumed by --orphan:
> >
> >     git worktree add --orphan <branch> <path>
> >
> > That would make --orphan, -b, and -B mutually exclusive, much like
> > they are for git-checkout, and much like -c, -C, and --orphan are
> > mutually exclusive for git-switch.
>
> I see now (but didn't before, I haven't really used "switch" before)
> that that's how it works.
>
> But that doesn't seem to make much sense as a UI, maybe I'm missing
> something but how do you:
>
>     git switch --orphan existing-branch
>
> Just like you can:
>
>     git switch -C existing-branch <start-point>

When responding to your initial email, I noticed this same shortcoming
of --orphan in both git-branch and git-switch, and assumed that's why
you made it a boolean in combination with -b/-B in "git worktree add".
Before writing that email, I did put a bit of thought into how one
might support a "force" mode but didn't include my thoughts in the
message.

> It's actually this exact use-case that prompted me to write the --orphan
> patch. I wanted to create a "meta" orphan branch in my git.git, but had
> an existing local "meta" (from Jeff King) that I'd happened to have
> checked out long ago which I first needed to "git branch -D".
>
> Wouldn't it make more sense for a feature like this & back-compat to
> start with switch's "--orphan" implying "-c", but you could also supply
> "--orphan -C" instead? And in worktree have -b and -B work like they do
> for other branches.

I'm not sure I follow. In git-switch, --orphan does not imply -c even
though --orphan also creates a new branch (thus seems to work similar
to -c); it is nevertheless mutually-exclusive with -c and -C. The same
goes for --orphan in git-branch.

As far as combining --orphan and -C (or -c), I'm not sure how we would
arrange that using the existing parse_options() mechanism. It seems
too magical and has potential for weird corner cases.

Since git-worktree doesn't yet support --orphan, we certainly have
more leeway and could go with your proposal of having --orphan be
boolean and always requiring it to be used in conjunction with -b/-B.
However, I'm quite hesitant to take that approach since it breaks with
existing precedent in git-branch and git-switch, in which case
--orphan takes its own argument (<branch>) and is mutually-exclusive
with -b/-B/-c/-C.

When I was pondering the issue before writing my original response,
two thoughts came to mind. (1) "git worktree add --force --orphan
<branch>" would be one way to make your case work; (2) given how
infrequently --orphan is used, we just punt and require people to
first use "git branch -D <branch>" if necessary (which has been the
status-quo for git-branch and git-switch). The latter thought is
superficially tempting, though it doesn't help in automation
situations since "git branch -D <branch>" errors out if <branch>
doesn't exist, so a script would first have to check for existence of
<branch> before attempting to delete it prior to using "git worktree
add --orphan <branch>".

So, I don't have any great answers at this time.
