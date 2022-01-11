Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990E9C433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 13:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240616AbiAKNjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 08:39:14 -0500
Received: from mout.gmx.net ([212.227.15.19]:45183 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240546AbiAKNjN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 08:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641908346;
        bh=kJx9zIfhCLp3ZmNn95l9oYLtPw5NCXohGgFZD0T4gH4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VJawBVW3m4thkhqnceEEOQff0Pom2KowmRFDJn9+Zt322yn2kOg3yxo2vrKmNnuBX
         alz+zzh8jqzWxxG1cOV+8FUAfQZl0+fdfLTwPtjFu2KFdgATv0RjmZo3PusRS5uGyH
         9Vw1hTGsB+w4lHJ8HeOD6F/TIiojjY4b9mVrZ7HE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.82.111] ([89.1.215.56]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2E1M-1mMUnH3pDK-013erJ; Tue, 11
 Jan 2022 14:39:06 +0100
Date:   Tue, 11 Jan 2022 14:39:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Subject: Re: [PATCH v2 4/8] merge-tree: implement real merges
In-Reply-To: <xmqqmtk78dty.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2201111435430.1081@tvgsbejvaqbjf.bet>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com> <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com> <1710ba4a9e432e2a854579c4c929e7f2cfc92211.1641403655.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2201071602110.339@tvgsbejvaqbjf.bet>
 <CABPp-BFUJ6pU_CKM7ccnFvi0nkeeGfd2GETdksKLaz=B_=BZAQ@mail.gmail.com> <xmqqmtk78dty.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:koglKKOdZ3ueT8X4lVOAd/nRn/qv00V1yL6RZnIzSJXOmj2BJGC
 1S30JcqnRq5q4DNsoLreYc2SW/ucNm6JxHGWMiL1HOOQg2emSdWPZHzhgXfwqfn5q/6vfEG
 Bw+MKTgNHwtlAGDx+ML/fF1e48D2Tw2S9GORrpMswWBE+o9M1icrrNCGjXDTNF3p3KvnD9f
 iPGtgxlLA8/0dg9+IjrTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vJHV2O41fm8=:VNtD7YOjGTHLrCiO6EuxOB
 /IayKxGdsr3qmqIaQzH1UTyQF62xbrqln+Oi1sMhI9TUCB+YZbxix3lojIIKvNjSpM74ooXkl
 Yal53mfJ5phTmfP+/a9fJVoNJBEil1vpCgyfQEpCt/MmZ2tKZIbpsGIpoFp8Wt/+yjtLFbIu1
 yeezXI/g2pTX4ayv0IBja/q7hcR3LDsxs5d+rH4skzIKiWDtR/ccKQX7/3bHdsnlNRymjhEBH
 LMuk0O4ezq4j/r3LyVK5a2j1MXzQeiQQAxIUPBJUNzzoR7LgFX4cDc3kr04cPjze3JDEZ8SqY
 +4ds6wn+1er/KintGY0y0W0aPFCEsWNGRI0FDopJRCEJgBhqJb32xBKyebkuSOtUXwFw3Sf5V
 wcwzAVubS6CUo2x3MDynAccFUt++JF5djyCnChXyDH+A6wKQCI3sXmsS6B5My6BNGfEgrvrhD
 Tep6rGSuJhwDZGS9bK7OXNi6Nc/H9lM/G64E2ZGG5K/HjX8gqOnmyTNHX0Bj32yE6mx/wPcpo
 i78+9gtMs0RQOL/O08PwdCLlU8bIHkoCM8LICNO+AXdyguO+6/cWTWWvGa0EHvCupB0O2cvtn
 VvLraEd7/NjEtdipnMcJ9mtC7GldaoRsB970Iyxls6ly16kVrHAZPFiW2iyX9V1Q5+gOibke8
 b8CdQa/SViNiQUONgILUm4cqzNIpYFLsgax7g3HR2nBRd+E8vQ6tV2MNbh0+B10qX1Nh6Z6Mz
 wq5cGBAIdV+2MXVVShpJTwuv+TwceWBEPm1UTG6PqzPOtEHI1LEJfpypGaq4W2u3JhR0mnLba
 7kDOcwtY5RBzgwkfesZs6Xobwlne11Zxr+rcy8lHJwlGCVxAsku5EnqGIlKU3PCxlrQxtUFJV
 KKexY0ksksoeYgHxDjGytcrNCeP8J31G2GzcrNX92Q7QosbKfSlCI6eNnsLffgCG/tP4lrA8O
 ZzDhslB3dF89cf65tglt+hhW2B+77fkVxF7Q3gEVZAMPz6UHQPEodBbuGLEXdvR3jZUTxtPbu
 +OIGRC9e60DdWPF0hl8EQnk77SRftzJKKw8qkHCbFiqbGx4rsrlMm+k5PzRjyV7dY2mHJii8e
 gPKUFwvemVPNg4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 7 Jan 2022, Junio C Hamano wrote:

> Elijah Newren <newren@gmail.com> writes:
>
> >>    'git merge-tree' [--write-tree] <branch1> <branch2>
> >>    'git merge-tree' [--demo-trivial-merge] <base-tree> <branch1> <bra=
nch2>
> >>
> >> That way, the old mode can still function, and can even at some stage=
 be
> >> deprecated and eventually removed.
> >
> > Ooh, interesting.
>
> I wondered if we can _also_ extend the trivial-merge mode so that we
> do not have to call it "demo".
>
> The internal result is expressed in this way:
>
>     struct merge_list {
>             struct merge_list *next;
>             struct merge_list *link;	/* other stages for this object */
>
>             unsigned int stage : 2;
>             unsigned int mode;
>             const char *path;
>             struct blob *blob;
>     };
>
> because the command was not designed to resolve content level
> merges, but show the half-resolved state with the "stage" number.
> The "explanation" the command gives on the result is truly trivial,
> but there is no reason for it to stay that way.

The original `merge-tree` code outputs a diff, which I think has now been
firmly established as something a low-level merge tool should not do at
all.

So I am not sure how necessary it is to maintain the original UI. I don't
think it is a good UI. In fact, I am rather certain that we will want to
get rid of it.

We can keep it for backwards-compatibility for now, keeping it working for
existing users (if any!) by that 3-arg vs 2-arg trick, eventually
deprecate and then remove it.

Ciao,
Dscho
