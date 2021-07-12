Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14D9C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 22:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F15961167
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 22:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhGLXBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 19:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhGLXBe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 19:01:34 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76675C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 15:58:44 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id v6so9318941lfp.6
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 15:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xzN38TFnC37l5ntthoUYy6sLZQiXX7o4zFZfgafcFnY=;
        b=dkKbiZLisXJCUx+k7GpVorFZJMDgef4TvPhRkkUmz+b2F5LsGEf99v0RbAoRmsQRdz
         Q67T39SSVZfAXMbjsw+4UTA6r+RA6oWVhgnogGV61gsk3GkqdAWBh+Yu7iuaw9MZL0tp
         QETdfllJjuP/rTjs8t3EcsH4GNnPmUr3QNQmRVo7vTHq6AlILQH9ElgQ3LjkjeUpWYy5
         ns8amRDJhuwf0JeiiFGkpOS1RNiXSRVNQMhvHpmv+xkAuxKrI7poJkKnbWCp6XKKjLPz
         dC1HO28t1kKC8ZMb+eb5z82drbe5GdMY5FzGG9aYoM54bxZ2AoplfJWB+QKjTIK3fCup
         Cxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=xzN38TFnC37l5ntthoUYy6sLZQiXX7o4zFZfgafcFnY=;
        b=gGpc5YasikeazaJbju1ePmD/rw+n5tJeacUtm1KRCyCdjnINHFidKyb16M+Fh3Lup4
         lRL/v7mPEWTXagv2sh5mpSfLOPG1iKLI40KmDfKtJuUnCqUIrYyfwF/zooUXTDOilGlP
         3CWZubgNPaN39wHPVvfdW0G2NUTVWzbt7rqRfVqWxHSZ8K6OzOMAve7tW0UyYKKTijpv
         Clbs8RoQDV9jBzo0f9u8IELMeRsB7PP9cfLCOydF+6BOoSlZAUJjP8qCN/PoDB3U8q1s
         +/b8fAs81cVSSejvb+iJOiR45K7Cf6t518Xfnd2IiCaxViYJgFE80OCx8tN5KEtwnq15
         gbfg==
X-Gm-Message-State: AOAM531CCGG1o/9dU0ASiuzE+xXozWTLCavv+SjJO9kXpOV2IjexjHkR
        EOWLiOzYdkmkSWuQsO6S979hgYpks98=
X-Google-Smtp-Source: ABdhPJwnVMWazNbyjAdhNXBsttEkV2NPDkVsbCv9Z0BZ4gaLa7IW0SFq0gvO6kF0baujMubPV0dDMw==
X-Received: by 2002:a05:6512:3604:: with SMTP id f4mr911738lfs.187.1626130722412;
        Mon, 12 Jul 2021 15:58:42 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b10sm1659059ljj.109.2021.07.12.15.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 15:58:41 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Martin <git@mfriebe.de>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: PATCH: improve git switch documentation
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
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
        <874kd1gr0q.fsf@osv.gnss.ru> <60ec6cd622c4c_a4525208a0@natae.notmuch>
Date:   Tue, 13 Jul 2021 01:58:40 +0300
In-Reply-To: <60ec6cd622c4c_a4525208a0@natae.notmuch> (Felipe Contreras's
        message of "Mon, 12 Jul 2021 11:24:54 -0500")
Message-ID: <87czrnf8bj.fsf@osv.gnss.ru>
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
>> > Sergey Organov wrote:
>> >> Martin <git@mfriebe.de> writes:
>> >> 
>> >> > On 10/07/2021 12:24, Sergey Organov wrote:
>> >> >> Martin <git@mfriebe.de> writes:
>> >> >>> Actually, "new" or "create" would make sense in "git branch". But in
>> >> >>> git switch, they actually raise the question "create what?" / "new
>> >> >>> what?".
>> >> >> I believe that's because "git switch" tries to do too much.
>> >> >> "git switch"
>> >> >> should rather switch between existing branches, and do nothing else. As
>> >> >> I said once in this discussion already: trouble writing good
>> >> >> documentation is often indication of some flaws in the design.
>> >> >> Creating (a branch) is fundamentally different operation than switching
>> >> >> to (a branch), and that's why the former doesn't fit into "git switch".
>> >> >> 
>> >> >
>> >> > Right, yes. But creating a branch is often followed by switching to it.
>> >> 
>> >> Yep, but here the creation is the primary operation, not switching, so
>> >> putting this into "git switch" looks like design flaw. These 2 actions
>> >> are fine to co-exist in "git branch" = "whatever you want to do to
>> >> branches", but not in "git switch" == "wherever you want to switch".
>> >
>> > I don't see the logic in here.
>> >
>> >   git branch topic # here 'branch' is the verb
>> 
>> Not to me. I assumed the "branch" is always a noun in "git branch", and
>> the actual meaning of this command is:
>> 
>>    git branch [create|new] topic
>> 
>> I.e., creation just being the default action taken on the branch.
>
> The question is not what you assumed, the question is can other people
> assume otherwise?

Sure they can, and that's part of the problem. I described how *I* see
it, as I try to interpret things as coherently as possible, and I don't
like to interpret "branch" in "git branch" as either noun or verb
depending on options when universal interpretation as noun is
sufficient.

>
> "branch" can be a verb, that's a fact.

Yep, who argues?

My argument is that specifically in "git branch" it could be universally
interpreted as noun, but can't universally be interpreted as verb, so
/for me/ it's noun there.

>
>> >> To me, while the latter is obvious, it's verb and specifies the action
>> >> to be performed, the former looks more like "whatever you want to do
>> >> with branches", and thus the "branch" is a noun there and the command
>> >> thus is object-oriented.
>> >
>> > I agree, and I did have indeed noticed the inconsistency. But there's
>> > another category of commands that receive subcommands, like:
>> >
>> >   git remote $subcommand
>> >   git worktree $subcommand
>> >   git bisect $subcommand
>> >
>> > In my opinion `git branch` fits more these subcommand commands, and it
>> > was a mistake to make the subcommands options, it should be:
>> >
>> >   git branch list
>> >   git branch new
>> >   git branch set-upstream
>> >   git branch move
>> >   ...
>> >
>> > Now the verb is crystal-clear.
>> 
>> Yes, lacking (assumed) subcommands is yet another dimension of
>> inconsistencies.
>> 
>> I mean what I'm after is inconsistency of the first argument to "git".
>> It's being the verb more often is where we currently are, at least when
>> considering "primary" commands that "git help" outputs. 
>> 
>> I mean, consider:
>> 
>>    git branch new nice-feature
>> 
>> vs
>> 
>>    git new branch nice-feature
>> 
>> It should have been the latter, when in fact it's currently the
>> [reduced] former.
>
> I disagree. I prefer the former.

     git create branch "nice-feature"

Almost plain human language. Isn't it nice? I mean I fail to see why
you prefer the former, but I don't care that much either.

>
> Either way this is way too far from the original point. I don't think
> you can convince me that `git new branch` makese sense, but there's no
> need for that.
>
> To move forward we need to find consensus, and if you and me agree that
> `git branch new` makes sense, that's where we should focus on.

It does make sense, in isolation.

No, I don't think it's an option, as unfortunately for your preferences,

        git branch new

looks impossible to introduce in a backward compatible manner, nor there
is significant need to, as

        git branch

already does the job, even if by introducing syntax irregularity. 

>
> Even standardizing `git branch` would be an almost-impossible task, even
> if we manage to convince others. `git new branch` even more
> impossible.

Quite an opposite. In fact it's easier to add new ways of doing things
that, provided they prove being useful, eventually obsolete and replace
old ways. "git switch" and "git restore" are recent examples of that.

That's why I started to discuss "git new" that does not yet exist. No, I
don't think it will be there any time soon, as there are more important
things to improve in Git, and then overall consistency of Git command
interfaces is not recognized by the community as a valuable design goal
anyway.

Thus, for foreseeable future we will likely continue to witness hot
discussions of what "looks reasonable" and what not, contenders lacking
common ground that some basic principles of design agreed upon would
have provided.

Thanks,
-- 
Sergey Organov
