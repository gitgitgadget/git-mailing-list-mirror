Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01069C636D3
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 21:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjBGVMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 16:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjBGVMv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 16:12:51 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4138233EC
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 13:12:49 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id p9so111893ejj.1
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 13:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OzlXt9GtFnH65bEdLoQ3yh5xqh8Eqpfa7pvnAt2bznU=;
        b=QoVtvtDbUQ2isnA3X+XlUMlpz3EQ0+xUBRItAdts0o1WYzvuZQI7hcSZa6XLm0h6X4
         JaWRSGSKSJ7n0aZ5tPphXkBwyfaA3iTGbmNtzc8DTCp0biepqQXsG9V8WpHXJCA+91Bb
         7Gal14Vl7g9FrT/mpj7PxVkJLYauSIRctBO2ZEofXoyEOFIb1T8K74s6s+e1cv5QvvzO
         HoBxF/Q2kCWMqsdagTwf1YVDSULDRlJSgZirs3Sj1Ng/mKDqDfJPsocieut3lWrBd/o5
         i2zWNNsUh3hvdlO+OA65kyazCPq8s8886Cja5cqiSBs/il9Iffbh7t89uxK0HPD/UPRP
         F4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OzlXt9GtFnH65bEdLoQ3yh5xqh8Eqpfa7pvnAt2bznU=;
        b=7bEUiuOo6sZlwgfiTWMSRimrbc/kx+yLMkC+9WpDrtUYq1ya/DgGDsmngMxY2Kx+sN
         /P+vilRXGh6D6g4+r2yaRvyx68zn0dMVNNIAfOUFtuKcKSZIWvVz0DdEidEzXzYSz+4O
         NYZJniC8ZXQYg4VHCpFwXGTzVuaTz6QBV+C/n1mJAY9EOZ2XTmHvv3vG3WUmCv9cfx0a
         zaJhR2KBR6E6kXcrvYUo8AJFDpIrEhFpt/R4ZUeHT2DBeW7M5Zk8QDQxnIxKYF40rBwQ
         aclPnr/rLAuz5g7fmB/87/Uax+YYeAZybHtpM3Px2rfgZRuHe5wRkk2G0ZyiTplIr3hA
         8IOg==
X-Gm-Message-State: AO0yUKVyKaCP9Ur77O82wC9HgP53uk9MSa1om+SHudAuOaVXzgU+a2Ml
        VANxpK1gsfd8wQ36ThJeslI=
X-Google-Smtp-Source: AK7set9IxoLj8Jx0xUsj5m5hppEwIKiYhBu3oi+yQcnclI/foV+ShYdeTrdqVQUaFuGob9vTmsYn6Q==
X-Received: by 2002:a17:906:131b:b0:8aa:be64:fd9f with SMTP id w27-20020a170906131b00b008aabe64fd9fmr1991807ejb.51.1675804368069;
        Tue, 07 Feb 2023 13:12:48 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id z20-20020a1709060f1400b0084c6ec69a9dsm7306134eji.124.2023.02.07.13.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 13:12:47 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPVGg-0011Sf-32;
        Tue, 07 Feb 2023 22:12:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Date:   Tue, 07 Feb 2023 22:05:29 +0100
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
        <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
        <Y+KQtqNPews3vBS8@coredump.intra.peff.net>
        <230207.86k00t2owm.gmgdl@evledraar.gmail.com>
        <xmqqcz6lyzhw.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <xmqqcz6lyzhw.fsf@gitster.g>
Message-ID: <230207.86bkm52n8x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 07 2023, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> From the user's perspective, this is weirdly inconsistent with the
>>> existing diff attributes, which would be more like:
>>>
>>>   # in .gitattributes
>>>   *.json diff=3Djson=20
>>>
>>>   # in config
>>>   [diff "json"]
>>>   algorithm =3D histogram
>>
>> That does look more elegant.
>
> We use attributes to define what it is, while configurations are
> used to define what to do on different things.  The separation of
> attributes and configuration came not from "elegance" or "security"
> but from a lot more practical reasons.
>
> For a tracked file, the fact that it contains JSON text as payload
> does not change per user who cloned the project, or per platform the
> user used to do so.  In-tree .gitattributes that the project
> controls is a perfect way to define what it is for each file.
>
> On the other hand, the diff program suitable to compare two JSON
> files may vary per platform (your favorite Windows program may not
> be available to me) and per user (a platform may support more than
> one and the choice becomes the matter of personal taste).
>
> The security aspect of giving users tighter control over which exact
> programs are to be run by not allowing the attributes or so called
> in-tree configuration mechansim is a small bonus that fell out as a
> consequence.

To clarify, I'm not suggesting that we ever read arbitrary parts of the
"diff.<driver>.<key>" config space, but that we could whitelist one set
of "diff.<driver>.<known-key>"=3D"<known-values>".

The reason to do it being that, as Jeff points out, that config
mechanism is already established, and arguably more elegant. I.e. that
this is a natural fit for "diff=3D<driver>" in .gitattributes), and that
mechanism is already tied to config as Jeff's example shows.

Some of your reply seems like it assumed that I was suggesting that we
read "diff.algorithm" (i.e. a config setting to apply for all paths)
from an in-repo .gitconfig.

I wasn't suggesting that, nor that we open Pandora's box on starting a
limited in-repo .gitconfig support with anything remotely to do with
executing arbitrary commands (which the full "diff.<driver>.<key>" space
does support).
