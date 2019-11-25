Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01411C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 15:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB7020679
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 15:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NzETgbAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbfKYPyU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:54:20 -0500
Received: from mout.gmx.net ([212.227.17.20]:46777 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728243AbfKYPyU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 10:54:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574697252;
        bh=ybugLsbtS2+KnHZe873p5udH+ZlyBTvvGlNPF3PfsPE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NzETgbAJfEYqBz5DYcNo+Z9RZd6RU/KyBxPn9dqWJ3X1v7fnX1WpVtTL7gKozgGQN
         76j0g50bTlCnITMxcfRO3H6uBazfYkRRGhSd0gvfmddGRzX2Tb7urXPaiF5Aaxx0qE
         bysvSxxohDjPmSA9FpS/DDOOH6GtIPSPb+2Uhp1E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkHMP-1i6DKE3iP3-00kdMX; Mon, 25
 Nov 2019 16:54:12 +0100
Date:   Mon, 25 Nov 2019 16:53:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] sequencer: fix empty commit check when amending
In-Reply-To: <43bdadd2-9ea9-4e50-1f47-ec18e0db4794@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1911251652510.31080@tvgsbejvaqbjf.bet>
References: <pull.467.git.1574345181.gitgitgadget@gmail.com> <pull.467.v2.git.1574451783.gitgitgadget@gmail.com> <037f2b2975e06847443aef46939e3c712053dedf.1574451783.git.gitgitgadget@gmail.com> <xmqq5zjb2vsx.fsf@gitster-ct.c.googlers.com>
 <340859a7-5cc4-f641-818d-fcedbf29a2a6@gmail.com> <94573071-556b-caae-b159-40c168a08f44@gmail.com> <xmqqr21wy80o.fsf@gitster-ct.c.googlers.com> <43bdadd2-9ea9-4e50-1f47-ec18e0db4794@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BcI/WdfnxbNzPdmI3Enmuu+CTlhzJDEWnWYPimnpubZU0YghYqO
 xf2aJuLz4uwneA7i4LpQs4NEGuVXP9jlFJGC/brMWBSWaH8OZVZ1/1ibgeSc36rJotDC2vd
 krrzykdnmOpXMTgOAFsPvnrgtnEmkKuIMDahWhIEwhXabB0pXkHLPRNT1WJD0x9n5lOZWK+
 1QAkpx6QttgGbYbjJm4jQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZDyLOeIoH3w=:1mUGdJ33R4vvKou1yQHwOI
 aVLnHAKhJGplBb5WcvgbWzL/kW/vYpdZAdzSXPC6kHA0AR2eOWWNog4qtlk1YXvyJV61CYmMI
 g/9AiYjiNHnhU6znwGVb4HrxQoDG8YiGK3Nwk0fPidBaAodKNB6GVBpXMXpNI4rgscOayQOiu
 kU+cJExgBSxl6CugHAbvDoWrOfQQEL1Dl4EU9lWPse0rtEtYCcdVgbtZ2mYLJeyDdNKTkv1An
 j9q4mY18MvWNCOvw1GzIrahwPg1jDeTLFHPCNIdf159pnUYy3Kqhh4JNrvw4sQBFMI0tLIzR1
 PBdTE/YzWk5VJ/mDCD/7WMyB4IRVZzTXC/nS1wXtALPmUO751ZxIz/BP4kZvEMgx4M1rWklvg
 x9o8sA43ZyVvSV9EV5ED53BGuVZ06LBabZdDOARU+8DYeu8A+28ogdjJjaTWSNbme654S/RoK
 YkeaNRuIdrqeG4VVkyPIWdWqvGaDY3CZ2Byd8G7ta296eyPF2DdLxFhS4a64MsgruNGZwqahu
 5AnpyFSAU0+qnkWZW2meWx0SbDosQXaU56T1bUSmu1J0dJA9xaaghrDZ14BPBIUbxWY9xz5El
 6nIWDKiioJbzlN1LgubV2nY6rxWAsvUEL+GLIZHUgWGn3UiJdXMC1DIyCdb5nDZWyr5BkpZZS
 sdoMyXYGNLPFQBuh51UC4lN06PoY5H6/Fo57bEbBQ2yJDVehhBYtagEZwtEL1ojjOzvGaGBJy
 LD+grFpnQCz5gI9ywChRIu7I8ZDqMm7Xx9qqZ2YB8qFkWjdumNJRR0xgWQhuQ4XMTDbUjBXZw
 XBIYNZMbQjx8m4C5KyrVJ93z2nWBaXwBdzauDZr2nnCNEkoRPuW6zv1f2GYZwjhyLuBgsV2/u
 TxvWjEyy7Y2gAPUlXgnmCwPKQhMsLNByIJqmLuh67DsVKv96Z1+b9y1giJlUEA0A6f138phHt
 OcTde2eW9+ntrLNP84pWUITNEGVcPOc2chKnw3xpntLYcJze1BTm/CdjUNDU8kBdz4a6czFI5
 WOAftxG8VNy0yGrjU03yOyEBCIOBFHL7tDOqhBk7EZg2IxNKuWWvOsWhk1GTL5nmu0HhYcBGe
 n7vF8CK72aSVngllBYNOaYCXJuz/iCwWP11/zFZVtv+2xLG4T1znrMQWnOm0nkAOPfnm3/qCk
 oCrXpKoVofD4eqz5kA64eZpbqF8Yqq55v3uqZfxonAjQzhGDGM3ailoFxM01y/o395jxgowGA
 SkERiMbkFsaN6MK4BjFUhd+YLtpM684W7xxfzph1B6MzP5mHOD9dYFtX02Dk=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 25 Nov 2019, Phillip Wood wrote:

> On 25/11/2019 03:00, Junio C Hamano wrote:
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> >
> > > We do actually check that there is a valid HEAD before we try to fix=
up
> > > a commit. Though perhaps we should still change this patch as HEAD m=
ay
> > > be changed by another process between that check and re-reading it
> > > here. If you try to fixup a commit without a valid HEAD you get
> > >
> > > error: need a HEAD to fixup
> > > hint: Could not execute the todo command
> > > hint:
> > > hint:     fixup faef1a5a7637ff91b3611aabd1b96541da5f5536 P
> > > hint:
> > > hint: It has been rescheduled; To edit the command before continuing=
,
> > > hint: please
> > > hint: edit the todo list first:
> > > hint:
> > > hint:     git rebase --edit-todo
> > > hint:     git rebase --continue
> > > error: could not copy '.git/rebase-merge/message-squash' to
> > > '.git/rebase-merge/message'
> > >
> > > The last error message is unfortunate but we do exit in an orderly
> > > manner rather than segfaulting.
> >
> > Thanks for thinking about the issue further.
> >
> > > diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interact=
ive.sh
> > > index d2f1d5bd23..4f55f0cd1c 100755
> > > --- a/t/t3404-rebase-interactive.sh
> > > +++ b/t/t3404-rebase-interactive.sh
> > > @@ -67,6 +67,21 @@ test_expect_success 'setup' '
> > >   SHELL=3D
> > >   export SHELL
> > >
> > > +test_expect_success 'fixup on orphan branch errors out' '
> > > +
> > > +       test_when_finished "git switch master" &&
> > > +       write_script switch-branch.sh <<-\EOF &&
> > > +       git symbolic-ref HEAD refs/heads/does-not-exist &&
> > > +       git rm -rf .
> >
> > That "git rm -rf ." scares me, though.
>
> I know I'm not too keen on it my self but we need to empty the worktree =
and
> index if we're going to switch to an unborn branch

How about `git worktree --orphan does-not-exist unborn`?

Ciao,
Dscho
