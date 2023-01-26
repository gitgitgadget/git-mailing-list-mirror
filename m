Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18672C05027
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 18:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjAZSwb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 13:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjAZSw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 13:52:29 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F1D125A5
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 10:52:29 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-50660e2d2ffso36273437b3.1
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 10:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eNNKm7W61wsnBni1MvZZgAef+wx/7plIJ9HXMWbkXWc=;
        b=b3T0beBQAtFiC+iauwQCjBTZvH3fj1/UPa5qGqKM1h/7Vi2P5KlF2QLS0vLoMZqNg8
         QHvuBFeuqC1/T+x1eCUbX2P8hoyGegXeLltHj8Uh6bLmbWgTkfVGLHyIkMQrxzsF507B
         x1jQ13f4CXP66YWB6kWvxCmPZSxGrYQ6yX0l7tybRwrsZFlqUL8ROobeQ9xjtQCmr6Xr
         vmsTLikCoPskhRJFQ65gE+IghdjNYWL6OfVeh6+kyoOpo8qBk7k9OlZfMiYvRh6Dti52
         2zZov93CwYdPfrmTnIJQrV84TTuHvR5r4xzbLw86t3/1L4E5JkxzKQybTO4UbLOHGyOC
         Rrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNNKm7W61wsnBni1MvZZgAef+wx/7plIJ9HXMWbkXWc=;
        b=byPW95zVeBIQ22C88MhUrDuBqTPORYNT/LyMEKTCGqu3TVRFnbadCp0CZPOURGaGGH
         BODxqLjtaNOdLkGWNLIHWKTEDaxLsYsnkxBoAmN5l4aDWZY644nmBtivE5Wnm+5U0HLo
         yHlj4rZXa7z5BC8SIzy2YM3AN9TSnuByWz47yCXoaDfhGewcSKPLrXkN6lGG3iHslYn8
         yMviMQHan/nN3dLYWNIVh6A+pSCQqeM4kTz7cm0GBb/kVglMTlpRGI/XrODBAwk1AwUa
         Uof6jIb132D66dfO9sdFZHsSrao+LMGDkKpQebDPE5NUNn9zVxUMUoZdxprNjuYhD9x5
         eZdw==
X-Gm-Message-State: AFqh2kousPcWEM9qn5PHcNUgGpIM4dtAl55c88e2qogKD5mDzH75C/Ou
        Q8ZZl74uOKn1UF0Wr5n3EUAuRqTeX1HGlF7MWFWtHA==
X-Google-Smtp-Source: AMrXdXtbo5F5juYW33uqg3kbA0ofIp/CY/4wU4xiwLP2l6yuxKfcF8N1LkknXK7YwZVf9K4FoBJ8Yjp+a87qIs5fCjk=
X-Received: by 2002:a81:160a:0:b0:4e3:f87:8c24 with SMTP id
 10-20020a81160a000000b004e30f878c24mr4894271yww.248.1674759148068; Thu, 26
 Jan 2023 10:52:28 -0800 (PST)
MIME-Version: 1.0
References: <20230104215415.1083526-1-calvinwan@google.com>
 <20230117193041.708692-6-calvinwan@google.com> <kl6lilgtveoe.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lilgtveoe.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Thu, 26 Jan 2023 10:52:17 -0800
Message-ID: <CAFySSZBiW7=ZTmXRaLzCoKUi0Jd=fzvW5PJ6=Ka0jKHoP2ddSw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] diff-lib: parallelize run_diff_files for submodules
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com, avarab@gmail.com,
        phillip.wood123@gmail.com, newren@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 26, 2023 at 1:16 AM Glen Choo <chooglen@google.com> wrote:
>
>
> Calvin Wan <calvinwan@google.com> writes:
>
> > @@ -226,6 +242,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
> >                       newmode = ce->ce_mode;
> >               } else {
> >                       struct stat st;
> > +                     unsigned ignore_untracked = 0;
> > +                     int defer_submodule_status = !!revs->repo;
>
> What is the reasoning behind this condition? I would expect revs->repo
> to always be set, and we would always end up deferring.

Ah looks like a vestigial sanity check. You're correct that we would
always be deferring anyways.

>
> >                       newmode = ce_mode_from_stat(ce, st.st_mode);
> > +                     if (defer_submodule_status) {
> > +                             struct submodule_status_util tmp = {
> > +                                     .changed = changed,
> > +                                     .dirty_submodule = 0,
> > +                                     .ignore_untracked = ignore_untracked,
> > +                                     .newmode = newmode,
> > +                                     .ce = ce,
> > +                                     .path = ce->name,
> > +                             };
> > +                             struct string_list_item *item;
> > +
> > +                             item = string_list_append(&submodules, ce->name);
> > +                             item->util = xmalloc(sizeof(tmp));
> > +                             memcpy(item->util, &tmp, sizeof(tmp));
>
> (Not a C expert) Since we don't return the string list, I wonder if we
> can avoid the memcpy() by using &tmp like so:
>
>   struct string_list_item *item;
>   item = string_list_append(&submodules, ce->name);
>   item->util = &tmp;
>
> And then when we call string_list_clear(), we wouldn't need to free the
> util since we exit the stack frame.

Unfortunately this doesn't work because tmp is deallocated off the stack
after changing scope.

> > +test_expect_success 'diff in superproject with submodules respects parallel settings' '
> > +     test_when_finished "rm -f trace.out" &&
> > +     (
> > +             GIT_TRACE=$(pwd)/trace.out git diff &&
> > +             grep "1 tasks" trace.out &&
> > +             >trace.out &&
> > +
> > +             git config submodule.diffJobs 8 &&
> > +             GIT_TRACE=$(pwd)/trace.out git diff &&
> > +             grep "8 tasks" trace.out &&
> > +             >trace.out &&
> > +
> > +             GIT_TRACE=$(pwd)/trace.out git -c submodule.diffJobs=0 diff &&
> > +             grep "preparing to run up to [0-9]* tasks" trace.out &&
> > +             ! grep "up to 0 tasks" trace.out &&
> > +             >trace.out
> > +     )
> > +'
> > +
>
> Could we get tests to check that the output of git diff isn't changed by
> setting parallelism? This might not be feasible for submodule.diffJobs >
> 1 due to raciness, but it would be good to see for submodule.diffJobs =
> 1 at least.

ack.

>
> >  test_expect_success 'git diff --raw HEAD' '
> >       hexsz=$(test_oid hexsz) &&
> >       git diff --raw --abbrev=$hexsz HEAD >actual &&
> > diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
> > index d050091345..52a82b703f 100755
> > --- a/t/t7506-status-submodule.sh
> > +++ b/t/t7506-status-submodule.sh
> > @@ -412,4 +412,23 @@ test_expect_success 'status with added file in nested submodule (short)' '
> >       EOF
> >  '
> >
> > +test_expect_success 'status in superproject with submodules respects parallel settings' '
> > +     test_when_finished "rm -f trace.out" &&
> > +     (
> > +             GIT_TRACE=$(pwd)/trace.out git status &&
> > +             grep "1 tasks" trace.out &&
> > +             >trace.out &&
> > +
> > +             git config submodule.diffJobs 8 &&
> > +             GIT_TRACE=$(pwd)/trace.out git status &&
> > +             grep "8 tasks" trace.out &&
> > +             >trace.out &&
> > +
> > +             GIT_TRACE=$(pwd)/trace.out git -c submodule.diffJobs=0 status &&
> > +             grep "preparing to run up to [0-9]* tasks" trace.out &&
> > +             ! grep "up to 0 tasks" trace.out &&
> > +             >trace.out
> > +     )
> > +'
> > +
>
> Ditto for "status".

ack.
