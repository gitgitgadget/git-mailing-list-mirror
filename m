Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5B9C433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 15:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240563AbiC1QBW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 12:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbiC1QBS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 12:01:18 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595B826ADF
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 08:59:37 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a8so29571537ejc.8
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 08:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=RX1xYrkul/JnwLgKbkMpVv99KhDsAPGamDxhMq36qoo=;
        b=SUs//1IwRdsMnUrwdp1Fh3P1CM7rNQdQJfiCyNHbE2N8GXQjwnBieqhbPekP259CXo
         rsI5lRt7LFu9pnRA2ssjkfFFTbaYhvCR7MKygh4s4+kD55ujkm+49gb0pvANukz2Yw6y
         GVK2JBpFKvQjP/oTDhBYbhBRd+svQP2ovAZxiGDOZkKiBzmbAgS8qfSDxF610FmMg4L0
         qeO+A7E3geV7/szmA3ZefUgeBLnMUAhiWK4jvTnjIQ0qI7rQ0ZlmrhBKEmsmWm3qBWTU
         RFe7PUhlh5L4ZoMB3x7nZ8vNR8XMlZb1sZx+VDcZyUgB2H+g1YqZoF2PhsPMy22bR/XG
         2nFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=RX1xYrkul/JnwLgKbkMpVv99KhDsAPGamDxhMq36qoo=;
        b=bcnvxcbjFzxykeMFojgytS0lblzI/AFQ+awcynyfOxIqtlfkDCRNbrMvLtKQN3o9Ol
         i2r/oZovmws9PX+xY8kku3LVM3EdkNlexcC0swjTZsIPAa/UZLPoquxuRXTnkkgqNmzo
         MUFv5kCxomzmkd2qQ10uqvrExzWNzkdiXzHS9ksbcHAY2bisqVlg15yFWfhYCplCcFn0
         cde2EjOlKO8jW+HtpCpKo3leWi9SPEt25u2HLfOXpxLMp8dawwOqKJmhn3O/y9kxWoGI
         dS+L3wX5HMQ8t8vMy1q2zwDLXdnmlzVPMzm0eRKJ5PUixtOBwLDO0Kb4KEnUW8HABtwV
         mdng==
X-Gm-Message-State: AOAM530+CMXJ6o8C2jeVQkxRZ5Y9cTBF05/R4J1ok1+up6XajoOlXj6n
        pARylQ1xPynXWopWPmNU3kj39esEiL10/A==
X-Google-Smtp-Source: ABdhPJyBID97vvupbvAQpCmHs5E/JOcNOicryT0bbk5qvo1P/ZHWKc4MV8bvuHJh3Vvftm140U9vkA==
X-Received: by 2002:a17:907:1ca4:b0:6da:86a4:1ec7 with SMTP id nb36-20020a1709071ca400b006da86a41ec7mr29083284ejc.556.1648483175668;
        Mon, 28 Mar 2022 08:59:35 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906a18400b006db0a78bde8sm6009821ejy.87.2022.03.28.08.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 08:59:34 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nYrmI-003Lfy-46;
        Mon, 28 Mar 2022 17:59:34 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: A "why TAP?" manifesto
Date:   Mon, 28 Mar 2022 17:50:39 +0200
References: <patch-1.1-47b236139e6-20220323T204410Z-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2203241434360.388@tvgsbejvaqbjf.bet>
 <220324.8635j7nyvw.gmgdl@evledraar.gmail.com> <xmqqczibjm7v.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.11
In-reply-to: <xmqqczibjm7v.fsf@gitster.g>
Message-ID: <220328.8635j23w61.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 24 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> =3D=3D It "can be parsed"
>> =3D=3D Human readable
>> =3D=3D It's trivial to produce
>> =3D=3D It's more flexible
>> =3D=3D It doesn't matter if nobody else uses it
>> =3D=3D Everyone uses it
>
> I agree with all of what you said above.
>
> But do non-human readers really want to read output from an
> "--immediate" session?  Don't they rather see the whole thing?

That test run will still take longer, especially if you're expecting
widespread failures.

The immediate use-case I have for this is that I have unsubmitted
patches to implement a "check" mode for SANITIZE=3Dleak, where it runs
with --immediate and "fails" tests that pass under SANITIZE=3Dleak but
aren't marked with "TEST_PASSES_SANITIZE_LEAK=3Dtrue", and passes (and
runs to completion completely) those tests that do have
"TEST_PASSES_SANITIZE_LEAK=3Dtrue" but pass with SANITIZE=3Dleak (and fails
those that would fail there, no "fail inversion").

That sort of thing is very useful to for any tests where we mark certain
other tests as being OK under a given mode, and except there to be a 1=3D1
correspondance.

The reason for the --immediate there is an optimization, it takes a long
time to run with SANITIZE=3Dleak, and if any single failure is enough to
declare the test bad --immediate is useful.

Now, the TAP tooling is quite tolerant of such bad output, another point
in its favor over something like JUnit (I'm assuming most libraries
using it would pass it through a generic XML parser, whose error
handling is either "ok" or "ARGHL!" :).

I.e. it'll give you a full parse, but just have a minor complaint about
the lacking end marker, getting rid of that output & parse nit is nice.

> The only "Huh?" I had with the original patch that started the
> thread was that TAP output currently does not work well with the
> "--verbose" option, and I've never run our tests with the
> "--immediate" option without the "--verbose" option to see where and
> how the first breakage happens and what is left behind in the trash
> directory, i.e. to bootstrap an interactive debugging session.
>
> But not being useful for the use case of human reader running
> interactively to get the leftover state does not mean improvement
> for other use cases is not welcome.

I was sad to see that ability go away, without the patches I referenced
running through a TAP parser with --verbose works for almost all ouf our
test suite, so IMO we were a bit overzelous in adding that early abort
for it.

But I do have patches to make it pass 100% guaranteed, so depending on
your interest ... :)

I was planning to queue that behind some of the outstanding test lib
changes it would conflict with, e.g. this one & the outstanding CI
topics.
