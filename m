Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFBDC433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 13:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EECE22202
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 13:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsM2LyCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgJNNWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 09:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgJNNWp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 09:22:45 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C156C061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 06:22:44 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id 67so4940367iob.8
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 06:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vOgHwMTrWcTh91bux8hGuExnH/vuQK2KWiWFuQO0EnQ=;
        b=SsM2LyCs/4NrNN0PHCcaI49ISEmg+Pi1BCmusbUh1S4TxJlDb2DZUR8M1mY0yylL2B
         p+XzTMOCAaBSLXLrIuyDlD2rFh61vGoj5dMiVZB5RkUTpegtIM2kUjBwJNGkyveJOGoX
         A3zTJ1eazlk/7rV97U8lBU1Lvg19njVMep1EX0K3vZn4RwNMmb69rbF6r4zVsfJdzwoO
         K+2bzBskvEQVudnRpm6koE/ksQRT+GAOzw7+8dFc3m2lwK12FKIXzNYtkHFeEg2g9WMr
         JNUeo6FVwMQBq+iy5eJP1twk6Vfjvnlm12nGJDWYqMiFPJm60rz9XgQv9uuIpIDUqPT6
         svEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vOgHwMTrWcTh91bux8hGuExnH/vuQK2KWiWFuQO0EnQ=;
        b=rcldzxSMcvADyVGaHuTd7ADDnON5+/LByiQJYAO3pFinUs8SgDkHiQfLrtZEmkSdjj
         MAaQQoWVJ8Kw7R3Myo2MsS9LdxninOzsz4ris+lpgWH+seEOuxBizDnueDqncPa9IS0R
         FY0lPzxXMAChYsp4fsvYL3iUSmvMiVo5pnHnQWLtOefGMyiUXhdlXjgsbaMZRsGJ2P6Y
         Y5VXqfW5qdL0qhKE0EKrbMS3hKgbpR25Em3yWDaQIIiKvDwCJu0xR3TQloACRAZuq/cR
         t6JNOvOFmOZF9iVZGI4DOa5zZq7E9GtPReBSVYEBSin/fqdRxSFzWzDtihYgRhbOzuwh
         3afg==
X-Gm-Message-State: AOAM533iL3PW10gXLEr8L+s6ci/FOuGWF1HTTFZbUtPLhsECtiWazW9c
        cmwCXOIJCfzPTZMoEyQ4fFk=
X-Google-Smtp-Source: ABdhPJwBMl2aQjxvaz457ZmrqD0I/h4eyQ1syRU1tduicZ9zH3tjceIRXAPy4RZbz4nbPccLYBT4bQ==
X-Received: by 2002:a5d:8886:: with SMTP id d6mr2862394ioo.125.1602681763429;
        Wed, 14 Oct 2020 06:22:43 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id y75sm3062195iof.36.2020.10.14.06.22.41
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 14 Oct 2020 06:22:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 1/3] t: add lib-crlf-messages.sh for messages containing CRLF
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqqlfgbm6el.fsf@gitster.c.googlers.com>
Date:   Wed, 14 Oct 2020 09:22:40 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>, Alex Henrie <alexhenrie24@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ACDD60BE-34B2-4E3A-881A-E82F2BA39BF9@gmail.com>
References: <pull.576.v2.git.1583807093.gitgitgadget@gmail.com> <pull.576.v3.git.1602526169.gitgitgadget@gmail.com> <f17d182c3bf5e758490441801423cdb0da17060d.1602526169.git.gitgitgadget@gmail.com> <xmqqlfgbm6el.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> Le 12 oct. 2020 =C3=A0 18:22, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>=20
>> A following commit will fix a bug in the ref-filter API that causes
>> commit and tag messages containing CRLF to be incorrectly parsed and
>> displayed.
>>=20
>> Add a test library (t/lib-crlf-messages.sh) that creates refs with =
such
>> commit messages, so that we can easily test that this bug does not
>> appear in other commands in the future.
>> ...
>> The function `test_crlf_subject_body_and_contents` can be used to =
test
>> that the `--format` option of `branch`, `tag`, `for-each-ref` and
>> `log` correctly displays the subject, body and raw content of commits =
and
>> tag messages.
>=20
> I am not sure about the wisdom of this arrangement.  Surely you do
> not want to write duplicated set-up for (existing) test scripts for
> for-each-ref, branch and tag subcommands, assuming that these test
> scripts are separated for subcommands they test.
>=20
> But you can have a single test script, that is differentiated from
> all other test scripts by what it tests: having to deal with commits
> that use CRLF.  Then we do not have to add dot-includable test
> library that lets various tests to create these same funny commits.
> Instead, we can just do these as normal set-up step(s) for that
> single test scripts, and then in that test scripts, verify what is
> shown by various commands that share the underlying ref-filter
> machinery.  No?

Yes. I was thinking that it made more sense for the tests
to be in existing test scripts, but if you feel a separate test
script is warranted for these tests, I'll do that instead.

Thanks,

Philippe.=
