Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A95BC12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A86D613CF
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240699AbhGPO4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240696AbhGPO4b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 10:56:31 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D97AC06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:53:36 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id l1so13267302edr.11
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=aCbZYlHOKVydoZ7TYRaS0iS1sdi5HR0bzSQ195x+858=;
        b=YlebhFVHVTOUxkvOZRbM7Hsa5eJarpHYCApOt8AB3QI+McAbR37FcqHWNIFy1WNfDT
         Ufv7K61SQbCPMSS4EtNDq0Kef8nwJ9FTnm07yk2j6Zp5KYOMGWrAgMs4En/vxNW6MFBH
         nsEUTkyrhiBKlBjQBrSyYd9gELgE2ooGn1Shw0XhY2MO9lF5EkZ2io1JsvZeWlP+iAJI
         68ROCOJKs8aDwDt8VwIVL6UF9NAr1o/N1hIv7LQmOkdMvuhGmlAyvO/8r0Vntn9mQA+E
         bIiB54X6Tn12xILDPI6TlsjHCcL60zEeHxG4dRarHpun5fjD7YCKSxGjSKd9D4JJDsB2
         YB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=aCbZYlHOKVydoZ7TYRaS0iS1sdi5HR0bzSQ195x+858=;
        b=GcHry0sLUMDlogvpdM7S5qpCvHyrDzftluEbHp4NRfO5Ln0aJ4A8Hd8PckN8nnd26T
         rK/wSQh+nQvhJLayQG86Hzmxc2o+Fyl071Sgc06K6PQs0tj5tga7T5V9fu2BNNqt1Y2K
         xM+gb+DdDXFUuVHG2MIdTSoZ8XanNAHwuEBpZ77TykpJZ027GPNaZgk0ZrRjYnWkT6lC
         1GqzoRR8/49JsNEzqN+d/H17FWuyy1m5Joit3G0vy9GValksTlheYlam8HdRKu9SJUIw
         I0qckhEFjRmzykX7HCG8qrQ8JmmlvvcXPevenQjkaHCcvNYT0PvXFllSv2Rk46eIJSJh
         agbQ==
X-Gm-Message-State: AOAM531hbcCPed7MXEYJ+jVWKFJgtHfPkqVyhH6HYWhaaoigPSDMOIk9
        EV4wDdzXVkLJNQWNqssPUX4=
X-Google-Smtp-Source: ABdhPJy8bm8F1XXn+xbCZEMMCKtq26bl2ufEky1HGRi9G1xsvyYz60o5p45LVWN8r3v3BTbVmpCKAQ==
X-Received: by 2002:aa7:c952:: with SMTP id h18mr15445145edt.18.1626447214710;
        Fri, 16 Jul 2021 07:53:34 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id f23sm2207196ejx.79.2021.07.16.07.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 07:53:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/4] tests: add a test mode for SANITIZE=leak, run it
 in CI
Date:   Fri, 16 Jul 2021 16:46:12 +0200
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
 <patch-1.4-0795436a24-20210714T172251Z-avarab@gmail.com>
 <YPCjTpumyh1P/DQj@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YPCjTpumyh1P/DQj@coredump.intra.peff.net>
Message-ID: <877dhqxqbt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 15 2021, Jeff King wrote:

> On Wed, Jul 14, 2021 at 07:23:51PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> While git can be compiled with SANITIZE=3Dleak there has been no
>> corresponding GIT_TEST_* mode for it, i.e. memory leaks have been
>> fixed as one-offs without structured regression testing.
>
> This opening puzzled me. I'm not sure I understand why we need a special
> GIT_TEST_* mode for it.  If you do "make SANITIZE=3Dleak test", then your
> binaries will leak-check while running the tests.
>
> I.e., there is nothing that test-lib.sh itself needs to do differently
> to enable it.
>
> What we _do_ need is some mechanism of annotating to tests to say "this
> is known to leak", so that we can skip them for normal integration runs.
>
> And that is part of what's going on in this patch, but I'm not sure it
> is the simplest way to do it. The first question is: how do we want to
> annotate the tests. By marking individual scripts or tests in the
> test-files themselves? Or by using a separate list of "these scripts or
> tests are known to pass"?
>
> IMHO the latter is preferable. It keeps the annotations out of the way
> of normal work (they are a temporary thing until we eventually pass the
> whole suite leak free, but I expect they'll be with us for a while). The
> downside is that the annotations may get out of sync with test numbers.
> But if we are primarily annotating whole scripts (and not individual
> tests), then that is generally pretty stable.
>
> And with that in mind, can we just use an existing mechanism for picking
> which tests to run, and drive it externally from the CI job?
>
> We already have GIT_SKIP_TESTS and --run. Those are perhaps a bit
> awkward for feeding huge lists to, and there is no environment
> equivalent for --run (so you can't trigger it easily from "make test").
> But what if we could do something like:
>
>   GIT_TEST_RUN_FROM=3Dt/leak-free make SANITIZE=3Dleak test
>
> and then t/leak-free contained the usual patterns like:
>
>   t000*
>   t1234.5
>
> and so on. That requires two new features in test-lib.sh:
>
>   - making a GIT_TEST_RUN variable that is the opposite of GIT_TEST_SKIP
>     (instead of just the command-line --run).
>
>   - adding GIT_TEST_{RUN,SKIP}_FROM variables to read the values from a
>     file rather than the environment (I suppose the caller could just
>     stuff the contents into the variable, but I expect that test-lib.sh
>     may want to pare down the entries that do not even apply to the
>     current script for the sake of efficiency in checking each test).
>
> That infrastructure would then be applicable to other cases, too. Or
> even just useful for using another list (or no list at all) when you
> are looking at whether other tests are leak-free or not.

I've included a mechanism for whitelisting specific globs, the idea was
not to have that be too detailed, but we'd e.g. get to the point of t00*
or whatever passing.

Anything that's a lot more granular than that is doing to suck,
e.g. exposing teh GIT_TEST_SKIP and --run features. of specific test
numbers, now you need to count your tests if you add one in the middle
of one of those, and more likely you won't test under the mode and just
see it in CI.

The marking at a distance I've done also has that problem in theory, but
I think in practice we'll use it carefully for globs of tests unlikely
to break.

This whole thing is much more with the GIT_TEST_SANITIZE_LEAK mode, it's
a really common case that we e.g. leak in some revision.c API user, we
should fix that, but holding up marking the rest of at test whose entire
tests otherwise pass is bad, it means you can't do any testing of a
given API or subsystem without getting the entire file to pass.

Whereas while we're fixing very common leaks in the codabase it's likely
that any given test file will have a few such tests.

It also means everything works by default, you get an appropriate notice
from prove(1), and even if you run one test manually it'll skip, but
emit a message saying you can set the env var to force its run.

>> This change add such a mode, we now have new
>> linux-{clang,gcc}-sanitize-leak CI targets, these targets run the same
>> tests as linux-{clang,gcc}, except that almost all of them are
>> skipped.
>
> I'm not clear on what we expect to get out of running it with both clang
> and gcc. They should be producing identical results.

Indeed, addressed elsewhere, i.e. it's just a thinko of mine.
