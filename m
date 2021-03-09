Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A784FC433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF3864E7C
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhCIVE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 16:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhCIVD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 16:03:57 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAD6C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 13:03:56 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id jt13so31767332ejb.0
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 13:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=5Lq2SbE1LYVn5FKuYPpT4EFn5rzxURWepy2u6rw9jWs=;
        b=r7VL56W/fdpwj+JHD5PymcnoLgA/eWqhpvVNfLt6GQCzrhca/0y4K3nIglU+dBxfyI
         6kBNQl3FcrqEjIr9uVGw7c+y1gIF2d9JbSeWAcx0Mb2Iw84bbqTrJiAp5TDuLNvaj3o3
         zpq1Rf9ObPUM++JWkWyVYdMvYpRdyhnpP6Ygpmedx6PmYgmm7aNK9AJc8chBAjtCVFMe
         8K1I5v2jh7Ltz49zY67kA8MxgcOK5a/fWCikjE0ufP/6m6VrpZKS/DWPS5Vh8dUHJcnU
         pouBOcZ43ZlqVQE4fdNB9hYZM2xwRBs6haNZCM4G6q9xrMXaGH9D9BgHwW6W1FnUCXIK
         R0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=5Lq2SbE1LYVn5FKuYPpT4EFn5rzxURWepy2u6rw9jWs=;
        b=Jh2A//Khm4hGReN8CI+CL+/miVfoiHAUJMF7yRDXWFWcsLU/XTij+Sqza8Xk/9NiZn
         9TWRx8C4VC1kuJRvGvYQr3kU1NNS8SaNYeOG/k0I4Mt7ZjSACjeoSy0nBO7GKCZSxHAs
         jLkI3UdFdFw7U61+4JLVHXm50Tgu6pMD5FYMGS4pY4KXGgUECKy2yFtv/jthIQj3n2DV
         Aqs0VxfSGqVdspXb2FsX7bf95wch3IUA3U6iDEAr5c2DlFbaH7RhK8Id2CaXN+hbhNcJ
         8kmZb84URPRX0D+vUskl3hfBPIFfZUU7rqn0OJQF2ejKwacX7n+TxF/y1+fbBzhaOz6c
         rO5g==
X-Gm-Message-State: AOAM532IzVylhf+IlAPiKSxI8gBpm6BKS5+QYpit9ei7tZeEClbbAAdo
        3Wo86QerLF7KenSr0RifpTE=
X-Google-Smtp-Source: ABdhPJwh0c0oRaUMtAbfDSraW66ORKKst6hXOGmmHPfTDrszDoTwiOsKoWTyT/YQiP/sWya4dlQGdw==
X-Received: by 2002:a17:906:52d0:: with SMTP id w16mr12081ejn.172.1615323835488;
        Tue, 09 Mar 2021 13:03:55 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d5sm9750236edu.12.2021.03.09.13.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 13:03:55 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/6 + 1] test-lib: make --verbose output valid TAP
References: <87r1kzj7xi.fsf@evledraar.gmail.com>
 <20210309160219.13779-1-avarab@gmail.com>
 <20210309175249.GE3590451@szeder.dev>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210309175249.GE3590451@szeder.dev>
Date:   Tue, 09 Mar 2021 22:03:54 +0100
Message-ID: <87h7lkhwed.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 09 2021, SZEDER G=C3=A1bor wrote:

> On Tue, Mar 09, 2021 at 05:02:12PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> The eventual goal not included in this series is to have multiple
>> output targets, and e.g. convert ci/print-test-failures.sh to use a
>> TAP parser.
>>=20
>> Machine-readable "TAP --verbose -x" output can bring us a lot of nice
>> things down the line, I have some local WIP code that's a smarter
>> version of ci/print-test-failures.sh that knows how to spew out only
>> the output relevant to the failing test(s).
>
> I wonder what you mean by the word "relevant" here, as I can't imagine
> how you could possibly identify what is relevant for a failing test
> and what isn't.  If you didn't at all meant "relevant", but that it
> will show only the output of the failing test(s), then this is a bad
> example.  Our test cases depend too much on previous test cases, and a
> failure of one test can be the result of a change in a previous
> successful tests.
>
> Therefore, any such change to 'ci/print-test-failures.sh' will have my
> firm NACK.

On e.g. the github CI every step in the run is an collapsable button, so
we could have our cake and eat it too here.

It seems to me like a sane default would be to have an equivalent to
"print-test-failures.sh" that only prints the --verbose output for the
failing tests, and a "print-all-output-for-failing-tests.sh" or whatever
which gave you the full output.

Even then, there seem to me to be some low hanging fruit for
abbreviating even that output. E.g. if you we have 100 tests and we
failed only on the 5th, isn't the --verbose -x output up to and
including the 5th going to be enough, or do we need it for the other 95?

There's also ways to unambiguously abbreviate the output, and that's now
easy to implement as shown in my other just-sent reply to you.

E.g. a lot of our test setup is really repetitive, so under -x you're
sometimes looking at the same 5-10+ lines of test setup. We could just
do a couple of passes over the output and change output like:

    + foo
    + bar
    + he
    + foo
    + bar
    + llo
    + foo
    + bar
    + world

to:

    $1 =3D +foo
         +bar
    + he
    $1
    + llo
    $1
    + world

Or whatever, I'm not advocating for the specific syntax there, just for
the output to be nicer.



