Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAB7C47089
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 01:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiLFBu0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 20:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiLFBuY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 20:50:24 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BF9167ED
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 17:50:23 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id m18so1201643eji.5
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 17:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ES911Eq6kw/8dSTANoO+nkamNxURb+CAIVIxPiIUt+Y=;
        b=NTbDtLbZ5ryEUWKrPoVnJYq+KX4iIr0Q8cXGyqKSty4o1P3tDKuIMc4vJdqf5E+ESv
         Ul3/XBShfbU647AqpOyL+pgzp0kQEd5Fswzgh3wzG/lGh5iJWdvUQyVn2WcGBwhYQ4Ml
         PqDzsKz+hcCw9lrN31l+HLpeBxzCpIRQJYz5T2sYvTedU25n8k9b0TfsyuhVcp9rNtOa
         rGu0xiGauwkJb+A9sVQhQAzT4QkZRTJ2PlQh88Y1Fxi1p/jZ/yiDDyHPSyD06328hwui
         BFVGo77+4guUx5r2VP9TsxGl9CcWh3ebWVUhDQCSJ8WT3LJQ0EIsWNV1cLHdmSpJq2IO
         0S7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ES911Eq6kw/8dSTANoO+nkamNxURb+CAIVIxPiIUt+Y=;
        b=kaQd2cawLn44UomZ6n5kzc/+YVlL3cm0uW6POcKAbhhvGqD/aHN6kB1+HTl8S70RPM
         MwaPCErJNAPY2bpQ/XFD983SD3oxWyTkH8VKVWzYsf7neVCcb0Z3MW+aMCcCJGvnL9ox
         xH3/Dac4Ox2Sy8vF2yUO6YLit5k8Rcb+HCOw/lyIGzNjvp6ifG35vJyEoYYq5W4Nf4Qe
         kxPsXI3x72XfOndrRVvjnTTaTnsJM1iun4wGw11uYjNwU5EnkW6Hhqey8DgyxV+vPKWG
         Niyi1agGtVIXJxacdiD8aJHPhnv5IARZA48EFFTtW6dmZKSYIwaIeZVdxt70tYG/tf2C
         u59w==
X-Gm-Message-State: ANoB5pn2Qd+Su0aG6bZPB6VADxzqWpqGBtZnU/CcDDAJGqwmQF27zDcY
        /GjWv7JWGVsKSDYUuuxNtQM=
X-Google-Smtp-Source: AA0mqf4GgnP8oOHE2PTWxZGDhYhYmlysL4msD36Oa6Q0CCCBXkCW86MczGBm5uLWY0mBjIxhyMLkDg==
X-Received: by 2002:a17:907:76f2:b0:7c0:eb3c:1037 with SMTP id kg18-20020a17090776f200b007c0eb3c1037mr7053034ejc.663.1670291422019;
        Mon, 05 Dec 2022 17:50:22 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090604c100b007c07b23a79bsm6773161eja.213.2022.12.05.17.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 17:50:21 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2N6C-003PD5-35;
        Tue, 06 Dec 2022 02:50:20 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, phillip.wood@dunelm.org.uk,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] test-lib.sh: discover "git" in subdirs of
 "contrib/buildsystems/out"
Date:   Tue, 06 Dec 2022 02:43:17 +0100
References: <663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk>
        <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com>
        <xmqq5yeuspam.fsf@gitster.g>
        <87f22a55-ee84-2f76-7b9b-924a97f44f89@dunelm.org.uk>
        <221202.86sfhxg2ng.gmgdl@evledraar.gmail.com>
        <Y4qF3iHW2s+I0yNe@coredump.intra.peff.net>
        <221203.86pmd1dyqn.gmgdl@evledraar.gmail.com>
        <Y45/8WnuUnP9gOMo@nand.local>
        <Y46clyoKk9KzFiqj@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y46clyoKk9KzFiqj@coredump.intra.peff.net>
Message-ID: <221206.86zgc1cnc3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 05 2022, Jeff King wrote:

> On Mon, Dec 05, 2022 at 06:34:09PM -0500, Taylor Blau wrote:
>
>> I think CI *is* the problem here. The CMake bits are basically a black
>> box to me (and I suspect a large number of other contributors, too). But
>> when it breaks, the only reason we as a project end up noticing it is
>> because it has fallout in CI.
>>=20
>> I would not be sad to make CI failures that are derived from CMake
>> "soft" failures in the sense that they don't make the build red. But I
>> think it's masking over a couple of bigger issues:
>>=20
>>   - Why do we "support" two build systems in CI if one is supposed to
>>     only be here for those that care about it? IOW, even if we say that
>>     CMake support is nominally an opt-in thing, in reality it isn't
>>     because of the dependency via CI.
>
> I think part of the reason cmake rose in importance via CI is that it's
> the de facto way to build for vscode. Before that CI job switched to
> cmake, there was some other alternate build system (vcxproj).
>
> So two things I'd consider here:
>
>   - how important is it for us to do the vscode build as part of regular
>     CI (as opposed to folks who are interested in it running it
>     themselves). Dscho gave some real data in the thread I linked to
>     earlier (which indicates that yes, it helps, but not that often).
>
>   - what's the status of cmake versus vcxproj? My impression (though I
>     admit based on my half-paying-attention-to of the topic) is that
>     cmake should replace vcxproj, and nobody would ever want to work on

I think the intent was to deprecate vcxproj, but I'm not sure, and I
wonder if the "cmake" is the proposed path forward why we still have it
in-tree anymore.

>     vcxproj anymore. But if that's not right, then does vcxproj cause
>     headaches for non-Windows devs less often? I don't really remember
>     dealing with it much, but I may have just been lucky.

It was less painful for non-Windows folks, but I understand the cmake
integration was also much nicer for VS. I.e. it's picked up by the IDE
in a way that the "make" shim wasn't.

> [...]
> That seems like going in the opposite direction from what you're saying
> above: doubling down that if cmake is broken by a change, it is the
> responsibility of the dev who made the change to find and fix it.
>
> I do like that =C3=86var is trying to make it easier to run cmake from Li=
nux
> in order to find that without using CI. But that does seem orthogonal to
> me to the notion of "who is responsible for finding and fixing cmake
> problems". To me, that decision is really rooted in "is cmake something
> the Git project supports, or is it a side-thing that some folks
> volunteer to keep working?".

I agree with that...

>> Personally, I would not be sad to see CMake removed from the tree
>> entirely because it has not seen enough maintenance and seems to be
>> quite a headache.
>
> I don't mind having it in-tree if I can ignore it (assuming the project
> attitude is the "it's a side thing" from above). It's the CI failures
> that make it hard to ignore.

...but on this thread-at-large, I'd much rather see us focus on just
reviewing the patches I have here than raising the burden of proof to
whether we should get rid of it entirely.

If we make the CI failures "soft" failures or move it out-of-tree
entirely it would still be useful to be able to run the cmake recipe on
*nix.

