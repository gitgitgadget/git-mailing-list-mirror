Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61367C6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 07:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 435616128E
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 07:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhGVHJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 03:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhGVHJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 03:09:27 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1B1C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 00:50:03 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id h8so5639457eds.4
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 00:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LFX2d7fPoE9Sso+RbvqFAPhmWkGUdg0Eke4UYiQ3sJo=;
        b=uKIaH/t+akxPpyMJRo32GhbYa5JEUSRzjIA8OzlZLMzegOyYMOn0rzvq3sHwfcMBwA
         KJJ5Xa5wp2pOmtL4/EKP3rBut9J50pcq51AGqe+L61Ph4adi7jAisUgvxYr5bnsSCCs0
         tvG1bJ5lxfNmQJivRy9yyfsPlJZCTwN9fOWxNCRdwZqmUTFiE0Y2bnuV/CBNP9ULCKQR
         ASqEDot59BUJIrMYmZaSj1YZ+ebNPApF7UevHk3FhlPG9WzvcabkXikIRW+clbZz4/XW
         k5kXU6thrCLUGr8N4Rgr7/wc+OwH3GbQ99me4nhKVBhxmU7xqHTnkCniNfXVbno3gO+2
         R53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LFX2d7fPoE9Sso+RbvqFAPhmWkGUdg0Eke4UYiQ3sJo=;
        b=Hjl/fcBLnGGxzgKl4xT1dfVJIvvyBem1OahzI1b/MEWfsAdCB2vYgwUOT7Ngke9soh
         LfJmHAr3UOhI1RF8bGZOaU3gMOTIK5i/3DJeJPfkwk4MUy4m4qdyXDYSOP8ID3HJBq4z
         08DWZ4c2bkQD/sOaEGphPhB4y+HQYjIHTlEe8FyZG7FgwNh36Ks6NJVy1iAGBogkQLcs
         U8Q4ZWlmlU9beNZ7Vie1gveEWBBVXIY9M6ejt03N6JEa6ocNNaiPgEbGis/c5ANp1UU+
         g/kMW6WhRKTADIGXaXkbVTAIg6958Qnf7f0lPhcQ5bzPbKCh8+k1HR/qJvCHxaJaagD0
         uiKQ==
X-Gm-Message-State: AOAM530eC0cOquaVPaapCHwE4kipMBY5V+9ZxOESwtAVRHEfV2TmiaW0
        DhwtiioxYYbeV1FYUb80i1pNHuuTHQOx7X6aVcQ=
X-Google-Smtp-Source: ABdhPJz52ktV9xmpyKsbS3LUHmQOTa29lBo8PVVojhbbDlPwJVhZV+Qn5YhRwXWzhIgVYSY6YtbcvAVNWOwaGpAP0to=
X-Received: by 2002:a05:6402:3549:: with SMTP id f9mr53250113edd.387.1626940201687;
 Thu, 22 Jul 2021 00:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8QLrG+R3sOHpMsAiveOT1wTKR-_Nw8Ro6iXL1_MTMZ6eA@mail.gmail.com>
In-Reply-To: <CAOLTT8QLrG+R3sOHpMsAiveOT1wTKR-_Nw8Ro6iXL1_MTMZ6eA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 22 Jul 2021 09:49:50 +0200
Message-ID: <CAP8UFD1Y-sL9UbU_U-adUhzMgR-UFFSNg6tdM=45c878WHhURQ@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 9
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 19, 2021 at 8:55 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> My ninth week blog finished:
> The web version is here:
> https://adlternative.github.io/GSOC-Git-Blog-9/

Thanks!

> ## Week9 BUG REPORT
>
> ### BUG REPORT 1

First, it would be better if these bugs were submitted to the mailing
list separately, one in each own email with a relevant subject, so
that people can more easily find and discuss them separately. It's ok
then if you link to these bug reports from, or copy parts of them to,
a blog post.

> * What did you do before the bug happened? (Steps to reproduce your issue)
>
> Because someone told me that `git cherry-pick` can't gave useful
> prompt information like `git rebase -i` does:
>
> ```
> You can amend the commit now, with
>
> git commit --amend
>
> Once you are satisfied with your changes, run
>
> git rebase --continue
> ```
>
> I found that I can take use of "GIT_CHERRY_PICK_HELP" environment variable,
>
> ```
> $ GIT_CHERRY_PICK_HELP="git cherry-pick --continue" ggg cherry-pick v1

Not sure what `ggg` is. Is it GitGitGadget, `git`, an alias with some
features turned on, or something else?

Not sure what is `v1` also. Is it a tag to a random commit?

> ```
>
> which will output prompt information "git cherry-pick --continue", good!
>
> * What did you expect to happen? (Expected behavior)
>
> I could use `git cherry-pick --abort` to exit cherry-pick normally.
>
> * What happened instead? (Actual behavior)
>
> Then I couldn't use `git cherry-pick --abort` to exit cherry-pick normally.

What happened when you tried to use it? Or what prevented you from using it?

> * Anything else you want to add:
>
> See the print_advice() in sequencer.c, `CHERRY_PICK_HEAD` will be removed
> if we use the env "GIT_CHERRY_PICK_HELP". It is used by `git rebase
> -i` and somewhere else.

So you got an error because `CHERRY_PICK_HEAD` had been removed?

> Here may have two solutions:
> 1. Prevent users from using the environment variable "GIT_CHERRY_PICK_HELP".

This means that we should remove it, right? Otherwise what's the
purpose of keeping it if users are prevented from using it? Or maybe
there is something I don't understand?

> 2. check if we are truly cherry-pick.
>
> ```c
> diff --git a/sequencer.c b/sequencer.c
> index 0bec01cf38..c01b0b9e9c 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -409,8 +409,9 @@ static void print_advice(struct repository *r, int
> show_hint,
> * (typically rebase --interactive) wants to take care
> * of the commit itself so remove CHERRY_PICK_HEAD
> */
> - refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
> - NULL, 0);
> + if (opts->action != REPLAY_PICK)
> + refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
> + NULL, 0);
> return;
> }
> ```

So this solution means not removing CHERRY_PICK_HEAD if we are indeed
cherry-picking instead of rebasing. Yeah, this looks like a logical
solution to the issue to me. Could you send this in a separate patch
with a proper commit message?

> ### BUG REPORT 2

Thanks Atharva for replying to this bug report!

> ### project progress
>
> I am still thinking about how to improve the performance of `git
> cat-file --batch`.
> This cannot be solved quickly, keep patient.

Yeah, sure! In cases like this when the issue is not easy to
understand, it could be a good idea to keep some kind of research
journal where you describe the issue, the possible ways to solve it
and how your research to solve it goes. It could be a text or markdown
file in a branch, or a shared Google doc, for example.

> My mentors told me to split my main patch series into a few smaller
> patch series, but how?
> In other words, there is a certain correlation between these patches,
> If they are really split into
> multiple patches, how can I send them to the mailing list without repeating?

Yeah, I am not sure if it's possible and easy to send a patch series
based upon another one when using GitGitGadget. But you could perhaps
still send the first patch series, and then focus on getting it merged
and on performance issues. Discussing performance issues can probably
be done by only sending diffs in regular emails or RFC patches that
cannot be applied to the mailing list until a proper solution is
found.

> I just received half of the GSoC bonus, and felt a burden of responsibility...

No need to feel too much responsibility, we all share responsibility
in this. Also feel free to privately email me or Hariom and me (maybe
Kaartic too) if you want to discuss this further privately.
