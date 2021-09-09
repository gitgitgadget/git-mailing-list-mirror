Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0ED6C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 02:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7E1161090
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 02:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbhIICmm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 22:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbhIICml (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 22:42:41 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FC8C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 19:41:32 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id me10so436835ejb.11
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 19:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=O+NnSuGla0P7X/vRKB/z+BrkLu74LJGukzmrIjFnTbU=;
        b=GM5R/bcl6BPxBFGp+4lPJNFlUS9NtuROO2tPO07jnw+8htSZCOv4a6dtuUK+t1TtZM
         pcwRQfVAlQBTH+bMf8XQcfVtQYYv7Rlpg8WnrCkUtbq9HA/WYAMYsz03gLWukimeb3dz
         Hvx+ihCwEJltVbT10gLZrtZg267f+wbjhCO3mQqp3vaBrPAy/X4HzWaAkP3LJdsII03n
         e5KLZHoygaRWV46IkgtWyoV9xaFpR6ofdAgcgkV+hpqlkmyCBc4XBkctKPEI2dIIzgEt
         VMdsCUe3diMfWsJRJJHo0tFS2aPpXfZQKuYJZUWZ7G2KBc5n8Y0LOofPVKgYAod0fYvu
         1flQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=O+NnSuGla0P7X/vRKB/z+BrkLu74LJGukzmrIjFnTbU=;
        b=cWfbIJ6m5f+OVF2eWbwF8TVczbwNCfoJbPSUsFnSfaLhqKtR9zCoeS/lxvSNdcraxw
         chuHsqiEuWBx+TlIZsNCDwrdO2+YbaRjivwOqB7A2HII6FtxSl8K9HCbjE8OI4pkoHwG
         4XC+S00sR7Pfirujx2dZEUeaG+mIJ+D4rTP0kjJpDhhbjhNnTld+V+vQiei0D+DmWRcy
         D/U2N1LCBYn/4kiITw/U9CmnyyT1dm623IK9fcYWq00Y7V0aNdjQwwKcLcApl6WudPQ+
         /w57BtHkQQzPcbx9mSLrpiOCBbMlyjzdjJSPmxqCGH7IHmqjTU8bixIVG/qGF6x2AFAm
         W5MA==
X-Gm-Message-State: AOAM532mDfrfdA/ingkYEzUOXbt8Kgqw+1z74IOIHSh2szT/Cuu3GruP
        /WjrXu+wZao2AC7GxYeHW5OoXLFF9Ksngw==
X-Google-Smtp-Source: ABdhPJybGd9D7MkzRxoYk5YGL0Qrs68N+2b8Q/XGIYjEAm5wBUy/Dtbhj6WtS6iRFJPZMvaFRkBrdA==
X-Received: by 2002:a17:906:417:: with SMTP id d23mr884638eja.383.1631155291010;
        Wed, 08 Sep 2021 19:41:31 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gz22sm128207ejb.15.2021.09.08.19.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 19:41:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v2 0/3] prevent opening packs too early
Date:   Thu, 09 Sep 2021 04:36:17 +0200
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631139433.git.me@ttaylorr.com>
 <877dfqhb8n.fsf@evledraar.gmail.com> <8735qeh8h5.fsf@evledraar.gmail.com>
 <YTlfp/tRmNy0kt+b@nand.local> <87y286fs3v.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <87y286fs3v.fsf@evledraar.gmail.com>
Message-ID: <87pmtifp2e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 09 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Sep 08 2021, Taylor Blau wrote:
>
>> On Thu, Sep 09, 2021 at 02:50:59AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>>
>>> On Thu, Sep 09 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>
>>> > On Wed, Sep 08 2021, Taylor Blau wrote:
>>> >
>>> >> Here is a very small reroll of a couple of patches to make sure that=
 packs are
>>> >> not read before all of their auxiliary files exist and are moved int=
o place, by
>>> >> renaming the .idx file into place last.
>>> >>
>>> >> New since the original version is a patch to apply similar treatment=
 to
>>> >> index-pack, as noticed by Peff in [1]. This should be queued before =
=C3=86var's
>>> >> series on top.
>>> >
>>> > I read Junio's earlier <xmqq8s063m7m.fsf@gitster.g>[1] as a suggestion
>>> > that we combine the two into a singe series. I do think that yields a
>>> > better end-result, in particular your 1/3 is much more readable if the
>>> > refactoring in my 2/4.
>>> >
>>> > I'm mot of the way done with such a rewrite, which also incorporates
>>> > your suggestion for how to manage memory in rename_tmp_packfile(), but
>>> > I'll hold of on what you & Junio have to say about next steps before
>>> > adding to the re-roll competition Junio mentioned...
>>> >
>>> > 1. https://lore.kernel.org/git/xmqq8s063m7m.fsf@gitster.g
>>>
>>> I've got that at
>>> https://github.com/git/git/compare/master...avar:avar-tb/idx-rename-rac=
e-3
>>
>> Beautiful :-).
>>
>> I mentioned in my response to [1] that I missed that message when
>> sending v2 of my series to fix a couple of these races. And I was even
>> happy to unify our two series, but you did all of the work for me while
>> I was eating dinner. Thank you!
>>
>> I fetched your branch, reviewed, and am happy with the result. So I
>> would be content to apply my s-o-b to your patches and resubmit them as
>> a unified series.
>
> Sounds good to me, also in particular any typo/grammar etc. fixes to my
> changes are most welcome, I tend to sneak those in, and any code changes
> you see fit of course.
>
>> But I did wonder if you wanted to include [2] in this series as well.
>> It's kind of different, but also related enough that it probably makes
>> sense to just pull it in. So I'm inclined to just do that, unless you
>> have any objections.
>
> In this latest push-out of "next" Junio's merged that one down already,
> see 1972c5931bb (Merge branch 'ab/reverse-midx-optim' into next,
> 2021-09-08).
>
> So I think at this point it could be built on top of that, but given
> that the two don't conflict in any way (textually or semantically) it's
> probably better to base this larger topic on "master" and proceed with
> them independently.
>
>> [2]: https://lore.kernel.org/git/patch-1.1-366ba928bd-20210908T010743Z-a=
varab@gmail.com/

Also: That avar-tb/idx-rename-race-3 has a bug where I didn't update the
bulk-checkin.c code accordingly, missed it because I was running a glob
of tests that included "*pack*,*rev*", but missed "*large*". I've got a
avar-tb/idx-rename-race-4 which fixes it. Sorry about that.

https://github.com/git/git/compare/master...avar:avar-tb/idx-rename-race-4
