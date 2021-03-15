Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD64C433DB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 14:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AED2164F17
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 14:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbhCOOTh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 10:19:37 -0400
Received: from mout.gmx.net ([212.227.17.20]:59717 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237558AbhCOOTH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 10:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615817929;
        bh=hi7zo3wQlyTJwdysOkY+LFUn4fjP2EKIq/xzGvCGwiI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CZLe3WR5EcBX+dXajJBfiWCMqci/tPR8azhCxbczRUr36BiJpJmD5jHByyOddjqT2
         ud6s9vDmxMZtJxT1G18A+w3IAya6Jcshw+pr+V+TcxGn2JGavWtcdQ45B/TJ8G+G4a
         DbZMItIe7EynqAMhLLJ/mtPNdLmKSQID55U54UlY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.201.226] ([213.196.212.127]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8ofO-1lp0Gc3UyE-015tGs; Mon, 15
 Mar 2021 15:18:48 +0100
Date:   Mon, 15 Mar 2021 06:19:37 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Arun Sharma <arun@sharma-home.net>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: bug report: mutual recursion in the git-subtree shell script
In-Reply-To: <CAN7rbOuOaHY553KX1Qcr_XWGG6DFo1yUjdYVu5mn=HYPmOj6vQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2103150616410.50@tvgsbejvaqbjf.bet>
References: <CAN7rbOve-EFOGPjr1wrD77r-3RQ+3+qso82_oV5Qud-skobL7w@mail.gmail.com> <YEzwOqgFcva4fmoV@camp.crustytoothpaste.net> <CAN7rbOuOaHY553KX1Qcr_XWGG6DFo1yUjdYVu5mn=HYPmOj6vQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ooFuzA2CM2K/MN7JaMymLP+i2HbGQ6sg6yoGgmWdyIQOs/KOy2Z
 jcarsqN2wxdRAqIWh1UcCcfjivZR8N7j/O3APLMZ1Pv/26xWvr8SgFhUkK9lmE0FQhJOnaf
 EG7kRe++IbFX73L18RpnXzLDNeXAOC5kp1JdVM1HR9xawixSK9I9RHvxjG0TG2S/Kg4fn7v
 NAk5By+ed8Uf7NnVgctqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xsZG/QBoljU=:EYzYiMMi8VNaLAeNZIX3Fw
 BMDfegjkJXYeeE2fXuXyby8x9c4z4bdE6i3rAQVYrgzrkE+feOABUgD5L47knp4S0VrqWeL4T
 B8LL+RHjyf4LKy7+Cm6dlO3DPaHQ9WUrRX0G9Leecqf8Y91zn3A1QiG5aAXENL3W25gq/OtVh
 CTQ+zBJ9fSncH1PYH8sAcrpRU8at8NQl1ej5LKS367z+zSoAmFaFT0C7l7MUrFKRloq2DhTnx
 bzQv7h94T2s3ZZHMurvzVGYJbfMMkE6JN3xKRf+PlSCks/Vn62NYUme7Q5hw0K3fl3jNW+L2O
 dC8u8/faOguxnls6++GAXd2qU3JoGxdxVBE/BVxy4O0ZWzylAmMn9bqvkqFHBgXhlmAlx02J3
 1LJOQ3KoeuBLPE4pNFmk03OdP22PBJQj8N+WN9W6wTQGTtCN+s7zVuu3GYJX/gTbIHFAVYZji
 gNjQfiChyC7J4ddVAcY8qxOOjD7nd7MlYTSEPUVaWPtz4QiM92NOaqHs22Tzij/jkbL7cShzb
 OmIrCjL38eHrkGoF9oiUV54LX0Mz6PMjBnWOU+W9SNQhKnWThwRGt00MpR5XjtZXbKOFNHRu/
 DLIMVtzsN54hfqCVeB+l+D1YI8BoxuUtugBlcyMN1N8psyjqIMemRbAmV8Nf4O+mvaUH4hBOO
 NdOtdFrxSzJIfH2owfxldKnsH345Yg+Nqzyx3T/b183HTpvPE7IayBxF8q5rNGgDDD4LNRg2s
 /hbmCXCmc2JwePT335mF374qVjGKOVC3pKV8Q/To3CMtBz84SgZJUwGKsV84uR4Gnd7LH5Hr6
 nzwMttR6rgciiVxC2dINeM+BbYZVOWO+4eyjUGL38k8hoTlCIjhmtQTw3NEuLd25BnuhHwBlP
 VrZ2JG9Rg2WAb+CGMF5cEKfjUKQSFlgzZ4dzrnxUA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, 14 Mar 2021, Arun Sharma wrote:

> On Sat, Mar 13, 2021 at 9:03 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > I don't use git-subtree, but there's some additional information which
> > would probably be helpful here to someone who does.  What OS are you
> > using, what version of Git, and what shell is the shell you have as
> > /bin/sh (or, if you've compiled using a custom shell, the shell you're
> > using for that)?
>
> Thanks for the hint. I was using ubuntu 20.04.
>
> $ git --version
> git version 2.25.1
>
> $ bash --version
> GNU bash, version 5.0.16(1)-release (x86_64-pc-linux-gnu)
>
> To repro, you can try to split a week old version of:
>
> https://github.com/postgres/postgres (subtree: src/interfaces/libpq)
>
> It could take several minutes because of the size of the repo.
>
> And then try to pull the latest version and push the merged result
> into the smaller subproject.

Without having had the time to read the bug report in detail (let alone
the time to try to reproduce), I nevertheless got reminded of this PR:
https://github.com/gitgitgadget/git/pull/493

The most recent iteration was sent here:
https://lore.kernel.org/git/pull.493.v2.git.1602021913.gitgitgadget@gmail.=
com/

This patch series _might_ address the issue (IIRC it talked about removing
a deep recursion). Arun, maybe you want to give it a swirl?

Ciao,
Johannes
