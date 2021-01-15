Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58ABFC433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 08:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ECCF22BEA
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 08:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbhAOIja (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 03:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730102AbhAOIj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 03:39:29 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35578C061757
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 00:38:49 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id w3so7816974otp.13
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 00:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nYAyGP9LH0WpwvgC10BLev1B6D/rFbswRYwul9XL1B4=;
        b=FweGNdMlf7ufTXCl6rM63CxXB/qxVpetxwxInHjyHSWkvvB0NY1HUvNTR8lP5jIUl3
         wqW+eCnOdFHYzb1JBoE2S5N9+rEhSU+Xqpjp/A653pxoXTV6BeBkgKSL0ETzwWBWlTSZ
         YIYDwsqjAx/sAZeQmfZgA5iPSsL12vyoyR9BSW86KfMfMDW21YhEg9QKNUPTDXa2Oynh
         mRzbfUSaf9q1zbeZJH3CVXGRbYgzj/qIX9qtUK9ZdIeDxc5goKBIxPXXE8GrqD1SFb2d
         zky2i/yO4LreY4LeTAcQlzaMkHugAwQNHL1ACrIBRrQOEOqx6m9R4u1D/Rbz7oyOttQB
         PjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nYAyGP9LH0WpwvgC10BLev1B6D/rFbswRYwul9XL1B4=;
        b=P1ibOc0BMeK/3k7IptiolqFmBRk9YmeGmKBChd0A/SR75KnyNHOFMw+OcvspTn85Fs
         NS8SKIv4xRlXnEcVzhfjxdeDZKS/qCLZG1Cu0SICFpf5WpKA47QeVEx9Lf1eSd0TbhTG
         7W/u1p3nP75LIsqxt+w1eO8iUmwYjs61wgkfs4j+aJeGqgEyC6yLEjFFgSIPKEQ5z//D
         b0eoetuNJkNwol//6f9BmyKmpXsm8PnoyCMz2Yj8/62jBuB/muJcXmfMjUUKy72fSWEP
         ZKBEav6Y+Gk0XmJ2gJxEkCJzq9fj/uhLGodZOtD35ml+LmQAYPuuTnop7zo5N6dGogAJ
         MITA==
X-Gm-Message-State: AOAM530W9Ayhyw0BX4T65KSXP/thjAJBG0YBA03G/9i1mWlJNX/CDYa/
        yusbjKgIue4l0VwJHEc1vD4EZ0OosHfAszrf/X8/R/u9ZG8=
X-Google-Smtp-Source: ABdhPJxXeQHB1nNV2ThwuXUhV+UvUK22uj5Q9gXtkKJuzH+mkAX6geCL/5Qonx7SDLf4ngmZY9QulaS6r++S9nfZuT0=
X-Received: by 2002:a9d:741a:: with SMTP id n26mr279548otk.210.1610699928657;
 Fri, 15 Jan 2021 00:38:48 -0800 (PST)
MIME-Version: 1.0
References: <20210108092345.2178-1-charvi077@gmail.com> <20210108092345.2178-2-charvi077@gmail.com>
 <X/8/WassxF7ujqjX@nand.local> <CAPSFM5ew583ZPZO9XUWxskQPsdSv520gKCM30GH2huhdTDxb2A@mail.gmail.com>
 <ac1691d6-e13e-2c04-b105-73a0645f4883@gmail.com>
In-Reply-To: <ac1691d6-e13e-2c04-b105-73a0645f4883@gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Fri, 15 Jan 2021 14:08:37 +0530
Message-ID: <CAPSFM5eBCVD9sx-AkA6Zr-PAq3JgTftcf2UhZBcBmK_00ff1+Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] rebase -i: only write fixup-message when it's needed
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 14 Jan 2021 at 16:16, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Taylor and Charvi
>
> On 14/01/2021 08:12, Charvi Mendiratta wrote:
> > On Thu, 14 Jan 2021 at 00:13, Taylor Blau <me@ttaylorr.com> wrote:
> >>
> >> On Fri, Jan 08, 2021 at 02:53:39PM +0530, Charvi Mendiratta wrote:
> >>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >>>
> >>> The file "$GIT_DIR/rebase-merge/fixup-message" is only used for fixup
> >>> commands, there's no point in writing it for squash commands as it is
> >>> immediately deleted.
> >>>
> >>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> >>> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> >>> ---
> >>>   sequencer.c | 12 +++++++-----
> >>>   1 file changed, 7 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/sequencer.c b/sequencer.c
> >>> index 8909a46770..f888a7ed3b 100644
> >>> --- a/sequencer.c
> >>> +++ b/sequencer.c
> >>> @@ -1757,11 +1757,13 @@ static int update_squash_messages(struct repository *r,
> >>>                        return error(_("could not read HEAD's commit message"));
> >>>
> >>>                find_commit_subject(head_message, &body);
> >>> -             if (write_message(body, strlen(body),
> >>> -                               rebase_path_fixup_msg(), 0)) {
> >>> -                     unuse_commit_buffer(head_commit, head_message);
> >>> -                     return error(_("cannot write '%s'"),
> >>> -                                  rebase_path_fixup_msg());
> >>> +             if (command == TODO_FIXUP) {
> >>> +                     if (write_message(body, strlen(body),
> >>> +                                       rebase_path_fixup_msg(), 0)) {
> >>> +                             unuse_commit_buffer(head_commit, head_message);
> >>> +                             return error(_("cannot write '%s'"),
> >>> +                                          rebase_path_fixup_msg());
> >>> +                     }
> >>
> >> I'm nit-picking here, but would this be clearer instead as:
> >>
> >>      if (command == TODO_FIXUP && write_message(...) < 0) {
> >>        unuse_commit_buffer(...);
> >>        // ...
> >>      }
> >>
> >> There are two changes there. One is two squash the two if-statements
> >> together, and the latter is to add a check that 'write_message()'
> >> returns an error. This explicit '< 0' checking was discussed recently in
> >> another thread[1], and I think makes the conditional here read more
> >> clearly.
>
> I don't feel that strongly but the addition of '< 0' feels like it is
> adding an unrelated change to this commit. It also leaves a code base
> where most callers of `write_message()` do not check the sign of the
> return value but a couple do (there appears to be one that checks the
> sign already and a couple that completely ignore the return value). If
> we want to standardize on always checking the sign of the return value
> of functions when checking for errors even when they never return a
> positive value then I think someone in favor of that change should
> propose a patch to the coding guidelines so it is clear what our policy
> is. When I see a '< 0`' check I tend to think the positive value has a
> non-error meaning.
>

Okay, I looked into the write_message(...) and agree that it does not return
a positive value and only returns non-zero for error case and zero for
success. So, for this patch maybe we can ignore checking '< 0' here and
later add another patch to make this function follow the convention of
"negative is error".

Thanks and Regards,
Charvi


> Best Wishes
>
> Phillip
>
> > Okay, I got this and will change it.
> >
> > Thanks and Regards,
> > Charvi
> >
> >> Thanks,
> >> Taylor
> >>
> >> [1]: https://lore.kernel.org/git/xmqqlfcz8ggj.fsf@gitster.c.googlers.com/
>
