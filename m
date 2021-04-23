Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE42C433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 09:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82A916145A
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 09:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhDWJQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 05:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWJQj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 05:16:39 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319F3C061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 02:16:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id mh2so51319886ejb.8
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 02:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Ra6w3KAYblpEzDfSU0DznunTXvuFT4oTps6kGTcKf6U=;
        b=L5KKOUdX23f9g2SYCybsP2pXuCxKoUPhuvNS3VszQ956kswx2TKWxf3It5nFHFXrqr
         7Ug7ZZ+dWK2bgwe5jUlhJwIz4pNUJ76iDIKftup2WAbmUTIzHb27Y1NsHPkhvupapHd0
         Bjem2GWfq3SA1cVEBNnZq7umGpzHTZ/iFwOLcbXB5hpCWrCJ25nqL7JHni36YbjPkh6Z
         H9tviqWTdKvTI8OPUWvAiXkDh6wNkEhKW/4KFcEeoE7vcPFwzlSWHW8jrFk34yxvObkx
         hLnSH4TlhTZZkCJn+GmDlcC00hUFlldlmsTSvPia/byMHn+1NX4iTvNOIGL/227srAE/
         3WYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Ra6w3KAYblpEzDfSU0DznunTXvuFT4oTps6kGTcKf6U=;
        b=G1bbq0wO4CH6DRz3YGBpqBIO7luasEey0/j4h4sHRwtcjv7A+5JApZAnPEPV8xXdvN
         Z+PQYLyo3BuUWjg1H3uEdvJy+FF5/vbChl+Mk1rlKp1fGVy/2ngoQsB30huWJIuAkWv8
         42rU+t3I2UO9xAFTSu/JtkvZFvyBMdExiRcSkMf598e6uSLp3uDU6HmPoBsCryU5AVYP
         UIHXb8QxkE+N7fFl5yTHQREnMBZ5Pn3VtJ1OHhqiKlUtL7c0AWKYprV+cslB+aG3ibIT
         udF3WaRB2yt7KNVhDgTpAoi/2Okiv1g2zXA+e0HP5K6z6eUfpL9UwNd7vL7Fa+BbFYeG
         YnKA==
X-Gm-Message-State: AOAM531d251Fx7c4IwO0XJJHCrWlgu4kg8U8c5Hbi2McmHaOFktWsPzx
        iXg+4Zm3C55f7wKJsPNkvik=
X-Google-Smtp-Source: ABdhPJzbeg6YvCtb1rr5vvPssLUeIgYZ74ozxMfNDhmSjcGXgj9/x62hr74J71T5UjztlkzUMx4FNw==
X-Received: by 2002:a17:906:b09:: with SMTP id u9mr3208351ejg.244.1619169361860;
        Fri, 23 Apr 2021 02:16:01 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w6sm3514996eje.107.2021.04.23.02.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 02:16:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 04/18] t1401-symbolic-ref: avoid direct filesystem access
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <53cf1069552b6cd6161ce6f69a31c44e59091096.1618829583.git.gitgitgadget@gmail.com>
 <871rb45ftz.fsf@evledraar.gmail.com>
 <CAFQ2z_MMAM6jZ0+zRi+8fyS69Qw4fKQSsXgQW2zW7tcMdmN=QQ@mail.gmail.com>
 <20210422045953.GC2947267@szeder.dev>
 <CAFQ2z_Md=LAkJzohf3E5ogWGQHzxN_ik=yHAGmxm7bg-yT6-Zw@mail.gmail.com>
 <20210423051255.GD2947267@szeder.dev>
 <CAFQ2z_NgFC-7zENyD7HkEgvS6Dtc4qYqPRFL3m1LsbXnrFkPsA@mail.gmail.com>
 <CAFQ2z_N9_eXtuGcXSj1bwP5sy+t1fn8Q=X1na0jK9OpzDz2UAA@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAFQ2z_N9_eXtuGcXSj1bwP5sy+t1fn8Q=X1na0jK9OpzDz2UAA@mail.gmail.com>
Date:   Fri, 23 Apr 2021 11:16:00 +0200
Message-ID: <87mttp1hv3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 23 2021, Han-Wen Nienhuys wrote:

> On Fri, Apr 23, 2021 at 9:47 AM Han-Wen Nienhuys <hanwen@google.com> wrot=
e:
>>
>> On Fri, Apr 23, 2021 at 7:12 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com>=
 wrote:
>> > > I see it as the test writer's job to clean up to the extent that
>> > > git-symbolic-ref can reset to a sane state.
>> >
>> > No, it's the job of whoever updates the cleanup routine to make sure
>> > that the updated cleanup routine still works just as well as it did in
>> > the past.
>>
>> Sorry, I don't mean to shirk my responsibility. What I mean is: is
>> there a way to signal "This test is fubar. Stop further execution of
>> test shell script".
>
> Or, more generally: if a cleanup routine fails, what is the point of
> continuing to run the test script? If that happens, the test directory
> is an indeterminate state, so the outcome of follow-on test-functions
> is indeterminate as well.

It's not a cleanup routine that's failing, but potentially the "setup
the next test" routine.

In this case it's probably best to invert the logic, i.e. to make the
tests do:

	test_when_finished "rm -rf copy" &&=09
	git clone . copy &&
	<test-logic>

Rather than:

	reset_state &&
	<test-logic>

That also makes it more obvious what's setup and what/where tests rely
on things carried forward from previous tests.

This test is just written in a style that I think it's fair to say
wouldn't pass review today. E.g. if you skip the first N tests we do
that resetting N times redundantly without any need for it. The pattern
of moving state setup & teardown into individual tests is better.
=09
