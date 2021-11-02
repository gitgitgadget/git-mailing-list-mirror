Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813E0C433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 14:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C0A960F02
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 14:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhKBPCI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:02:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:32821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233604AbhKBPCH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 11:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635865163;
        bh=OZml3RZ7whKI85iM4xKX8yVsP1muE1A+mivcnevNnzY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=e6wAct9uMC8idOo7B6BXHkE5eyS+KYTfFFAOLi5ISW6LJHr1QqTPwZO42Y8bIuSsH
         dSQybGPr0eSMVabM9YRBI7Ul0rCKdgcxYYVctfFlu8WET9LHGjXuC1X7rELAUktdIK
         QgsJCkr4Fdai/cE8qwaZwAX/bq7YDA9uWxMKw0tE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([213.196.213.29]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV67y-1n9wEv2B9S-00S5Ko; Tue, 02
 Nov 2021 15:59:23 +0100
Date:   Tue, 2 Nov 2021 15:59:21 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Matt Cooper via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matt Cooper <vtbassmatt@gmail.com>
Subject: Re: [PATCH v3 8/8] clean/smudge: allow clean filters to process
 extremely large files
In-Reply-To: <xmqq4k8zh14r.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111021557500.56@tvgsbejvaqbjf.bet>
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com> <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com> <acc5591517fa519fc45c07c27defb309c891dea0.1635515959.git.gitgitgadget@gmail.com> <xmqq4k8zh14r.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:aVEDUlXX+19qwOIxEb4eLzxdh0zhU5soMuU8lqk5I450psb2kor
 r7qUfH+4iGcXZRLBOFr6Pg5q1DpIHoSveZiv7a+3+f5y1VQm6XdkEQnxDS3xp/+Bi1f6Mji
 C4fuXsvihXK3bXppKb3xOyTdbWFcIoOZwL3zdfe1WrSbiqCzyeYIOt295M2KYN2fG5r3xLV
 gxt3WwVhkpMYgBCj6utBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:67XvL9Z0hFc=:ipjl2iiAJ9NaU7f9y4hjEa
 g7YIi611Swt2SLNtcoaF5VlidHjeHoiixjS8lr+aJiJz8VhmeVt6YGyX3QNarqAGqbQAok58l
 lyFW4bX39YUjU5uvsxYDFIQvGSFJsjR8xSYunk1YKT3wadA1XqMhNPSkXlZdjZiFV7JWpP70F
 7/JBt3l0E09B14Zdu1QXfgt0VIyangeAQa695N2zq8+u99+jmS6ADbFv1mwYvb800T6a0tNuX
 aTcaCFOtU4F1a5tlZzCZbim2lovPmX5OvLNoH4ITaXeqIl1zgsMYwLRHEjASrbj5htR4Sl0/F
 RZ83qQUIzkMaKJEwnQ1qkjlGuapbkCeNFCSkIlASHlDjGFnGfb1RmKS4UObZEvCUGotAEilhD
 iT3pK9SJmRy5eiC1F8nil4nsoikYT8KWGZ7cKRKlc7duTzQU9PnE+LuMSsc16LBk+WOqOaJPA
 Mp9rpJINdlzfAFTnZ/sHiIxP0qSLniwHfysNuns0sNru21U/SUh3xl1ahGq8gMdv8J9+oiD8+
 GTHKmosM/qGH3GmIM92wcUOIXluYDzD2hBlUg9tjsB+zApgPBe8jPGR+pHuIuPDCduinC1cBU
 CPZzQ5NDrB0koQEqN/eJ7tZT/ighwCbavfcMJEtUVIICxT2l381pjyIJNDz7Jei7UvQGFwLzK
 Z8ep7RhC0pubBh67ZxxjilqBC3OfjjsnyGIX4iRJRh34bD0d+uJnkrW9TQMSsBVDrDjczBR96
 +04eRX4srXw1FJm522A9XPii0TlZddS3FOIqGHNdQ8RFcvhWUzPPJ4FR0Mq1bgVqznneo2e+L
 5YyQnGKGO8En0rk1M/koNjQ8PrvjbjuD/2VhhEk4Bg7sMW70Q/coJIxbNczy3CQ2pydGLm6rU
 7+C7fYUugKOxdDK0LWgV+nuqdeTavV2NDW/1bzSrZ3QCGOKei9NX2MiEsAg74BNGphYQR+ZBR
 h3JJbBDCz8/6vMkAcq8r29FHG+LU3eBRhQ5dYBZnUkFRL4Y/v/54b4e8ZnzKLsE+drlLdRI2O
 O+W/1cA5nZY6F0n+Ko2KlRbyd4rQVbcVkS5GyA7vQ9awa3E9KCIgwPkR91zoY4kxeKdf2yJPv
 u7ddqpYondevSc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 29 Oct 2021, Junio C Hamano wrote:

> "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +# This clean filter writes down the size of input it receives. By che=
cking against
> > +# the actual size, we ensure that cleaning doesn't mangle large files=
 on 64-bit Windows.
> > +test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
> > +		'files over 4GB convert on input' '
> > +	test-tool genzeros $((5*1024*1024*1024)) >big &&
> > +	test_config filter.checklarge.clean "wc -c >big.size" &&
> > +	echo "big filter=3Dchecklarge" >.gitattributes &&
> > +	git add big &&
> > +	test $(test_file_size big) -eq $(cat big.size)
> > +'
>
> I would have expected that the clean filter to be sending the count
> to its standard output (to be hashed and made into a blob object),
> and the test wuld be doing "git cat-file blob :big" to read the
> contents of the raw blob, bypassing the filter system.

That was exactly what Matt had in his first iteration. But I dislike
unnecessarily spawned processes, they are not "free" on Windows, so I
shortened the design to take this shortcut.

> But we are testing with only a single path anyway, use of this single
> extra file is OK.

Precisely.

Ciao,
Dscho
