Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D685C07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 09:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E505B61279
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 09:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhGKJHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 05:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhGKJHp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 05:07:45 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D174C0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 02:04:58 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id r16so17340132ljk.9
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 02:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PHHPUlWoMapZ6Z1uS5qnkaVx3/cGBS3rvaooUgKJ+9Y=;
        b=XPonE9v9SV9t9xJajIRe6U0zBNgCkGYD/s45/FCNWqTlRnEh4tSIOES38Wab0BuF0j
         0QbJ3nHqlC43MWi7pFLrOcJDsOLrB+rNpC2uF9aZNW+ZuEfF/dQ0SFCuePs9b7wafQmX
         ShK3kTYseQDOj0ddsVji6UG8IT/+98gOc4WDthpLnxLRa/xp3lgNNDLcyFZMtnxPD9HG
         HNffurVmzs7RGn284B2H9nWP0DdbdPAzB/jGZu/Wmu/0eBwVeJIkwhM3wc1F4NsXwIcl
         yZSstScjQq2eYTClCGsymq6eKunFhV0IT4tY3bXOSWgf4DnufUCUTUjX/oaaWzCq71dV
         YsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=PHHPUlWoMapZ6Z1uS5qnkaVx3/cGBS3rvaooUgKJ+9Y=;
        b=DNAKpYdhGawNbaFeeaqgyVOecHvuJkUdkiyN9qiJ8PQuBULFBW6fJRl7yv41Gx3CWU
         8k5x0q5QuwERHJXRJrCtKCTXXtUWVfYGfVchpdbnVjuGf+zJMo3HC209vmFfkIemSbLP
         9k+tPwxPSZ4HHum4ouEGoqUeGIVr8i24Z3fnd4dhBN/P4BGfrUZWIV46sGUG2slz5seb
         Aarp0dtAnJ00pxyVrg3csbryC1okjuW1si++KFY2NqJumfd/L230HYfs5l2h2cyFBGGD
         e16epe6oDkgOYMeDbEZA3N/xcJ3fVq5wlb0mYiqwLBc5kkOcUWUIl1NAwWA2suVIK6zv
         Hhbw==
X-Gm-Message-State: AOAM530FVZjwOStbfd9qKGwiWFVGwjG1DuchJg/PggY5ChOgq0FKhmfC
        eRLyT5hEf42cLqsSY3xTaqEXjrAhFUo=
X-Google-Smtp-Source: ABdhPJyucH9KYLSiZIIf96pv0ixiedPXB6ov4HQiLv6vlgJyzeAAdgpTP8tKhxGiF8lLT6NuLKFbDQ==
X-Received: by 2002:a2e:a3ce:: with SMTP id w14mr13382997lje.73.1625994295648;
        Sun, 11 Jul 2021 02:04:55 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f23sm1179126ljn.98.2021.07.11.02.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 02:04:54 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Martin <git@mfriebe.de>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: PATCH: improve git switch documentation
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
        <87wnqaclz8.fsf@osv.gnss.ru> <60e5f3981de5f_301437208bc@natae.notmuch>
        <87bl7d3l8r.fsf@osv.gnss.ru> <60e61bbd7a37d_3030aa2081a@natae.notmuch>
        <877di13hhe.fsf@osv.gnss.ru>
        <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
        <60e67389a4adc_306ac1208fd@natae.notmuch>
        <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
        <60e736e72da68_30939020850@natae.notmuch>
        <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
        <60e762243aab1_30a7b02089@natae.notmuch>
        <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
        <60e79c31aaa72_30b8a4208c1@natae.notmuch>
        <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
        <60e874e1c6845_215320861@natae.notmuch>
        <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
        <87im1ieaba.fsf@osv.gnss.ru>
        <1bd36aa2-ac90-f7d4-9d48-1aa39159b263@mfriebe.de>
        <87a6mudt9b.fsf@osv.gnss.ru> <60e9ff4430c57_7ef20815@natae.notmuch>
Date:   Sun, 11 Jul 2021 12:04:53 +0300
In-Reply-To: <60e9ff4430c57_7ef20815@natae.notmuch> (Felipe Contreras's
        message of "Sat, 10 Jul 2021 15:12:52 -0500")
Message-ID: <874kd1gr0q.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Sergey Organov wrote:
>> Martin <git@mfriebe.de> writes:
>> 
>> > On 10/07/2021 12:24, Sergey Organov wrote:
>> >> Martin <git@mfriebe.de> writes:
>> >>> Actually, "new" or "create" would make sense in "git branch". But in
>> >>> git switch, they actually raise the question "create what?" / "new
>> >>> what?".
>> >> I believe that's because "git switch" tries to do too much. "git switch"
>> >> should rather switch between existing branches, and do nothing else. As
>> >> I said once in this discussion already: trouble writing good
>> >> documentation is often indication of some flaws in the design.
>> >> Creating (a branch) is fundamentally different operation than switching
>> >> to (a branch), and that's why the former doesn't fit into "git switch".
>> >> 
>> >
>> > Right, yes. But creating a branch is often followed by switching to it.
>> 
>> Yep, but here the creation is the primary operation, not switching, so
>> putting this into "git switch" looks like design flaw. These 2 actions
>> are fine to co-exist in "git branch" = "whatever you want to do to
>> branches", but not in "git switch" == "wherever you want to switch".
>
> I don't see the logic in here.
>
>   git branch topic # here 'branch' is the verb

Not to me. I assumed the "branch" is always a noun in "git branch", and
the actual meaning of this command is:

   git branch [create|new] topic

I.e., creation just being the default action taken on the branch.

>   git switch topic # here 'switch' is the verb

Yep.

>
> Now, if you want to do both at the same time the logical options are:
>
>   git branch --switch topic # here '--switch' is an adverb
>   git switch --new topic # here '--new' is an adverb

Yes, we can (and do) shove it into the "git switch", but "git new" would
be better design.

>
> The former reads like gibberish to me: "git, branch off in a 'switch'
> way".
>
> The latter makes perfect sense: "git, switch to a branch in a 'new' way".
>
>> Logically, there could be something like "git new" that does create a
>> branch and then switches there by default, or something like that, say:
>> 
>>    git new feature3 --at origin/rc-2 --track
>
> Here the the verb is clear, but not the direct object, a "new" what?
> Couldn't it be a tag? Or a commit? Or a remote? Or a worktree? Or a
> bisect? Or a submodule?

Yes, it could be anything. The above is written in an assumption that
default object for "git new" is branch.

>
> It's too ambigous.

Yep. The explicit mode should have been:

  git new branch feature3 --at origin/rc-2 --track


>
>> And while we are at it, do you guys notice how 2 concepts are mixed in
>> Git commands? I mean, the interface seems to mix object-oriented and
>> action-oriented commands, most of commands being action-oriented with
>> only a few unfortunate exceptions.
>> 
>> Let me try a short survey:
>> 
>> 1. In
>> 
>>   git branch ...
>> 
>> is "branch" a noun or a verb?
>
> Both.

No, it's rather noun plus lacking subcommand, sometimes making it look
like verb :)

>
>> 2. In
>> 
>>   git merge ...
>> 
>> is "merge" a noun or a verb?
>
> Verb.
>
>> To me, while the latter is obvious, it's verb and specifies the action
>> to be performed, the former looks more like "whatever you want to do
>> with branches", and thus the "branch" is a noun there and the command
>> thus is object-oriented.
>
> I agree, and I did have indeed noticed the inconsistency. But there's
> another category of commands that receive subcommands, like:
>
>   git remote $subcommand
>   git worktree $subcommand
>   git bisect $subcommand
>
> In my opinion `git branch` fits more these subcommand commands, and it
> was a mistake to make the subcommands options, it should be:
>
>   git branch list
>   git branch new
>   git branch set-upstream
>   git branch move
>   ...
>
> Now the verb is crystal-clear.

Yes, lacking (assumed) subcommands is yet another dimension of
inconsistencies.

I mean what I'm after is inconsistency of the first argument to "git".
It's being the verb more often is where we currently are, at least when
considering "primary" commands that "git help" outputs. 

I mean, consider:

   git branch new nice-feature

vs

   git new branch nice-feature

It should have been the latter, when in fact it's currently the
[reduced] former.

I.e., I'm in favor of universal:

   git <command> ...

syntax to Git commands where <command> specifies an action. [Why things
tend to drift to Lisp all the time, I wonder?]

From that POV, for the commands you mentioned, "git bisect" is probably
fine, whereas "git worktree", and "git remote" should better be split to
operations on them, e.g.:

   git new remote
   git new worktree

Once that is regularized, we may as well consider allowing for inverse
order of the first 2 arguments, by making

  git new remote
  git remote new

the synonyms.

It doesn't mean we need to rewrite everything. Having an end-goal
specified though, we may design new features accordingly, and add
commands in preferred syntax for existing features, so that they
eventually obsolete the current status quo.

Thanks,
-- 
Sergey Organov
