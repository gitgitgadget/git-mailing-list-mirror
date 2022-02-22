Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38784C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 16:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbiBVQyz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbiBVQyx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 11:54:53 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BFF11942A
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645548859;
        bh=YPJvpNkAAX3YMO+A9pecIoAna+VC+7kz4VzA6EhysMw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RCY4ohm35FlH1wSP9+7tdUeDBzJQXPVaKb7TK2B+D4QGN0+3nvMbS4cFnlm014/5X
         ewrmQoQjS0exGLKBnMxUOPYq9DpJvTVQKT5XUOTBmcr/EnXc1IvoFkuRf/JttVNNl1
         OvWiYTs1UdM/DniOYxVlzi7egUQ0zeEsiZir5AWY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1OXZ-1oOsNc2Qpv-012syS; Tue, 22
 Feb 2022 17:54:19 +0100
Date:   Tue, 22 Feb 2022 17:54:18 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Sixt <j6t@kdbg.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 08/12] merge-ort: provide a merge_get_conflicted_files()
 helper function
In-Reply-To: <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2202221751550.11118@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet> <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com>
 <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org> <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com> <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet> <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RLugEiViD9C9aXIVLEFOsiprRH/ZKZZiu1rJk7VJTAHOtqsD2dS
 1mYKpq0WDDXSC9L3/fH2COWMhhES9+WVN+68a39ezuw+bkfCexJc5j9m6lN/ZO3a2clkFnF
 roF/zZXv+8c5lftRw76g5kDu7noJy2rWE3gfrfVTFlCM9bxBwxPG4as0ZgQr5Kf+8xb4qj2
 ziiXTtm7RWIkhf7MM6u8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RCobeN/qCJs=:LarF9d9UvpVPi3ZPDaTzZT
 FCTp7eTFSgYBHDXT1kBRsEgoNVKKKOdLomkdl6RoczDc45YYEosVuTESptH3HmbHbyn9pKTGO
 QyEfIvtR9b7aOpi5D5KgPBGXT5vNmDexdmKjPp89oeX0NuBEgcP8B/ubGw/NQowY6BT1OfpHF
 l9enAhakJB2zfcUlKr5VCfMJghiC8WX7FLl65Zi+5ShC3eRJfpJKWZ1xxlERlmTqt86KMcqNt
 9BG1vYUVzLrJ/m03eRdhPBEKqWITLB70CndNGCOzGXuarCczXBA7MHv5tjdO7saAwPJCaurP8
 WYHTSykmOsfQ95gkg47ifnDNmlkoudN+G68l4Xte5//TfMcERAzbLojs/aYepajQzHn/nLcmd
 V/++9ECZzdjDaYh4M4MvQfJqdmI0kF33CSrsP8zNu77RoXxRIeuRjqxDqwHrjCo/4hnkzTagH
 eHJZdfggOtcuZZcRsvFY0hTA1GxZLdF2TRH2BUMiHdSN3FCJpXqM84llx7pXrlWRnkss5me1w
 bVClqKxt3cKQKmgjGDuAI3jMtK5io9CghKZSqwrGD2Hk4zgiwbltDYYERF3GgSo4ZpSFYg7Jc
 u1urUeWiulFIMrNTBfEgPl8v7f5T6hba6ScHeDMz9EHNkFvWPb2QdC7zGmU14akT4pEuzmPA3
 ZBiNQqoRHmOsY/25uWrh5CkxqgQ89FHIaGENqMaPzu66YTbgMG2RYoV7qmUGKFpXN+xM47pD5
 tKvGzqzTXrvzJe8P06Kt+Mif9OP92Bg9EHgLYNHyvVvH9JZYt0KJjtEDHIeDNvuN2btayh/6F
 RkAFU25dFFxFyWZ+Io556zOJiEN9j/EeFH5CjXoTW3hgRgJvQ8UKF9lRSodEH6DrweD+OXmel
 sxRZVXoTNKl8St7NkUfXjNXt90eV4Lcv+dxDCZQrDUBZjcAgeoFh5WU+ENwVGJdbRgKReWQyM
 I/bAyiFE38M+UD/PTB3dsD3onCHnCvdCd/T1FOf7QPvQxUHMZNaXoSCRWZvIMQjBJtGfhdBsv
 pilxQym+cSx+6YRdUnXpWNbv8iyFZAFh2bdBidZItwODMypvh20I/WLxIcc7pfRmKML3N3zaS
 Mvg2a607s89VKQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 21 Feb 2022, Johannes Schindelin wrote:

> [...] since `merge-tree` is a low-level tool meant to be called by
> programs rather than humans, we need to make sure that those messages
> remain machine-parseable, even if they contain file names.
>
> [...]
>
> Do you think we can switch to `sq_quote_buf_pretty()` for these messages=
?

Or maybe much better: use NUL to separate those messages if `-z` is passed
to `merge-tree`? That would address the issue in one elegant diff.

What do you think?

Ciao,
Dscho
