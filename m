Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D50CC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 18:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240590AbhLGSkw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 13:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240582AbhLGSkv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 13:40:51 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4117C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 10:37:20 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y13so60456574edd.13
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 10:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=J5cQo76exKui0NidrlqEEBYP4gJ/BNccTZ72jbhsjwQ=;
        b=AytWnDr6lzLUNcWsYfwBXDQY+3Yd1uQ9y7Vwrth0kyHmr4A2DuCoizwLFTkt2kUcAG
         F2FBRMn3J/XWncGXfft6K17hlx9RV7A7howFnQXj1Hm21q/iEXsR8upJ4jp1VVVdIxD1
         JDvq3HTc6isEuNi3byeuIL/qlcfs+6JPw8JREdLUwZVAdfPN6H3nugdXVZY5ojNhdWkR
         pFeGoIBj2AxwoFnsEL9dL7yKo6qUcnNprKjAyR7hjTwZHWitstqYutD4x6fu7j6x+voz
         FXDQbSMxj92S9yYWm+a8327J8rM2/Srt5SdDQMVo19dttUdv78yRH1st3Xt3UkGsHD7Y
         awcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=J5cQo76exKui0NidrlqEEBYP4gJ/BNccTZ72jbhsjwQ=;
        b=GyH+dSPjbecW2ANQQ1gJ/mGV6RQYIUcoVj+lzgLuk+FUOEhmnt6iFsa+13rGmTGo4w
         7z9BYgi7pkRZq5rTGLjlSmc0Q+387w4ieHyfJCVSfIVnubtfXkaLEHPiEZqtoLe5nby/
         R2C8stmc91ZxOaLsEdLeXJUxsFL0nxefcObBVx06UyejqlfGR0FWWz5GDqNc9ItO1yBc
         pMl4YYdpcBKGKJNtIr8lrr7KxqtVTKMpUYTAXoRTlBcbbT3zP6V+hLIvfT2GmFQ6cp4G
         DBdit2FR2f0ogi66U8hzXl/hGF74RZg4xVsiJO6eHKXPSb9IWPe21Vwgirko4HTZohaU
         OBUQ==
X-Gm-Message-State: AOAM530v0dP+qlCW79DHPsNBhhVseoXYvy9eMtSF6zb55Wj9TTC2T5ne
        qW13GKvoubV+gb7BHVa5bL0OG7L5DjVS5w==
X-Google-Smtp-Source: ABdhPJw83O1QiUUDIy7/cbVJ88idNwLxXHssE3CHXx83mqzW3zkHLLR6h3jWEsHcu0zSJllmkvTegg==
X-Received: by 2002:a17:907:3e13:: with SMTP id hp19mr1282117ejc.376.1638902238715;
        Tue, 07 Dec 2021 10:37:18 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j17sm397404edj.0.2021.12.07.10.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 10:37:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mufL3-001Ftx-IZ;
        Tue, 07 Dec 2021 19:37:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 00/11] Avoid removing the current working directory,
 even if it becomes empty
Date:   Tue, 07 Dec 2021 19:30:23 +0100
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
 <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
 <aa85e35d-143e-93e4-f54b-146b38dd4b88@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <aa85e35d-143e-93e4-f54b-146b38dd4b88@gmail.com>
Message-ID: <211207.86tufkmfc2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 07 2021, Derrick Stolee wrote:

> On 12/1/2021 1:40 AM, Elijah Newren via GitGitGadget wrote:
>> Traditionally, if folks run git commands such as checkout or rebase from a
>> subdirectory, that git command could remove their current working directory
>> and result in subsequent git and non-git commands either getting confused or
>> printing messages that confuse the user (e.g. "fatal: Unable to read current
>> working directory: No such file or directory"). Many commands either
>> silently avoid removing directories that are not empty (i.e. those that have
>> untracked or modified files in them)[1], or show an error and abort,
>> depending on which is more appropriate for the command in question. With
>> this series, we augment the reasons to avoid removing directories to include
>> not just has-untracked-or-modified-files, but also to avoid removing the
>> original_cwd as well.
>
> I did not clearly voice my approval of the core idea here, but I do like it.
>
> I think this fits squarely into a category of "help the user not get stuck"
> which Git has enough of those situations that we don't need this one. Even
> expert users won't know for sure if a 'git checkout' will cause their current
> directory to be removed, however unlikely.
>
> In the Git project, we spend a lot of time in the root of our workdir, but
> this is not the typical case for large projects. I remember spending most of
> my time in a previous role working four levels deep in the directory hierarchy.
>
>
> I read the previous two range-diffs and took another pass at this v5 and
> didn't see anything worth commenting on. This version is good to go.
>
> There is _also_ more work to do, as follow-ups. In particular, the thing
> that I thought about was sparse-checkout and created this test which still
> fails at the end of your series (as an addition to t1092)
>
> test_expect_success 'remove cwd' '
> 	init_repos &&
>
> 	test_sparse_match git sparse-checkout set deep/deeper1/deepest &&
> 	for repo in sparse-checkout sparse-index
> 	do
> 		(
> 			cd $repo/deep/deeper1 &&
> 			test-tool getcwd >"$TRASH_DIRECTORY/expect" &&
> 			git sparse-checkout set &&
>
> 			test-tool getcwd >"$TRASH_DIRECTORY/actual" &&
> 			test_sparse_match git status --porcelain &&
> 			cd "$TRASH_DIRECTORY" &&
> 			test_cmp expect actual
> 		)
> 	done
> '
>
> Please do not let this test delay the advancement of this series. As we
> find these kinds of issues, we can fix them one-by-one as needed.

Not to pile on about "the core idea", just a question while this is
fresh in your mind:

I think that those cases would per [1] be ones where a more isolated
change of reading the $PWD from the environment would make all those
commands work as expected. Or would the "$TRASH_DIRECTORY" also
otherwise go away in this examples?

Anyway, just per [1] and the potential future follow-ups is this (I
don't think so, but maybe I'm wrong) or other examples you have things
that specifically need the "retain the getcwd()" part of this series?

Or just (as I think would be the case with that "git status") to not
have setup.c die quite as eagerly as it does now when getcwd() fails,
but it can find its way back to the .git via the environment's $PWD?

Also note that writing any tests to check the current behavior is a pain
due to the bin-wrappers as I discussed in some previous threads, but
that's a test-only oddity, and won't impact how git would behave once
installed (although now it doesn't behave well at all). So probing the
current behavior via tests is hard, unless you use GIT_TEST_INSTALLED to
get around the bin-wrappers.

There *are* definitely cases where not-just-that-setup.c change but also
the "don't remove the CWD" is an inherently better & more complete
solution. But I think that's mainly to do with 3rd party shellscripts &
other programs outside of our control.

I'm assuming that you were working with this on Windows, where
presumably there's fewer/none such shellscripts you rely on, but that's
now two presumes in a row, so... :)

1. https://lore.kernel.org/git/211207.86ee6opy0f.gmgdl@evledraar.gmail.com/
