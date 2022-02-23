Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5962EC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 10:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbiBWKYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 05:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiBWKYH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 05:24:07 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FAF8BF57
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 02:23:35 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z22so43335610edd.1
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 02:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=LI6HXV8lfA/wr5iq+4qEWz4m8kDn81wVDySXXsKR6s4=;
        b=coW0LPOCl3t4w0/DAZH+qhkc4/WQcN/jPkv0qxQULQVJBrBOM9ODCIMDw4+mJ/FlT7
         B0//gAZu7oe9/zfiZGlE7C5quSh/LI2kLeQ7rlu1q0COlUyNsdd0WsjvDVBmpBlAWlnF
         PlvtkQxOIxfMWXMe3z5cA+lCwEqrEG+qJL0V/2yJR5Lmxb7s7hOw/OuytaG5CYj3v5ur
         YftRojHlHqSPTk163HRUHYwN6onxGNCXuRsn6XiOZMNSzw0YMeRGksimwryKb5evZ812
         goYEc50TW+HpaZtgKpjr6eYusoax8tcafq49153OLamtY9aAyEg3kfQ9yg5VqHJK5gbg
         Pjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=LI6HXV8lfA/wr5iq+4qEWz4m8kDn81wVDySXXsKR6s4=;
        b=Y3tF0PViK2u2LotwJpVx76POMdJ/QkndxfHiithP5Fud6BTrqpWNu7PcEBAzMvx3uB
         0xu58/kLW8pA5i5a8e6bm4STyZeBDtMioGDdlF52s/2iZ27H/ibo9XGfptU3O4da/aK8
         tQzV6s003P1bdHT3W+eIKJRaqOfTr1JVQnXa0pxNSL/G18ky+1KyAYa5RGEO9bj5G8Jk
         9qNazFkMiXd/7JryGlNyGB+Kpb8wRRZkqsxppnq8Za9atBU/YDKYE9KL9F2KpcwAsN21
         GRIDoV0SsjzWXv6F1TVXDi5HylZJsUAwVl0iN9PGA2evnXwYMwL6pPmq9Iom27FZwwoO
         rROQ==
X-Gm-Message-State: AOAM532DmMDGGjeQCZ1mPUJ6cLOU5No7qsQZkBCQqeWKxM1J8RzcSevM
        HA89+XgwbvnKDRv9epgEWySyKL2AfxU=
X-Google-Smtp-Source: ABdhPJwr7+yxIywrAJiUZgP3mipWzIV5YbAVFa1xM3kMzbAQIVfkqAhnsgaB4WFpnllMrccaEhJy/w==
X-Received: by 2002:a50:fb19:0:b0:404:eb52:62cb with SMTP id d25-20020a50fb19000000b00404eb5262cbmr30215773edq.363.1645611814128;
        Wed, 23 Feb 2022 02:23:34 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v8sm6386614edc.0.2022.02.23.02.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 02:23:33 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMoo0-006Fwm-4p;
        Wed, 23 Feb 2022 11:23:32 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] rebase: help user when dying with preserve-merges`
Date:   Wed, 23 Feb 2022 11:20:28 +0100
References: <pull.1155.git.1645526016.gitgitgadget@gmail.com>
 <cd06aa68c2fc65551cd810a1c2c0941c51433163.1645526016.git.gitgitgadget@gmail.com>
 <220222.86czje7w4i.gmgdl@evledraar.gmail.com>
 <c04eba64-0357-cfdd-2ffe-3905ce4f4cb9@iee.email>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <c04eba64-0357-cfdd-2ffe-3905ce4f4cb9@iee.email>
Message-ID: <220223.86r17t6fvf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 22 2022, Philip Oakley wrote:

> On 22/02/2022 15:32, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Tue, Feb 22 2022, Philip Oakley via GitGitGadget wrote:
>>
>>> From: Philip Oakley <philipoakley@iee.email>
>>>
>>> Git will die if a "rebase --preserve-merges" is in progress.
>>> Users cannot --quit, --abort or --continue the rebase.
>>>
>>> This sceario can occur if the user updates their Git, or switches
>>> to another newer version, after starting a preserve-merges rebase,
>>> commonly via the pull setting.
>>>
>>> One trigger is an unexpectedly difficult to resolve conflict, as
>>> reported on the `git-users` group.
>>> (https://groups.google.com/g/git-for-windows/c/3jMWbBlXXHM)
>>>
>>> Tell the user the cause, i.e. the existence of the directory.
>>> The problem must be resolved manually, `git rebase --<option>`
>>> commands will die, or the user must downgrade. Also, note that
>>> the deleted options are no longer shown in the documentation.
>> I can go and read the linked thread for the answer, but:
>>
>>>  		if (is_directory(buf.buf)) {
>>> -			die("`rebase -p` is no longer supported");
>>> +			die("`rebase --preserve-merges` (-p) is no longer supported.\n"
>>> +			"You still have a `.git/rebase-merge/rewritten` directory, \n"
>>> +			"indicating a `rebase preserve-merge` is still in progress.\n");
>>>  		} else {
>>>  			strbuf_reset(&buf);
>>>  			strbuf_addf(&buf, "%s/interactive", merge_dir());
>> As much of an improvement this is, I'd be no closer to knowing what I
>> should do at this point.
>>
>> Should I "rm -rf" that directory, downgrade my version of git if I'd
>> like to recover my work (as the message alludes to).
>>
>> In either case I'd think that this is getting a bit past the length
>> where we'd have just a die() v.s. splitting it into a die()/advise()
>> pair. I.e. to have the advise() carry some bullet-point list about X/Y/Z
>> solutions, with the die() being a brief ~"we did because xyz dir is
>> still here".
>>
>>
> Hi =C3=86var,
>
> Exactly. This is a slightly special, but real, case. The previous
> message was essentially totally opaque to users. An "If I were you I
> wouldn't start from here" response is somewhat true, so we simply tell
> the user how they got to receive the fatal message. They can then take
> any of the options they choose.
>
> Ultimately the user downgraded and managed to use "rebase --continue",
> as advised by Git, without the response "fatal:" to complete their old
> preserve-merges rebase.

Right. I'm pointing out that in this proposed version of the die()
message we stop just short of actually telling the user how to proceed.

I.e. just that they have a X directory, not that they should either
remove X and lose their work, or downgrade git, proceed, and then
upgrade git.

> They'll hit a similar fault in short order because when they next `pull`
> they'll be slipped into trying the preserve-merge rebase again - that's
> the 2/2 patch, making sure they know why.

Well, this is "rebase". You can have been running rebases in a
repository without ever having any interactions with remotes.

And even if you had interactions with remotes you might be doing so via
"git fetch" followed by "git rebase", and might not ever invoke "git
pull".

And even if you did a "git pull" later shouldn't the error you got here
be sufficiently stand-alone as to tell you what to do, without needing a
later "pull"?
