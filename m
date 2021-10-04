Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDF4C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 18:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6954A6115C
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 18:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhJDSCl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 14:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbhJDSCg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 14:02:36 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2D4C06174E
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 11:00:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b8so33572041edk.2
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 11:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Tno8iURTuXtdh8HYezxYVvnAsUS4TXteEUixpqIatuU=;
        b=lcl7NRLIvSTknbeyfkq64hOGW8KGaKYuiIWZj4ggIGp4Ovqm0spVJ1bE/S0gjX2tQV
         rotKZkM8pnq18bBnviyObsbGb8XTgbShi9ZVd+bV823EaY35QyFGZXRjrdQ10NCbMYmc
         +K1vtXD0Z+vHE64CN5Y5XtpEbCaC9pNq6K3KidMDydnG5GX6KUvLzrtw1KTiUhNuXyZ9
         6aiEDTzou6w4GJG/GmciAVnFujkLkjpXwyiHrf7VIUWw1+uyXss431MC/R0xRFLPu1tm
         uKsXKrVgDwd9Oe8U0OOgWOc2YZNA01QF35Wsm1Gv0uvKMIEzZ2o9c8jOCICSzsnfG5Ws
         miNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Tno8iURTuXtdh8HYezxYVvnAsUS4TXteEUixpqIatuU=;
        b=qCWFTqqnxVprnyt+QWjOQzMPwf+rl1mb9gSSEUa8mmTTWx0K9zEfYbORZxzxIEfCav
         PPshd4MEpkpjcLwDAC0BsAIkwAPBMDVd4ZDL+x9RRNu+6M8OntygijaqtNxjfhQQ022W
         CeeShvWd6JkP0UxZnAX0LimHxsCgg4kjjRv0bw8R0nIP7Rkb/QBm3AXAz3eYd34GMu1Z
         FMn8ypy6uzVsG8f3QriXlbeAtsqmPCi9lNADmidHY+K17/tQz7d99Zf3Pv52Si2aNfli
         LgLUacJGVLSS3xCH+M4rVYemr8YTm/eG1U2vcFks0XumKmddXfhW+9WVVSynatTWcWyQ
         pNyg==
X-Gm-Message-State: AOAM530qFxkzVhMdZKfJDwxJqeK5YiqOBMMX/DXuS4esywaRKAujCmr2
        331FsPmp3y7bRYzw2yExvItZGxPcVU4vTQ==
X-Google-Smtp-Source: ABdhPJwZtzp1y9IvKGUwUL67ru79r+rDUNpR0YC2ByFW5divb9znfi2eTrqjgMPzbCHV1EiX++IuGg==
X-Received: by 2002:a17:906:1454:: with SMTP id q20mr19106289ejc.446.1633370439283;
        Mon, 04 Oct 2021 11:00:39 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d22sm6779643ejk.5.2021.10.04.11.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:00:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH 1/5] "lib-diff" tests: make "README" and "COPYING" test
 data smaller
Date:   Mon, 04 Oct 2021 19:59:12 +0200
References: <cover-0.5-00000000000-20211002T091212Z-avarab@gmail.com>
 <patch-1.5-8a4ca06bce0-20211002T091212Z-avarab@gmail.com>
 <CAFQ2z_NwrpMuYmtB1caokup9SCr=od97ONG86c4PWmfEJ5vZCg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CAFQ2z_NwrpMuYmtB1caokup9SCr=od97ONG86c4PWmfEJ5vZCg@mail.gmail.com>
Message-ID: <877desmzzt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 04 2021, Han-Wen Nienhuys wrote:

> On Sat, Oct 2, 2021 at 11:19 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> Follow-up the change in 459b8d22e54 (tests: do not borrow from COPYING
>> and README from the real source, 2015-02-15) by not shipping a full
>> copy of older versions of the top-level "COPYING" and "README" files.
>>
>> The tests that use them just need the small blurb at the top of
>> "COPYING" as test data, or mock data that's dissimilar. Let's provide
>> that with a "COPYING_test_data" function instead.
>
> I had to read this patch a couple of times before I understood what
> was going on.
>
> Your change is a definite improvement, but if the actual contents
> don't matter that much, maybe something like "lorum ipsum" would be
> even better.

The actual contents do matter to the existing tests, which e.g. in
t4003-diff-rename-1.sh munge the COPYING file and then assert the exact
resulting diff output.

Those tests could all be rewritten to use some new better-known test
content, but I figured that wasn't worth it in this case, as opposed to
just providing them with the data from the opening paragraphs the tests
are interested in / faking up a new "README".
