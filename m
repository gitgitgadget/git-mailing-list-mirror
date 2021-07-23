Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507DAC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 18:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BCDE60ED7
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 18:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhGWRmS convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 23 Jul 2021 13:42:18 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:41560 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGWRmR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 13:42:17 -0400
Received: by mail-ej1-f41.google.com with SMTP id hb6so4922165ejc.8
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 11:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jeAQQH1SszbqUp7tEESr5pHWDCqxaL7Ae6m46u9fY7k=;
        b=bf1MTq/063F0dbeLCdSrGF5SHCkqjLDmrcPqBEaiGUDRz3AlBoIo98JWHB2jeqoxvf
         e3tZHfWBskayskTpfbEGwzWNolOn6VVjfs7yfCVyTiQxeytJZuQWwNz30libIkUoAZXB
         pkkYMeQ18rf4dnGwLz9YJuoBdDp+gmbukl3lsfvx44ghL1mFT5nsfF+x2W2JmKWoeEYD
         qP9WahN38SoYszAWF0A23YMawruTVwahIqzKqlcpiQgBeAFJRWqcJF0x9noBYC9pHzLX
         cR5qqkf2AGchDuai7z96l1EKn8D4G0Jl9qr2WAslTwk3+iO4BV6Z1kEl/j9PJdUwFIcf
         LrSQ==
X-Gm-Message-State: AOAM531Zqn5NTlKXby4FSb7yoDOOkk+J8SMgbiQQ/j1BfviNowZiPGqE
        an3RGYag+bm/+2ZSTOYMGuO7/fnPzZiIAf367Nw=
X-Google-Smtp-Source: ABdhPJzt0XwtEL1L/cNoIAWOkJeg+uRvXC5qCeXvBJQaHJivEkGn+b4iS16t2Tl5ZrBYpX2dVufjOnOcvK8Y22uIYg4=
X-Received: by 2002:a17:906:f9c5:: with SMTP id lj5mr5900626ejb.482.1627064569234;
 Fri, 23 Jul 2021 11:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-5-emilyshaffer@google.com> <87lf66y6pd.fsf@evledraar.gmail.com>
 <YPnwBu4oMA9K445J@google.com> <60fafd8295996_defb208dc@natae.notmuch>
In-Reply-To: <60fafd8295996_defb208dc@natae.notmuch>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 23 Jul 2021 14:22:38 -0400
Message-ID: <CAPig+cS6EmxZeO5Ad3oUMn2tkSwE1CdLTaA7-Pp2CbmO--EW3g@mail.gmail.com>
Subject: Re: [PATCH 4/9] hook: treat hookdir hook specially
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 23, 2021 at 1:34 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Emily Shaffer wrote:
> > On Fri, Jul 16, 2021 at 10:58:34AM +0200, Ævar Arnfjörð Bjarmason wrote:
> > > At this point I tihnk it would be way better to squash this and other
> > > such changes that basically add a field to a struct that isn't used yet
> > > into whatever commit use/need them.
> >
> > I think at this point we run into you and me having different
> > patch-storytelling styles - which probably is what led to the big topic
> > restart in the first place ;)
>
> Yes, but as a reader of the story I prefer not to have to read the
> entire thing in order to understand it. I prefer each page to tell a
> small story.
>
> Putting my armchair reviewer hat I cannot do that for this particular
> patch, I would need to do more work to make sense of it, and while I'm
> writing this message to explains that, others will simply skip it, and
> that's a lost opportunity.

Implicit in what Felipe and Ævar are saying is that a well-structured
patch series asks the reviewer to keep only one or two details in mind
after reading a patch in order to understand the next patch in the
series, and that the reviewer shouldn't be expected to keep a large
set of details in mind over several patches. Unlike the author of the
patches who can keep all the details in mind at once and understands
the series in its entirety, reviewers (usually) don't have such
luxury[1]. So, it's important to hand-hold reviewers as much as
possible by not asking them to remember a lot of details between
patches and by ensuring that the details which they must remember only
need to be remembered for a very short time. This is why it is
helpful, for instance, to bundle documentation and test updates in the
patch with changes to code, so the reviewer can see at a glance that
the changes to documentation and tests match the changes to the code,
rather than delaying documentation and test updates until later in the
series.

[1]: If you've ever read a novel in which the author has multiple
story lines running and switches between story lines infrequently,
such that when the author switches back to story-line "A", which you
last saw 100 pages ago, and you can't remember what was going in "A"
or even who the minor characters are anymore, so that you have to go
back and reread 10 or 20 pages from the previous time you saw "A",
then that's representative of the difficulty reviewers can experience
when reading a patch series, except with a patch series, the cognitive
load is already quite high. (Very nice run-on sentence I just wrote.)
