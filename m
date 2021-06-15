Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7DEC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 15:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADFED61621
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 15:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhFOPYB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 11:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhFOPYA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 11:24:00 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87649C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 08:21:55 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id q5-20020a9d66450000b02903f18d65089fso14620109otm.11
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 08:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+3a7qiuzCB18rWjWaTCbE3q0OEHwCrrOouOm2U1OkCQ=;
        b=MGpueuFAUvurCqZFh6jjGLW1ycIkfS5Ii1OUYCp2kIKGWdqHqP+fz3Qya7LH9Zy9sO
         FLS34jilAn5C3Uor0VEhwM7GFvz4oy1Qac5AsbrQQrEiD8q5F6NtNRHF2stuvdfOA2UC
         NK1JFK54og9KL9sQAfMcS4Bo3OPQOaaPUGeGojqeVIJbceCXJETfCpV52WNuTdN8lGSm
         KxTLe7+0Z+vZJGyFztiTFSmf/KHqB8ffwB9KFDb3LlKLMV1gGtRx8/ZnfrxnlQoJOazl
         lQlM1iRMHeWqKUatP6Q9HoDJhqqjAneHQTByfQX0PhZ8f3jES7rN/V5RHiGPkSP5c2a8
         2CVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+3a7qiuzCB18rWjWaTCbE3q0OEHwCrrOouOm2U1OkCQ=;
        b=Xuo7RshB3SA3WzAqORKqadgJO9WGNKG2Y2G7S1q+ss1uyjgsPDR/jThSAi5IbHms0s
         W0ZmtVDbocQvwj0HPa8hd+owpSndGmRq/MXvCc0zzqWmm2tOSB9fHIFAfopJI0SkYBuS
         weauPjWjlcuL0darTCabQK++N4rg4d3/9GiM83Lciwk8x1lJ6jAN8nXaA9oNmL706AT2
         w+hFM8R717tWjUX2HhGNQ9KzmS2jIWF39lcXF5tQIpX/iJPSQlr+Nz2MQ1II0aZ5K9n1
         CNnidOrwidJzAb0d5iuYdG+HOcKclktQjoFz6t/+KKdlyhQOZCRJejhockA2MdViqIE3
         XNqQ==
X-Gm-Message-State: AOAM5312592pf3KFZhBoxsjgv022FLnSQdYy+qaVQZHfFUvyYnRQObsx
        oUjHfG6aeOfcT+lTm0XJsZNXWUy/5C7pOagjvTI=
X-Google-Smtp-Source: ABdhPJydueYxlI9M14ki1oQCrXVQqTTuHar6dTVBh1WPANR0DpcZ/7pMzURqvAqWfpPIarD0ZcO+MTs0rFAeui1xhzo=
X-Received: by 2002:a9d:426:: with SMTP id 35mr17798320otc.162.1623770514836;
 Tue, 15 Jun 2021 08:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210613225836.1009569-1-felipe.contreras@gmail.com>
 <20210613225836.1009569-5-felipe.contreras@gmail.com> <CABPp-BGZ2H1MVgw9RvSdogLMdqsX3n89NkkDYDa2VM3TRHn7tg@mail.gmail.com>
 <60c85bfd112a9_e633208d5@natae.notmuch>
In-Reply-To: <60c85bfd112a9_e633208d5@natae.notmuch>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Jun 2021 08:21:43 -0700
Message-ID: <CABPp-BEXtJtkkh9Diuo4e1K1ci=vggGxkLRDfkpOH12LM8TCfA@mail.gmail.com>
Subject: Re: [PATCH 4/4] xdiff/xmerge: fix chg0 initialization
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 15, 2021 at 12:51 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Elijah Newren wrote:
> > On Sun, Jun 13, 2021 at 4:04 PM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> > >
...
> > I'm somewhat worried by the cavalier posting of the zdiff3 patch[1],
>
> When Uwe sent the patch [1] nobody said it was a "cavalier posting".
> Jeff King said "I think the patch is correct".

The difference here is that Jeff reported segfaults after Uwe sent the
patch.  Uwe could not have read those reports before he posted the
patch.  You did read those emails before re-posting the patch.

> > Peff already pointed out that you reposted the zdiff3 patch that had
> > knonw segfaults without even stating as much[3].
>
> He knew that. I didn't.

You knew he had reported it as a possibility.  That behooved you to
try to investigate, either by asking him for details to try to
reproduce, or attempt it on a large range of merges, and then to
report the results when you reposted the patch.  Or, at the absolute
minimum, to at least report Peff's report along with your reposting of
the patch.

> > and that you would have included multiple new testcases to the
> > testsuite both to make sure we don't cause any obvious bugs and to
> > provide some samples of how the option functions,
>
> It is not uncommon for v1 of a patch series to be missing something.
> Uwe's patch series [1] did not include tests either, and nobody focused
> on that. It is completely reasonable to assume that a reboot of the
> series wouldn't initially focus on that either.

Not when folks spent several emails in response to the original about
the finer points of how splitting should or should not work.  Nor when
folks had reported segfaults with the original patch.  With that
background, I'd say it's completely unreasonable to assume that a
reboot of the series comes without any tests unless marked as RFC.

> > You didn't do any of that, making me wonder whether this patch is a
> > solid fix, or whether it represents just hacking around the first edge
> > case you ran into and posting a shot in the dark.  It could well be
> > either; how are we to know whether we should trust these patches?
>
> By assuming good faith [2], and simply asking questions. I don't think
> assuming the worst and calling into question the competence of a
> contributor is a good approach.

I did not assume the worst with your patches.  I assumed good faith
until I was provided with strong counter-evidence as perhaps best
summarized at https://lore.kernel.org/git/YMbexfeUG78yBix4@coredump.intra.peff.net/.
That made it clear something was heavily problematic.  If you hadn't
reposted patches for which there were reported segfaults without
saying anything about those reports, I would have asked you none of
those pointed questions.  In fact, I probably wouldn't have asked them
if your original response to Peff were along the lines of "sorry,
won't do that again" rather than "I don't know how I was supposed to
investigate the few segfaults you mentioned. All you said is that you
never tracked the bug."  It was precisely that cavalier attitude that
made me question this patch in this manner.

> If you want to deride the hours I
> spent working for the community for free which resulted in a patch that
> most likely is a net positive, feel free, I think this doesn't help the
> community, which needs more of this kind of work, not less.

I was not deriding your work.  I was asking deep and pointed questions
due to the cavalier manner in which you were posting, and which you
seem to be doubling down on.  I would say that after
https://lore.kernel.org/git/YMhx2BFlwUxZ2aFJ@coredump.intra.peff.net/,
I'd have to agree with Peff that you have displayed a level of
carelessness with which I am not comfortable for the project.  That
kind of carelessness leads to skepticism in others, moreso when you
double down on it.  It makes me think that if I review any of your
future patches, I need to check them far more rigorously because you
are willing to eschew what I view as even the most basic of
responsibilities in ensuring you are submitting valid patches, and
even worse, you are unwilling to change how you approach the project
even when those are pointed out to you.
