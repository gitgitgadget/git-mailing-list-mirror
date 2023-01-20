Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21119C05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 16:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjATQrr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 11:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjATQrq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 11:47:46 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354E8CDF5
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 08:47:45 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id g13so8946352lfv.7
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 08:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hz9vrhVPO8iU9IqvtfC6p+gnfLfb/yo0o8qBtdrON4s=;
        b=PmYl7TiNAhc8Qb0L8nsSnklTHChlg5q2N+A87k7/HAK/qrIvUl98xVmmo34+HAMbOL
         ykgoISg2KvHONhYRMJzXl9zbZqPcjqfmIdhQWQ6/dvRmVF7U53kpiK5mXK65SGdjeRel
         wUfMAcsPj0jfzn4mlrKe2XNUSK3exnaCN3R5bnEHyCrC8k9hk5QzbHD4vXvg9fQ3CSQV
         jf0kSNbUs6PLTKPcp0pwiwiUCFepXkGqpdYHX5mvmDkCz3D2Z5Il0xKjHs7qmx5WLhGT
         c+39Wq7LHSQINlXh7E/hzV8Ev/pu8mjotTRTHC5UiXXsMZ1ptyaYVkWFujs7T5GHuovd
         tAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hz9vrhVPO8iU9IqvtfC6p+gnfLfb/yo0o8qBtdrON4s=;
        b=yUyPHTXpVfj3MbTqvj/MSoKwIGaQvJFGjwUnqRf/iuqym/pP30xUjIMj5pWyWE/l6J
         pZTe73dwqRCDRdBizGKZusoJcyy9zUFK0UOxkxQ5sVunqRv5i7UMUVjhc80dXROxsj5+
         +LtinFQxs/0BpfjgahVAlc6B1XsiKujlWCFwjXkP/w1+eezcdjdgI4ioT6ne6n6VDbhP
         edUuOjjeGWA7dBPr1D3AgFE3MA5IYX2kPIBHzmOt2msR+ucK/LPc1Hz7XS7yYCz5g+Fq
         1opH7xg15i/YJUJWlpI3Gl94w8DyY59CQ3EAR6puqWJXR2YAPrWP0ueTApgBZ28QnGur
         QihQ==
X-Gm-Message-State: AFqh2koUhf6cBqdQXGa5681BilFD5ymjgQ5iHQu5ZQ6WHaVZ4L3M35JH
        gVm2ZSxzxXIfHbe8AvZ4BgI98JGctS5jyPKcY9U=
X-Google-Smtp-Source: AMrXdXsWYk3nlDNf7GuAg4qVYZlX4aFAEG/0QvhB2U2rOb2orm10sZOJ4Za2XlKvWQC3ILaILxJj/wL5V1t7QiX8L+A=
X-Received: by 2002:a05:6512:3b9c:b0:4b5:9233:6e9b with SMTP id
 g28-20020a0565123b9c00b004b592336e9bmr1526156lfv.394.1674233263279; Fri, 20
 Jan 2023 08:47:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.1466.git.1674106587550.gitgitgadget@gmail.com>
 <f480813c-7583-179f-0149-d970d3f2519f@github.com> <xmqqr0vpxm3d.fsf@gitster.g>
In-Reply-To: <xmqqr0vpxm3d.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Jan 2023 08:47:30 -0800
Message-ID: <CABPp-BHDhpSVpuaubTP=smWaf7FBmpzB-_Frh0Dn5oN+vx0xzw@mail.gmail.com>
Subject: Re: [PATCH] rebase: mark --update-refs as requiring the merge backend
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2023 at 7:27 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Derrick Stolee <derrickstolee@github.com> writes:
>
> >> +    if (options.update_refs)
> >> +            imply_merge(&options, "--update-refs");
> >> +
> >
> > This solution is very elegant. The only downside is the lack of warning
> > if --update-refs was implied by rebase.updateRefs=true, but I'm happy to
> > delay implementing that warning in favor of your complete solution here.
>
> If features A and B are incompatible and both can be specified from
> both command line and configuration, ideally I would expect the
> system to operate in one of two ways.

I agree that one of the two ways you highlight below would be ideal.
Should this series be held up on extending the checks to implement
this ideal, or are you just commenting for whoever later circles back
to implement this?

>  I haven't thought it through
> to decide which one I prefer between the two.
>
>  * Take "command line trumps configuration" one step further, so
>    that A that is configured but not asked for from the command
>    line is defeated by B that is asked for from the command line.
>
>    This way, only when A and B are both requested via the
>    configuration, of via the command line, we'd fail the operation
>    by saying A and B are incompatible.  Otherwise, the one that is
>    configured but overridden is turned off (either silently or with
>    a warning).
>
>  * Declare "command line trumps configuration" is only among the
>    same feature.  Regardless of how features A and B that are
>    incompatible are requested, the command will error out, citing
>    incompatibility.  It would be very nice if the warning mentioned
>    where the requests for features A and B came from (e.g. "You
>    asked for -B from the command line, but you have A configured,
>    and both cannot be active at the same time---disable A from the
>    command line, or do not ask for B")
>
>    When A is configured and B is requested from the command line,
>    the command will error out, and the user must defeat A from the
>    command line before the user can use B, e.g. "git cmd --no-A -B".
>
> A knee-jerk reaction to the situation is that the latter feels
> somewhat safer than the former, but when I imagine the actual end
> user who saw the error message, especially the suggested solution
> "disable A from the command line or do not ask for B from the
> command line", may say "well, I asked for B for this invocation
> explicitly with -B from the command line, and you(Git) should be
> able to make it imply --no-A", which amounts to the same thing as
> the former choice.

If it is clear to the user that A and B preclude each other, then I
agree with this sentiment that the former choice (silently ignoring
the config) would avoid a minor frustration for some users and thus
would be better.  But I don't think that's applicable here.  There is
no reason that --whitespace=fix shouldn't be available from the merge
backend other than that we haven't implemented it yet, and it's likely
feasible to implement --update-refs for the apply backend with enough
effort if we thought it was worth it.  So, if a user sets
rebase.updateRefs=true in their config because they always want
included branches updated, but one time they run `git rebase
--whitespace=fix`, they will likely have a negative experience like
the one that inspired this patch.  Perhaps we're forced to choose
between possible frustration by different end users, but if so, I
think trying to debug and figure out "Wait, I switched to this branch
and started tweaking it but it appears to not have some relevant
changes I'm sure I made to it yesterday.  What happened?" is a much
worse frustration than "I have to manually specify --no-A in this
special case".  So, when it's not at all obvious that A and B preclude
each other, I think we're better off giving the error.
