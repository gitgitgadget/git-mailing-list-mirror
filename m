Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DCBC433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 02:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E7A861175
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 02:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbhKICHX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 21:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhKICHX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 21:07:23 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB1CC061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 18:04:38 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x15so39120057edv.1
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 18:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=W+nbdPHKETs+5MtMjwtEYfeeJgj0x8NUCJQPbHt0lLg=;
        b=QAyHtg9PeVMNh/JP8vFNE/+aZETKvTNIop+WDyEeKXtKl5AEaQJqr6LZrqlHGGAsGO
         YXh+ARY9Xa5/SzgLx904gFdVekj8yJz2vgYp98YVL0ijtYZSIFty1smNpjI3FId3NlKn
         HpxAC8oZ28rr5yJSGJ067bCK4XsTXZtzlr3zOQCk6Xxpe75lEGqfKhoo5AEkLoDBq0Xj
         tqje7Sag0G7NW1w7h724UxqxhdmI2salkxgCKcPRWzqr6DoW1WHp8QqboLYqmHrgsc4P
         +tibqIf8Of5cL0VQPXKn2Y0n41gZj/f4y0kKo8Ewo4Q3oO2KIv2YWBwkxlCXbmQIryRd
         ac8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=W+nbdPHKETs+5MtMjwtEYfeeJgj0x8NUCJQPbHt0lLg=;
        b=u8gvcJXalxzClVrV4D/T+4q8gEYFLCNOG8rznhbp89wRR3WyRdLHUcONOCKGBzYKVK
         D3gbpA16vSzeb1M2L4pRi1wCbEP/wz834jkZLR0ZgeVWo0aOjk7yBcBVMq7PQj9anohn
         PqPIqCDYFcIaSDS8aRXAa7Gruv6TKM+00HGDk0F+fXd6fuM+rDVAyHL/hw8AumDNl2kf
         kNvKFICbKMy+MPHheLSQv1eT8N3M6y0vDQQ5XfSl8CR3tRBbW/DTXBmuBAERg6svDZRc
         0L0SYtnWZT709CNT4B+UgviNbqGvizwcCvwO4T/7TNHNvSutD1eXULKo/DKVsATxjDZx
         q78A==
X-Gm-Message-State: AOAM5334z4CBpqPjS3IWQ88IyWVlLuldk/qLJaB6ZLx6N1k8Wqk+tT1r
        SGhV8M/CX7gSPoHyRZKEUMU=
X-Google-Smtp-Source: ABdhPJz1zWZO5f4qblqLynCXJT20d1BIoueF6h3Wlu53HaNvygIF69F65i2Hjhi9jUIMp1Yh34T5ug==
X-Received: by 2002:a17:906:2b12:: with SMTP id a18mr4884867ejg.254.1636423476487;
        Mon, 08 Nov 2021 18:04:36 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w25sm1959250edv.57.2021.11.08.18.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 18:04:35 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkGV1-001JIw-2z;
        Tue, 09 Nov 2021 03:04:35 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        J Smith <dark.panda@gmail.com>
Subject: Re: [PATCH 7/8] grep: simplify config parsing, change grep.<rx
 config> interaction
Date:   Tue, 09 Nov 2021 03:01:12 +0100
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
 <patch-7.8-677a8f8520f-20211106T210711Z-avarab@gmail.com>
 <YYms4czKVnQFWYQ+@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YYms4czKVnQFWYQ+@nand.local>
Message-ID: <211109.86ee7qdqz0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 08 2021, Taylor Blau wrote:

> On Sat, Nov 06, 2021 at 10:10:53PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> I.e. a user would correctly expect this to keep working:
>>
>>     # ERE grep
>>     git -c grep.extendedRegexp=3Dtrue grep <pattern>
>>
>> And likewise for "grep.patternType=3Ddefault" to take precedence over
>> the disfavored "grep.extendedRegexp" option, i.e. the usual "last set
>> wins" semantics.
>>
>>     # BRE grep
>>     git -c grep.extendedRegexp=3Dtrue -c grep.patternType=3Dbasic grep <=
pattern>
>>
>> But probably not for this to ignore the new "grep.patternType" option
>> entirely, say if /etc/gitconfig was still setting
>> "grep.extendedRegexp", but "~/.gitconfig" used the new
>> "grep.patternType" (and wanted to use the "default" value):
>>
>>     # Was ERE, now BRE
>>     git -c grep.extendedRegexp=3Dtrue grep.patternType=3Ddefault grep <p=
attern>
>
> OK, so this is the case that we'd be "breaking". And I think that the
> new behavior you're outlining here (where a higher-precedence
> grep.patternType=3Ddefault overrides a lower-precedence
> grep.extendedRegexp=3Dtrue, resulting in using BRE over ERE) makes more
> sense.
>
> At least, it makes more sense if your expectation of "default" is "the
> default matching behavior", not "fallthrough to grep.extendedRegexp".
>
> In any case, I am sensitive to breaking existing user workflows, but
> this seems so obscure to me that I have a hard time expecting that
> m(any?) users will even notice this at all.
>
> The situation I'm most concerned about is having grep.extendedRegexp set
> in, say, /etc/gitconfig and grep.patternType=3Ddefault set at a
> higher-precedence level.

*nod*, but the only user who'd end up with that is someone who's trying
to override grep.extendedRegexp but failing to do it, so this would
help.

Or someone who'd read the docs, understood that we promised that would
do nothing, and inserted that just to test us, but that seems unlikely
:)

Or, I suppose someone who's entirely confused, and will continue being
even more confused now that behavior changes on a git upgrade from ERE
to BRE.

I'm hoping the last two paragraphs describe no-one & that this is safe
to do.

>> ---
>>  Documentation/config/grep.txt |  3 +-
>>  Documentation/git-grep.txt    |  3 +-
>
> Not the fault of your patch, but these two are annoyingly (and subtly)
> different from one another. Could we clean this up and put everything in
> Documentation/config/grep.txt (and then include that in the
> CONFIGURATION section of Documentation/git-grep.txt)?

I've got a large series to do that for all of these, but opted to skip
that particular digression here (even for just grep.txt it's a bit
distracting).
