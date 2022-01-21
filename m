Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E72C433F5
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 11:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380136AbiAULXb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 06:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380209AbiAULXS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 06:23:18 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7234DC061751
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 03:23:17 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id b13so41920612edn.0
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 03:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=B00M2S/KAZz3VvWMAY71igOxMk7ZCoccvYbhtKful9M=;
        b=UfPi3wu4IGgzqnrK5WcC4bm4korpEEfRAFK0fe+M4D/Q+8IgbZfKTuGS3zRRZinuCk
         rcvlX5GEFJKbwj0IaUdFFhXSHE+2byrwacubz4kbhiu4AjkKvG45J2Zh+WO+1Lk5gJXn
         lrRZomoAKkxMGEiWBerA/KeD3Ed30ksoTafOsybgJsRnCIolKGEMmWsSmOqlizewio3f
         GzS+CtKRz1cbbpQN4cnhUyH7BzeZI3hRzxytkJhgXVbWFszkSqUTr5AP79wLkhqqz2xR
         QPvJ2z1A47RrTt1DIhnlSP5WNdI4ZZBIRK5MNnAXz+l8ib0KJXerO4rVLaU41oM0X+AU
         rlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=B00M2S/KAZz3VvWMAY71igOxMk7ZCoccvYbhtKful9M=;
        b=266Z2/8ja00r48OJAWP1DoHipDW+o0oRuHvVUfrnkkxsFtSTtPsyeJuAkT14/y/ky5
         UcDNuwuIt8BJSpzrln/e1cPuI4DeXr5TV2Gnrlaw3xnSkf/cl3K/Z7Zu5BeDAbtscyIK
         +Kh9O+8WyqLSX99CUZlK4Asm/qKlGt6XdljPaxbNUdT7CBElfDgAYvvGPARWM0r6MDNS
         oCaWu2c7ZEnUVltSzuQTpCElRAdukod/6PAPll7NNWOl1qqhWqvqGlEr8rALc1Y++A9/
         w2EIsqJEzVMLdbZzyLAKbKMYpT4Yqzu3SmiXT+9exbtAmXOWP0KMzYuuYbb8E1OBRBAU
         jgDA==
X-Gm-Message-State: AOAM533uN/FoZZvv9a8hA0XfaiC/SW0Hrq1Fcgw6F9I8qVi9UkPZgImC
        4mXe23uBafjnaxP4xzVFNe2f1zGxEew10Q==
X-Google-Smtp-Source: ABdhPJwZJzZYYqMLPNvgrogRENLDTanSC/lxUnpmY/bmKiSxCAEWW8cVON7QCYwUESqwG1q0lHnlMg==
X-Received: by 2002:a17:907:7b84:: with SMTP id ne4mr2903642ejc.273.1642764195423;
        Fri, 21 Jan 2022 03:23:15 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k3sm2454915edr.97.2022.01.21.03.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 03:23:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nAs0g-0026sD-I7;
        Fri, 21 Jan 2022 12:23:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>,
        Petr =?utf-8?B?xaBwbMOtY2hhbA==?= <psplicha@redhat.com>
Subject: Re: [PATCH] checkout: fix BUG() case in 9081a421a6
Date:   Fri, 21 Jan 2022 12:14:58 +0100
References: <YemTGQZ97vAPUPY0@pobox.com>
 <patch-1.1-21ddf7c628d-20220120T212233Z-avarab@gmail.com>
 <xmqqee52ghwg.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqee52ghwg.fsf@gitster.g>
Message-ID: <220121.86iludl4d9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 20 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Fix a regression in my 9081a421a6d (checkout: fix "branch info" memory
>> leaks, 2021-11-16) where I'd assumed that the old_branch_info.path
>> would have to start with refs/heads/*, but as has been reported[1]
>> that's not the case.
>>
>> As a test case[2] to reproduce this shows the second "git checkout"
>> here runs into the BUG() in the pre-image. The test being added is
>> amended from[2] and will pass both with this change, and before
>> 9081a421a6. I.e. our behavior now is again the same as before that
>> commit.
>
>> +test_expect_success REFFILES 'checkout a branch without refs/heads/* pr=
efix' '
>> +	git clone --no-tags . repo-odd-prefix &&
>> +	(
>> +		cd repo-odd-prefix &&
>> +
>> +		cp .git/refs/remotes/origin/HEAD .git/refs/heads/a-branch &&
>
> I am not sure if this is a sensible test case to begin with.
>
> It sets up recursive symbolic ref in this way:
>
> 	HEAD points at refs/heads/a-branch
> 	refs/heads/a-branch points at refs/remotes/origin/HEAD
> 	refs/remotes/origin/HEAD points at refs/remotes/origin/branch1
>
> The checked out branch (i.e. what HEAD points at) is nominally a
> local branch, but it totally violates the spirit of the safety valve
> that says "HEAD" MUST point at a local branch or otherwise it is
> detached.  Creating a commit while "a-branch" is checked out would
> not affect *ANY* local branch state and instead makes an update to
> the remote tracking branch that does not reflect *any* past states
> at the remote repository.  Even worse, a "git fetch" that updates
> the remote tracking branches will make the HEAD, the index and the
> working tree into an inconsistent state.
>
> Simply put, I think the BUG() is catching a case where we should
> have been diagnosing as a broken repository.

Yes, I agree that we should be spotting this . Todd/Petr: If you're able
to describe it I'm curious about the original case you encountered that
the test case is derived from.

> So from my point of view, BUG() is indeed inappropriate because what
> the conditional statement noticed was a broken repository, and not a
> programming bug.
>
> What we should never do is to promise this "only kosher in letter
> but not in spirit" violation of "HEAD must point at a local branch"
> rule will be supported.
>
> So, unless I hear more convincing arguments (and Todd's example or
> anything similar that makes "git commit" from that state update a
> ref outside local branches is *not*), I am hesitant to call the new
> behaviour and 9081a421a6d a regression.

Well, the user is doing odd things with git, but we should reserve BUG()
for things that aren't rechable. Any time a user is able to arrange our
tooling in such a way as to call BUG() is a ... bug.

> What did the code before that BUG() do when faced with this nonsense
> configuration?  If forbidding outright broke a sensible workflow
> that happened to have been "working", I am OK to demote it to
> warning() and restore the previous behaviour temporarily, whatever
> it was (I think it was just old_branch_info.name was left unset
> because we were not on local branch, but I don't know if the missing
> .name was making any irrecoverable damage).  But the longer term
> direction should be that we treat the "update HEAD ends up updating
> some ref outside refs/heads/" a longstanding bug that needs to be
> fixed.

The behavior with my patch here is exactly the same as before. I.e. it
was rather straightforward, the xstrdup() is new, but before we'd just
take the un-skipped string that didn't start with refs/heads/ as-is.

I agree that it's better to look at this more deeply, but given the rc2
being out, and this surely being something we want in the final I'd
think we'd want to keep this patch as-is.

I.e. this is all a bit odd, but it was odd in exactly this way in v2.34.0 t=
oo.

We can add a warning() or die(), but a change that does that & convinces
you it's the right thing thing will require more careful consideration,
testing etc.

So I really think we should narrow our focus and keep this as-is.
