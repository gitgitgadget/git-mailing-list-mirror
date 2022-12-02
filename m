Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25463C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 10:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiLBKIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 05:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiLBKII (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 05:08:08 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810DB60B70
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 02:08:07 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id n21so10390966ejb.9
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 02:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MT7ULWX1WqNc8wVxeEmxSfA5r4Hg1q5VzhC0nNzwwR8=;
        b=aqdDEi9qHKChUBL5xmXTwCm1mfaERck9nIFW15T5JgfL1Ba7SKKgtZxLSnaVeuI/5L
         7CovAmwE15dR7EXJclM8dZG8wYKKWQk3M9jvoo7+txFuDZxCHDRv+FukAfVab9uPQdY2
         HscBJQNqSXsdDWguKyhpUTOn3g3Q3WNARF6yh7hWxlxmwTBridHmKyvvT4H5AWK4VH8K
         SptdaXFqWVQJ8ocB+JXCKth4YdmrFVj7N4fKf349YNw21qZrI030XNsxT1fOcJw9mg8Z
         1gTF+6tRYFGJGFwptXALRQVtLQfjcpQoofsgLpEPz0Tdp/W5sUOOXZBAdgfV8oHLuJML
         +B6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MT7ULWX1WqNc8wVxeEmxSfA5r4Hg1q5VzhC0nNzwwR8=;
        b=hy+zXfxxBdJl2OuSoRAfTkMXijvlCSH2evw9fesftBwPSKmuzV8EtXIE317FGP3/GS
         SB87SoCIqKfC+wlpeCGT7UHiJQ/gJr5m0MaE1Xu1RKU++xqMnwoSmGaqPsBRpdOK8HD0
         m7XpGw1f+CEvHtueXwjoJkCO/1eED7/yuFN7FItagvogDRr8StnZa8YfTkRZsqeErnFv
         Iob32z7Ck3B+NdNS8euUwArbjp2veEL36ST4pfmM4vvgBAaKRrU9P/EVGtkBpfR3hsJH
         lsWWwq1+coxi7wy9RZxed46XsO4/7nMUmuzxlYMrI11EH49LfC/p3vdQzTXMGtIfQ3bz
         OzZQ==
X-Gm-Message-State: ANoB5pnnbM+Qkn6sOkD+dARI6tgDSdQsHI4MYIHpe4N3j61e/LmCJJGM
        XPeyp38G9Hm0f13mZ4Apz/UevugSrw9NCg==
X-Google-Smtp-Source: AA0mqf6r9TJMIidSqrTpMrHAePPpBYhFwVnKIhdkZZciMees+H1hP5dPMJ3DCXrX34tpgsIy2EpWoQ==
X-Received: by 2002:a17:906:3a5b:b0:78d:f3f4:b1a0 with SMTP id a27-20020a1709063a5b00b0078df3f4b1a0mr59998691ejf.489.1669975685822;
        Fri, 02 Dec 2022 02:08:05 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id x8-20020aa7d388000000b004678b543163sm2751377edq.0.2022.12.02.02.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 02:08:04 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p12xf-002a9O-2R;
        Fri, 02 Dec 2022 11:08:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 1/8] log tests: don't use "exit 1" outside a sub-shell
Date:   Fri, 02 Dec 2022 11:02:28 +0100
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
 <patch-v2-1.8-7c9f8d2830f-20221202T000227Z-avarab@gmail.com>
 <CAPig+cQK8BRU0u0g+jAkyJaqSamYBynJ6s00_6H2beb6gXaRDA@mail.gmail.com>
 <xmqqwn7apodp.fsf@gitster.g> <221202.865yeugp7e.gmgdl@evledraar.gmail.com>
 <CAPig+cQvqPgo1UKbAAtyz8UVJZiwrG7j+kAokMEimv1E62pR0A@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAPig+cQvqPgo1UKbAAtyz8UVJZiwrG7j+kAokMEimv1E62pR0A@mail.gmail.com>
Message-ID: <221202.861qpiglto.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 02 2022, Eric Sunshine wrote:

> On Fri, Dec 2, 2022 at 3:55 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>> On Fri, Dec 02 2022, Junio C Hamano wrote:
>> > "return 1" is obvious and safe correction.  I have to wonder if
>> > test_expect_success can be taught to be smarter to intercept "exit"
>> > so we do not have to bo so careful, but that would be a much more
>> > involved change to the lower-level of test framework.
>>
>> I can't think of a way to do so that wouldn't involve running the test
>> in a sub-shell, which I think would bring us to the state management
>> problems noted in [1] for Phillip's "test_todo" series, except in this
>> case we'd have those issues trying to pass state back from the
>> "test_expect_success".
>>
>> It's possible, but we'd need to change a lot of code that's expecting to
>> talk to itself via variables in the same shell to use IPC between
>> shells, wouldn't we?
>
> It might make more sense to turn this on its head and make it a
> linting issue and simply throw a "?!FOO?!" as is done for other
> suspect shell code. In fact, I already have local chainlint.pl patches
> which detect whether a subshell is active so that the linter can
> complain if it sees `cd` outside of a subshell. I would think that
> warning about misuse of `exit 1` outside a subshell (and perhaps
> `return 1` inside a subshell) should be possible, though I haven't
> thought through all the possibilities.

That would be great. As a reminder I think (maybe it's not what you have
in mind exactly?) that we had a brief discussion on this topic starting
at [1]. I.e. I was hoping chainlint.pl could be extended to detect
exactly these sort of "test...$(git" patterns (among other things).

This topic doesn't get us there, but once we finally get rid of some of
those patterns it would be nice to have assertions to ensure they don't
come back.

1. https://lore.kernel.org/git/221024.865yg9ecsx.gmgdl@evledraar.gmail.com/
