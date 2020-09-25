Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C99AC4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 11:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1270920936
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 11:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BKV1MCi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgIYLVT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 07:21:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:37255 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgIYLVS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 07:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601032871;
        bh=QTzpDZKLbpxmkGpGaDq6VeGQiMi6SXL0F5byzYe3sGM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BKV1MCi75IZR1DH6+edo4rNRREzkENkEr/TfIK7bL++7i9ApFev2uJfqarSIJT5AN
         ZUki4Inikkkr1hY6sWXxGwsmcBp0msyeVI1euAAiSvQO57txv/lt0F7GI+hkKkGwHu
         TPC15yAzu8zbTmT7c03W9Iqhyn9dRBBNQ03fw3F0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.212.158]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhD6g-1kzlAr2THG-00eIx1; Fri, 25
 Sep 2020 13:21:11 +0200
Date:   Fri, 25 Sep 2020 09:13:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: Re: [PATCH] bisect: don't use invalid oid as rev when starting
In-Reply-To: <xmqqwo0jm356.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009250910200.5061@tvgsbejvaqbjf.bet>
References: <20200923170915.21748-1-chriscool@tuxfamily.org> <nycvar.QRO.7.76.6.2009232229000.5061@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2009232302050.5061@tvgsbejvaqbjf.bet> <xmqqa6xgi363.fsf@gitster.c.googlers.com> <CAP8UFD3mfPgedqGk0ZFp3K3r1gDA3-stbSxoEomRh4T0_qH+tg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2009240950010.5061@tvgsbejvaqbjf.bet> <xmqqo8lvgmdw.fsf@gitster.c.googlers.com> <xmqqwo0jm356.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:sAMAaRc9FmvgiLVjl/nS6ci66Nm27Yck5M5hTUnd8mlmAFGCuzD
 qv+VGzntxWTla/YBUlLHhAxA2/E/eeOQaY8t3h85DptOY3x+XFnA7DwuRitDLHtn/7dFUDa
 e8BQJ55QlsxXNff85buD1M61USk+klPP9HnMxJQfG/zerDVdf90ZdZr+2uJ+gi1+jVoUFhi
 kjjHiWH/mbzZxE75T/Eng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2EZS/J8t3vE=:iG4XeWkaOLoxPjpz1qQGtv
 2qiDh8QeDqA4A6RDe5DTpoquVZ9hVtSECa2zzr7BZNyn468bkuYZRPaszs7aBqWpv6kccHnYk
 zss11uHKDPHQpmPCqUs426w2LRoamhqtgdo0KzsIaA7KwvlsjiG5muWIyVFNN1ZDMoiBq1Uk3
 T9IDoEiqhRHKuiGn3NHKtE+D3DkLw1a0+9D9EzZEuRa3gBFRflYibCju1DR3uBSF/DEdkWcga
 bDqr/XeddwGNeI3j3JPayrrV1LzoiVCb1C5uW3upbran8oyM0XqnHQksWSgIZZWwkkVZmObZ5
 z6jSygOKDUY7M8xKK4LQA3fmYU7rUNXCk4C8Xyh/l4dH4aC4Efowg1YksFoSrbrUz4IgnO4ga
 ME9SkkTowh4upYeyZf1v5boNRF5Fy6+RPAgN+XPCSmyC6C2mBSlpXSOMFnbI9blDvjWQRbVya
 xzNYy+YSowfkg+VU6TxkVCR0na0DbALbysIcs5gsqe2WAZJI5wS4+UPY9QaD+fpoplHiD8WQQ
 l/iGSav5gPp+A/B62RpGAmQcwX9FkWEXvv4sFpIKwZhK5bjkoV6VfXLxjVqZB1+tUglqIOewQ
 hd7km+R2WLsYk8XqBahqt9qP7T8Rsh+p4e6jaUrWSIPa7mVGjSwC+3HKEjQg66XaEgQV85G90
 PuTnwrqJEOQd1wKG3wA5fhHTiHAW7+/EETLmpGFRga2YN9CpCUYeXxTPIKdxXeTefBFPaBhJZ
 gtNvjJpSZqVm9VRBXrc+guLeju/xiekexnZTl3TN9l5xFn1JdU0zJAUNTOQgnpBYcfM0noJbS
 myGl6GIzLbD0a9GDtPFFeaO3kHQnbfEHGMAngbghiN+hGhu40jzH87Eq+owtmshF1dZGSPcGa
 t+EHgJUovHdylut/faEgLYVlYddYOFWuTylDD4AQ3u5Hj3NDUdeFATSEphBSca4ifStBpxBgO
 j8FSPULCc3ZSU49g2J2IkwvTjeqkM2/f0xWeLiaI6fo/DGo4bSVjrrQ9QFgT0SV7iIaJdkCF3
 gyhmFclo/YUG6kgtq7PVTxNvdWwoSb3wcCZaGUJEoH4fzKZmPBTfBDZ5MGOZUsT0IUpPZMi14
 YqfT+BNlIGKM86O8ClCxY8VDvfwbfXiPvqpWlOdcnEfoe82kauZ9LM25MVtpTaM7PuJwpWiuN
 7U5JjYPxl08YRFCrOHKSTWINAkeCvWOGiQEsptqCnJj0UD9tSkKMnszclrNylsAVjEbatsgzd
 bOoCrmpSTChkz4PMU7QsvoXV+wp/mQBTB4FF91A==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 24 Sep 2020, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >>> Hopefully the V2 I just sent will be better anyway.
> >>
> >> FWIW I was working off of Miriam's `git-bisect-work-part2-v8` branch =
at
> >> https://gitlab.com/mirucam/git.git.
> >>
> >> I'm happy with Christian's v2 (with or without the indentation fixes =
I
> >> suggested).
> >
> > Thanks, both of you.  The updated one does look good.
>
> Oops, do you mean s/path restriction/pathspec/ fix?  v2 looks OK nesting=
-wise
> and I think your indentex-fix suggestion was for the previous one.

I was referring to the indentation of the -/+ lines in the commit message.
Your current `SQUASH???` does not include the line-shortening, but that's
okay. I slightly prefer the version where single conditional statements
lose the curly brackets, but that's just nit-picking.

A slightly bigger question is whether `git_oid_committish()` would be okay
enough, or whether we do need `get_oidf(&oid, "%s^{commit}", arg)` (as
your `SQUASH???` does).

I'm not quite sure: aren't those two calls idempotent, with the latter
going through some unnecessary string processing dances?

Ciao,
Dscho
