Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DBAA1F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 22:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfJZWF6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Oct 2019 18:05:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:40819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfJZWF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Oct 2019 18:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572127548;
        bh=Z0JmCCRZnh/YpAjs/WCD2nJo3P6SdL5i9nnbkVjZInM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=guH9356AOnb+7iKnQAKeUuEznCtiLFWtbrLKBx6+5UCpxoAgdUX6+lQcPc0X5oms4
         BLqA1KAZIXFyrqO2T4w/wms2RH9/ZS16oHXLhH3vfNPK+tlijCjd2o8HOUgG+B/85m
         aA6gn8v0Qa9U7HzGk55l4LEw5Dt1rVwWq8hXvuzE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMXUD-1ifk5u3cql-00JXBU; Sun, 27
 Oct 2019 00:05:48 +0200
Date:   Sun, 27 Oct 2019 00:05:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] vreportf: Fix interleaving issues, remove 4096
 limitation
In-Reply-To: <nycvar.QRO.7.76.6.1910262351340.46@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1910270002570.46@tvgsbejvaqbjf.bet>
References: <pull.407.git.1571755147.gitgitgadget@gmail.com> <pull.407.v2.git.1571755538.gitgitgadget@gmail.com> <54f0d6f6b53dd4fdd6e4129c942de8002459fd88.1571755538.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1910251034110.46@tvgsbejvaqbjf.bet>
 <e7002f76-65d3-607f-3b5a-e242938374f7@syntevo.com> <nycvar.QRO.7.76.6.1910251548560.46@tvgsbejvaqbjf.bet> <20191025221118.GA29213@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1910262040360.46@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1910262351340.46@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QhHOfXM0V1fOeKj5Xr/uUpWuMYfGu3x3f92El515ySmZ+DYyJY3
 qvRV5wu1CrJLV8GTWyIjKd6DhDO8EpCAAripDQrPLNqDTb4D8xIRTnkjofXxr8++cOiLxCh
 pjt5O+Gxa/RZSF/GQHltvNpB/zoJ4FD93wKL60yYsQtA0mGBv/6AUcLenU9y9pSRG//R8lZ
 aXPgwp0CdFoi5bqk08wdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bceuj22+fA4=:hmJUNZ2NwDPkcOv4ZewobG
 5CYKEfhXj0fJkcPL+yoHgotoBTzfD98nYNQfFv9tZGy9pKf4vTXtt3daQ2KSKQz6h5NSIuRN/
 L62kkVNeHXV0Iud891N+kkhjFx8H6ezSROvXayNgQmlD0xOGootqqCMtLZD04/FK5M8rYspSe
 m63zhcVliTFCYDu/mU/3BaLktB2+XOs153ZEJVO34AHnVulBlJNrW6qVyszW8PvG1tdRnvGIj
 tJ1cMBMLY2cSFoI3a85z0fnWB1os9zYi7bfD52uXWvglNALt0BYQM1yTY61ocTcq4qcGzwWPi
 nv+oF1p/Cat5cYef/ceyVaA29Vt/I39cBz/Q6dQjDPjK8QXCeAuQXrDJDcofaGKBbeYR4ZOAh
 0pTqNoLnx6hwTpgc5BLNk6NQq02RwfZqwmCdvdYioHKHRxjdzhagvTbyCANrQvx5CP2E+dpte
 jyvAdJ/2fTeCDRp3LrFO9yANIclnM8EfyoZfL9F2KRVH8TKnmcQeiVXT6Z6qXFI525D+avG9p
 jJL9rKDZrH+DLsOmvZOc5EcQaVeT3qv0RHta+MVUtQIDVl+tMkzrzbHPUbegh2JTllA9EkFLR
 pjRAjR2Ei0ZLNRfz7X9MPG6xwEyLpmkLoV1Y9AoxmkYbAinIaMHQz7ykFviAvVO23DibbeEyB
 BKTCR9SFPxak2eBvqCY7flWz3ox2TpgHBPk43B+16gArQCiRacZNqkkpT0ro25h8KdmCpRKHY
 r+WvoQPXB+CG/c4fcu2Bgz0B5lWY5b+FXF7f6w8x2rORBtQZ3shszzagP0/7kg598Jcl90NAO
 +P6NJuChqM3EUTe3kMfQ+sBVRI61FmjVsT+EcWqEypOkcr7P97yWRpURJ/U8SyYAjyEaxO2Xc
 fg2lcmMr7BDjld1NF6773fLMw2GsBZ8Iw/vILbzuH8/ytY8Et6w93ekjRiX+MqSZ+QolmKBiQ
 9gpWecX/tBv6RDEZCgz8OxBQSqhNKBnG76ATdAQd+uuTrsEr9ClkBo1p+gRQzDVYFIF7qFyv3
 4WcuTeiX5ZzAUIuh6p2+TG6vI010NLihgOVUQ6SBl+j3RmfsuH7cs1t7r4/LcfGHeMWofaAOy
 hFXlo0xp78OHE5zKGaVX6w/bWV8iwjJF318fSWVbOxTvaSqdMEoEV1uuq5WBzo03NQzes94Rn
 2kCV7Tnk/l4xs0aQof+8b+sI2/mYtR0vzLHBvHum8G5HxBpIBOJyn7PGokefS2OXOnU5VVcwb
 ozaZnMHaEPLp4EJsU8YhSCY7iyTsRmjXhTG/sFbHdanPtmg1gHYsvw0s0xlM=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, me again,

On Sat, 26 Oct 2019, Johannes Schindelin wrote:

> On Sat, 26 Oct 2019, Johannes Schindelin wrote:
>
> > [...] I did open a GitGitGadget PR with my proposed change,
>
> I should have mentioned the URL:
>
> 	https://github.com/gitgitgadget/git/pull/428

I should have mentioned that I also opened
https://github.com/git-for-windows/git/pull/2373 with the same branch,
which exercizes the Visual Studio build, too, so it is a bit more
informative than the GitGitGadget PR (which only runs the regular GCC
build on Windows which, as per Alex' analysis, is not affected by this
problem).

Ciao,
Dscho

> FWIW, in the meantime I managed to address below-mentioned breakages
> (apart from the broken pipe problem that is discussed over here:
> https://public-inbox.org/git/20190828161552.GE8571@szeder.dev/) and the
> build is green.
>
> Alex asked to be given time to brush his patch up on Monday, so I am
> holding off sending my version (for now...).
>
> Ciao,
> Dscho
>
> > in the hopes that I could somehow fast-track this fix into the
> > CI/PR builds over at https://github.com/gitgitgadget/git, but there ar=
e
> > problems: it seems that now there is an at least occasional broken pip=
e
> > in the same test when run on macOS.
> >
> > There _also_ seems to be something spooky going on in t3510.12 and .13=
,
> > where the expected output differs from the actual output only by a
> > re-ordering of the lines:
> >
> > -- snip --
> > [...]
> > +++ diff -u expect advice
> > --- expect	2019-10-25 22:17:44.982884700 +0000
> > +++ advice	2019-10-25 22:17:45.278884500 +0000
> > @@ -1,3 +1,3 @@
> >  error: cherry-pick is already in progress
> > -hint: try "git cherry-pick (--continue | --skip | --abort | --quit)"
> >  fatal: cherry-pick failed
> > +hint: try "git cherry-pick (--continue | --skip | --abort | --quit)"
> > -- snap --
> >
> > For details, see:
> > https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D19336&=
view=3Dms.vss-test-web.build-test-results-tab
> > and
> > https://dev.azure.com/Git-for-Windows/git/_build/results?buildId=3D445=
49&view=3Dms.vss-test-web.build-test-results-tab
> > (You need to click on a test case title to open the logs, then inspect
> > the Attachments to get to the full trace)
> >
> > So much as I would love to see the flakiness of t5516 be fixed as soon
> > as possible, I fear we will have to look at the underlying issue a bit
> > closer: there are two processes writing to `stderr` concurrently. I
> > don't know whether there would be a good way for the `stderr` of the
> > `upload-pack` process to be consumed by the `fetch` process, and to be
> > printed by the latter.
> >
> > Ciao,
> > Dscho
> >
>
