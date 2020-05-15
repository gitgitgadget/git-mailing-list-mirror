Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536D1C433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 13:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2563D2075F
	for <git@archiver.kernel.org>; Fri, 15 May 2020 13:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="P5AZe0Ap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgEON74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 09:59:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:54481 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgEON7z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 09:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589551185;
        bh=KyR2CDJHGzZIGNe78lCILK8PmvVnY3WxavK4eFIOh2M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=P5AZe0ApSW/Wuo9sdGZyitSJb/e2Fazsu/1iGNZLTBR/daqHT7BzXAdsEU8YROo2w
         3FyrI6EHekKLNRP+CMHBJBp7hjHB3ywDCoOtZCrHI4iGkhuwRl0Bp9SSKPMc1tIlWn
         Pbl2r5LWX/apuASCG3IpbdBVNM6Q8D6hwguLEJfY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.131.160] ([89.1.214.237]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mxm3K-1j9i1v1PdG-00zByO; Fri, 15
 May 2020 15:59:45 +0200
Date:   Fri, 15 May 2020 15:59:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: avoid pounding on the poor ci-artifacts container
In-Reply-To: <xmqqimh0afkh.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2005151557130.55@tvgsbejvaqbjf.bet>
References: <pull.632.git.1589316430595.gitgitgadget@gmail.com> <xmqqimh0afkh.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jTcQcqqkTdQBD9x43Jdh04nuJLgbYI8GRvNhM6dfAE9TlsVjjwP
 thw8UIX4gLBQKDrKwMoE6drx/GzeJk4QntAUa7wDN+T8pLkTEuRn5ha7ankTqKcxBAP0kcA
 1RbrNBJWEf3RGjg3+DjSmAEwWFzGdnOvm6J6zBXDzP0VCjjrTcNcIH/Z4jhQGDo1oCgaCNG
 gKzFYVkc5KW7KcTBqTPOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5eXBU1cCo9o=:wFTmSEF8aBYtSRVPSeB31s
 vBj6M37wmInezjUsjJtJ6RqKzPaObjNHw7JM5VgkIzuCu+m2oF0PApZX7WSdAJ89mrGM3633z
 nChnUlZBrMJ8of7n0w6ulr9KTinZXnKRQgYdKUjQe9djqHGIZRL8CyPTYUwQbhD8HMRoBmKNI
 bq1lB6ZtUQ/S5v3QoJyiZQ6DqvOG+xVO8cB1r+eFPouPCOm1x0YXXoosqB0k4WfUycMqy1qiA
 wNJWmkiVisRYg1AUxkd+9VDBDIVNY0Ymxs4CB1beZ9wR9WJXN0C4vUZ8D7+zzcV16lU1S5+XQ
 Xfvmy9Azp3VdjDDQSZ5McwgDb9q/n32OM4FS4zmIfnaiOZaCb7mdgl/acfZsMmBtSnvBXO/af
 Y98Qg3YuLdchdwBUfVwV7uTyRAq2C+y7ZGroFp9MB6E7zogobgClNzjY6j43dZcBWGbzv5vO2
 ovUoJYzyCZHK4o39Id0/DedGmIq6utIk71+6jqMFO/tF+mWllkSIY/i54vMMeIVEe/QxKPDVH
 kVjgT+oeBAf/XmpsybE4DcS3rdITsR/uzCj0WtsN/hpRcloc3kV7drs9lekcG0sZQJcvuT1pY
 vTA3ocAxQAwxUBqXE13lyqAMPQsw0v9DHTRMZQAb9HNklW9Vm5mNB9qh+2ujC2x8d6pTiC6cS
 KjtepjJOPnkvctxxtCCivDNoYdCj5gw6W9ktCPawwj+/zLvGgFEJXTHnRafo+3ChXBO2Scl8P
 STFuL9ZSQ/Q2Lb1MecmelMFFHejK+OPAqYtQ/fdOHOfucEDkdDrtkDOyDLnOGs9RTb/DLipzf
 +YO+vfqv8dgkDkGKUOMmcFajAM69t/aD9IVFBSyGeeZRn++wUlT6NcG3I8FFfNT5dvK09q8/C
 MI3e/3M5Iw2esQ54FSqcnO/3wfXxwXhC/LKlho9oDAli2DdSlkMop06qXt/PxtLrsyPQ1aZ6O
 UIw/9TktmeJfAEtSS4G+8rSaFz/C4AC2KsJEeYy51ttpPadn1KS8nNnncpQY4AdIZ9X8AoIpj
 kAvrtwzaoxesZ/0qfOXHzWvVSQnfILeigXyrwjkD1JtUu6TjRqb3TR+aLA0pQ23vLhC365IpM
 /RdFUXLGWElce3qgMHY98TeXgoFKiUPCIlyKyLUs0Zvt0utBD430D2BmOObWXz62zKSgJq0Ez
 1PCEu3naHgpmU2dZSLlhu59cVtJFq0HMZzr+Lvz683GDPmUpAx/0tpav9H5CuwWyeZOfGdIc8
 yZQLvGfuhzmgl8Va/
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 12 May 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > Let's switch back to using the Build Artifacts of our trusty Azure
> > Pipeline for the time being.
> >
> > To avoid unnecessary hammering of the Azure Pipeline artifacts, we use
> > the GitHub Action `actions/upload-artifact` in the `windows-build` job
> > and the GitHub Action `actions/download-artifact` in the `windows-test=
`
> > and `vs-test` jobs (the latter now depends on `windows-build` for that
> > reason, too).
>
> I guess this answers a question I sent earlier to the list (our
> mails almost crossed, I guess, as two of us were looking at the same
> problem at around the same time?).

I am terribly sorry, but I did not get to read the Git mailing list at all
this week (or for that matter, my private mail). So I would not even have
seen your message... :-(

> Hopefully when cmake-for-windows-build topic lands, this can go away
> altogether, but that is probably at least 8 weeks away (3 weeks
> remaining before the next cycle opens, plus a half of 10 week per
> cycle for a typical major release).

The `cmake-for-windows-build` would address only the build part for Visual
Studio. The regular Windows build, as well as the parallelized tests
_still_ need the `git-sdk-64-minimal` artifact. With or without CMake.
That's because neither CMake nor Visual Studio can accommodate the fact
that our test suite is implemented in shell script _and_ requires a
working Perl interpreter.

> Today's final integration (these days I'm pushing out twice or three
> times a day) contains this one, and it seems to have passed ;-)

Excellent!

Thanks,
Dscho
