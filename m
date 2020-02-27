Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1386FC3F2C1
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 21:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84CD246A3
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 21:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="aQWSqLbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgB0VPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:15:47 -0500
Received: from mout.gmx.net ([212.227.15.19]:49081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgB0VPr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 16:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582838137;
        bh=yOBe2ZuS8ASyUUApDH4cM309s8Yhfp40V57krxXmNZg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aQWSqLbfS5ecfxk5hLZ9n7SR+5RG34E5KoixiPqYplucO5dxlgAas7HJ/y4iwey/w
         Mjorbav/UBaxC+CorPltt8kgKCIi5Sw56LYJoWTpp4MBAusPG5zTplfDkUzHfQ5rj2
         2XlwvGWowtEro8Z0qmHOqlKCbQNFI/8xFnSxo8qM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mdeb5-1jh2Iz3zqD-00Zfs2; Thu, 27
 Feb 2020 22:15:37 +0100
Date:   Thu, 27 Feb 2020 22:15:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3] mingw: workaround for hangs when sending STDIN
In-Reply-To: <xmqqy2szkfxr.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2002272215210.46@tvgsbejvaqbjf.bet>
References: <pull.553.v2.git.1581956750001.gitgitgadget@gmail.com> <pull.553.v3.git.1581962486972.gitgitgadget@gmail.com> <xmqqy2szkfxr.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rAd/zDvYUJ04JLbmBCY5O5ERGhcbWDwfhg5bPHeoV+zlm40Bhrn
 L7wBiVq4iDG6pe9xInux1MFmpDoK0avVFbK7c78oEbSk7ztVCtaOD/7uQRtaT/aiueGiKZE
 sMXwTlW4J2wOOkuGY5w1GemWoPcp9c7AlnIRW8ws9gtoCiD3NW0KjluOH5B9R+b/da622Uq
 Qtu75pwGuNNONwxyknNMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gUNvGgy1+VI=:g6Ac5jeWXHdOkCx0A/Q5gn
 NauP8Ln1gRkx5lbUJFk1o2qyKFjkyg+0UXMH5A8Yf21FtHQNwLn7hUqegv+3MHe7D6kshFV9p
 PTBvzS53Ms1rOZmZKxjerzVH9mWQMqt8rnWOdbVo/O5zgWNdtcmZ6bf1N7/ZR9O23icMLq5In
 jSfsdaj/ZkzElVrZe7z9n6Xx97En7+lqq5ArYDbbLxWqMPu/UCz5ce1E7RY3q0sTGQ3nrF5RL
 2YOI1dlqcvW+SMPH03fH2MeFhCfoCLEyvKx9OzDSP9yBwITSrUj0ve+MAgxMQOpab2c2cghne
 tS8g0HggLD7ld6q05CIZ3ylzBrafEQtxlqA5/zXT/8UPr19/Kv/HS/G2Ea78gOGk+o1I1cKKg
 KNr8EM1fI1boXht+Vux+h85GCgBbItNm3Be8D20UHqUw1Ym6cG7RmMlJ8EV0RFE1A6lE3+pXQ
 EiRIMEEV1ngrMoDoBDvTyoauYMV539RbcPrMMwoMm12+tVm8HdlM95uAi7kqBULiVpDf/MXUh
 Osyhb/zPTC+axCeBEYhIHMH/ir+5QxmfM8S5pSidxHRy2UV4g7pl+LjjjcS1d5NSlMaSinxVU
 YFD9EOpyieyt7Q/Iddk9Z8aPAscoS1TRl+Yxy//faoA3O+rjseBDPXaGsJDEpLsRQ5xT54/EB
 rBvHiNInELrvCCJX04x2oRMaXxp9dplJE2Z+COf+3ymplb6HRm2FBmzeu9rgFewh+iI6c2R4o
 TAXDGr+ZdkF7Q0T2TmVWAVwm/TIpcE40IJdSlb7IY+/givjcibsqUNDDk8ScxZr62RudZ24m1
 fjqQODO8aSrFmyXc7P0+do0oTcAhkowZghfLfvd43kj/hoMNdLk7eaZOoA44avdtrxg5Sn3Ti
 OoM3CjI91iuxgYp0lIBPqdYSsg/vlkILVLcR2+Ui7hsnOnhlEDTgXTUWRiUkF0zTl9BMrg3Nl
 yT3kPAlNcOQMqBjOdPLrYZJA3Bh5pQXkVOUZ1Zd0VHcRMMJ//5UsNgDtkAp3U4qCuZku11oCk
 sHasWUwAXUOvya8DAuX4zDdjuPfyGqrJflBJkTgdS0se3Mb9Bggour1y/wPoJAu5UcnqOEX8N
 gK55B48LWdp4JxPw0MWH5EagRpwdnFqjXLG3QvFzi/4lgUENkZbzqtCRuAyPy/SPsquh+BRLK
 Mgs19tyIptOAXx3MYXvQfPmgDpsNeVvbNYAAkS7ACB8iEtKpY5jd/sVnk7Rk/+hGvkH9utewm
 yFzks2wmwQGdTBTAw
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Alex,

On Tue, 18 Feb 2020, Junio C Hamano wrote:

> "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
> >
> > Explanation
> > -----------
> > The problem here is flawed `poll()` implementation. When it tries to
> > see if pipe can be written without blocking, it eventually calls
> > `NtQueryInformationFile()` and tests `WriteQuotaAvailable`. However,
> > the meaning of quota was misunderstood. The value of quota is reduced
> > when either some data was written to a pipe, *or* there is a pending
> > read on the pipe. Therefore, if there is a pending read of size >=3D t=
hen

I usually try to refrain from grammar policing, but in this case, the typo
"then" (instead of "than") threw me.

Other than that, I think the patch is fine. At least it works as
advertised in my hands.

Thanks,
Dscho

> > the pipe's buffer size, poll() will think that pipe is not writable an=
d
> > will hang forever, usually that means deadlocking both pipe users.
> > ...
> > Chosen solution
> > ---------------
> > Make `poll()` always reply "writable" for write end of the pipe.
> > Hopefully one day someone will find a way to implement it properly.
> >
> > Reproduction
> > ------------
> > printf "%8388608s" X >large_file.txt
> > git stash push --include-untracked -- large_file.txt
> >
> > I have decided not to include this as test to avoid slowing down the
> > test suite. I don't expect the specific problem to come back, and
> > chances are that `git stash push` will be reworked to avoid sending th=
e
> > entire patch via STDIN.
> >
> > Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.co=
m>
> > ---
>
> Thanks for a detailed description.
>
> I notice that we saw no comments from Windows experts for these
> three rounds.  Can somebody give an Ack (or nack) on it at least?
>
> I picked obvious "experts" in the output from
>
>     $ git shortlog --since=3D1.year --no-merges master compat/ming\* com=
pat/win\*
>
> Thanks.
>
