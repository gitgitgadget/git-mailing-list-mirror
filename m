Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAE9ECAAD5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 18:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiIBSy0 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 2 Sep 2022 14:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiIBSyS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 14:54:18 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A586F1157C2
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 11:54:07 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id j204so4431032ybj.2
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 11:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UX4VAJX2x/91dMxE3GzaHWTce9G6mkGgix1oEWbV6gs=;
        b=4n3uasrD5PVggPN40/QZ5aBd88sd9y72wCmYPtTxPW9pRUjZWDcDxf1cCBRJ1YjjaQ
         WHwznyT2WeW8gX+2xaipRtwQqUdRMVHsQwUzeQivxi7rrnsuysqL20ARfs67EjPU6Sha
         Csqjip9Q/d4i6wMa/8hEbxJKVSp53uRH2HppeYzecOkeg0pL0mQZ3eMFuskFc36Lm9Ym
         fD/KwMiiiyUpMU72Q7FEpVCI7y6CbwAcmjyWzuRF8kj9KRzMaWn/vTEt74b+X1nVeKFx
         NyjFStOpa6JEabN972EmRV+DmzDqbNgM5uPXps21d+WDBTKjShUfr3co6cvT3UYLZlL7
         JEYQ==
X-Gm-Message-State: ACgBeo2VVNDDsoZjGPgclfOlA1hkqYgNouc3h4qWG3ZNwnk8IrGSriEk
        PV4gukQNgcOL5U9yf9u1cwt/3ZjQyhVZ+5IkX/0=
X-Google-Smtp-Source: AA6agR6HeG15Z3YpTfAn/TOUAAT/ElX2I6zUNVMYZ9xOqO31f3bcybsqkoECN/tbRwREVvolvlV2JTmUM3tgEWcR+kQ=
X-Received: by 2002:a05:6902:523:b0:693:9bec:ed14 with SMTP id
 y3-20020a056902052300b006939beced14mr23905426ybs.462.1662144846315; Fri, 02
 Sep 2022 11:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <3423df94bd6035640828a2508968cf8e1f5b4dda.1661992197.git.gitgitgadget@gmail.com>
 <220901.86k06njmvq.gmgdl@evledraar.gmail.com>
In-Reply-To: <220901.86k06njmvq.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 2 Sep 2022 14:53:55 -0400
Message-ID: <CAPig+cT_Z=D2ECJTCC=hosBw9i0vMBZfOAc-+jkPSg3Q519X+w@mail.gmail.com>
Subject: Re: [PATCH 01/18] t: add skeleton chainlint.pl
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 1, 2022 at 8:32 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Thu, Sep 01 2022, Eric Sunshine via GitGitGadget wrote:
> > From: Eric Sunshine <sunshine@sunshineco.com>
> > [...]
> > diff --git a/t/chainlint.pl b/t/chainlint.pl
>
> I really like this overall direction...

Thanks for running an eye over the patches.

> > +use warnings;
> > +use strict;
>
> I think that in general we're way overdue for at least a :
>
>         use v5.10.1;
>
> Or even something more aggresive, I think we can definitely depend on a
> newer version for this bit of dev tooling.

Being stuck with an 11+ year-old primary development machine which
can't be upgraded to a newer OS due to vendor end-of-life declaration,
and with old tools installed, I have little or no interest in bumping
the minimum version, especially since older Perl versions are
perfectly adequate for this task. Undertaking such a version bump
would also be outside the scope of this patch series (and I simply
don't have the free time or desire to pursue it).

> That makes a lot of things in this series more pleasing to look
> at. E.g. you could use named $+{} variables for regexes.

Perhaps, but (1) that would not be very relevant for this script which
typically only extracts "$1", and (2) I've rarely found cases when
named variables help significantly with clarity, but then most of my
real-life regexes generally only extract one or two bits of
information, periodically three, and those bits ("$1", "$2", etc.) are
immediately assigned to variables with meaningful names.

> > +package ScriptParser;
>
> I really wish this could be changed to just put this in
> t/chainlint/ScriptParser.pm early on, we could set @INC appropriately
> and "use" these, which...

I intentionally avoided splitting this into multiple modules because I
wanted it to be easy drop into or adapt to other projects (i.e.
sharness[1]). Of course, it is effectively a shell parser written in
Perl, and it's conceivable that the parser part of it could have uses
outside of Git, so modularizing it might be a good idea, but that's a
task for some future date if such a need arises.

[1]: https://github.com/chriscool/sharness

> > +my $getnow = sub { return time(); };
> > +my $interval = sub { return time() - shift; };
>
> Would eliminate any scoping concerns about this sort of thing.

As above, this is easily addressed if/when someone ever wants to reuse
the code outside of Git for some other purpose. I doubt it's worth
worrying about now.

> > +if (eval {require Time::HiRes; Time::HiRes->import(); 1;}) {
> > +     $getnow = sub { return [Time::HiRes::gettimeofday()]; };
> > +     $interval = sub { return Time::HiRes::tv_interval(shift); };
> > +}
>
> Is this "require" even needed, Time::HiRes is there since 5.7.* says
> "corelist -l Time::HIRes".

Unfortunately, this is needed. The Windows CI instances the Git
project uses don't have Time::HiRes installed (and it's outside the
scope of this series to address shortcomings in the CI
infrastructure).

> > +sub check_script {
> > +     my ($id, $next_script, $emit) = @_;
> > +     my ($nscripts, $ntests, $nerrs) = (0, 0, 0);
> > +     while (my $path = $next_script->()) {
> > +             $nscripts++;
> > +             my $fh;
> > +             unless (open($fh, "<", $path)) {
> > +                     $emit->("?!ERR?! $path: $!\n");
>
> If we can depend on v5.10.1 this can surely become:
>
>         use autodie qw(open close);
>
> No?

No. It's clipped in your response, but the full snippet looks like this:

    unless (open($fh, "<", $path)) {
        $emit->("?!ERR?! $path: $!\n");
        next;
    }

The important point is that I _don't_ want the program to "die" if it
can't open an input file; instead, it should continue processing all
the other input files, and the open-failure should be reported as just
another error/problem it encountered along the way.
