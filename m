Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF128C28D13
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 23:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbiHSXi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 19:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiHSXi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 19:38:27 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFC93DBF1
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 16:38:25 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r16so6761881wrm.6
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 16:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=IhdGmiT8DxYPW04ieyBh5f0BjoF7C9YY618GT2tY5cY=;
        b=AQIEIA//d1W8DaN1eweGWR1TO1PHLHzCzvimNS/i2AYjnDlCGyBad59qfj7RQidHB1
         bGv/L08+pPwOGbhkRlYMEE58maz0FjZx+a/OOzxiIGmkiST8wpffwv0ty/sQepvxJybB
         ZDwuVsWYCJLvpzWe5XCKGpNT2HuyW0MpHtJwpSOMxNBZ8CdZPo84HXkkkxoz3bq7hy1d
         Qodglv+GnDvCaYYnCULGcmBpcvZfk2Mp+nJ5lIhPfxr3kivtwcpNS0DEphxh/ezGddf0
         43teVdszjOWtt9KCF6jZjdaQZsuNARIzOjTi26mLZ+7fPVGyqN0atIA9PmWszh9MtQ91
         caZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=IhdGmiT8DxYPW04ieyBh5f0BjoF7C9YY618GT2tY5cY=;
        b=FB7/HgfGEJVt4LpzdAii9iiz8j0T0ND7RhhtEcCaG41H9LubFP3IXtxkog+isTSyXt
         1qKDsmrOgDCBW1+koGkZAsbBZaFs4wQl+mvoYWF+uTrMuyO0UTvCgV0U+Mmi9efja4DG
         7K5hC3VnM+RPvpAL1igTcwNcIPRlHxq6vFgO5Bbgv3Ru3FfGGInVgfTYipxS4xbxsunq
         XyE8+qBVmT4r43xRa9rdUGXfW7OJGmuY36hwgSRaDjcjXrP5TCiXVnviM6emeSbmrLAL
         M0WiEr/g2nuYqmG8RjqmymBLgYSpoWR6eYocSu3BXN3P4Uxrv5jFACWGjmSSEhXZTWzk
         YjIg==
X-Gm-Message-State: ACgBeo1pDXKidTE8Dya7nyLbTS9uMWooZOSMERs84eoaMyZQi3hxY/zf
        XfAJ7ECQa0wpdgR8oa92+dE=
X-Google-Smtp-Source: AA6agR7uGdC2nuqrhQpcEMGwOAtBpx9kBMfPdIWlpszFdB1mmPeMP+fUygAdo8n7gDkqQs/JkofKhA==
X-Received: by 2002:a5d:64a6:0:b0:21f:b3b:5cc9 with SMTP id m6-20020a5d64a6000000b0021f0b3b5cc9mr5059210wrp.601.1660952303816;
        Fri, 19 Aug 2022 16:38:23 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id bg2-20020a05600c3c8200b003a5e9337967sm6839089wmb.13.2022.08.19.16.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 16:38:23 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oPBZF-000yVG-1x;
        Sat, 20 Aug 2022 01:38:21 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/4] sequencer: do not translate reflog messages
Date:   Sat, 20 Aug 2022 01:33:56 +0200
References: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr>
        <cover.1660828108.git.git@grubix.eu>
        <ea6c65c254bb08b20ea6c4d81200b847755b555c.1660828108.git.git@grubix.eu>
        <220818.86zgg18umf.gmgdl@evledraar.gmail.com>
        <6oqr69o7-qsps-sr86-o4r9-16r7no9n5424@tzk.qr>
        <220819.86o7wg6zci.gmgdl@evledraar.gmail.com>
        <xmqq8rnkklon.fsf@gitster.g>
        <220819.864jy853qc.gmgdl@evledraar.gmail.com>
        <xmqq4jy7kg8e.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq4jy7kg8e.fsf@gitster.g>
Message-ID: <220820.86v8qn4xea.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 19 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Fri, Aug 19 2022, Junio C Hamano wrote:
>>
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>
>>>> Doesn't that also mean that the relevant functionality is now also (and
>>>> still?) broken on any repository where these translations ended up
>>>> on-disk?
>>>
>>> It may, but the first response to that problem is not to make the
>>> breakage in repositires worse by keep adding unparseable data to
>>> them.
>>
>> *nod*, but where is that breakage specifically?
>
> Set your LANG to something other than C and then run "git reflog"
> after running sequencer operations, and you'll see the same breakage
> that motivated Michael to send this patch set, I think.

Yes, I can see how and what we write to the reflog. But in order for
this to cause anything other than cosmetic breakage we'd need more than
that.

Or what do we mean by breakage here?

That it's broken because we intended for these to be LC_ALL=3DC, but they
weren't? Fair enough, but that's got a smaller scope.

Or that it's broken because we expected to not only write "rebase:
fast-forward" into the reflog, but to parse that out again, or to
e.g. parse the "rebase" part of it out as a command-name. I haven't
found *those* bits yet.

Of course we also have to worry about third-party software that expected
LC_ALL=3DC breaking. I'm just wondering if we have some code in git.git
that would also be similarly broken.

Because if we do it wouldn't be that hard to just hardcode all the
translations we shipped at that time in some array in the C code, and
not only parse out a "rebase: fast-forward", but also the German
etc. equivalent.

