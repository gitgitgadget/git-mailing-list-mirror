Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAE1C433F5
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 22:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E304F60F0F
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 22:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhJRWeW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 18:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbhJRWeV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 18:34:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89569C061745
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 15:32:09 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w19so4892762edd.2
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 15:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=gs52uXgLog/JJBzr0CAZ5ZL7rWn87SRqWxwGV2bSEXY=;
        b=pTW5dgEsh5dzs/3TqKMhs+zcOfCD65Uf6tVemTyiHOL2xZwKtEbQEdyoDhuNbQPZuK
         F5X+NY6KMAs3UUgKgT3sPpFjhnxQLTeVp4hN2Bsr8kxVpYsSTaf1fWctTb0trBS/YTdk
         2SqaQWcMBdLZ/qySVYMzyYqw6mzfixohIRlOBZuLukthLjp8gZVLgh+CEEH7/+CgunT6
         5gzSbLQ9QxHfDr4EQvqLWJCXjItOc4D5xSEJH9oHdH39ArZNOHBR02JQyFhWJfM3RUkU
         q/WgNhevWpcJYXIKbWMsWQ4xvarEcKlmwMrQIeTaJV8jWkv02keI+/jyqFQP85B18vOI
         D0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=gs52uXgLog/JJBzr0CAZ5ZL7rWn87SRqWxwGV2bSEXY=;
        b=7PjMSHZs+3JM0OftmFZZOymJkms5yek/z0u/8wtnmWjvqx6+p/L+lsySzZQh0JLv9Q
         sX/K2s/GTa8oyQF5N7dFURyvfnnUAIfR5ahc4Tk0dPaja1kk0QRSK06fEyRpc2dfBlh7
         YI15j2pdnkNig+IcfkyuRD8rYVZxMUOmpoUU3/YhB5zkPkfC+vUWFBrhdfHXy26E7Kuj
         mEOfUB8rzz6zBUJ3hjQ3ap0FIQPpvfkb3qLLn0xDAWVj8YJ2qil2QhwgYT4DIyB0l29Q
         dZphRVm+JrNGJl7k/6K4nLPXS+sfuEogLKvbZ7oU6u/ESb3fMtcz7nHKcpOhlF33YB7v
         KAwQ==
X-Gm-Message-State: AOAM5329fTaChLSqb+2aQ20zJMeGFo24qzfSaWbX/jQGiQ2EfIHKyE/e
        UdoD31Y7JMn+gKwL1pwAfbnN05QcfMU=
X-Google-Smtp-Source: ABdhPJyovqwyEOxcNRSBlyGgKze1LypbPrRPftBwgIgkvsn389S8MzS2f52D2owqiDLZtpEjkffFhQ==
X-Received: by 2002:a17:906:520b:: with SMTP id g11mr32998198ejm.502.1634596327756;
        Mon, 18 Oct 2021 15:32:07 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z1sm11084371edc.68.2021.10.18.15.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 15:32:07 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mcbAs-000Agx-O6;
        Tue, 19 Oct 2021 00:32:06 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        emilyshaffer@google.com
Subject: Re: [PATCH v3] branch: add flags and config to inherit tracking
Date:   Tue, 19 Oct 2021 00:11:54 +0200
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <b9356d9837479914bcf9a265f52afe170be7e2e2.1634445482.git.steadmon@google.com>
 <87a6j6tbsv.fsf@gmgdl.gmail.com> <xmqqk0iauhwu.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqqk0iauhwu.fsf@gitster.g>
Message-ID: <87sfwyx8ux.fsf@gmgdl.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 18 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Sat, Oct 16 2021, Josh Steadmon wrote:
>>
>>> It can be helpful when creating a new branch to use the existing
>>> tracking configuration from the branch point. However, there is
>>> currently not a method to automatically do so.
>>
>> There's no method to get *only* that config, but this use-case is why
>> the "-c" option (copy branch) was added.
>
> Hmph, I doubt the claim about the original motivation behind "-c",
> but it sure sounds like an interesting point of view.

While I didn't implement --copy, a co-worker of mine at the time did (in
52d59cc6452 (branch: add a --copy (-c) option to go with --move (-m),
2017-06-18)).

He wanted to try to submit a patch series to git.git, and came to me
asking for ideas for things to work on. I suggested that he come up with
something that had personally irked him, was lacking from his POV etc.

After coming up blank there I suggested something to the effect of
"well, if you want to just hack on git.git, but can't come up with
anything, I've got a pretty long personal TODO list in that area,
so...".

The feature is the result of that discussion & my mentoring it. So yes,
it's useful for other things as a side-effect of scratching that
particular itch. But in terms of why we ended up with it that's the
exact use-case it's intended for.

> The commit at the tip, as well as configurations are copied, which is
> most of the way there, but I suspect that the --track=3Dinherit is
> mostly to be used in the context of "git checkout -b" and the mention
> of "branch" is merely for simplicity of the description of this topic,
> no?  And you cannot say "git checkout --clone-branch original" (yet).

Yes, this has integration with "git checkout", but "git branch --copy"
doesn't.

The original iteration of "git branch --copy" that didn't make it into
git.git would switch you to the branch (so behave like checkout). So
there is a "git checkout --clone-branch" equivalent out there in the ML
archive, it was just invoked via "git branch".

I think at the time I advocated for having those "checkout" semantics,
but in retrospect I'm happy we didn't go with that, per the table I
later posted at [1]. That UX would be very confusing.

But we should have some way of doing "copy config and switch", and per
[1] we don't have that yet.

So now with this patch we'll have "copy remote config [and switch]"? I'm
not saying that's a bad thing as as incremental step, but it might be
worth thinking of the UX here more holistically. And Josh: I think some
extension/update of that ASCII table I posted in[1] would be very useful
to explain this change (and compare it to "branch -c").

1. https://lore.kernel.org/git/877dkdwgfe.fsf@evledraar.gmail.com/
