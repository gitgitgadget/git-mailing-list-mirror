Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4BCC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 11:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC120206FB
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 11:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oW80QZic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgKKLnq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 06:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKKLnh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 06:43:37 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5043C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 03:43:36 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 10so1979957wml.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 03:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QVniBJY9jfB771xaLEOUQ6faK8HBSWI4wBXXz7Dq83E=;
        b=oW80QZicARZ64r8IYqNiJvUdL8oy0JemYHugZS+oqh1m5ct3AznH0t5dnfPuXnmOV0
         zi5LZfIY3NsLxnQKb9nRPTe0hK2fTSZ0w2YJ9xla1j0OCKw3HtcOB+TMVlyncUY1acIH
         m0N4olVMnOH0w850ohf25CiGGBgKhUW549OBiBog1Gf+l/5kU7i5fE01desRVE/s6Xl0
         erhDLlbKWM0+AGo3EDkAK9mNw4YqEXY/TOCFB8Mabo2LszcvFer4bQfmRBesD8qDeIgJ
         qwJglIqt8UfgxY2aj4awZQ2UYcIzSXkZToj1U1BX6Qy0O813PhN0zDvmzPVvki8yWDY3
         BGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QVniBJY9jfB771xaLEOUQ6faK8HBSWI4wBXXz7Dq83E=;
        b=ju+kMYWniUaD28vB9N3y7pyEZAfDPKND43kF+JWKjcbazB+xQ4YM2IHN4jwS6fHL7U
         AMs04RkA7VpP37zFtHvfu5dPBJM4h+uP5xh/5S73vXkH0CxFrCzlofS0nbgLlA741HYh
         3kTqx+L3P8zg+46PdelW9INyrYnaUEF4Vm6ClmNO/4/RHn8UZOzDqIPyLVuPquf0v6Cj
         wS39sr705dthx9aKqkgfwXdHju6njwQEfVxTUzl3qiwZlOt6z+X5i5QyeVJkZ1zUN+qi
         8//ZMrVxPc9gx2zZjBGRTiRMqWjpt7mWncz/y/o+CexLuaeBfUG3ZgrPa1GQOCdC0Z/D
         h3+g==
X-Gm-Message-State: AOAM530t2fvWOhbv/AaGDvxEKF/S+ltP/dxwcx3S/5NmUpMhp5HjqES9
        vM9BrXSWNm3iJlmrgXxxEHK6FzV08PLBTA3LvQA=
X-Google-Smtp-Source: ABdhPJztRBOw5FIwbgvsUGQMW5D2FWY/fjDbMyAv1BdExThWfXzSg5/qG1LiH8y1aqtD1TjO04T8ampzCwkaRJF+4RI=
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr3747335wma.100.1605095015413;
 Wed, 11 Nov 2020 03:43:35 -0800 (PST)
MIME-Version: 1.0
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
 <20201110212136.870769-7-felipe.contreras@gmail.com> <xmqq1rh05p6f.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1rh05p6f.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 11 Nov 2020 05:43:24 -0600
Message-ID: <CAMP44s0XA6QjOZTJaC5CK9Rp9ySfoH9_rJu-AoEGgprstzprfw@mail.gmail.com>
Subject: Re: [PATCH v2 06/26] test: completion: add run_func() helper
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 11, 2020 at 1:27 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > Pretty straightforward: runs functions.
>
> Hmph, sorry but this is not straight-forward at least to me.  Yes,
> the helper runs whatever is given on the command line, but then it
> does "print_comp", too.  And the proposed log message is not
> entirely clear on the most important thing: why?
>
> What is this "helper" meant to help?  Reduce repetition?

Well, I thought the "helper" part of the title made it obvious: the
helper function does help in not having to type the same code over and
over. But there's in fact multiple benefits.

1. It makes the code more consistent. Everything in the test script
either calls a test_ function, or a run_ function, except the code
that is testing the functions directly.

2. It reduces code (obvious in a helper function), as the same
__gitcomp* && print_comp is executed over and over, with zero
variation.

3. It makes the code more maintainable (I also thought this was
obvious); if we want to add something we don't have to do it dozens of
times, we just do it on the helper function.

Is this enough of a "why"?

It is in fact number 3 the one I'm after, and a line that shouldn't be
part of this patch was smuggled in, so perhaps that's why future
patches don't obviate the need for this one.

But even with no other reason for it, the patch stands on its own.

> > +run_func ()
> > +{
> > +     local -a COMPREPLY &&

This is the line that was smuggled in. It should be part of a separate
patch, since this is behavior change.

> > +     "$@" && print_comp
> > +}
> > +
> >  # Test high-level completion
> >  # Arguments are:
> >  # 1: typed text so far (cur)
> > @@ -452,8 +458,7 @@ test_expect_success '__gitcomp_direct - puts everything into COMPREPLY as-is' '
> >       EOF
> >       (
> >               cur=should_be_ignored &&
> > -             __gitcomp_direct "$(cat expected)" &&
> > -             print_comp
> > +             run_func __gitcomp_direct "$(cat expected)"
>
> This is an no-op rewrite, as we used to do the gitcomp-direct
> followed by print-comp, which is exactly what the helper does.  So
> the helper does reduce repetition, which by itself would be a good
> thing but is there other benefit we are trying to seek (there does
> not have to be any)?

It's not exactly a no-op, since I cleared COMPREPLY. That should be
done in a separate patch so it's truly a no-op.

It is the clearing of COMPREPLY that I'm eventually interested in.
First; that's how the testing framework is supposed to work: test #1
should not interfere with test #2, but second; once the gitcomp
functions are changed to append code instead of clearing COMPREPLY by
themselves and then appending, this prevents the tests from failing.

> >  test_expect_success '__gitcomp - doesnt fail because of invalid variable name' '
> > -     __gitcomp "$invalid_variable_name"
> > +     run_func __gitcomp "$invalid_variable_name"
>
> This one changes the behaviour in that it starts running print_comp
> which we didn't run.  It may be a good thing and improvement, but
> then we'd better advertise it in the proposed log message.

But nothing is done with the output; the behavior doesn't change. The
test still passes or fails irrespective of what print_comp does.

  test_expect_success 'test 1' 'true'
  test_expect_success 'test 2' ': echo foobar'
  test_expect_success 'test 3' 'echo foobar > /dev/null'

These three tests may do different things, but their behavior is the
same, that is to say: with the same input they generate the same
output.

Do you want me to add: "In two places we generate an output that
didn't exist before, but nothing ever reads it." ?

Cheers.

-- 
Felipe Contreras
