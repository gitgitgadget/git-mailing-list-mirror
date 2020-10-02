Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E5EC4727D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 14:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED6E120719
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 14:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="AJTeqN2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbgJBOuS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 10:50:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:46027 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388232AbgJBOuI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 10:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601650203;
        bh=goN27Ez6hnDBrWNHtJwzRoitusWu6h4El3vBxIN9XWk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AJTeqN2ytN+FZ9LeYLBE0vvCLz8DI895x4lW1fg9vo+Vp1NWFHCWhEBGjwBQt2RTH
         S2t/Z/kzVo58RHdUgCieCd5cT78Phjt4Qa+Y+vS1nWxVB1taN1ADNlDVGYcr+bLNfH
         6YbKA9BnX9oh37TAe3NywxQWpvSOLCZ7XqVhoo+g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([213.196.213.114]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbAci-1kzt3a3Rwe-00bXmd; Fri, 02
 Oct 2020 16:50:02 +0200
Date:   Fri, 2 Oct 2020 16:50:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v9 1/3] push: add reflog check for
 "--force-if-includes"
In-Reply-To: <nycvar.QRO.7.76.6.2010021550170.50@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2010021642210.50@tvgsbejvaqbjf.bet>
References: <20200927141747.78047-1-shrinidhi.kaushik@gmail.com> <20201001082118.19441-1-shrinidhi.kaushik@gmail.com> <20201001082118.19441-2-shrinidhi.kaushik@gmail.com> <nycvar.QRO.7.76.6.2010021550170.50@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eCAZ63eP6PCBgcMtlmH+uh2m6GPtZguKdGsKyFJMHm+obTyIFjt
 CJ4Xi3Shu/y8lI94kdejTz4a58kKJ97HWt/XFmxMJeW4KDzLzgh1iqBt/v3mBL14Z/VdaEL
 h2YunYwxMaPSDhdSUHTy1EZDItM113gu65gM63PoLUdNRgMtISdSqG8aDmKEVZvqpv4dW1Q
 ptidh6hO7d9w+jAfzTPhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ndY3J3kPbK4=:T3bFmdT07BARe8qSVzTqSZ
 SBO84UKsU62+ZMDaPYj8jAdK/JWWlzAiaWvmpZ8lgJqZFAc1KXOrWkfcgXCbvJZ4nsQgXA0nQ
 8X0+i7xsIgYfs/8oIcyEnEVpTFK/QAfn9lEnXRIpbfdPm1VT1ZtAxifo6W16ohReQf/HR4MyK
 OdcM2opxao1srYy37huTGv82Ay6GQBN4eiFWvlKoEGRZG37AyURI+q15xx8ibONl/XDz4X156
 ggAQ7CISqc67dRfdQXKzFqkD7Ggkt4WO0yCgeH9hq3BgNOvEeWgcmZDMX04zFMwpwCGCr1b9H
 FLRskVPomPIlJQiJ1oSUfEtpL4PrBbqcvpFiiW7AXbrHiYlGod7j1EIwblTP0cQ42PbwWAlKz
 kaIATg16xTOPwgOa1go1+jV+U+BFHNgh2RtE8DbSPEAwBGqYnbP4j0k9TwrAaNQrz8UD29l4A
 EdZXY3zGedmPnT68Bh43ZR/Ew7JGOTgFD/BC2R7rTVnZxBwwm/WtmObh17+34XZgyVAK7KgP2
 rKJVIhEYydF/1e648Qz90AEiYtf8LBEl8KmOE5SSqkHQX3h76qcT+/pZkgIDeaSm5viKcbTg1
 O6eZfCOdOU8XmvMww53Xn+dfWs+H+lmklAR5mltNu1sHEox9VhIzacJpnaU/DQBtpXmKhmkjq
 STOILebDuwGY4EUrC248ShBX2YQvMQBZLGSt9mIzTs7z6xdiF6Bq8ohIcAqz24X0RnZNME46G
 5Sx6xycsdm6fvKhVcZmheRb6dKtlrk2UyuVm69ofa0f63gaKBMmcdwPhV36phuyjourhHjwkJ
 HZyvPoj0FOSOBnnJVFdoT/3asBL+Lcfnj7oBcm+meS3dSNTxDB68lZa+VbY5H+B6sglB0AN5H
 WhwWO+ylHhI+IlI/vy3L5VHvl4R2FHsdwZpsVfZLtGL2Ix1xOJUJPBR3Kpxj7EtbbOg4nvgCG
 CHHf55y0Bl6FTtfK02KhBReR76zXecOgpQyYE/7/JYocEMEpTumcl4qeXJ3ZBlrcH6nXGd5n6
 HFwvw9JSiPWAHeKoYk+kAbImGJnM8QOKtX/1+f0eE/mc/n9n3ooTH4MPmHNVixr76JNq3DtSw
 OeepoOTkaXqnASzWS82Yc3Mel/XyqS2JFJrAaY1Kns48z+SToMa955QMpwsEkVR6ja/bOcQ0l
 8H4GjwNghCgiQ+enRhhZzqXkngdalmqIRiGP+ft2k8PEn32VKB9gVutCP3JjquYs8inRhs/ta
 XrM9uNSc+N5ToeBzka0X4qZQf1n8InQaEj34Cjw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 2 Oct 2020, Johannes Schindelin wrote:

>
> On Thu, 1 Oct 2020, Srinidhi Kaushik wrote:
>
> > Add a check to verify if the remote-tracking ref of the local branch
> > is reachable from one of its "reflog" entries.
> >
> > The check iterates through the local ref's reflog to see if there
> > is an entry for the remote-tracking ref and collecting any commits
> > that are seen, into a list; the iteration stops if an entry in the
> > reflog matches the remote ref or if the entry timestamp is older
> > the latest entry of the remote ref's "reflog". If there wasn't an
> > entry found for the remote ref, "in_merge_bases_many()" is called
> > to check if it is reachable from the list of collected commits.
> >
> > When a local branch that is based on a remote ref, has been rewound
> > and is to be force pushed on the remote, "--force-if-includes" runs
> > a check that ensures any updates to the remote-tracking ref that may
> > have happened (by push from another repository) in-between the time
> > of the last update to the local branch (via "git-pull", for instance)
> > and right before the time of push, have been integrated locally
> > before allowing a forced update.
> >
> > If the new option is passed without specifying "--force-with-lease",
> > or specified along with "--force-with-lease=3D<refname>:<expect>" it
> > is a "no-op".
> >
> > Calls to "in_merge_bases_many()" return different results depending
> > on whether the "commit-graph" feature is enabled or not -- it is
> > temporarily disabled when the check runs [1].
> >
> > [1] https://lore.kernel.org/git/xmqqtuvhn6yx.fsf@gitster.c.googlers.co=
m
>
> I can verify that the multiple calls to `in_merge_bases_many()` lead to =
a
> problem, and I intend to debug this further, but it is the wrong functio=
n
> to call to begin with.

It was actually Stolee who figured this out: the shortcut at the beginning
of `in_merge_bases_many()` which tries to exit early when the generation
number of the `commit` indicates that it cannot be reached from the
`reference` commits (because their generation numbers are smaller) has a
bug in the logic. Obviously, the generation numbers are only used when
commit-graph is used, therefore things broke only in the `linux-gcc` job.

Stolee will send out a patch shortly.

Having said that, the change I suggested (to use `get_reachable_subset()`
instead of repeated `in_merge_bases_many()`) is _still_ the right thing to
do: we are not actually interested in the merge bases at all, but in
reachability, and in the future there might be more efficient ways to
determine that than painting down all the way to merge bases.

Thanks,
Dscho

