Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D235EC4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 05:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiKUFMX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 00:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKUFMW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 00:12:22 -0500
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9852BB19
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 21:12:21 -0800 (PST)
Received: by mail-pg1-f173.google.com with SMTP id b62so10206776pgc.0
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 21:12:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unAWiGjMWI5jd+DdgakxIWfX3i8uVIXZg5++YaG5vxs=;
        b=ymRq9Lly3mHqqKi7X7tHqUz03Gj9S+w++R/pvuYzPxs7676B5M0YBf1lCBFGUeV9xa
         NeUBjhDgZ7U55lqwElBEOswkXwysPPBb/5SBtDhuvcXEoKXD2vACU8po2gV4t/LL/mn3
         1Kj6a1maiW4CmuLgP18TuGx5mn3pNwDuWE8GFOcJgrZ1zmyJGO0KG2GGdcc7Q2Y7AUzi
         2z5YNSKFL0aRdGrgoNarpPJBGlgCfPkAQRU8wIAyUmcGK081Saei8IQauBUaWrd9FU//
         CtUA4UqfaTs29FqsgsRi64XMm/doh7LilZslaNPmZlQdLGflcfbwmzZ9lJNr6+NP64sM
         gPXg==
X-Gm-Message-State: ANoB5plX7d+uTMJpPeBAh6SSRpEO26Wr5y+TITFQHhP4NjN67EG0DOWd
        ekQ3sbE0ypu2qoLHW1Zoe+J4v2QArjtao5citj07e8nM5Kc=
X-Google-Smtp-Source: AA0mqf73102PuiuSZBoFQ9NN/OZnEDnrq5bQjOwv0GSl9xrNrhy5u6AVpNZxSc+xOo84QPmtbxO+SfnvSnvsNTUpi9U=
X-Received: by 2002:a63:d43:0:b0:477:66b9:341b with SMTP id
 3-20020a630d43000000b0047766b9341bmr4131775pgn.130.1669007540473; Sun, 20 Nov
 2022 21:12:20 -0800 (PST)
MIME-Version: 1.0
References: <4657a19c-89c3-2237-9e6b-db897a492072@opensuse.org>
In-Reply-To: <4657a19c-89c3-2237-9e6b-db897a492072@opensuse.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 21 Nov 2022 00:12:09 -0500
Message-ID: <CAPig+cT92EokWeVA_Ou1P6kkaq90wneRrgPqnKLbkHnc=U56Vg@mail.gmail.com>
Subject: Re: git can not be built for s390x since update to git-2.38.0
To:     Sarah Julia Kriesch <sarah.kriesch@opensuse.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[cc:+git; taking this back to the mailing list so others can weigh in]

On Wed, Nov 9, 2022 at 1:38 AM Sarah Julia Kriesch
<sarah.kriesch@opensuse.org> wrote:
>  > Gesendet: Sonntag, 06. November 2022 um 21:42 Uhr
>  > Von: "Eric Sunshine" <sunshine@sunshineco.com>
>  >
>  > On Sun, Nov 6, 2022 at 2:18 PM Sarah Julia Kriesch
>  > <sarah.kriesch@opensuse.org> wrote:
>  > > We have also identified this week, that chainlint.pl --stats says "0
>  > > tests". That can explain the empty output.
>  > >
>  > > ~/rpmbuild/BUILD/git-2.38.1/t> /usr/bin/perl chainlint.pl --stats
>  > > --emit-all chainlinttmp/tests
>  > > total: 0 workers, 0 scripts, 0 tests, 0 errors, 0.01s/0.01s (wall/user)
>  >
>  > Was `--stats` added for debugging this issue, or is that somehow part
>  > of your build process?
>  >
> Yes. We tried to debug that manually. Therefore, we have added the --stats.
>
>  > What is the content of the "chainlinttmp/tests" file? Is it empty?
>  >
> It is empty.
>
>  > It is quite curious that it reports 0 scripts. It should report 1
>  > script even if chainlinttmp/file is empty. This might point a finger
>  > at File::Glob::bsd_glob() returning an empty list for some reason, or
>  > the problem could be a failure with Perl "ithreads".

Do you happen to know if Perl is built with "ithreads" on your
platform, and if so, is "ithread" support working?

The empty "chainlinttmp/tests" file also sounds suspicious. If you
haven't already done so, I would recommend following the advice in [1]
and running each command individually which Makefile would have run;
this might allow you to isolate the problematic command or shell
construct if such exists.

[1]: https://lore.kernel.org/git/CAPig+cS184iKk6icG6ML=X+6Ng=fJyfic8izFyp1hT40cChm4g@mail.gmail.com/
