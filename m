Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D836C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 12:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJKMWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 08:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiJKMV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 08:21:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B46F8F952
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 05:21:57 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a13so19895476edj.0
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 05:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=plgQjzxBNVOxXB4yTHXmhESMQHpQGWgexiML+BnYPBQ=;
        b=hb0GgL15R8twX2/b5Jt6mRz9FN+Sr8pmvailzlMy+nsD8HwARpLf/zocd8AxhU5/6u
         DSEuUHgKH2FSivw7XuCyE/1UIsozm0Grio9LNBDXuCVb32pZxsCaKTW5RDRqDn9P3KsF
         dj1aHVS4MwlmNAcRGID9yyjKvMhpcYjBlBIFitHFuO+XlJ4o/Zu9dj3Uxqb8CjAXaKDb
         YBBaZdEKVT8Lyub/yfZxbR6c2PWwfFEmbrN8e0F0wLVyzC2OS0BVWNIoTWfTvYE+bnA/
         Dc1g3ZI6JYTow4KDDHueigteJ8qigRvH92uhMFsX5/f1AvNTSA9jqsPrOjf6i7A9qg6m
         lw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=plgQjzxBNVOxXB4yTHXmhESMQHpQGWgexiML+BnYPBQ=;
        b=L0IHAkMfFOf8S8LhNuvTke/eM8WVRXuI0aAsJzyO84rpg6BKY1sAFYu+YWefGRXumc
         YRfzQtia70r2INUFgF3A3dtRBnKKvgfFCOBTo9BrbUCVJqJku4LUBBGdcgLpGsn0W4ZL
         LuCBO1vO+ihGYDLemgd/5gQN4FVnBrVtaRSbbZPV8Fx3NNc41AB4DTvlMcYPwiphd8hH
         42fTQ+rHtRr0fXF/zBryPdtHeMqbX83cbIQqeRSr8bdCRosPV17dxT6jHrOepoKWHkN+
         Gz1bnaf3ZExfyhfWP558NeoERoLs6etZPHumGu79yBHTSI73ZU2sgL5nI8W8o7A0eIZl
         zJQw==
X-Gm-Message-State: ACrzQf0czrRXdl8QG2zF4Hyo+NIEfyh3we7uYV6w/vg+XpjYrrvfTRPG
        XyptSpYIDircAgfecQ9ENvUXVAxdTydirg==
X-Google-Smtp-Source: AMsMyM5ZdAUhMI/vIoSx9nsny2mugVPvLXLQ6Qz3qPpoBzaj9ByEquNFpbcyVLpg97ID6rxRRCeZMQ==
X-Received: by 2002:a50:ec15:0:b0:458:a612:f751 with SMTP id g21-20020a50ec15000000b00458a612f751mr23105722edr.111.1665490915878;
        Tue, 11 Oct 2022 05:21:55 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ly15-20020a170906af4f00b0077077c62cadsm6937746ejb.31.2022.10.11.05.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 05:21:54 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oiEGf-003s64-30;
        Tue, 11 Oct 2022 14:21:53 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bart Kuster <bart.kuster@sidn.nl>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Seemingly inconsistent checkout behaviour
Date:   Tue, 11 Oct 2022 14:14:37 +0200
References: <DU2P194MB1584B11245DF0DE7515297B6E3239@DU2P194MB1584.EURP194.PROD.OUTLOOK.COM>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <DU2P194MB1584B11245DF0DE7515297B6E3239@DU2P194MB1584.EURP194.PROD.OUTLOOK.COM>
Message-ID: <221011.86tu4ao8im.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 11 2022, Bart Kuster wrote:

> Dear People of Git,
>
> I had some trouble getting out of a detached HEAD state using git checkou=
t. I=E2=80=99ve solved it now but the behaviour of checkout when doing so l=
eaves me a bit puzzled.
>
> I=E2=80=99d expect the behaviour of the commands below to be equivalent:
>
>    git checkout origin/main
>
> vs
>
>    git config checkout.defaultRemote origin
>    git checkout main
>
> But they are not; the former leaves the HEAD detached while the latter
> sets it to main. I failed to find an explanation in the git-checkout
> documentation, which seems to indicate that checkout always updates
> HEAD.

They're not equivalent, the documentation that describes it is the
discussion of the --guess option.

I.e. these are equivalent:

	git checkout main
	git checkout --guess main

And the latter of those resolves to (in this case):

	git checkout -b main -t origin/main

The "in this case" being that it's actually (pseudocode):

	git checkout -b main -t $(find-the-only-remote-that-has-a-branch-named mai=
n)/main

And the "checkout.defaultRemote=3Dorigin" is a setting that disambiguates
that "find the only" down to "origin", if you happen to have multiple
such remotes.

But I'm still unclear on the "I had some trouble getting out of a
detached HEAD state using git checkout" part of your question, isn't the:

	git config checkout.defaultRemote origin
	git checkout main

Exactly what you want then?

If you're trying to get a "non-detached remote tracking branch", i.e. to
have this somehow checkout a branch:

	git checkout origin/main

Then there's no such thing. We treat them specially, and don't allow you
to check them out as a normal branch, so when you do so you end up with
a detached HEAD pointing to wherever that branch points to. IOW:

	git checkout origin/main

Is always the same as:

	git checkout origin/main^{}

Given that you have an "origin" remote, a "main" branch, it's not
ambiguous, or the right config blah blah.

That's also documented somewhere, but I didn't dig up where that is...
