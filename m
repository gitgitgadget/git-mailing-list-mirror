Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6F8C433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 05:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiFFF3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 01:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiFFF3B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 01:29:01 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CBA92D10
        for <git@vger.kernel.org>; Sun,  5 Jun 2022 22:19:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id q21so26775035ejm.1
        for <git@vger.kernel.org>; Sun, 05 Jun 2022 22:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aAbUCcZKDVNdZlZrAajhtAWtpBYkkE4UYbk2qXAjWUM=;
        b=PW0M+kfuWSJ6gs2RSfqlzze6W2Z5UNJIiKlEqIdyzOQV6rXK7EwMsBrmFCek/IYZYM
         CtNvzhZXcCnLnM5zjsgiZbngu0JD/d+2ZSdi1khOYHqph5zDYq9gp5NzhoeNlOxhvEg5
         kGUklKDlEW2HOABOysn0lkyyCrF0/cTH9SZXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aAbUCcZKDVNdZlZrAajhtAWtpBYkkE4UYbk2qXAjWUM=;
        b=tUjidZSXozcGjLdVKOsBgQx95kWFauysZb9TsAKICV7MCqR/LIBaZAiWIomFI58b8/
         wQigrXdGex0WGrtQnZv2Wtlh7i8w8VN2ItR8Wyael4wcG/7rFa/5kCUmyCOybKbMKEAx
         sO2HSe+CJF31t96hT+QnuFwm1csX8kX1bdJS/CW1QqxJgFPGKYDA/L2s+Ltzknm1sppj
         CrwiIxLmE175WxslN8IYU3YZ1Fm9vZn5PnbcNUntlvUFSR7GJlrdI4XzlKb/W4VNOU+k
         eqAXcUuhwy7w0rBAhwbkbd4wzJ/3ixmRbo3uIAKaH0q9FO5gCWAtEN/APQ8GQ2jt4iRw
         oPew==
X-Gm-Message-State: AOAM533faIxMuAYdkAJAN3cQzM/tRoqg80I9u72PqFOPtnx3p3nhA7RZ
        t16AU8wX7biwdjpCSWCD25acbFhEfLlub1Dw8y3DC+z3i+s1Sw==
X-Google-Smtp-Source: ABdhPJwUJXN0Gqw9Cgh8mhrQbfxMf0W0fifwI0XQs+XB4ogK8PYxZUx6C0Nyob3uVAJDXhIX9F5RkFTScWAMf8Hwamw=
X-Received: by 2002:a17:907:6e20:b0:6ff:1541:8d34 with SMTP id
 sd32-20020a1709076e2000b006ff15418d34mr19250137ejc.447.1654492746681; Sun, 05
 Jun 2022 22:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <87h750q1b9.fsf@gnu.org> <CAPMMpohzqKo-+q-tOcXymmzGxuOY-mf2NPRviHURm8-+3MPjZg@mail.gmail.com>
 <87y1yb2xc8.fsf@gnu.org>
In-Reply-To: <87y1yb2xc8.fsf@gnu.org>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 6 Jun 2022 07:18:55 +0200
Message-ID: <CAPMMpog-7eDOrgSU9GjV4G9rk5RkL-PJhaUAO3_0p2YxfRf=LA@mail.gmail.com>
Subject: Re: [BUG?] Major performance issue with some commands on our repo's
 master branch
To:     Tassilo Horn <tsdh@gnu.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 5, 2022 at 12:55 PM Tassilo Horn <tsdh@gnu.org> wrote:
>
> Tao Klerks <tao@klerks.biz> writes:
>
> > I haven't attempted to debug this, and personally have little
> > incentive to do, as switching to "git log" and accepting the process
> > overheads solved *my* problem.
>
> And I'm happy to report it solves *my* problem as well.  There's a PR
> for the Magit git porcelain replacing "git show" with an equivalent "git
> log" incarnation which makes the 30seconds "refresh status buffer"
> operation instant.
>
>   https://github.com/magit/magit/issues/4702
>   https://github.com/magit/magit/compare/km/show-to-log
>
> Still maybe someone might want to have a look at the "git show" issue to
> double-check if the performance burden in this specific case (no diff
> should be generated) is warranted.

I spent a little time with this yesterday, and can confirm:
* My issue seems to be the same as yours, "export GIT_TRACE2_PERF=1"
shows all the time being spent in rename detection
* "git show" is a slightly different entry point into the "git log"
code (log.c, cmd_show())
* options to the "git log" functionality are largely collected in a
"rev_info" object (defined in revision.h)
* one option is the "-c / --diff-merges=combined" option of "git log"
(setting rev_info.diff, rev_info.combine_merges and
rev_info.dense_combined_merges)
* another option is "-s / --no-patch" option of "git log" (setting
rev_info.diffopt.output_format |= DIFF_FORMAT_NO_OUTPUT)
* the "--patch" and "--no-patch" options seem to be (and are
documented as) opposites, but they are not implemented as such; one
calls for the work to be done, and the other only hides the output.
* the "diffs" options are set automatically/implicitly for "git show",
before argument parsing
* we can simulate the "git show" performance issue in "--git log -1"
by setting "--diff-merges=combined" *and* "--no-patch" explicitly
* this performance issue does *not* present in a "git log" call with
only the regular "--patch" argument, however; this basic "show
patches" instruction defaults to "--diff-merges=off", which means the
rename detection work does not need to happen. There might still be
slight diff-related overheads, but they are undetectable in my
testing.

Therefore, I have confirmed it is possible to get "git show" to behave
the way we would expect for "--no-patch", by *also* specifying
"--diff-merges=off".

There are at least two possible approaches / directions to improving
these issues generically in the "git show" implementation, I think:

1. Add some "git show"-specific code, saying something along the lines
of "if --no-patch is specified, then also imply "--diff-merges=off".
This feels like the safer option / less likely to have side-effects.

2. Add some post-processing to the generic "git log & git show"
options parsing, to generically propagate "--no-patch" into other
properties like those set by "--diff-merges=combined"

I don't feel confident enough with the code here to try for the second
approach, but the first looks like something I should be able to
propose a patch for - and in the meantime I know how to get the
"single-process, many arbitrary commits" performance benefit of "git
show" again. Thanks for sparking the exploration down this little
rabbit-hole!
