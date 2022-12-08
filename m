Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF5AC4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 13:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiLHNXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 08:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiLHNX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 08:23:29 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA5D7E43F
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 05:23:28 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id x22so3759686ejs.11
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 05:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mHMzQWfY/UIK9Z9EkVjuP1Dp8stqOR8AISxnS2/yE6w=;
        b=grtx4jrKvs94hrM/NduE6eDC48jD8L+xwYySwb8Ut7CbBITZJpjD71SIJEseEhBBAa
         c0E095kFSmfFBUmaAYvHvTzLLVD4aso1GTpDeyWjMtKaZDwhz3QnBMjIv07G/avZixAR
         7PUnnXzs4cfUj5PpgPqPtJcuYmWD2dJSHJSVKaMX8Ebn/OWyanG23p2zMjNu5blIkGnZ
         M5IBOMJi6nTEsTY9LyxW8ocAV0qUSg0XoLWOBqVYNsNtS3zbR+WUhgMckgVJkUOEq381
         tSLUse9+Pq9YTW3wRKriHqkL1aff8havwdFxUgu2tVdFmwd+cbBP8kR20b3vzdxw+lI+
         GCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mHMzQWfY/UIK9Z9EkVjuP1Dp8stqOR8AISxnS2/yE6w=;
        b=tuEhFzmmzi4a44wl4hSazOMtfxUgf8sLRKihHzG/q/V4u64bgDzB+a0FlFYyE1av5C
         zRsDDmm7G5TVcVqsPs/udMRyT8IcD1TH0RUddvVT/5whMn3oX6hQCsa4w+HWsTkVhl/u
         +i2aEjF++eOyuYUIxEsLr32kzF5puC8bWDT70VucA7bqTOYnZAdbmHBBerGWZT9wUGiL
         6JBmWhZPBp82+woKdf6eH2Z3VK4aCU3/tJ8bTq67zvnItOuz+LBZN8opd9wMhxnd5Kee
         ZxPTDToSXWnUumdYSM8SUFEgO2proYlT8l8jMmtar6DUpc1tofJPXGNoH00yqvSKtsGL
         gPRA==
X-Gm-Message-State: ANoB5pkF8BJE7vqRRTogMxDGWaeGhJPY8b9qevy3Yv3v0MiHtcH/Y2WX
        gRKIkXV6HA+hjcDTzgrvGYI=
X-Google-Smtp-Source: AA0mqf56GnNOLd5eXDoYtSPaVQgzCJgKtzeXukjURSZ6g1MFId56hLV3oaLQdpt+N6kbhIs06SgN+Q==
X-Received: by 2002:a17:906:2249:b0:7c0:e23d:12c4 with SMTP id 9-20020a170906224900b007c0e23d12c4mr1973638ejr.63.1670505806569;
        Thu, 08 Dec 2022 05:23:26 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id sb25-20020a1709076d9900b007ba46867e6asm9837027ejc.16.2022.12.08.05.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 05:23:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p3Gs1-0054qe-2D;
        Thu, 08 Dec 2022 14:23:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: "test_atexit" v.s. "test_when_finished" (was: [PATCH 3/3] t1509:
 facilitate repeated script invocations)
Date:   Thu, 08 Dec 2022 14:14:39 +0100
References: <pull.1425.git.1668999621.gitgitgadget@gmail.com>
 <97ada2a1202190776ce3989d3841dd47e2702316.1668999621.git.gitgitgadget@gmail.com>
 <221206.86ilipckms.gmgdl@evledraar.gmail.com>
 <CAPig+cSfvgu8XjvmmAkFWe1G1VDRgrcx5GjUhr4xSDqoJ4cZOA@mail.gmail.com>
 <n2586428-1r80-9s29-8345-7p2opnor5086@tzk.qr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <n2586428-1r80-9s29-8345-7p2opnor5086@tzk.qr>
Message-ID: <221208.86fsdq6nci.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 08 2022, Johannes Schindelin wrote:

> On Mon, 5 Dec 2022, Eric Sunshine wrote:
>
>> On Mon, Dec 5, 2022 at 9:48 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
>> > On Mon, Nov 21 2022, Eric Sunshine via GitGitGadget wrote:
>>> [...]
>> > This is an existing wart, but I also wondered why the "expected",
>> > "result" etc. was needed. Either we could make the tests creating those
>> > do a "test_when_finished" removal of it, or better yet just create tho=
se
>> > in the trash directory.
>
> An even better suggestion would be to use `test_atexit`, of course.

Why?

For assets that are only needed within a given test we prefer cleaning
them up with "test_when_finished", there's legitimate uses for
"test_atexit", but those are for global state.

In this case (and again, we're discussing the #leftoverbits if someone
wants to poke at this again) the tests in question could relatively
easily be changed to do the creation and cleanup of the files that are
"test_cmp"'d (or similar) within the lifetime of individual tests
("test_when_finished"), rather than the lifetime of the script
("test_atexit").

A good reason for why we do it way is that it has a nice interaction
with "--immediate --debug".

On failure we'll skip the cleanup for the current test that just failed,
but we're not distracted by scratch files from earlier tests, those
would have already been cleaned up if they used the same
"test_when_finished" pattern.

If you use "test_atexit" to do that all subsequent tests need to deal
with the sum of your scratch files, until they're cleaned up in one big
operation at the end.

It not only makes that debugging case harder, but also to write tests,
as you'll need to contend with more unwanted global state in your test
playground the further down the test file you are.

So I think what you're recommending here is an anti-pattern for the
common case.

There *are* cases where we really do need the "global cleanup",
e.g. tests that spawn the apache httpd use "test_atexit" rather than
"test_when_finished", we don't want to have to start/stop the httpd for eac=
h test.

We should leave "test_atexit" for those sorts of cases, not routine
per-test scratch file creation.

I semi-regularly run into cases where a stale "httpd" is left running in
the background from such tests (and not after I kill -9'd a test), so I
suspect we also have tricky races in that are, that probably aren't
improved by "test_atexit".
