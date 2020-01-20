Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A9DC32771
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 20:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABB922525
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 20:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PDm2ToFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgATUEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 15:04:38 -0500
Received: from mout.gmx.net ([212.227.17.22]:46171 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgATUEh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 15:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579550663;
        bh=n6UkDXBLQqnWl9BURskrJhiXsXg405spFeFNCJk8WWs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PDm2ToFsvMBDfsRngITRhtBSImt0L9UZg045GssteMcjXXds8jClOzeuW38GOEaUW
         8atrIcn7eVp3utVSZzLcdfYakH921p1N++ozbJPkpBfXdmxWGgl1+RYivaNOO8SQc9
         9v3zq72BzuxdYaGiu4AA1mF6aZ0EVc6nApib/4XM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXpQ-1j2XEV1ia0-00QS6K; Mon, 20
 Jan 2020 21:04:23 +0100
Date:   Mon, 20 Jan 2020 21:04:21 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] rebase -i: re-fix short SHA-1 collision
In-Reply-To: <CAPig+cT8t39UvnF2i6CDoHW4kfEGr-CRFxZKOCstCTU0YzrCgQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001202103221.46@tvgsbejvaqbjf.bet>
References: <pull.529.git.1579209506.gitgitgadget@gmail.com> <pull.529.v2.git.1579304283.gitgitgadget@gmail.com> <102fa568dc09c1faa2d36903ccb7e1b285dd50b2.1579304283.git.gitgitgadget@gmail.com>
 <CAPig+cT8t39UvnF2i6CDoHW4kfEGr-CRFxZKOCstCTU0YzrCgQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:R4kS5HkKhOeRnQ3GuO7yUhOLgsEpl+5zz68btyUElbTAvewyQj4
 PvS0DRW06QMaoXadaqRQXSuMyYG6l/YbGfguiUP/TBP/MJZ7j4HZvqUQBb+0cQMFbPCxO+7
 rWANvyYcb1vKihX4bgBgrUlOQPPfO0ReCqbLXBDQwuLhPgNm/8y6msmagrX3k47hY3DbeU/
 o51RO1JLLDxMqA06mUZzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fM5Ey1LI5oY=:x1VsloLsP06sXsE7x8ic3T
 kVxtnBtj/+MaaH4GvOyuEKLWGiWSKke74CDAOXHXsnN6q2d7nBqxTWWDBLW0VOXSIq3zJnmQz
 CEdoM3xT3jrDqQSfBQpmu1W53ZP9/WWEDqwKxBon8vmp1ihbtwArkwtADRWKdYo48zLEOq9Os
 kpTUe/GlUhFc6rfpn2dKmcpFLrqRH1tnAkSFYFg59/VZI9pQw8zL9daqTX2XOxkelaZIs01fc
 yC+tMXs+PVdKPthFMFkp0PLBzVbLQbhZpVwpInkThExXS79Fv1ClFwFELC0QlQYafRdKEyg2k
 zNLoIn214+GKo3V3v6GkWE+IoFq/q9bgAAvyZO8tL7H2DiZuGEMy6z8zn3KiwOH4Hw2b8Y6Wi
 hxuPuJpbE9mnaKGXi+ZxD7ZsGWHiJQiGCBW2OUQanVODMakqKRfA8Lr9+bwB0kONKHsAtsEDC
 C5N+gC3LLgDYf8Jp9gcOX4C18yMUfFbXCCnMDGmgGQkih+C6E80i+czwNme+8pnlNssViFIfp
 jVuwk83b6eHlFHYqXuN0EzxpWODv/gsimKqZCGDK9l1GYB+rfH7FXvUf+EMR40zcxQFV56ISk
 AzWAitlWEaREPyhMoTNk82NGHmeT1c/sBsFdBnDbDSYfRDXK72L2V7V5f0iig7L6E0hO2zVoB
 CT7NrDoCxuf+1YxH4PqvSZkpvKbJo6hromRlNwpiKb0ln3OGLUn9X0g6i4x/dssMJQH4iEMwP
 EDlByzCQ+tVsYwk6MPD14ftzUd0cFvuYQLnyFJK7QcwGcr8Ra2YjrS3DcMnoKywhzFXzytiez
 1qUZbVU8LPRX1gN8Iw9ZQMWMkofIi2ms4Efwx97TRz+VqYkf5Lm9uaV4rOUYdKEtzIfxVrvhS
 MrNAffZH+YPEGVB2lw30HAVnbSG+XCH9aKKyXBc6ncl31Y/ZuGUMTzR9FRSBSLDmzIhLFhr2b
 nuBBkXPfO1avFePVmttwccvTUOEyerPB8Vz1Slvt+/zjAT6LEQ0+zS5vriZQrqXtlzqlX6yoV
 vWMjod07u/ofkyClH6ViCa3zh6A/KTL1ef1tnoKLzNLWSCy0x3A4HbLXZ/c/RUrgngOEP5kVH
 3fw5TMUycwRfVZqOPQ+b8YxDcckdMumUAwr0wQxYHwD3W3uifjnxI5FcSwohSBEbpSqrr1JhR
 J9+pOHcvP+65ko0Uw4eI9TWXfblYwJqV5XSz3Dw4CQzfNr5pGkxw2RD+EC6rp2ZBeYuQigguM
 11zmPAbyikggRHjwXXwFtYSM2TARi0nyQlrNzLTscwGStxHU/zJWZ8e0k9+4=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 20 Jan 2020, Eric Sunshine wrote:

> On Fri, Jan 17, 2020 at 6:38 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactiv=
e.sh
> > @@ -1264,13 +1264,24 @@ test_expect_success SHA1 'short SHA-1 setup' '
> >  test_expect_success SHA1 'short SHA-1 collide' '
> >         test_when_finished "reset_rebase && git checkout master" &&
> >         git checkout collide &&
> > +       colliding_sha1=3D6bcda37 &&
> > +       test $colliding_sha1 =3D "$(git rev-parse HEAD | cut -c 1-7)" =
&&
>
> How much do we care that this is introducing new code with git
> upstream of a pipe (considering recent efforts to eradicate such
> usage)? Same question regarding several other new instances introduce
> by this patch.

I would argue that the test case will fail if the `git` call fails. So I
am not overly concerned if that `git` call is upstream of a pipe.

Ciao,
Dscho
