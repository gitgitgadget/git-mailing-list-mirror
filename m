Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3E8C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 15:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352748AbhLCPTs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 10:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhLCPTr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 10:19:47 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B07C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 07:16:23 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id t5so12985915edd.0
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 07:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Wt2ApBXTTiKAaSsAht6fJxihkN9ilGjxUdN1M62UYdY=;
        b=llqjZwMnu0SdDfeZOoMEIbWtpAEL1/6QQqyVdrCOV26uuvnQWgOdsK1Et4EZrTV2Xx
         KEFL/jc8XMcMn2tBEZ+04dWmtj4zE80mBMS+mKhMbD0IiTHOjpzhAHGvzqbPeMgGvOfD
         mYPbQ4RT0Fc0NIpYIlLxaN+Wk6gzJIaqkD0zkr2V7g/tcp1ej+5qe358tIxl2FVGd3Wi
         AFDrZjXeaYcRCWbiFlJX/qHLDm9tko4duRtc7te7umZT+KwTFEGzbLCtm3J0jmQUM5i7
         24chC0MrG73DYNmWXZ7m4GVaV4HV7u1gw2Lxh/2vh2TJns7kuMBCOkTeCavNCzuMuzfY
         bz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Wt2ApBXTTiKAaSsAht6fJxihkN9ilGjxUdN1M62UYdY=;
        b=P17cmg3Q5EFAWCIU5/DWYjr8iiuIJ2QtLCb/Fo7jN8IfXxB0xoyRgCLsR/JfeQeZpA
         mTNoMGBRbf8jwfzQUn6KnvrjO4WulHXpXdJ3AHJ8pTnjNKEEFUFRcNKQaJs6swV7MAfc
         6JPq21hjU1Dg6g2ojLzqwU0IdrcZ5TEDCSdt3mGiIwsB6fWb2GmIfkHxKSFroWpXF2FH
         BDcrAGaGR3cT0VdvQ4kG8vx1Jt/webOeULvCehuIxFCCed5JD9Km0wJxJTfGdmf55BwH
         oGS4VDRXDRkSGUOfQA1WVND/gL8ZsrgBx3OmWbXey3ObK1e96jXM67nllLaDfWONq5/A
         oaDw==
X-Gm-Message-State: AOAM530QUVzgnIS7bzhMqfLCEqmKwU/OSrrrtgBkMOXWaRrygw/f2bnz
        ReEGByGjMFav9HVKmLElVm7WK7NlsfZJ/g==
X-Google-Smtp-Source: ABdhPJw+kqOvarLZvnW96kg2T+NEKoMuE9q4XBt8vwspjigq+FHNyUtnZVXU2A7jrzIaipcqTxpWsg==
X-Received: by 2002:aa7:c941:: with SMTP id h1mr27406899edt.319.1638544581215;
        Fri, 03 Dec 2021 07:16:21 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id jg32sm2490005ejc.43.2021.12.03.07.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 07:16:20 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mtAIN-000Bga-NG;
        Fri, 03 Dec 2021 16:16:19 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: Re: [PATCH 2/2] git-worktree.txt: add missing `-v` to synopsis for
 `worktree list`
Date:   Fri, 03 Dec 2021 15:57:41 +0100
References: <20211203034420.47447-1-sunshine@sunshineco.com>
 <20211203034420.47447-3-sunshine@sunshineco.com>
 <211203.86k0gmt5fl.gmgdl@evledraar.gmail.com>
 <CAPig+cR7f1koM7d2GoHMcDhZkQe3=XJD2RVuMajXSpcwZiyGtQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CAPig+cR7f1koM7d2GoHMcDhZkQe3=XJD2RVuMajXSpcwZiyGtQ@mail.gmail.com>
Message-ID: <211203.865ys5soqk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 03 2021, Eric Sunshine wrote:

> On Fri, Dec 3, 2021 at 4:15 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>> On Thu, Dec 02 2021, Eric Sunshine wrote:
>> > -'git worktree list' [--porcelain]
>> > +'git worktree list' [-v | --porcelain]
>>
>> Aside: I've been thinking of hacking something up to just change all
>> these "[verse]" bits in the *.txt source to:
>>
>>     [verse]
>>     $(git worktree -h)
>>
>> And then have the doc build process pick that up, run 'git $name -h', do
>> some light search/replacement (e.g. "$cmd" to "'$cmd'") and build the
>> docs like that.
>>
>> Seems far preferrable to dual-maintaining all of these forever.
>>
>> But in the meantime this small fix is obviously correct.
>
> One caution that springs to mind is that there may be external tooling
> which processes these documentation files directly, and such a change
> might break them. (The one which popped to mind immediately was the
> git-scm.{org,com} website, though I don't know what their tooling
> looks like.)

True, I hadn't looked into how that worked before, but behold!
https://github.com/git/git-scm.com/blob/main/lib/tasks/index.rake

It seems to be a re-implementation of a non-trivial part of the doc
building process.

In any case, if we do end up generating more of the documentation
ourselves presumably any such concerns will be brought up then.
