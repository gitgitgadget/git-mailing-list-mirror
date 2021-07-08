Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A320C07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 11:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17BAD6161F
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 11:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhGHLTh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 07:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhGHLTg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 07:19:36 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BEAC061574
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 04:16:53 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y42so14355143lfa.3
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 04:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cW//i53m7rhE3tDzOI3p6O445xAcYvOWglMECoJWsFw=;
        b=lbB4vhtqWejq/a2IGFeQ7vtj9CukhSOBA9BnwnHjyQXWi8RkbZ65/zz+clBn1Q19hf
         bwP/fnFcKoB9RvHegtDm8Vr4o8zB5LGNKidX/3Z/J/bqVlN9y19y/pM2ZDN6jRP4nR1n
         ah0wvYcxVczoHWhcW1jg6IT3Mcofn/nmhKHYS/bm/G/X4xeXEFKAvNAUtEy78f1xToHx
         VLHg5j8AuaqmxjjZqhaDxZO+pWbqM/o25PteeXVbwxmhr7pk3yHLRsfZg/9oWYXcePuX
         CYWBa7kiLEA/TZnwweI9mHRspfe7nNPggqSYmQ1drb8/Df4MwNOkJ0QCr2YnC+uirpdf
         4ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=cW//i53m7rhE3tDzOI3p6O445xAcYvOWglMECoJWsFw=;
        b=n+5qCZ8Wd+00XE1uV/y32ltOvyn2m6S1ldbL5VF3q1TwventOrF9fsrDT7UIwIHzQY
         ALLtv9f8n7CnaXaozBlM9H79etylg7qGRdqfXbW9YJMd8unozbj8PfQTdclVxBxvGPqb
         70tadgF+pvE+XOnYocU+RCIen41l6OM9CFk940ZryIPO8wciz1d207zjlpIc+z0TgSjo
         xPF25pD76ONScSH5Nq8KmmiGGA3gqJMYpOxPK8y7EKLfBcFbpx8Ou1Jkc9NuDpYjnurs
         vbn3mGDXrbcAON25zarzjJuqWQD3wMxct2xp6QwyMdoYpzaSq4JpeGRVYXfUS+wr7+wM
         LW3w==
X-Gm-Message-State: AOAM530i2zj3v3o/a5BkS2Pw/YShHP3wMNAERnUg714M0EOoXxga3rYZ
        rxJvSWivVBGXxMsZwgspTAKN23Vh+NA=
X-Google-Smtp-Source: ABdhPJxQ0NQsxtjo1fbnyMlDJhUSU3LxaN0Amoc6OcCLEESaPIxxs8peOQ5er6MJTgXEsq8UpMV56g==
X-Received: by 2002:a05:651c:a08:: with SMTP id k8mr23795083ljq.46.1625743011521;
        Thu, 08 Jul 2021 04:16:51 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i2sm166436lfe.38.2021.07.08.04.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 04:16:50 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Martin <git@mfriebe.de>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: What actually is a branch?
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
        <xmqqk0mcy6g2.fsf@gitster.g>
        <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
        <xmqqpmw4uwh2.fsf@gitster.g>
        <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
        <xmqqy2arrmba.fsf@gitster.g>
        <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
        <87wnqaclz8.fsf@osv.gnss.ru> <60e5f3981de5f_301437208bc@natae.notmuch>
        <87bl7d3l8r.fsf@osv.gnss.ru> <60e61bbd7a37d_3030aa2081a@natae.notmuch>
        <877di13hhe.fsf@osv.gnss.ru> <60e66d28c0cb3_306ac120813@natae.notmuch>
Date:   Thu, 08 Jul 2021 14:16:49 +0300
In-Reply-To: <60e66d28c0cb3_306ac120813@natae.notmuch> (Felipe Contreras's
        message of "Wed, 07 Jul 2021 22:12:40 -0500")
Message-ID: <87im1l3vj2.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Sergey Organov wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > Since this is not strictly related to the topic of `git switch` I
>> > renamed the thread.
>> >
>> > Sergey Organov wrote:
>> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> >> > Sergey Organov wrote:

[...]

>> >> As for branch tail, I do have convention of marking start of a
>> >> long-standing branch with corresponding tag, where branch "foo" has
>> >> corresponding "foo-bp" tag marking its "branch point". Recently I
>> >> started to mark start of feature branch with yet another branch "foo-bp"
>> >> rather than tag, "foo" being set to track "foo-bp", that allows to
>> >> automate rebasing of "foo" against correct base.
>> >
>> > So foo-bp is the upstream of foo, and you do basically:
>> >
>> >   git rebase foo@{upstream}
>> 
>> Yep, but essential feature to me is that I in fact use tools that simply
>> run bare
>> 
>>    git rebase
>> 
>> and that "just works" (tm).
>
> I typed the revision explicitly, but `git rebase` would work just
> fine.

Sorry, I don't follow. Did you change semantic of `git rebase`? With
current mainstream Git, as far as I can tell,

  git rebase

essentially is:

  git rebase --fork-point @{upstream}

How introduction of @{tail} changes this, exactly?

>
>> > This is works if your base (or tail, or whatever) is static, but many
>> > branches jump around, and that's where @{tail} comes in handy.
>> 
>> Yeah, I see. When I need to make a branch jump around, I do need to
>> manually move my references, but that's fortunately very rare use-case
>> for me. Having direct support for that is still a win.
>> 
>> >
>> > You can do this:
>> >
>> >   git rebase --onto foo@{upstream} foo@{tail}
>> >
>> > This will always rebase the right commits (no need to look into the
>> > reflog). So you can say that the branch is foo@{tail}..foo.
>> 
>> I see where and when it's useful, but for a feature branch 99% of times
>> I don't want to rebase it onto some true upstream. I rather want to just
>> fiddle with the branch in place, and I prefer to setup things the way
>> that ensures that bare "git rebase" does "the right thing".
>
> But that's precisely the point: when you do `git rebase` you don't have
> to type the base or --onto anymore. It's done automatically.
>
> Not just for your long-standing branches, but for *any* branch.
>
>> Probably that could be solved by a branch-local configuration that makes
>> "git rebase" become "git rebase @{tail}" for the branch instead of "git
>> rebase @{upstream}"
>
> No. @{upstream} is where you want to rebase *to*, @{tail} is where you
> want to rebase *from*.

My point is that for feature branch I rather want to rebase from @{tail}
to @{tail} 99% of times.

>
> When you do:
>
>   git rebase foo@{upstream}
>
> This is basically the same as:
>
>   git checkout foo@{upstream}^0
>   git cherry-pick --right-only foo@{upstream}...foo

Yes, but you probably meant foo@{upstream}..foo (2 dots, not 3) here.

> git is smart enough to figure out what commits are already part of
> foo@{upstream}, and those are skipped, but at no point was any "base"
> calculated (at least not from `git rebase`).
>
> Most of the time `git rebase` works fine, because there aren't too many
> commits to figure out where they should go, but it's definitely not
> efficient, and there's many corner-cases (see a Linux kernel maintaner
> baffled by what the hell `git rebase` is doing [1]).

Once again, how exactly the foo@{tail} fits in this picture?

>
>> > Another advantage of having this notion is that `git rebase`
>> > automatically updates the tail (in this case to foo@{upstream}).
>> 
>> Yep, looks useful. Is it all local to given repo, or else?
>
> I implented it as 'refs/tails' (as opposed to 'refs/heads'), so it's
> local to a given repo, but could easily be exported.

Do I get it right that now `git switch br1; git rebase --onto br2` will
likely have different outcome in the repository where "br1" has been
created compared to any other repository, as "br1@{tail}" will only
exist in that exact repo?

Thanks,
-- 
Sergey Organov
