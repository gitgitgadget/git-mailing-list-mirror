Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AE0C48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 16:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB004610CD
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 16:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhFQRAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 13:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhFQRAt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 13:00:49 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B95C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 09:58:40 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so6828505otl.3
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 09:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=vDjcUsT3HcwQu8j6rMlDSEms8fnsD328mfSGsJLwYpk=;
        b=QsSn77gEbWZcls/etCqDVP80o4jplfGwurrKzeyFxeezyf6wPa5VrIsHavMbRGkLoh
         MLNojYesfzsyBUm+5+hmF7+lUt+kGCgX1MZgZhpu9oGQKUOyKVx55cDdJkydGORJBT+v
         KT2LyOB+aWFn3zLKFR2ycdixru0Owx9MLzRuC84Pg3dPlTRAaha7f4KWwaHTvrzdHv6h
         JDHgHfX7lDQdBH6FLnipEr17iOg7JJNGv5MehJZ3e5iVfhBwWVk/Rb76/rCUitAw2R0F
         HJ6B46+FhXDOI1Ad3CzWQrnrfGts0YPe4vqwndSVYa2D5LSEeH6ZRyGBWGJkOWRICXEF
         ERfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=vDjcUsT3HcwQu8j6rMlDSEms8fnsD328mfSGsJLwYpk=;
        b=Aw7c7CnerAVPdqoXYRAUy+y85TrHPllUbLZZb279p7aMs23LKkSCaKjGIhPc4fKRWL
         1UO5LV2dP8BLeq7VLXIa8MGQhlFbO3VviIY4oT1E26QwZdrp4K4wNzUTWv8CQtodWcfp
         WDO9EI3MZvGiyfKv2C+xtw7H5HXwE28UemvRn5uInZAJRLXzBPhfQa1Et+7axu2GWzVP
         LM7nxRZS0Vh/kr0vOhDQOs+cwbOi5bPqHyvp1Bxn2ifnxAnhYrd5kpGJKO2l4wEsKIH8
         YIpQVzauvHvGWkeWgHIiIvAnJhfJbd4Ex2FfHATuxJmX9zzmiFKxRMe4OG8usGZVXrOl
         bGfA==
X-Gm-Message-State: AOAM531ESfqKU1guiBuDMKdFKSST4ilLZZWUL8EjIoeApF4BBMPKCEVI
        iapfItcoCrE8uy3hC1Xuc4A=
X-Google-Smtp-Source: ABdhPJwxdGU9MG535SKd2ckvARE/FxcyCxuPq8jUiALreH7n9ktV30Lo9+Jam3KsCpGsxQTekcLfsQ==
X-Received: by 2002:a9d:4b02:: with SMTP id q2mr5532643otf.370.1623949120329;
        Thu, 17 Jun 2021 09:58:40 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id n21sm1193033oig.18.2021.06.17.09.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 09:58:39 -0700 (PDT)
Date:   Thu, 17 Jun 2021 11:58:38 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <60cb7f3e66cfd_1305720822@natae.notmuch>
In-Reply-To: <CABPp-BE95Y0+d6yVQ0ZqRWnknqc3N1vL04VYoqy-7mvQckfuaQ@mail.gmail.com>
References: <xmqqr1h1mc81.fsf@gitster.g>
 <CABPp-BG53Kd7MhzE3hdq5fjBQVV2Ew3skcUCAuTfM5daP2wmZA@mail.gmail.com>
 <60cb5a02f1b31_1259c2086f@natae.notmuch>
 <CABPp-BE95Y0+d6yVQ0ZqRWnknqc3N1vL04VYoqy-7mvQckfuaQ@mail.gmail.com>
Subject: Re: Contributions which I feel are dangerous and/or deceptive (Was:
 Re: What's cooking in git.git (Jun 2021, #06; Thu, 17))
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Thu, Jun 17, 2021 at 7:19 AM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Elijah Newren wrote:
> > > I hate doing this, but...
> > >
> > > On Wed, Jun 16, 2021 at 7:58 PM Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > > * fc/pull-cleanups (2021-06-15) 3 commits
> > > >  - pull: trivial whitespace style fix
> > > >  - pull: trivial cleanup
> > > >  - pull: cleanup autostash check
> > > >
> > > >  Code cleanup.
> > > >
> > > >  Will merge to 'next'.
> ...
> > Do you see anything wrong with these particular patches?
> ...
> 
> Sorry for responding when I said I wouldn't but let me clarify my own email.
> 
> The *code* changes in fc/pull-cleanups are good, I said as much
> previously.  The commit messages are also fine, except for the
> misleading Reviewed-by claim that you still aren't addressing.

I did address that two days ago:

https://lore.kernel.org/git/60c887f678c88_e63320846@natae.notmuch/

I said I guess I'll avoid reviewed-by.

Do you want me to resend the patches without that trailer? If that's
what you wanted all you needed was to say so.

I just did so, to be safe [1].

> That could be overlooked on its own.
> 
> Any other problematic patches or portions thereof of yours could
> easily have been written off as mistakes and been no big deal.
> 
> My concern is primarily in how you *respond* to feedback.

You titled this sub-thread "Contributions which I feel are dangerous
and/or deceptive", that has nothing to do with feedback.

Additionally, responses to feedback have nothing to do with the parent
thread "What's cooking in git.git".

I'd be happy to discuss any comments you might have regarding my
responses to feedback in the appropriate thread, but I don't think this
is it.

> I feel you have displayed a callous disregard for what others find
> critical and important, and appear to be unwilling or unable to adapt
> and work with the community.

OK. You are entitled to having that opinion, that doesn't mean it's
necessarily true.

I am entitled to have my own opinion and disagree with you, and so can
others.

> It was particularly your recent emails with Peff at [1], [2], and [3]
> that have me deeply troubled.

All those responses are from the same thread for the same patch [2].
That patch never even landed on "seen", nor is there any remote
possibility of it ever landing on "seen", so I don't see any urgency in
dealing with those responses.

That patch has been removed from the archive even though it's a direct
copy of Uwe's patch [3], and Uwe's patch remains there. So this is
clearly an ad hominem thing: if Uwe sends it it's OK, if I send it it's
not OK.

There is nothing urgent for me to do regarding [2], so I'll deal with
the dangling responses of that thread (which likely include personal
attacks) later.

> Troubled enough that I do not want my name used to endorse your
> changes, particularly when I already pointed out that you have used my
> name in a false endorsement of your patch

You may disagree on what "endorsement" means, but most people take:

  Yes, very nice!  Thanks. [4]

to mean an endorsement (approval).

Although the Git project doesn't explicitely state an equivalence, the
Linux project does:

  Hence patch mergers will sometimes manually convert an acker's "yep,
  looks good to me" into an Acked-by: (but note that it is usually
  better to ask for an explicit ack).

Yes, I mistakenly used reviewed-by instead of very-nice-by (or something
similar), which in Git's by-laws could be considered a no-no. I did not
know that at the time, so it wouldn't be generous of you to attribute
that mistake to malice.

But that most definitely is not "false endorsement".

For some reason you decided to launch a personal vendetta against me,
threw personal attacks, and now you are slandering me, implying that I
forged your endorsement of my patch.

This is not true. You did endorse my patch [4].


For reference, here are all the last 5 comments that got translated to a
Reviewed-by line:

  This looks good - it's exactly the same as the change I approved previously
  Looks good to me [Elijah Newren]
  this v2 patch looks good to me
  This change looks good to me [Elijah Newren] (explicit Reviewed-by)
  Thanks, this version looks good to me

Only *one* has an explicit Reviewed-by, and it's by you. I think it's
safe to say it's not a generalized practice.

Moreover, you yourself said "Looks good to me" without an explicit
Reviewed-by [5], and Derrick Stolee used that in his next version of the
series [6].

Why aren't you accusing Derrick Stolee of "false endorsement"?

Could it be that this has absolutely nothing to do with the action, and
everything to do with the person doing the action?


None of this has anything to do with "[c]ontributions which [you] feel are
dangerous and/or deceptive".

Cheers.

[1] https://lore.kernel.org/git/20210617161710.81730-1-felipe.contreras@gmail.com/
[2] https://lore.kernel.org/git/20210613143155.836591-1-felipe.contreras@gmail.com/
[3] https://lore.kernel.org/git/1362602202-29749-1-git-send-email-u.kleine-koenig@pengutronix.de/
[4] https://lore.kernel.org/git/CABPp-BEsQWsHMAmwc3gmJnXcS+aR-FtoMJxBRQ=BpARP49-L-Q@mail.gmail.com/
[5] https://lore.kernel.org/git/CABPp-BFudyBP8c_ROmxDEeuu5AfdoyVW8hNPYqVdFPFNofJnCQ@mail.gmail.com/
[6] https://lore.kernel.org/git/1d825dfdc70b8c658c4b6317310706bb6386f468.1620432501.git.gitgitgadget@gmail.com/

-- 
Felipe Contreras
