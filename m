Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81E8C4320A
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 23:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84DB9610A3
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 23:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhHLXys (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 19:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhHLXyr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 19:54:47 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BFBC061756
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 16:54:21 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d17so9515171plr.12
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 16:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dJrzzhRbqBlf6/rzjOlq39tRUbSW+O9hheyjilylVTE=;
        b=C/GYf0cHHIueUiRamwhu+Z8GWzoS0EpKHq8BkO7mz75sB5SQeeconf7UNTKYY7R6IX
         XjC9fvhxYuLX1A0xg1tmWA2cwuJ816EzY4EDNSR+R4pTaVpvnJK2a+Sxs7OKU75KlIYv
         jZlm4rgTOyCi9WrUMg/hVzEe3cDAofzP/qWYh8bNc6b2G189+dpE/++gnm/8A6CXYJkv
         tH/NijMEJfHInzRVd7DbdrTSR/A8Oahlh8irX8DYws2h4a6U/rH7zFr12/qCRzhV1jNx
         HcRQjS5YtB6Yz88PN3CuoqHh6pINj5PiGY41i4/Al9/KTopwF2FCbJc6w2BLFbnDpEAt
         4dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dJrzzhRbqBlf6/rzjOlq39tRUbSW+O9hheyjilylVTE=;
        b=OaEIuX4ToTK9t7jHg76dFpyJ99WZB4UTociSittm+RBQTrBNjV3wKlT2k9g3jVo6U2
         ExbvB10GPHLphO9t8UKTeyN9PSR+0AnNoUj7C1blfJImZdbfmNbWWbmx0PCwwG0r6vy7
         ji7mJfk84iCCF0a47q3YhZoQr7rbUTzbN/rmfzwCQCbmLmaoFgkCS5uIJY+WbO0iakTA
         4C2W7OM/GTLVhj/+yG654Rl6sbUG3jDysLn3ifxW6mud+6oIGIID/WjU715CFRoCLwxB
         3AE4rqEzQ2yDLSG0xArvH0CjtXapvzy6zFK0WuMyNkzSFhnD9EtIG1F/1mhdl65CFLwP
         1G4Q==
X-Gm-Message-State: AOAM531cT5VPYFqLnYdPqOVeo70ZRd0+csKX+7d8JzlZQNHB7UB1F08z
        G7x/d9Z/c2elyEeabPIWx2KwiA==
X-Google-Smtp-Source: ABdhPJxL2sj4Ap/HwHZKw5eqqO3EEFaEl+BrgIHXHPbLuGP7bqF+oDcwDUHNtxIpqWwT4ErLOcOqUg==
X-Received: by 2002:a63:36cb:: with SMTP id d194mr6026238pga.224.1628812460647;
        Thu, 12 Aug 2021 16:54:20 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:c961:2061:df5e:20fc])
        by smtp.gmail.com with ESMTPSA id m28sm1794165pgl.9.2021.08.12.16.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 16:54:19 -0700 (PDT)
Date:   Thu, 12 Aug 2021 16:54:12 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Mahi Kolla <mahikolla@google.com>
Subject: Re: [PATCH v5] clone: set submodule.recurse=true if user enables
 feature.experimental flag
Message-ID: <YRW0pGXXWnY7C470@google.com>
References: <pull.1006.v4.git.1628536305810.gitgitgadget@gmail.com>
 <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com>
 <xmqqeeaz70ph.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeeaz70ph.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 11, 2021 at 09:20:58PM -0700, Junio C Hamano wrote:
> 
> "Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Mahi Kolla <mahikolla@google.com>
> >
> > Currently, when running 'git clone --recurse-submodules', developers do not expect other commands such as 'pull' or 'checkout' to run recursively into active submodules. However, setting 'submodule.recurse' to true at this step could make for a simpler workflow by eliminating the '--recurse-submodules' option in subsequent commands. To collect more data on developers' preference in regards to making 'submodule.recurse=true' a default config value in the future, deploy this feature under the opt in feature.experimental flag.
> 
> Please wrap overlong lines in your proposed log message to say 70 or
> so columns.
> 
> >
> > Since V1: Made this an opt in feature under the experimental flag. Updated tests to reflect this design change. Also updated commit message.
> 
> This does not belong to the commit log message proper.  Noting the
> difference between the version being submitted and the pervious one
> this way is a way to help reviewers and is very much appreciated,
> but please do so below the three-dash line below your sign-off.
> 
> > Signed-off-by: Mahi Kolla <mahikolla@google.com>
> > ---
> >     clone: set submodule.recurse=true if feature.experimental flag enabled
> 
> The proposed approach misuses feature.experimental flag, which was
> designed to turn on many new features at once.  The features covered
> by the flag share one common trait: they all have gained consensus
> that in the longer term we would hopefully be able to make it on by
> default, and give early adopters an easy way to turn them all on.
> 
> I do not think setting submodule.recurse=true upon "clone --recurse"
> falls into that category just yet.  If we were to make this opt-in,
> we'd want a separate flag, so that those early adopters who are
> dogfooding other features that have consensus that they are
> hopefully the way of the future won't have to be forced into this
> separate feature.

I'd like to open discussions to get said consensus :)

It seems surprising to me that a user would want to clone with all the
submodules fetched *without* intending to then use
superproject-plus-submodules together recursively. I would like to hear
more about the use case you have in mind, Junio.

One scenario that did come to mind when I discussed this with Mahi is
that a user may provide a pathspec to --recurse-submodules (that is,
"yes, this repo has submodules a/ and b/, but I only care about the
contents of submodule a/") - and in that case, --recurse-submodules
seems to do the right thing with or without Mahi's change.

It seemed to me that trying out this change on feature.experimental flag
was the right approach, because users with that flag have already
volunteered to be testers for upcoming behavior changes; this seems like
one such that is likely to be welcome. By contrast, turning the behavior
on with a separate config variable reduces the pool of testers
essentially to "users who know about this change" - or, to be more
reductive, "a handful of users at Google who we Google Git contributors
already know want this change". I recommended to Mahi that we stick this
feature under 'feature.experimental' because I really wanted to hear
from more users than just Googlers.

> 
> Perhaps a separate (and new) configuration variable (in ~/.gitconfig
> perhaps) can be used as that opt-in flag (I wonder if the existing
> submodule.recurse variable can be that opt-in flag, though).
> 

Do you mean something like "git config --global submodule.recurse
TryTheNewThingPlease"? I guess it could work - repos that use a pathspec
in that slot would still have the pathspec configured locally, repos
that have submodule.recurse intentionally unset wouldn't know what to do
with the junk string, and repos that have submodule.recurse
intentionally set to true would still have that true override the global
value.

Or else I misunderstood you...

 - Emily
