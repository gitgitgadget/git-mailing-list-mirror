Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB54C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 04:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B1C264ED4
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 04:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhBBEJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 23:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhBBEJy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 23:09:54 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5022C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 20:09:12 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id y9so6200194ejp.10
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 20:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E9V8tU/uPLCP6pL/yJMhs+MzVYfJCpTjYiJidGUmj/E=;
        b=s3KU6rP7tBtSQZ5ovHHw/6Hbk1Fw3iNqVooHOtlBs3obOhebMoTudf0y74Vxdv42JB
         W/TgNGTREaAhOhjfXVxZz3+g1U6Pl88dCeMr5XrU+OozUfGqebd9bFurXBf3Etg/q2ex
         9PVSUJdE6izny6t/0/smgGF4g7wrySK6eN92CtiMuVuldWTebv4Yz3h3hhz59Q6fJcrQ
         Fu45XHxRkTYL3o77PrmfmsUS60oQWxCEFC1fzlxAi9/qrUha4ZMDgj7YXFI6BusLlM0C
         6JazD9qQG2JO8+XVZHpOW8FIp17ZzaXOtUIljCRVNWS5rf8heFxwrXw+EnIACivHr9N9
         oMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E9V8tU/uPLCP6pL/yJMhs+MzVYfJCpTjYiJidGUmj/E=;
        b=PM25+1+YJjsOLxsdOoBh8Fipf91qTAMM+PHDt6ykbeVcfB7Zfg1jzCIKl1tjlh8grg
         kw5wDKEErFEQ/3ZX2Q17rKcQOKMklRgauhcl0uxYhR4kMaMYc74i2WHQqa5yc4N/+6Ql
         TfQ9Py73Prpnv6mRk2Z1yl2l+nwJ+e4ysh+WwFKQJVaWfdzoAwsZwlROr+mp6VtGGdCK
         OJFwP+Fu9hAV3PU/KjaVaTnqIJg3Hje20mTDrCH2R1WfL0NIGNGxIGUSqKIx5oZ17E00
         xlCs96mvmXYSwx1tFjatWqPVHQDH+SDyxR2JggFXiqAhPTk/b+sdZAn35vkSzdT40A0s
         E0vw==
X-Gm-Message-State: AOAM532y9C0ztWrupg4lg0NJiIrz5kLR62wQ/BD/XOp3HlPOt4NZ1Twb
        2HESVQ9D63+QiojrXjcm+9B18ofQyoaZd96KxsnO/pLmdQKaxg==
X-Google-Smtp-Source: ABdhPJyAcOv5NGjZhmXHkxeFPF8R3j8+0pneCmGoZaAUvNXvl+mavyjS5Y9/UqGoLySpOJgwX8r6ehItCBiL0OwkYss=
X-Received: by 2002:a17:906:fc4:: with SMTP id c4mr21369331ejk.143.1612238951615;
 Mon, 01 Feb 2021 20:09:11 -0800 (PST)
MIME-Version: 1.0
References: <pull.854.git.1612021544723.gitgitgadget@gmail.com>
 <CAPig+cQMn6oc4Jh=gb1jNfArXJBYhPRaSzJJvvbvprit6_OC0g@mail.gmail.com>
 <CACPHW2X2UGAVmNM+cHXs6dwVfZbgLFZ0iUGU89h04H5czAt1Ww@mail.gmail.com> <CAPig+cS-hnwp2HjkkFPeJ4aibFHnJ0VZq0DSVgdWB0H_q5=oXw@mail.gmail.com>
In-Reply-To: <CAPig+cS-hnwp2HjkkFPeJ4aibFHnJ0VZq0DSVgdWB0H_q5=oXw@mail.gmail.com>
From:   Lance Ward <ljward10@gmail.com>
Date:   Mon, 1 Feb 2021 22:09:00 -0600
Message-ID: <CACPHW2VBEu=02HFhyrDes=6KceLtHzGDqBJVf2qAnD2s1f8VAg@mail.gmail.com>
Subject: Re: [PATCH] status: learn --color for piping colored output
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Lance Ward via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <ericsunshine@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

I've updated my patch per your request.

On Sun, Jan 31, 2021 at 5:09 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> [cc:+junio +peff +duy +dscho +rene]
>
> On Sun, Jan 31, 2021 at 1:49 PM Lance Ward <ljward10@gmail.com> wrote:
> > On Sun, Jan 31, 2021 at 1:31 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > On Sat, Jan 30, 2021 at 10:51 AM Lance Ward via GitGitGadget
> > > <gitgitgadget@gmail.com> wrote:
> > > > diff --git a/diff.c b/diff.c
> > > > +void set_diff_color(int use_color)
> > > > +{
> > > > +       diff_use_color_default = use_color;
> > > > +}
> > >
> > > This new API for setting `diff_use_color_default` feels a bit too
> > > quick-and-dirty and assumes that the caller has intimate knowledge
> > > about when it is safe/correct to call the new function. Did you
> > > consider the alternate approach of having wt-status functionality set
> > > the appropriate diff_options.use_color value at the time it drives the
> > > diff machinery? For instance, as a test, I added:
> > >
> > >     rev.diffopt.use_color = s->use_color;
> > >
> > > to the functions wt-status.c:wt_status_collect_changes_worktree(),
> > > wt_status_collect_changes_index(), and wt_longstatus_print_verbose(),
> > > so that the `use_color` value from the `struct wt_status *` supplied
> > > by commit.c:cmd_status() is automatically applied to the diff options.
> >
> > Originally I tried to use what I thought would be a much more appropriate
> > method which is to simply let the --color flag set things the same way
> > as the config option status.color=always does, but I noticed it does
> > not work the same when piped.
>
> I'm not quite sure what you mean. How exactly did you originally
> implement --config to accomplish this?
>
> > For example the following produces full color output:
> > git -c status.color=always status -v
> >
> > However, running this colors only the status, not the diff:
> > git -c status.color=always status -v | cat
> >
> > Right now I can only get what I expect by running:
> > git -c status.color=always -c diff.color=always status -v | cat
> >
> > This appeared to me to be inconsistent behaviour [...]
>
> At an implementation level, this behavior makes sense, but I can see
> how it might be confusing and unexpected from a user's viewpoint. I
> think the approach I suggested of patching those wt-status.c functions
> to use:
>
>     rev.diffopt.use_color = s->use_color;
>
> would fix this inconsistency, wouldn't it?

Yes, it did.

>
> > [...] and lead me down
> > a path trying to figure out where the color was being disabled which
> > made me realize that the status command shares code paths with
> > the commit message and porcelain output.  I wanted to be very
> > careful not to do anything which might break either of these in some
> > unforeseen way which is why I created the function.
>
> I see where you are coming from and understand the desire to isolate
> this behavior change, however, I can't shake the feeling that this
> sledge-hammer approach is going in the wrong direction and that the
> fine-grained approach I suggested in my review is more desirable.
> Having said that, I'm not particularly familiar with this area of the
> code -- and had to spend some time digging through it to find those
> functions in wt-status.c to make the fine-grained approach work -- so
> it would be nice to hear from people who have spent a lot more time in
> that area of the code (I Cc:'d them).
>

I've made the change you requested and it resolves the issue.
It also fixed the inconsistency I mentioned.  I only needed
to modify wt_longstatus_print_verbose to resolve the issue
since it is the only status path that had an issue with the
git status command.

> > If you feel existing unit tests would mitigate any issues with commit
> > messages and porcelain output I can try going the route you
> > suggested instead?
>
> I doubt that anyone on this project feels that the unit tests have
> sufficient coverage to make any guarantees. However, for changes such
> as the one I proposed which might have unforeseen side-effects, Junio
> tends to let the changes "cook" for a while in his 'next' branch
> before promoting them to the 'master' branch so as to give time for
> unexpected fallout to be discovered.
>

I did not have to patch all the functions you mentioned and think
the new change is cleaner and will not break anything else.

> > Also if you agree the behavior of status.color should be the same for
> > both piped and not piped output I could add that to this patch as well?
>
> I'm not quite sure I understand your question. Are you asking if
> `color.status` should imply `color.diff`? If so, I haven't thought a
> lot about it, but I can see how the present behavior may have a high
> surprise-factor for users, so it might be worthwhile.

Yes, the inconsistency I mentioned was basically that:
color.status implies color.diff when outputting to stdout,
but this is not true when outputting to a file.  My latest
change resolves this inconsistency.  Now color.status
implies color.diff when running git status regardless
of where the output is going.

>
> In fact, I can envision this patch being re-rolled as a two-patch
> series which (1) patches the wt-status.c functions to do
> `rev.diffopt.use_color = s->use_color` which should make
> `color.status` imply `color.diff`, and (2) adds a --color option to
> `git status` which sets `wt_status.use_color` (which would then be
> automatically inherited by the diff machinery due to the first patch).
>
> (By the way, `status.color` is a deprecated synonym for `color.status`.)

Right now as it stands my patch resolves both of these, but
if you'd like to make it two separate patches that would be fine.
