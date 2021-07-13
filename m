Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42786C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 17:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DCCF60230
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 17:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhGMR5Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 13:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhGMR5P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 13:57:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D51C0613E9
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 10:54:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id he13so43004593ejc.11
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=xrPxzNe8duCtCozMpTvrWmlpgPrNYP1LsknhjKkLJfo=;
        b=JQIKh/ubFNdD4NrtvK2vxZrZRZUsUBPzSFDCSgFmYXlkCe1eKAhnRhDBVRecMDLBcl
         jVqp13zAG04vncfRmk2Vhn/RzKtEQsurEg7KAIlbA/k5XQFX0S2cCop9ihTRPYzUrhmE
         XiX6uNVo/Z/g1OsEId/tSTk68KwAb8UR06/5vWyAB8gVmP3fALsRyfZXs7wnV+QxWrVe
         EZwffggkPOqNZwRz+Rtk/KCygXOw3jkFPtqXVp5KvsgIKa7L9zBJ7um+28zvsUsyHFXo
         6YbXIiQV2Vn08cuFnyMKQbMwXOvxyWu5jJraj34wJbtYivs/ljQRpqgU/QrhiOP5BCmV
         MnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=xrPxzNe8duCtCozMpTvrWmlpgPrNYP1LsknhjKkLJfo=;
        b=NkVwIvrK4ygkwRWp1x3Tz90snyfGTOTgwJsYsEE/7/N422pymYz/gvSjVLI0GN4lny
         fMCw0667VF9FwKMjmcVt9Bolvywzo7Djy8PNbMCELEDljYNkQc8j+3wdA/i/7Ztl92g3
         yKdec6qqqcpt/RcFx8MSLHQ57QVvq1b/IANvfkcwKJgB+uxAI8RSyawJth3IjMWavMer
         OMP6GczJUnQMlAv5seLZrS1107aPuZ4am0AB7iP+93pG/kdDjXZMq+5uUvwp+QTakKtw
         s2R7ECuvKkNlGm6XqhrrIghFA3NTJmaMRJTc5UTnhaePCy9Qxn8h8w9mSM/JRiu6FuCU
         K6Sw==
X-Gm-Message-State: AOAM531icMIbqEkYor8m9jVd/tZVCXWwq1qauX5ndmSHB+z/JcdYYTaO
        Ev+M5Jx64zONuIeUZA/Hgqk=
X-Google-Smtp-Source: ABdhPJysnAfKC/D77lj+rtQbISzUpqaHoWZl0XHqXJdBvy5DEOKgPtBc26O+cjfVLUjwWgG36P8TCA==
X-Received: by 2002:a17:906:c006:: with SMTP id e6mr7155182ejz.510.1626198862976;
        Tue, 13 Jul 2021 10:54:22 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id j19sm10115482edw.43.2021.07.13.10.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 10:54:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 02/34] fsmonitor--daemon: man page
Date:   Tue, 13 Jul 2021 19:46:07 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <5db2c0390a657d5790cf24404201505c4ec3a829.1625150864.git.gitgitgadget@gmail.com>
 <877di9d5uz.fsf@evledraar.gmail.com>
 <533d47fc-ea37-1e6a-b6f4-ac4fdd24555e@jeffhostetler.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <533d47fc-ea37-1e6a-b6f4-ac4fdd24555e@jeffhostetler.com>
Message-ID: <87v95e2j71.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 12 2021, Jeff Hostetler wrote:

> On 7/1/21 6:29 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
>>=20
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>
>>> Create a manual page describing the `git fsmonitor--daemon` feature.
>>>
>>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>>> ---
>>>   Documentation/git-fsmonitor--daemon.txt | 75 +++++++++++++++++++++++++
>>>   1 file changed, 75 insertions(+)
>>>   create mode 100644 Documentation/git-fsmonitor--daemon.txt
>>>
>>> diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/gi=
t-fsmonitor--daemon.txt
>>> new file mode 100644
>>> index 00000000000..154e7684daa
>>> --- /dev/null
>>> +++ b/Documentation/git-fsmonitor--daemon.txt
>>> @@ -0,0 +1,75 @@
>>> +git-fsmonitor--daemon(1)
>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>> +
>>> +NAME
>>> +----
>>> +git-fsmonitor--daemon - A Built-in File System Monitor
>>> +
>>> +SYNOPSIS
>>> +--------
>>> +[verse]
>>> +'git fsmonitor--daemon' start
>>> +'git fsmonitor--daemon' run
>>> +'git fsmonitor--daemon' stop
>>> +'git fsmonitor--daemon' status
>>> +
>>> +DESCRIPTION
>>> +-----------
>>> +
>>> +A daemon to watch the working directory for file and directory
>>> +changes using platform-specific file system notification facilities.
>>> +
>>> +This daemon communicates directly with commands like `git status`
>>> +using the link:technical/api-simple-ipc.html[simple IPC] interface
>>> +instead of the slower linkgit:githooks[5] interface.
>>> +
>>> +This daemon is built into Git so that no third-party tools are
>>> +required.
>>> +
>>> +OPTIONS
>>> +-------
>>> +
>>> +start::
>>> +	Starts a daemon in the background.
>>> +
>>> +run::
>>> +	Runs a daemon in the foreground.
>>> +
>>> +stop::
>>> +	Stops the daemon running in the current working
>>> +	directory, if present.
>>> +
>>> +status::
>>> +	Exits with zero status if a daemon is watching the
>>> +	current working directory.
>>> +
>>> +REMARKS
>>> +-------
>>> +
>>> +This daemon is a long running process used to watch a single working
>>> +directory and maintain a list of the recently changed files and
>>> +directories.  Performance of commands such as `git status` can be
>>> +increased if they just ask for a summary of changes to the working
>>> +directory and can avoid scanning the disk.
>>> +
>>> +When `core.useBuiltinFSMonitor` is set to `true` (see
>>> +linkgit:git-config[1]) commands, such as `git status`, will ask the
>>> +daemon for changes and automatically start it (if necessary).
>>> +
>>> +For more information see the "File System Monitor" section in
>>> +linkgit:git-update-index[1].
>>> +
>>> +CAVEATS
>>> +-------
>>> +
>>> +The fsmonitor daemon does not currently know about submodules and does
>>> +not know to filter out file system events that happen within a
>>> +submodule.  If fsmonitor daemon is watching a super repo and a file is
>>> +modified within the working directory of a submodule, it will report
>>> +the change (as happening against the super repo).  However, the client
>>> +will properly ignore these extra events, so performance may be affected
>>> +but it will not cause an incorrect result.
>>> +
>>> +GIT
>>> +---
>>> +Part of the linkgit:git[1] suite
>> Later in the series we incrementally add features to the daemon, so
>> this
>> is describing a state that doesn't exist yet at this point.
>> I think it would be better to start with a stup here and add
>> documentation as we add features, e.g. the patch tha adds "start" should
>> add that to the synopsis + options etc.
>> See the outstanding ab/config-based-hooks-base for a small example
>> of
>> that.
>>=20
>
> I like to lead the series with the documentation that summarizes the
> purpose of the entire feature or patch series.  This gives the reviewer
> the context for the complete series that follows.  In the past, we've
> had discussions on the list about how hard it is to review a series when
> the foo.c comes (alphabetically) before foo.h in the patch and all
> the documentation is attached to the prototypes in the .h file so the
> reviewer needs to bounce around in the patch or series to read the
> intent and then go back to the beginning to read the code.  In that
> spirit, I think that having the complete man page come first provides
> necessary context and is helpful.
>
> The argument that the man-page should grow as the feature grows
> presumes that there is a meaningful cut-point mid-series where you
> would adopt the first portion and delay the second to a later release
> or something.  That division would not be useful/usable.

Isn't there such a meaningful cut-off point?

In 08/34[1] you add a skeleton of the daemon, so then the NAME/SYNOPSIS
(empty)/DESCRIPTION/REMARKS/GIT sections could be added, in 09/34[3] you
add stop/status commands, so then the SYNOPSIS/OPTIONS could be
updated/created with those, same for the addition of run/start in
13/34[5] and 14/35[6] respectively.

> And it just clutters up later commits in the series with man-page
> deltas.
>
> So I'd like to keep it as it unless there are further objections.

I'll leave it to you to do with the feedback as you choose,

I suggested this because I think it's much easier to read patches that
are larger because they incrementally update docs or tests along with
code, than smaller ones that are e.g. "add docs" followed by
incrementally modifying the code.

That's because you can consider those atomically. If earlier doc changes
refer to later code changes you're left jumping back & forth and
wondering if the code you're reading that doesn't match the docs yet is
a bug, or if it's solved in some later change you're now needing to
mentally keep track of.

Which is not some theoretical concern b.t.w., but exactly what I found
myself doing when reading this series, hence the suggestion.

1. https://lore.kernel.org/git/f88db92d4259d1c29827e97e957daf6eda39c551.162=
5150864.git.gitgitgadget@gmail.com/
2. https://lore.kernel.org/git/877di9d5uz.fsf@evledraar.gmail.com/
3. https://lore.kernel.org/git/02e21384ef0ca4909e0bda2c78fa63c06be22a50.162=
5150864.git.gitgitgadget@gmail.com/
4. https://lore.kernel.org/git/5d6646df93a17659af66f136295444d1bd834090.162=
5150864.git.gitgitgadget@gmail.com/
5. https://lore.kernel.org/git/5d6646df93a17659af66f136295444d1bd834090.162=
5150864.git.gitgitgadget@gmail.com/
6. https://lore.kernel.org/git/9fe902aad87f1192705fb69ea212a2d066d0286d.162=
5150864.git.gitgitgadget@gmail.com/
