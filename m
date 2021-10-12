Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BEDC433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E185F60F3A
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbhJLNqD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbhJLNqD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:46:03 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76631C061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:44:01 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w19so21404964edd.2
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=2ltBWp9DahsGxSJml62w8S6OKQJi6ROj19gAcSMMDUY=;
        b=I7hcibGfc6JoNSRFnCw6QdoW3yDELHnr+IkKcXU53sDqvkF39KlTyygIvw/wTr2hzi
         YchmgtKsi0DCG5HP6uSrr6w0I7+iCQrEQhoyJZOxC6bZfmbAY9w8Lt1gSIVzuoY0G3RE
         W4yUQCKSnzwbVVr/slrxU53NYIh8rh7LFMwVJJzDlwur/aE8O1Q0zUAPr+xrYAmH3Iqs
         XWWQdIUxG14vu3WCaQoDYGDmnStdHdYOhUSGbA9Tyhr1s+1kW/5MyniioohBjIKRDhnG
         EpcPwElB0/5FCSYbQaa2MwU4LHB5jk02tNJ4gcIEXvWqh3IWyZHaqBJBVBDTlU+VtTFx
         VHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=2ltBWp9DahsGxSJml62w8S6OKQJi6ROj19gAcSMMDUY=;
        b=7RnSXxMHnZnrvIC/dhayJ9XyWwxZ1e4EB1XXw3/sntmPyGPsszzQyiq6VeYUt7tQ6j
         99RwJRL/kpjN4eIUW99HrfwqkCW05ugCiPkU8e6KpNCjaR1aCTqXAtZxR6IuPfE/d2dX
         rDe7HIAy49pY3KDJuQ8LFVGJ7nzw7i2YYXTJKTS1Zo4rof0Iv4VGle/5q6ovevtNvB+2
         KQI1qvPGOdUBUrq8MZVCFPvmJDAw/32/pEh0J5nQ0bC1T36+VuAMhjaNMyihzv+h31kn
         pEiv3N1un0u+7eVMBzjDX6cmpM0Wr+/DHhnQLe71UxqnMW71dS1cNqWcfi+iccNDwGuo
         s8CA==
X-Gm-Message-State: AOAM533wPRFj4B36UaUr9rEYW5MyysY1Td0cxyA4IkrGdAonZs30XYwZ
        omwQ6d1zobtlP5ARr9Culy7mA7C/UB1yuQ==
X-Google-Smtp-Source: ABdhPJwWNS13Uoxi6GKr9bhurpSnNHCWWQr194eqVKlz/Ype+70mwbXqlGK7BIvTyHkRa+w2bkhXcg==
X-Received: by 2002:a05:6402:26d1:: with SMTP id x17mr51734898edd.300.1634046239779;
        Tue, 12 Oct 2021 06:43:59 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p10sm3362457eju.74.2021.10.12.06.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:43:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/10] leak tests: mark more tests as passing
Date:   Tue, 12 Oct 2021 15:40:04 +0200
References: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
 <CABPp-BEpCa7dxYqe2R82N_eVzx5e17C2w+d1zD9XWzyEXCDbPw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CABPp-BEpCa7dxYqe2R82N_eVzx5e17C2w+d1zD9XWzyEXCDbPw@mail.gmail.com>
Message-ID: <87czoajr35.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 06 2021, Elijah Newren wrote:

> On Wed, Oct 6, 2021 at 2:50 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>>
>> This goes on top of ab/sanitize-leak-ci, in that topic I introduced a
>> "linux-leaks" job that runs in CI and checks that we don't have
>> SANITIZE=3Dleak regressions, but it just marked one test file as passing
>> under that mode.
>>
>> That was out of an abundance of caution, and to not conflate any
>> potential failures with the mode itself.
>>
>> This series marks up a lot of tests as passing, ensuring that they
>> won't regress when it comes to memory leaks.
>
> I like the series.  It does have the potential to annoy folks who want
> to add additional tests which make use of git commands outside the
> area they are modifying and which happen to have pre-existing leaks.
> But, I think in such cases, they could just remove the
> TEST_PASSES_SANITIZE_LEAK=3Dtrue and mention it in their commit message.
> And when the checks fail because of a git command someone is
> modifying, then we get useful early signal and the author can address
> the problem.

Yes there's a definite chance for annoyance while the common leak fixes
I've got planned are cooking, i.e. as we've discussed elsewhere "git
log" and "git checkout" among others leak in almost any invocation you
cank think of, so if you add a new test that steps on those landmines
(including via test_commit!) you'll run afoul of this.

But I'm hoping to have those common cases sorted out SOON, so hopefully
any problems with this are short lived.

Just FWIW if this does happen you probably won't and shouldn't need to
remove the TEST_PASSES_SANITIZE_LEAK=3Dtrue entirely, it should be enough
to make the specific test use "!SANITIZE_LEAK" as a prerequisite. See
956d2e4639b (tests: add a test mode for SANITIZE=3Dleak, run it in CI,
2021-09-23).

Well, that can also get annoying if e.g. you want to add a "test_commit"
to a short test that has an existing setup (you'd need to split up the
"setup" phase).

Anyway, will re-roll, just FYI^
=20

