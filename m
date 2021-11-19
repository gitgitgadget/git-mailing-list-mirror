Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E26CC433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 16:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F86A611F0
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 16:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbhKSQoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 11:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbhKSQoY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 11:44:24 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2187AC061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 08:41:22 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r11so45040905edd.9
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 08:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=lbA/CtxYdiPXSMugsEe5fxIACeF1Hn3dM+fROzRXQ4o=;
        b=g7uO5TBbXX13Rz82KHGVV9cn9G4OT440hRvCTqrbtolcyYG3jcnx3v2iuOj6qeQtLW
         pZCzAc/REGd7K9ezS9p8IeNNr1tlp3hWhEVeyGMYLMon9QZhZ7VJWBS42gLMOQ5fOkdT
         sQRtkDqApfp8trGxSfnpVJbUr7OKL9np7iRuNNt1NEObkij/kP2kjoZDs3GLmIDm/3TZ
         nXaRr+yPv6roWbOjB2oa6yxdHn2rRIdL/+1x2X9sZA4u14iComXWXuq9r7dHKXADtrNa
         h1FC/D309T8WPvpdFFRl+r9hqmf4ohycY2wPu/0hcQ/njfD3teoH6lGzci7vdRuu/OqJ
         DE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=lbA/CtxYdiPXSMugsEe5fxIACeF1Hn3dM+fROzRXQ4o=;
        b=M9n0fg/uhVBd11ELG67J3RzL4Ztl4Dj7mbqSmjQMhC94Mpgi8EiZe1r4wzFxNr0Jrk
         7GeyvRGqq84Ij+UXiVZDoRatD4MTDZpsBb0XfLmqk0K2j6cvlOqg9g6w/Fs0k4CAPYQO
         1y3sNZx3DZnGZJAN8Zblaw3J9d3yeucfEbHzP8vR4IRrR0BhuwcHBteUE1NNSdKcwpJH
         QBugRBu5Sbtd1ou/5hK9jJfBS7zL+vB44El6DVzTVUqXKAZTsQxv+12FN5eSAcBKutlO
         tnTjzBaESZoaNDD74Bre7awkxP8gPfyoIKFpQRih4pRXOOV8+F6XAsnVZXbsrAwyiIs8
         uo8g==
X-Gm-Message-State: AOAM533uBUbIOORoBWh/0bf7cn/1k0lWHkvUwnDwLB0D+chK9zpU6oO8
        1waeUQ4v12QCgqfxAnJMWEE=
X-Google-Smtp-Source: ABdhPJxDSQdF8yRcBwWMY5G0aVoDFsaQYmeeRF3FFbhrGY+i6QkTukU3nTCHg83fUrh0+kdweUbzig==
X-Received: by 2002:aa7:dc15:: with SMTP id b21mr27069533edu.237.1637340080297;
        Fri, 19 Nov 2021 08:41:20 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l16sm180706edb.59.2021.11.19.08.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:41:19 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mo6ww-000m1N-U7;
        Fri, 19 Nov 2021 17:41:18 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] test-lib: introduce required prereq for test runs
Date:   Fri, 19 Nov 2021 17:37:13 +0100
References: <20211117090410.8013-1-fs@gigacodes.de>
 <20211117090410.8013-3-fs@gigacodes.de>
 <211119.865yso4a9y.gmgdl@evledraar.gmail.com>
 <20211119140953.cgdppgv3f64hqbdx@fs>
 <211119.86sfvs2p9w.gmgdl@evledraar.gmail.com>
 <20211119154036.5n5kpecgnptzkaqn@fs>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211119154036.5n5kpecgnptzkaqn@fs>
Message-ID: <211119.86o86g2j4h.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 19 2021, Fabian Stelzer wrote:

> On 19.11.2021 15:26, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>>On Fri, Nov 19 2021, Fabian Stelzer wrote:
>>
>>> On 19.11.2021 12:13, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>>
>>>>On Wed, Nov 17 2021, Fabian Stelzer wrote:
>>>>
>>>>> In certain environments or for specific test scenarios we might expec=
t a
>>>>> specific prerequisite check to succeed. Therefore we would like to
>>>>> trigger an error when running our tests if this is not the case.
>>>>
>>>>trigger an error but...
>>>>
>>>>> To remedy this we add the environment variable GIT_TEST_REQUIRE_PREREQ
>>>>> which can be set to a comma separated list of prereqs. If one of these
>>>>> prereq tests fail then the whole test run will abort.
>>>>
>>>>..here it's "abort the whole test run". If that's what you want use
>>>>BAIL_OUT, not error. See: 234383cd401 (test-lib.sh: use "Bail out!"
>>>>syntax on bad SANITIZE=3Dleak use, 2021-10-14)
>>>>
>>>
>>> Hm, while testing this change i noticed another problem that i really
>>> have no idea how to fix.
>>> When a test uses test_have_prereq then the error/BAIL_OUT message will =
only be printed
>>> when run with '-v'. This is not the case when the prereq is specified
>>> in the test header. The test run will abort, but no error will be
>>> printed which can be quite confusing :/
>>> I guess this has something to do with how tests are run in subshells and
>>> their outputs only printed with -v. Maybe there should be some kind of
>>> override for BAIL_OUT at least? Not sure if/how this could be done.
>>
>>It has to do with how we juggle file descriptors around, see test_eval_
>>in test-lib.sh.
>>
>>So the "real" stdout is fd 5, not 1 when you're in a prereq.
>>
>>Just:
>>
>>    BAIL_OUT "bad" >&5
>>
>>Will work, maybe it's a good idea to have:
>>
>>	BAIL_OUT_PREREQ () {
>>		BAIL_OUT $@ >&5
>>	}
>>
>>Sorry, I forgot about that caveat when suggesting it.
>
> Hm. Any reason to not do this in BAIL_OUT itself?  As far as i can see
> the setup of the additional fd's would only need to move up a few lines.

That does look like a better solution, I've tried it just now locally &
it works for me. Perhaps there's some subtlety I'm missing, but that
should Just Work.

This is by far not the first time I've poked at something in test-lib.sh
only to discover that its pattern of doing setup A, setup C, setup B
etc. caused a problem solved by moving B & C around :(

It could really do with a change to move everything it's now doing to
functions, which we'd then call, so what setup we do in what order would
fit on a single screen, but that's a much larger change...
