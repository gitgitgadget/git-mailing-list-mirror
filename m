Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05A5C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 11:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F9A61248
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 11:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbhFRL1G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 07:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbhFRL1B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 07:27:01 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC0EC061767
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 04:24:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gt18so15304365ejc.11
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 04:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=HtQM8RXEDw47a/h/CbVvZu3TVqpYOX4ZZ/xk+0mLJOE=;
        b=p7jaMfZxxdS2ZmvRIc6DkwfVy1o+q9EwniKoRRYpFy9QGjZwHv4Sn+9VAnG+fzltt0
         ycaGDM0DGDCuNS4LKxtJD2hrnos/0vh6dnZuWe+nc7D2Spwr31Y79YShMaYuKwTJXuqk
         rT3eI7e1V4IHLvezIKHVCmZKJFPGMJfQpeDlwE92nPYydUxbiTAy14/knChqwzrp+7wd
         Z5/JYZHrx+atOigyfDGAJFF1U0SXUuv5ma2h4SXBfVlyh5q0DSLkL9snwAb9An3VZ5ak
         FluLEphtTeJF4YnbPy2AD5s+GO41OyPg+WU9CbNpl/7ZB4Lp5oCTyoaRdhrCCDkbB5Sm
         0CJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=HtQM8RXEDw47a/h/CbVvZu3TVqpYOX4ZZ/xk+0mLJOE=;
        b=WDwhI+w6LSCOUzCzXqoBg0Ds5IO6NLMh6GWaXfdj55hZwYvzaKoJFj7xgrDFAUm4Tc
         b+X5C5tM+xn4kqZZEjDRf8FZ1RN1Ked3j2wR5GJBFQFdlLoxn9sXKgysRQP6X16h6uZV
         uZV8JWuLSuAf6/8BnIEUeDho0qIjvSzvd4Hn0tDEOvLuh/MI30TCAG2k7wtrqkgQ6IQI
         260lUn2SfbPcmvFEJCOzE7CyL6vn1qPdgmbRQOoGCOKPAcjQ1nasGeyJEYewPCE4YP9x
         P6pa9L7U0tZSYA//MxBpwWzH7Naj244bHocBJ4FXE0uj0BwgqRW3xI3M39jrs/9Ld5Uo
         LWAA==
X-Gm-Message-State: AOAM530Y0pBt19egr8r558x+4H7BYBkMe3vNSuCL0Q01nti429tbVnZC
        tA2scvL+QUagfFGD7Mrsh6E=
X-Google-Smtp-Source: ABdhPJwDVl/24iOb2pJxjvbIdUzVPCb/x81Qpnu/WqMUzgTF1UKfcFWGBA+GtDWLpp+udVgbttS2zg==
X-Received: by 2002:a17:906:6c97:: with SMTP id s23mr8997539ejr.248.1624015490309;
        Fri, 18 Jun 2021 04:24:50 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id j24sm6130679edv.48.2021.06.18.04.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 04:24:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Tessa L. H. Lovelace" <tessa@assorted.tech>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: Using .gitignore symbolic links?
Date:   Fri, 18 Jun 2021 13:15:46 +0200
References: <1623983680.3494.0@smtp.dreamhost.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <1623983680.3494.0@smtp.dreamhost.com>
Message-ID: <87o8c34dq6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 17 2021, Tessa L. H. Lovelace wrote:

> The recent release candidate of Git (v2.32.0) hit my OS this week, and
> it included a line () on symbolic links for several specific files are 
> now ignored.
>
> Thank you for putting the changelogs in an accessible location,
> knowing that this was a known breaking change was useful in debugging
> why my workflows stopped working.
>
> I have two concerns.
>
> First, the error thrown is
>
>> "warning: unable to access '.gitignore': Too many levels of symbolic
>   links",
>
> ,,,which does not accurately represent what is happening.
>
> I spent a bit of time convinced that I'd broken something with the
> symbolic links during setup, and an error such as "symbolic linking no 
> longer allowed for 'filename'." would make more sense, given the
> change under discussion eliminates *any* use of symbolic links.
>
>
> Secondly, and more personally important to me, a system administrator:
> My repositories use symbolic links to allow a single .gitignore file
> to define my folder structure, allowing me to avoid hardcoding the 
> repo-specific folder paths into my configs.
>
> Is there a flag to disable this new behavior?
>
> If not, this change means I need to update dozens of files, duplicates
> all, or completely rewrite my .gitignore files to have shyteloads of 
> arbitrary file paths in them, which I'd rather not do.
>
> Also, is there a justification for forcing this as the on-update
> default new behavior, when a user-querying behavior (such as with 'git 
> pull' defaults as they've changed recently) exists?

[CC-ing Jeff]

Breaking this was intentional, see https://github.com/git/git/commit/2ef579e261

That doesn't mean we can't take it back.

As discussed by Robert's reply and in that commit there's the workaround
of .git/info/exclude and the core.excludesFile.

However, we realize that sucks for many users. Let's say you have a
script to clone a "tree" of repositories similar to but not using
git-submodule (or they live side-by-side), such a thing won't Just Work
anymore.

At the end of the day there's an inherent conflict here between security
and convenience. We really want a repository to be safe to just "git
clone", i.e. we don't set up any hooks, execute code etc.; these
gitattributes and gitignore issues were on edges of that.

We can make it work as before, but it gets hard to distinguish the
gitignore you mean, from a gitignore that's pointing to /dev/urandom
(annoying), or to some crafted out-of-tree thing that'll cause an
overflow in the parser and an RCE.

Any way out of that that's configurable is going to be be the same
opt-in problem as core.excludesFile is now.

So I'd think our options are basically:

 1) Do nothing, it sucks for some people (like you) but we think it's worth it

 2) Some DWYM middle ground, e.g. we could discover if the link points
    to another git repo, and only trust it then, or if it's in the
    user's $HOME or whatever.

 3) Bring back the old behavior, it was more of a "while we're at it for
    gitattributes..." fix than something specifically a problem with
    gitignore, the RCE threat is a hypothetical, and we can more easily
    audit/be confident in the gitignore parser, probably...
