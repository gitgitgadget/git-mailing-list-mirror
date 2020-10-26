Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB18CC4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 10:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A87120809
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 10:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5jdomvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770261AbgJZKn0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 06:43:26 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:41136 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1769754AbgJZKn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 06:43:26 -0400
Received: by mail-wr1-f44.google.com with SMTP id s9so11787573wro.8
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 03:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=reHJykyZk1d2lj29LPGLzrC6TQ3vT7qBYSmBBwfy9CQ=;
        b=X5jdomvQkb9pYoYuVQs2AORSe1Mrgd8ucbnBLosaPA0dP+5/2/8mayc5xS+pOGz46k
         ZRJJSiYTAaJjIwCzJ9E9WpZQhEa2RyIreunh0ug7n+L30qmnOyMN0qmjosuEFc7pIqVn
         QjGaxwwmYBCO3TvanCn56VYIS3b/aZ0mgSknHSQO1VCTYtPoLs+uYxYdWtpAu03Io0a8
         fpybjRjuWKD/XMD2cQBpUz7dKAM2V8KmtcVJSEVlZP+ix/4oRT0NEw7LxnajbYrOOF0A
         xrnf4ObX+HDUl7c7YQkXAqviElVU/REfIVmpMgRDk8SnuLOhhDCnoo9YFvQyyMbdYYta
         QhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=reHJykyZk1d2lj29LPGLzrC6TQ3vT7qBYSmBBwfy9CQ=;
        b=knJHWpcFFLrhtrShu5EgrNTzbHyaS5le0po12XAml7lTvJIQlXE+P/wu6vV/HZWHbI
         g4mneACU2nV55OT/IRnGWuoYd05iQ8CBh8R+Z9JP4iTCIqZH65kCtoeGemlgkKxRGGaM
         AqaEE1OPBOjvVVKyhCBUJ7Lj2tgqJe6oSmIlDl8GfHwHvnW6lQdb7LlwJYY1dkgL8DEo
         NYMeUFEVLZuxKqWqe/YsKKbMmNAiVqF+hnDs+RZbExojIDN7b+oi0iM7JuZArEZfKNcQ
         EBwUV2kH8CFrX1zNzUtA+UlOnN2g+ze+FdItpuIJuERjGg7hx20M7m+ZqqmqUvWZ39eU
         LhtQ==
X-Gm-Message-State: AOAM531icCVZZv6LYSOtppy5Hi11dkNl4coFcd40DS24Zv2B5fQJnTLj
        Mk8GIZJLR5wrY3Io0CPJsnWDjcu6QEM=
X-Google-Smtp-Source: ABdhPJz+0SUCep171jSn/2k5tb/RU+fljR4PDRuestpMnQ4CgH80l/GO0ohEjabRB08zn9bPNh/1fw==
X-Received: by 2002:a5d:4691:: with SMTP id u17mr17370143wrq.324.1603709003949;
        Mon, 26 Oct 2020 03:43:23 -0700 (PDT)
Received: from [192.168.1.201] (13.45.90.146.dyn.plus.net. [146.90.45.13])
        by smtp.googlemail.com with ESMTPSA id u20sm18850613wmm.29.2020.10.26.03.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 03:43:23 -0700 (PDT)
Subject: Re: ORIG_HEAD after rebase is confusing
To:     "herr.kaste" <herr.kaste@gmail.com>, git@vger.kernel.org
References: <CAFzd1+62PmHBoVpMw-y4TC=bmc8N0wDpF2jQa7XGz2e+7Dos6A@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <8bb82be6-dc51-6602-47b5-c849a87ae55e@gmail.com>
Date:   Mon, 26 Oct 2020 10:43:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAFzd1+62PmHBoVpMw-y4TC=bmc8N0wDpF2jQa7XGz2e+7Dos6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Caspar

On 22/10/2020 21:31, herr.kaste wrote:
> Reading the git rebase manual and some answer on stackoverflow I assumed
> `ORIG_HEAD` will point to the original HEAD, the tip of the branch *before*
> I started rebasing.  But it doesn't seem so.
> 
> For example, I have this:
> 
> 
>    $ git log --graph --all --oneline
>    * 9830f9f (master) X
>    | * fb7b6a6 (HEAD -> feature) D
>    | * 46b7a7a C
>    | * da5e4c7 B
>    | * 5c135da A
>    |/
>    * 6848823 Init
> 
>    $ git rebase master
>    Successfully rebased and updated refs/heads/feature.
> 
>    $ git rev-parse ORIG_HEAD
>    da5e4c7e9eb3b10c1efa08c534b9c9e4b92d9fd7
> 
>    $ git reflog
>    a647bd7 (HEAD -> feature) HEAD@{0}: rebase (finish): returning to
> refs/heads/feature
>    a647bd7 (HEAD -> feature) HEAD@{1}: rebase (pick): D
>    2f458e8 HEAD@{2}: rebase (pick): C
>    0aa2160 HEAD@{3}: rebase (pick): B
>    b957fc7 HEAD@{4}: rebase (pick): A
>    9830f9f (master) HEAD@{5}: rebase (start): checkout master
>    fb7b6a6 HEAD@{6}: checkout: moving from master to feature
>    9830f9f (master) HEAD@{7}: commit: X
>    6848823 HEAD@{8}: checkout: moving from feature to master
>    fb7b6a6 HEAD@{9}: commit: D
>    46b7a7a HEAD@{10}: commit: C
>    da5e4c7 HEAD@{11}: commit: B
>    5c135da HEAD@{12}: commit: A
>    6848823 HEAD@{13}: checkout: moving from master to feature
>    6848823 HEAD@{14}: commit (initial): Init
> 
> So `ORIG_HEAD` here points to the original B commit.  (I expected the D.)

It should be D, unless you ran `git reset` or `git rebase --skip` while 
you were rebasing as they also update ORIG_HEAD

> Honestly, this doesn't make much sense to me in that I don't know *why* it
> even chooses B which is a middle commit in the chain.  (And from reading the
> source `sequencer.c` I can't deduce it either.)
> 
>    $ git --version
>    git version 2.29.0.windows.1
> 
> What I actually wanted to do was `git reset --hard ORIG_HEAD` fwiw.  And for
> example `git diff HEAD..ORIG_HEAD` to check for unwanted changes after a merge
> conflict.

After you rebase you can user feature@{1} to get the head of feature 
before rebasing (until you make another commit on feature)

Best Wishes

Phillip

> Regards,
> Caspar Duregger
> 

