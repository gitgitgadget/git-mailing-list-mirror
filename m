Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F48C433EF
	for <git@archiver.kernel.org>; Sat, 14 May 2022 02:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiENC5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 22:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiENC4V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 22:56:21 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC3E3864E2
        for <git@vger.kernel.org>; Fri, 13 May 2022 18:20:35 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id x4-20020a1709028ec400b0015e84d42eaaso5122931plo.7
        for <git@vger.kernel.org>; Fri, 13 May 2022 18:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gohVnMtzztEbIPJ9As/pveH3DDYcdj5drov+Kmj2GAU=;
        b=gfYaJ/CCX18qhxhhIcrLt9L6lmBvRC1VB1MFJvz3C6/4HBi378+IXaaPCJwQgTAulb
         aE21+Q9vy9nispqEEgwxHMlcq++W7J0jL1M0FbtDz60nPK23Nd3VAAqF78nXJOJy9S9V
         iDHfeCoAnvWsn8qQaqTmJh+9AigHAX+z0VDQoyb4zhhLgS8Hv+tKHyKn1skZZJmbYa1m
         LgEaNj6KQsJzsn41Ct11k+/Z0EBYXFujPonCXqqytyvRFfDh73aW1LO8zkI6wINiDuXm
         SGg8Kil3C1qDNLO3PGjdl3KjAnSGXUJO1ico3HMfaiGiUqn9SWo1A4JWm4leUhPLWmnI
         4hTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gohVnMtzztEbIPJ9As/pveH3DDYcdj5drov+Kmj2GAU=;
        b=z9OQqhgd03hvVBwsd4TMjAcqnUghUvzXBRx2P1eS2ZwhMDesryMVhUAJ/mfBJgOZwz
         aSNbZDanUFPhhYl9LX9vX34CWYbLvTwZy/tkt+5+CQQpRfh35qH80mmbLQX4GwrUFGDI
         AjnVJymhi/gwNAMAX06mrU4gHjHqzLlG5KOdz1JJgyCDZ9UA3upiL2UcpFrsXKIyj7lC
         fyGiXxNIBePCV+8TWaO9wzzxU4VV1i4LI8qwbZKv6jUBAMGE5Ri+wDp15G8yHGNvoHb6
         0EyYpWG/SmDml2czvI24LufoNVExmNVGRZEip/j7HSIN6IXuESZr5rTRBtXkZruonmAw
         Y5Tw==
X-Gm-Message-State: AOAM533KnqfJOP4CA7irvPRhlIDa6A+tEbz+ZntknJUgPTOB4S3VDjfZ
        QJg7RIrYJkryK88qqCckLYsmOmHCIkPRdg==
X-Google-Smtp-Source: ABdhPJx7K/oDkPrKT3adJ1vHQWXBehcaDGE9c6WoKWL6PrdxLYJOMZGx2l31LevPpzyRo6N8xpGqeFT6i0DjBg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2481:b0:50d:4839:5896 with SMTP
 id c1-20020a056a00248100b0050d48395896mr6923413pfv.37.1652486829077; Fri, 13
 May 2022 17:07:09 -0700 (PDT)
Date:   Fri, 13 May 2022 17:07:00 -0700
In-Reply-To: <xmqq1qxfbqtq.fsf@gitster.g>
Message-Id: <kl6lczghj7tn.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <CAN8jHOgwVF5g=jM_KYT0Oh+j+Lk3qvdyA4zNRbzf8e1Xp5WAUw@mail.gmail.com>
 <xmqqczgzdc1r.fsf@gitster.g> <kl6l4k2bpv61.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq1qxfbqtq.fsf@gitster.g>
Subject: Re: Bugreport - submodules are fetched twice in some cases
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Benedek Kozma <cyberbeni@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> A simple and concrete reproduction 
>>>
>>>     git init top
>>>     cd top
>>>     date >file1
>>>     git init sub
>>>     cd sub
>>>     date >subfile1
>>>     git add .
>>>     git commit -m subinitial
>>>     cd .. ;# back to top
>>>     git submodule add ./sub sub
>>>     git add file1
>>>     git commit -m initial
>>>     cd .. ;# out of top
>>>     git clone --recurse-submodules top copy
>>>     cd copy
>>>     git config submodule.recurse true
>>>     git config fetch.parallel 0
>>>     GIT_TRACE2=$(pwd)/trace git fetch --all --prune --prune-tags
>>>
>>> This throws the three lines to the output.
>>>
>>> Fetching origin
>>> Fetching submodule sub
>>> Fetching submodule sub
>>>
>>> The two "Fetching submodule" messages are coming from two separate
>>> calls to get_fetch_task_from_index(), and the trace does show that
>>> the code is doing "git-upload-pack" three times (one for the top
>>> level, twice for the same top/sub).  We can see it by grepping
>>> for "git-upload-pack" in the resulting 'trace' file above.
>>
>>  
>> Thanks for the reproduction recipe and findings, that'll be very helpful
>> :)
>>
>>> Glen, as submodule.c::fetch_submodules() was created in your heavy
>>> refactoring quite recently, I thought I'd redirect this report in
>>> your direction, as I expect you'd be the most clueful in this area
>>> ;-)
>>
>> Hm, this does look like something that I probably introduced. But even
>> if it turns out to be older than that, I think I am the right person to
>> fix it, yes.
>
> It seems that ever since the introduction of the --prune-tags option
> at v2.16.1-16-g97716d217c (fetch: add a --prune-tags option and
> fetch.pruneTags config, 2018-02-09), we always behaved this way.
>
> Without "--prune-tags" (but still with "--prune"), we can go even
> older than that version, and v2.10.0 seems to fetch only once.
>
> And the command keeps working that way all the way back to the
> commit that starts honoring submodule.recurse configuration, at
> v2.13.0-137-g58f4203e7d (builtin/fetch.c: respect
> 'submodule.recurse' option, 2017-05-31)
>
> If we instead use "git fetch --recurse-submodules" with versions
> of GIt older than that, we can go even older.  I saw v2.5.0 behaves
> that way before I got tired and gave up.
>
> So, we still would want to eventually get to it, but no rush.  This
> is an old thing and not as urgent as fixing a recent regression.
>
> FWIW, without "--all", we do not make an extra fetch at all, with
> the current code or with code as ancient as v2.5.0

I had a little free time, so I dug into it a bit more. "--all" does seem
to be the crux of it and I _very strongly_ suspect it is because "--all"
creates a child process which also fetches submodules.

Here's a hint inside of builtin/fetch.c:fetch_multiple..

  static int fetch_multiple(struct string_list *list, int max_children)
  {
    // ....
    strvec_pushl(&argv, "fetch", "--append", "--no-auto-gc", "--no-write-commit-graph", NULL);

Notice how we pass "--no-auto-gc" and "--no-write-commit-graph"? This
makes sense because those tasks run _after_ the main fetch and only need
to run once. If we didn't pass these flags, then we'd run those tasks
once per remote, and once more after the main fetch (R + 1 times, where
R is the number of remotes).

And obviously, we aren't passing "--recurse-submodules=false", so there's
good reason to believe that "--all" will fetch submodules R + 1 times.

But confusingly, I can't validate this hypothesis because I can't get
the "inner fetch" to respect "--recurse-submodules" (I hope this isn't
due to that recent change I made).

I did most of this testing without "--prune" or "--prune-tags". Your
findings suggest that they're somewhat relevant though, so maybe I'll
look at those versions to get more clues.
