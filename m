Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9984FC77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 15:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbjEBPqK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 11:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbjEBPqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 11:46:09 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033403586
        for <git@vger.kernel.org>; Tue,  2 May 2023 08:46:03 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-38e3a1a07c8so2420477b6e.0
        for <git@vger.kernel.org>; Tue, 02 May 2023 08:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683042363; x=1685634363;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJeeXhU+FllpWaKheXG8tnxgJNmcHHbYrRVyxwDVp48=;
        b=E62PdpYIv8nye4/I7rRUzCjfwCFzvpmlNMriMwuZoUAkf7fc1t0QOAyzILWqc0IZ6J
         +lSIQ+m6jZ3sqRoAHpPzprxL9jZEdzzPwIGuwyvA16vuAgUPyxl2PzVBAEU7ZpBsagb7
         c/mr4BE1mHh5vwXLI2NiESiC6ZnXcev8pHY40QYUeOzzBznykUZ4Tp4+TUruZt8ZyKuO
         puFek6ws+blIgU8+I4pLe6RdnLGitCNGV1OBm9KJ+iU4NTl2u8D3Ew/fjv/mDBtNo/nL
         lWoxUF//lD6I3wPvu8Vcx29uGysRylKAh4wIYkrj+y5gn0NwudFfqnNpnF5siIeo/HO7
         t2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683042363; x=1685634363;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OJeeXhU+FllpWaKheXG8tnxgJNmcHHbYrRVyxwDVp48=;
        b=Oug9Moo7+HPg2W51qfP2du6RdUYAUI+WoFf+N9G/lHZ+DoPYmmPwdu4AD06zDTtabA
         igzJ6OVj36cBP2UGLUHg5WTyjZlvjphaObKL+9QgtO2SllyOkElbk2WH5BI5mbxjPaA7
         uWZQ8yH4/+W0PUc4gaDu/4Qf3CiFG/+yXhdHEXGAeThjghaGpIY0Koha+JIB/pjV9HlF
         SN2YrWTvXdruVqpoFiNnQnk5ZDoo7pjl8AQ20oie76WXgMa5WWYUJVMp4/hulvYAuS6a
         fvkPTR6c9wTv0UwFmYssejTbHvwjrYcHhO1hKwjzKZhQx4jo837CVMr9IRmhBG8kKZjF
         Jdqg==
X-Gm-Message-State: AC+VfDyD1Dck47fbBNEtmyHrpLlB+Ij3OV1eJQX/uJPnaNoiqYU6IpvX
        WyfBSsjJRBIQ3wZ8pqWAkF53GoHP1Ow=
X-Google-Smtp-Source: ACHHUZ7vfNlJk2S1IOCyNy7Pyof/cDmgmSHR31emJ3n+Mqfd9kAMyTnvX1PvC47whrXVhh1rSR24Tw==
X-Received: by 2002:aca:1001:0:b0:38e:63aa:b5bb with SMTP id 1-20020aca1001000000b0038e63aab5bbmr7624627oiq.40.1683042363214;
        Tue, 02 May 2023 08:46:03 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id ay13-20020a056808300d00b0038e086c764dsm12283112oib.43.2023.05.02.08.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 08:46:02 -0700 (PDT)
Date:   Tue, 02 May 2023 09:46:01 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Calvin Wan <calvinwan@google.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org
Message-ID: <64513039b4f8b_1ba2d2948c@chronos.notmuch>
In-Reply-To: <CAFySSZCQfeGnrMPKHwsrT+UvaH_+t=nGhUPUtdVuijOmrrWejA@mail.gmail.com>
References: <20230427175007.902278-1-calvinwan@google.com>
 <20230427175007.902278-2-calvinwan@google.com>
 <afd3e80f-99d9-7472-36e7-335f86263d09@gmail.com>
 <CAFySSZCQfeGnrMPKHwsrT+UvaH_+t=nGhUPUtdVuijOmrrWejA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] Add C TAP harness
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan wrote:
> On Thu, Apr 27, 2023 at 1:15=E2=80=AFPM Phillip Wood <phillip.wood123@g=
mail.com> wrote:
> >
> > Hi Calvin
> >
> > On 27/04/2023 18:50, Calvin Wan wrote:
> > > Introduces the C TAP harness from https://github.com/rra/c-tap-harn=
ess/
> > >
> > > There is also more complete documentation at
> > > https://www.eyrie.org/~eagle/software/c-tap-harness/
> >
> > I'm afraid this reply is rather briefer than I'd like but I'm short o=
f
> > time and about to go off-list for a couple of weeks. My ideal unit te=
st
> > library would

> >   - allow named tests (this maybe more trouble that it is worth as I
> >     think it inevitably leads to more boilerplate code calling the na=
med
> >     tests)
> =

> I'm not quite sure what you're referring to with "named tests". Could
> you clarify (possibly with an example)?

Many test frameworks have a way of specifying a name for a test case, for=

example in JavaScript's QUnit:

  test('basic test case', t =3D> {
    t.is('actual', 'expected');
  });

In this case "basic test case" is the name of the test case.

In git's testing framework:

  test_expect_success 'basic test case' '
    echo actual > actual &&
    echo expected > expected &&
    test_cmp actual expected
  '

When running this test case the TAP output would be:

  ok 1 - basic test case

Other testing frameworks report on a per-assertion basis, for example Per=
l's
Test::More:

  is('actual', 'expected', 'assertion check');

These are more like named assertions rather than named test cases.

The example of what you proposed shows:

  ok(unit_test(), "unit test runs successfully");

Which is similar to Test::More, so it seems it runs on a concept of asser=
tions
rather than test cases.

That's what I presume Phillip meant.

Cheers.

-- =

Felipe Contreras=
