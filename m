Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2348C43381
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78D1064F6A
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238330AbhBDTaL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 14:30:11 -0500
Received: from mout.gmx.net ([212.227.17.22]:32955 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239440AbhBDT2w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 14:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612466834;
        bh=M53Z4z9nXw7z0DCqa8g3BPuTiUKCCri2OKtxDsp8v8E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=C/sJV1D4rNMAcNtNLPEAprVICC7LmFUic+roeDPPU8+eENOKnfHJsl68z9q+/TLod
         QCCZ+MOou1K6eJtiXIZ+NoEIR9jaIx7W+MZTjhSul36d04stx5V2um3J/nd/Qjnkzl
         MSWCILIQx4CEemXB+9voLVXdex61he4HDki+RliI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([89.1.214.8]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuUnK-1lz9sm2Ipm-00rbDp; Thu, 04
 Feb 2021 20:27:14 +0100
Date:   Thu, 4 Feb 2021 20:27:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/3] range-diff/format-patch: refactor check for commit
 range
In-Reply-To: <xmqqy2g364s9.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2102042026490.54@tvgsbejvaqbjf.bet>
References: <pull.841.v3.git.1611765444.gitgitgadget@gmail.com> <pull.841.v4.git.1612431093.gitgitgadget@gmail.com> <b98fa94b87037b811ea973c1aeb7cfe08d7c1bd6.1612431093.git.gitgitgadget@gmail.com> <xmqqy2g364s9.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2ucj79Li9iV+LPj4FoqynbIWIb01bfiaHQk7WVJzXF/TNBDX/fC
 PK/5jzbyUJURSQXDg19qpvRdxOgxswXJAvvlQwvTDKkGwhYduDXLWNpc4G/7wv+Zx9hQZPO
 rSmEHK3Tkx0lgss72IXAny369OJb3iBr55107+BgeeecPJ0V7F+yGsEeodj+Kv/oMH1KDV0
 yL0kzNJ+sW2hDYGPohtbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2JRpyciIYNI=:N6Tywk0cnZ4GUlEaSpsvk8
 F/pfgCJgf++hYOWy5LsMZbatGdD2bh0wOKz5XiSbWpnQ6KIxWW89ELPygd6XK3p+kbC1kyuTF
 M5yKkS4kONsL6po6qi8SgT0nFCiQVbBsFRlhYNRU6R03RXVb0iNx18mtTqOF+e2KFsqwuThBs
 Prgs8qW5mgVJ3dbX1KOB0c6x5a+6Avsc7Eg2u5fy925RGiKyIq58hgVA86jw2Ou6qsQbvPsIl
 J98GWr9nBuAlHqNUom3S03H3LJzkbqKZnhfbfCtUYzn+KfpEmBcJ2l1QFwy0d3ZbV4vFSVtgd
 0FowKrcQzk/PuyiHwhGQrVVco7XCLI+7Fm/vgMgYZdZ64iD/tvRE+xhRTdZh6OJYKV4+8oMLK
 +N21UJDeGvAh01DAzKYbq/kP1ehgr7pVf7BxRhDIhTdBTo175pAwrzF0RgfC5PQbid2Hl9X7V
 1hnyNU/ZnVdQtYzbGWht1ryJfWfbRUx2WDZybGpy8Bwf1VsWWo8sMOrJl/FwEHB/AYUuhVx+z
 0pyEj6KK29m2hLYQbMhI29m/baED44rS1E5TZAE6nVR8CTuC6IFU03uL6SabOb1VSMzZAETcd
 RtPINOUueN3sS9rp/rlscvCR9dvFqXbIiNRb4lGfpxAlD/FHLw2wI3y3L7naWWZaltozAnE8N
 L2O9K7KRw6EmFB49yBkCR8pQkx1UjUMqdLcHDLb7d47GB1DRIbDNn04gSsgTtRR2sbKyIjCYF
 HaVWslF9gfYR6GuVy+IVmum/obWVhZFjna2mpkGYt5BL9l3Bvmw1u/UYJxMEZA3qhZY1FGlSc
 V8jNd5z14cDHcv2iP/jQuFIoSc2dHUGCmWYcam7qYYSyT6ClX+F5AQC0mBVvtM/S/+wsqyzjn
 KuODz1BLAbCb0EcDSk0StByeU5xl1ksePjKw4cGNs=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 4 Feb 2021, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > diff --git a/range-diff.h b/range-diff.h
> > index 583ced2e8e74..c17dbc2e75a8 100644
> > --- a/range-diff.h
> > +++ b/range-diff.h
> > @@ -16,4 +16,12 @@ int show_range_diff(const char *range1, const char =
*range2,
> >  		    const struct diff_options *diffopt,
> >  		    const struct strvec *other_arg);
> >
> > +/*
> > + * Determine whether the given argument is usable as a range argument=
 of `git
> > + * range-diff`, e.g. A..B. Note that this only validates the format b=
ut does
> > + * _not_ parse it, i.e. it does _not_ look up the specified commits i=
n the
> > + * local repository.
> > + */
> > +int is_range_diff_range(const char *arg);
>
> If we were to use [v4 2/3], then we do parse it, even though we do
> use the parse result to reject some valid ranges (like "a history
> all the way down to root" in the implementation).  I think just
> dropping everything after "Note that" is a sufficient fix.

Fair. I will add the sentence in 1/3 (because it is still correct there)
and remove it as part of 2/3.

Ciao,
Dscho
