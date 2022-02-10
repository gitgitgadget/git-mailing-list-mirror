Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3BFC433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 22:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345289AbiBJWxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:53:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238083AbiBJWxP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 17:53:15 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839B8273D
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 14:53:15 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id a39so12085175pfx.7
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 14:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qspXvMp+fwAGu7gYTxyvxMOluGLKl3Do0wgyOUiAmT0=;
        b=p6HdAkJwacOvZMjnmn4TuHjBNyNNtXwauPOOAXPoRPULXs+56DfFVqKncqJuS8MPoE
         ZOzmwzJSKA247LZjUPOXjf2rpFeLxKsVs+HlO10XfVju3gUCax29GCfpZfPNDGBd4DUR
         RS4JmSTYtC/ZbQXO6JObVW4icuwK7QqpbvrFC2ziBjN0cWvduvMtHapuXG3lezRby8WP
         AGQ4FmX2CmUlAXcZo1HxVvpe7n0btBgPcIAjh/SpUuvMlz4Vo6JkY0/BwVc4JC+Q+ckT
         gsYVQlkvQW196WpVWWFITVqTiMJSw+HckwbP9kL3hAK/bO80tuY8M+HuVrti64ox3ome
         uJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qspXvMp+fwAGu7gYTxyvxMOluGLKl3Do0wgyOUiAmT0=;
        b=u74ajuQSfhbFyirkSxRJJevhJksLBZVcrun/Cqjaud7ljl2BXBDZYGZyAzgcliapXM
         neUnQA7GRnYYq8oZlWKBHrAYZ3Rli5wHHDVWbfH3ACLn0JCfVH3ep4yM+FtZamYTjOUF
         SN3445TKhtQY3QZCzlOOG+7ofOOuxKzkNE33qG5NW5MVJ5Q/3ZIf3K5gzdhEC05VUUkY
         yohm2WsEUG12qVhDGDoKipCMq/j7JszJNZ4Uq4NFtKxzQoSAmvxEpcihrdkkP2l4Debd
         OaFKE9OULKDxYFwAlCslTzrhxPTDtU8tKRZCyKflkCoZUy+bnCNhlD+4HJfGH3C7EpAc
         j0Iw==
X-Gm-Message-State: AOAM530GwLRiiynKuXdd+4Scu2Rm4AStn6Y0aSErpBCPX3l6E8h1fhMB
        RP6/OpPqfncLWYbhilsbhTg=
X-Google-Smtp-Source: ABdhPJxsO89L7s6baEwCSpXMpJ6rkyTGAJiP8MZNT67ObarIgvPzZYjP7r+gV/v6YTSM3U5cN4EIiQ==
X-Received: by 2002:a05:6a00:c83:: with SMTP id a3mr9813259pfv.36.1644533594890;
        Thu, 10 Feb 2022 14:53:14 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:e390:aa3f:5258:75e2])
        by smtp.gmail.com with ESMTPSA id d22sm24050215pfl.71.2022.02.10.14.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:53:14 -0800 (PST)
Date:   Thu, 10 Feb 2022 14:53:11 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 0/5] teach submodules to know they're submodules
Message-ID: <YgWXVybMBIyKSvN9@google.com>
References: <20211117005701.371808-1-emilyshaffer@google.com>
 <20220203215914.683922-1-emilyshaffer@google.com>
 <220204.86pmo34d2m.gmgdl@evledraar.gmail.com>
 <YgF5V2Y0Btr8B4cd@google.com>
 <xmqqk0e6gt5j.fsf@gitster.g>
 <YgHE4iaV8QHRw64U@google.com>
 <xmqqy22lcj2m.fsf@gitster.g>
 <YgWNwIE4ZLSWAr6n@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgWNwIE4ZLSWAr6n@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer wrote:
> On Tue, Feb 08, 2022 at 10:24:49AM -0800, Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:

>>> My point with this example is that it's useful to have a definition of
>>> what is a submodule repository, to make it unambiguous whether this
>>> repository is a submodule or whether it's just a repository that
>>> happens to have been cloned inside of a git-managed worktree.
>>
>> OK, together with the other "no need to let NFS automounter worry
>> about parent directories", it makes a very successful argument for a
>> single bit (i.e. this is a free-standing repository and is not a
>> submodule, so no need to auto-discover if it is one).  I think the
>> "Alternatively" you later mention to solve ambiguity with just a
>> single bit, without "this is a submodule of that superproject"
>> linkage, is essentially the same?
>
> That resolution - "teach submodules to know they're submodules, but not
> whose submodule they are" - would still count as a success to me.

Thanks, both.  Sounds like a good path forward.

[...]
>                              So I don't terribly mind sending this as
> just a boolean, if we feel that the effort to keep it up outweighs the
> benefit of saving us a filesystem walk.
>
> I'm not completely convinced that it does, though

Personally, I'm convinced --- e.g., life gets painful enough when
core.worktree ends up pointing to the wrong path, so being able to
avoid that complexity seems like a nice outcome.

>                                                  - would the addition
> of a 'git fsck' check for this config be satisfactory? In other words,
> is the problem that the execution of this series wasn't thorough enough
> and it should be refined, or that the concept itself is beyond saving?

For the absorbed case, the path to the superproject should be pretty
stable, and in that case it's probably possible to make this robust
enough.  (That said, the path to the superproject gitdir would
typically just be "../..", at least as long as we have the other patch
to escape slashes in the submodule name.)  In the non-absorbed case,
it seems likely to get messy fast because a user can "mv" the
submodule around.

Another kind of case that gets interesting is when there are multiple
superproject worktrees and multiple submodule worktrees.  Does the
relative path become a per-worktree variable?  Using a boolean saves
us from having to think through it.

Thanks for the clear explanations,
Jonathan
