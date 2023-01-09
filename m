Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B75AC5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 21:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbjAIV1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 16:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjAIV1e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 16:27:34 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4A9BCD
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 13:27:33 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id e3so436561wru.13
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 13:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QT44yFAdNF+sYJGCanb/VRQGpUqQCEESq6s0V012RGY=;
        b=RZlKuz4dCWh+PNMhlz3rNZqZnqNUOe6pL15udJSB0khr6/SDNyQDCOTZ6+S0nG0a1X
         WxM3OtKkn6mR84zdJF2aSErdnspieLcS/EzDYewf4yLBo/a1sWkjCYqBiMBp65FL6zSI
         TrW5QZKDLXSWThoMh3UbGoHQUi9hFLwovggFU/XmaELxOTGuHbwdhXaAr8jjY77oFZbM
         l0XF7TgONfgmIDJnoDhOorUpT4Yl+q2qLybz/ufrlm3drCHblDzWDi2AQWludr+WjAUX
         1FBDjwxegs+yYzVFDDRf9UHhjW64bPhoATanf7i2IGMvpwYrlnWztfcWH3GDlS6yjlCV
         RAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QT44yFAdNF+sYJGCanb/VRQGpUqQCEESq6s0V012RGY=;
        b=vxSP6wMIEFT3/5eKnG+TWaxaIAsiv7AI8mrX2MVrMS0+ktrMfg0ZLHEXC8xrofsJAX
         RjExHSX6PJaCmZiVwS0VGEZ5WlPKGZTJnFl6BIXlyRnYZw2jSYviB0NPWoENZadJDCgn
         ttqGSTN697vX9qyj1uc28qUFcmP6HkHSRu9YX4rC6Kxf/sBTyjDf1DzPPO1Y9wDguMIR
         HAGFnc1+BHIRSyi5Gbg1JK3UkfgC9ZADRmPKIJ3P12mrThm8iXAbnRa9O1gjmBFUCinC
         gxNH3onxoHqrOeiMM5+Gy398SHPzTAb635J7ocNna82jtXgrjgnq0a18PXG0pX1Xl6hr
         RS7A==
X-Gm-Message-State: AFqh2koABcEJ06Or8ve8/gpGsJgBhp8CPYb/9ADJUAEwnIin+/W8YUhj
        m1HP/Ag1KSP4nuFcjZbU1vs=
X-Google-Smtp-Source: AMrXdXuC5GGC7MIOQ6q5V0kq+PqHU1uAbTTS1rE6M1LMFLcpMUSeN19L8/xVQyizlTWti6VjKuFBug==
X-Received: by 2002:a5d:430e:0:b0:279:53e1:5178 with SMTP id h14-20020a5d430e000000b0027953e15178mr33071428wrq.45.1673299651440;
        Mon, 09 Jan 2023 13:27:31 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003d9e74dd9b2sm9093025wmq.9.2023.01.09.13.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 13:27:30 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pEzg2-000DpA-0f;
        Mon, 09 Jan 2023 22:27:30 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     rsbecker@nexbridge.com, Junio C Hamano <gitster@pobox.com>,
        Yutaro Ohno via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Yutaro Ohno <yutaro.ono.418@gmail.com>
Subject: Re: [PATCH] doc: use "git switch -c" rather than "git checkout -b"
 consistently
Date:   Mon, 09 Jan 2023 22:24:53 +0100
References: <pull.1422.git.git.1673166241185.gitgitgadget@gmail.com>
        <xmqqbkn8wcqo.fsf@gitster.g>
        <018501d9241b$fe4b1270$fae13750$@nexbridge.com>
        <CAPig+cQ1PMYhWiwRiq2eOWzHYmqcCC6QfkHCuVTxaeA7fz0ddw@mail.gmail.com>
        <01ad01d92464$b62492c0$226db840$@nexbridge.com>
        <CAPig+cTJ7CQpeo6v6j0L1beoTKyKnXcii2vYqRwy40R01vCo+A@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <CAPig+cTJ7CQpeo6v6j0L1beoTKyKnXcii2vYqRwy40R01vCo+A@mail.gmail.com>
Message-ID: <230109.861qo31jr1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 09 2023, Eric Sunshine wrote:

> On Mon, Jan 9, 2023 at 2:58 PM <rsbecker@nexbridge.com> wrote:
>> On January 9, 2023 2:17 PM, Eric Sunshine wrote:
>> >On Mon, Jan 9, 2023 at 6:20 AM <rsbecker@nexbridge.com> wrote:
>> >> git switch is still marked as EXPERIMENTAL in the online help. I don't
>> >> think moving broadly to switch from checkout in the documentation
>> >> should happen until the EXPERIMENTAL designation is dropped. After th=
at, then
>> >"switch -c"
>> >> should be used everywhere instead of checkout (except for in the
>> >> checkout documentation).
>> >
>> >Such a point probably should have been raised when 328c6cb853 (doc:
>> >promote "git switch", 2019-03-29) was submitted, but since 328c6cb853 w=
as
>> >merged nearly four years ago and has been pointing people at git-switch=
 all this
>> >time, it's probably too late to use it as an argument now.
>>
>> I agree. Perhaps it is time to drop the "EXPERIMENTAL" notices from 'git=
 switch', in that case.
>
> Perhaps. Perhaps not. As I recall, both Felipe and =C3=86var expressed
> rather serious concerns that git-switch is not yet ready as a proper
> git-checkout replacement. Samples of their concerns can be found at
> [1] and [2], for instance.
>
> By the way, git-worktree is even older and probably more widely used
> than git-switch, yet it is still marked "experimental", as well, and
> perhaps rightly so. As far as I understand, for instance, it still
> isn't compatible with submodules (though there may have been some
> recent work from one of the Googlers in that area?).
>
> [1]: https://lore.kernel.org/git/211021.86wnm6l1ip.gmgdl@evledraar.gmail.=
com/
> [2]: https://lore.kernel.org/git/CAPiPmQnb=3DXMaF2+YkryEbiX8zA=3Djwa5y=3D=
fbAGk9jpCExpbS4Rw@mail.gmail.com/T/

I think deciding on the "EXPERIMENTAL" would be nice, and it should
arguably precede wider use of "git switch" in the docs.

But on the other hand we already provide examples of it outside its own
docs, so perhaps a change such as the one being proposed here is
something we should just accept.

Discussions such as these might also suggest that thinking we can change
its fundamental behavior at this point are wishful thinking, i.e. maybe
too many users rely on it, and didn't read the disclaimer.
