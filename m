Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F022C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 13:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0431207BC
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 13:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SgKylAj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgJENSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 09:18:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:36021 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgJENST (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 09:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601903894;
        bh=2TVeiosEYUy24FzlGFphYYl/Kt8K8kgI5/1Xi0rOHxc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SgKylAj/JxQe+L/DwaGdiUtj9LvlaYEeSSmdAySPad2O35BAShE3sLPRZJ5nz0aee
         Me8puYKmqhGgT6dLKLoo6ld2gLP7yxcpBdNF1tDd453ave10q0DnDfg3uf0pQLidk0
         5E7BuxQMA6ZSaT3qr/sOOG1k5mUpICM+Oh6GV8mc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.214.27]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3se8-1kYSv81rfc-00zq9A; Mon, 05
 Oct 2020 15:18:14 +0200
Date:   Sun, 4 Oct 2020 21:27:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ed Maste <emaste@freebsd.org>
cc:     Tom Clarkson via GitGitGadget <gitgitgadget@gmail.com>,
        git mailing list <git@vger.kernel.org>,
        Avery Pennarun <apenwarr@gmail.com>,
        Tom Clarkson <tom@tqclarkson.com>
Subject: Re: [PATCH 0/7] subtree: Fix handling of complex history
In-Reply-To: <CAPyFy2BsFLZZeEY=54evEJwed9q+Dc3TX3s1O+cr-nqwjCRHvg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010042124320.50@tvgsbejvaqbjf.bet>
References: <pull.493.git.1589176201.gitgitgadget@gmail.com> <CAPyFy2BsFLZZeEY=54evEJwed9q+Dc3TX3s1O+cr-nqwjCRHvg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SOLUNoQBc73z5VV7av55EsAZrBE8KXm26DLF2EMqf1/zqqFRYEe
 gz+xx2s991Fe/ZZYPt5GNkQKViXkkeNU5GTNYiyQOTWr7vfVCJhgocQmM4oFMe6Wr0TwcSb
 QhQv3B8s6JPPLspct03eRa7h36J4QdeVdZgx9kH+v4DuTyHuhICSHEnAI44uu9lXo/2rS0X
 DXdtS2dVPx3XpKP4Sv6Rg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LO+iKfo3BJg=:/TIf4LxMmxlsbjRUtkiKBX
 vkNKuzzhRTVU8TMUStwsWB951aUt+DhpwNwUWBkyPTzFN8fv5ANXlqGUhwNSBSvYNjuu2XOll
 B4mWl1BLxoCfWpAdWQOHi1gRddIVq2f3/VT4mFj8p6/aTr9sJpd/0N62NtSjAzr9ZhhGb72ui
 yj6KDYGFP+9tokzB4k4p1LhHMvHMKL7LVF4KXL82JYfS+VfRjBzx5RZSegNqRUwl0urlq0WkQ
 kF30Ygcy9w+MIN/AozEgwFjzzPse4E+o47DAoK6WbTyn3+IKQBpPkGLayWCb9cKZGDpGr6qB6
 6Pi3hCfTCj+cAxvkmrU7uII6rCh9Y5PSstOPGMRVOQRzBST9Kt/LGNT2a8W/W0WiEwT8wwtS7
 UdwgLQOqsMczKIplbb2l/ywaqzZ44KdluGyfXMndUVlcVzLfjEP0fDRZn4OnjDaRaVlHKeonZ
 JEi1BOJF+BnH1KDETRS6+sOTgRk6YWJe9MqWr060SLawscVP2spQ0JdM8Kb5bvqwSyNCXZ+aK
 2+g5j2bsMCR8ysviIk88HAdxsdADojhHQXKPYWAOO5IM6+bMSeyJfrL/s62O6AdXo7Jv6hRL1
 QD/y+UDtofjMuDbGSzTwH7Ex1tq4/YrrTe0vsW0CzBhivK68cy0Ji+7+PwBoWuPUfCmwYm8qK
 LyYhvdPsgjCDPYAbYO+Pc9oQ1UHBA6Zru7Q6TRTQJvlQpdj+gszMSoMcQWigDvzQGnF9rfGE0
 zSYTbCXMI938JG4lOpx+s2He0EkL3Ipa+Rhj1EvWGuyxK0TQbiWcHHy8CSiNMkL35pDjO1lW5
 s9FdWxP263q/avRnf3hKoEcMrReE7EdQe/MuvQu7dnzqOPF5mXOABNxsaksJG90+XRAhDbhZs
 qZTp9hXLdF27myppmLhlrBuwGv5PHMC+6GTGpHNWsDIFzlwT0v6kcWUwL+oRFcW/MDapHshXN
 dWD83EqDf6Sc7eChHSvZZ0keZ2DEpNYyUxLRxlBjN4MkDRfGy0wRS8OCsV2pHm1IjMCXZVbPm
 o5K6L0s7XijXs6hP1n9j6jpoOSIQDLTqXml3RgBGEJ9FgfAIqcVL90+ATCgD5vbccsUdVt8jU
 NZEWj2bf6lS4mOeOeRVQup8YO8dfeuHuDanfaPV1VRC3SgzQ33D3R6PejhQtA/QBu1TM8VUER
 jDfGyd4pZCB1STXTw02wJC4hIva3eGI/S5qfOhDVAcoS+GuRkY9VDUk05ktrgnIwYHmO3dxI1
 WRrmyI0CsOWIWRcb8Zno85CmiHLq1wHkDXFBQ4w==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, 4 Oct 2020, Ed Maste wrote:

> On Mon, 11 May 2020 at 01:50, Tom Clarkson via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > Fixes several issues that could occur when running subtree split on la=
rge
> > repos with more complex history.
>
> I've been using this patch set locally and would very much like to see i=
t land.

FWIW there have been more comments in favor of this patch in
https://github.com/gitgitgadget/git/pull/493.

I guess what this patch series needs to proceed further is an ACK by
Avery?

Ciao,
Dscho
