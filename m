Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 544941F454
	for <e@80x24.org>; Wed,  6 Nov 2019 12:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbfKFMGP (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 07:06:15 -0500
Received: from mout.gmx.net ([212.227.15.15]:35041 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728550AbfKFMGP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 07:06:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573041960;
        bh=49s5OzerkaVVWFKJB2SmsiSUyAvhoIQOLb8K6si2HGk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iD4HmUQg5oRjlaQusEtCpNmEMyYXckQYwcevtsAZn/J5uUCKXCxJt2+Pwx9+Ek+7v
         p4ngjOKjr7RgKG9LGb9Qf/bZtk5FmZCmM9ezGBDpdZx7ig2P8h61PAbDHdxhFoM7bi
         L9xvDT6EvTIV+tP45foofJU0X0F1S2uxliTLkP2U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYeQr-1iNf7T1czT-00VglE; Wed, 06
 Nov 2019 13:06:00 +0100
Date:   Wed, 6 Nov 2019 13:05:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Fix locking issues with git fetch --multiple --jobs=<n>
 and fetch.writeCommitGraph
In-Reply-To: <20191104195928.GC20900@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1911061305060.46@tvgsbejvaqbjf.bet>
References: <pull.443.git.1572740518.gitgitgadget@gmail.com> <20191104195928.GC20900@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eOmcWmyvtqGNdlt5S5x3VjJJWH7OJjXmJBIWX5rTJX5UMnc3wK2
 sKYW1OW5o36JOOJBaMk/tVydXLW5y8XsoHDBW0+fOz37tGy9i8sceOZzok4p0+ZpPZKUFKO
 vP9lI/AvYTfZYaLh+2e0VQPJEBgReUTquedN5jAzT7K0IlJtRryeRByJbB1M50B68gJ6OyM
 WdSXQmUElgMgp8wTjQGpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9bplAlPS9IY=:yiBJuftBVCRtacBmoogwAx
 b5UFEmyq/spB3mznhoWPOr6ifc6f/LMnUSSKfrjVuKmBq2WIZZhrJ5cGi2psPtxs4XM6zvRFA
 y8NRu9WIMmwL2q4OZqIoO74afNd2tHe7QtzyiDLLovSoTC6hHfYU19kpG1w89vTv8mURVKAHF
 pF/PEF/8/3FBeoeRbGgJTSNV0E3TAC5vvtSuj6Chn0/PtIwOsI59VD5fZa/pszmFsVOjPj09V
 zk4PKk5kXxXCTGfycc0SaKYDesJMn5uSe2fSagtmEJa187zwJxbl03i+a9FjpmLFzt7gTIRsf
 JJ26UWL3tbmGUowZV/FR3rjfWJ1rPMIXL2mnmCvwgAiNyDGo35Ml0OhkOoFbGbx8q/2No281i
 c866yiJYG27aHWWVOLySac7pXmIv/KRYME6jndrEnQI/4ut67XI/sIqmJTcUf8cWiqtSKuU+g
 sKGrlnkagQzGNBdvnwFKvi49HfkH8MJgQWTHwW1DAApG3qx+UOSnapI3zQe404ixjjxlJorD+
 KznML/eVRih+5TOnYj+iF24tcLggOLBWdP0OCdhKX3NYyqesoVXNkHXMk189ezR/eNdavfoSd
 OKfscPYilFfgHvtTiEvVtbyKdmf/t8MbCSqM7pWQ0Hv14qtvBjt1Y8rkSNMkFaUkWAqhEuG41
 nyZImNQWsngXLXNpTtLaWHsODFa06bpecMSzy2kV8qd9Y5limk71q/GRTVh2fDD0tCUGB4q2g
 5qFiTkTWn0tGC8PMkcyfQqhkyBRJBqa24D9uBqmCppeGl88FQbJEwyR/U0Ixnjf+bNBXGll7p
 RNgRw+DzOzUGP6F0/zzawqWI5kumC6C0VtJaRu2RSce9ZiPs+jAX1ddXNgrBHURWrUXet9Ln5
 CpRBSEdorQk5LFA/XfhXFokTFBg44ZSYNTe4kPORf0CohaVsimNaBbVOQjWLQCI47QF779poc
 ++JuYieJEQO45zjC00tXqMOviEWrdr6VjK2zHYb/k4VwRCYSDfcH/D2YjaI/KBEqjGj6pLfNz
 kTaVDAfja4kMWnpBZgfC6YRe/2zvM5nAV26S7qgcy7ZQg6IIFLsYld0DA4IA9ssNlInvJz9Db
 K8vEMajRbZJ8BVT4ylWIhzZ/FjPWaKtgFY64lwgsqZxhSMhnB9HyTEXPJnQHXGBwYWfhoFoFF
 ++hy2SpKIxzUi8zPgX2/zUhKPesXnNCmwrzaiNsFwc/RW5+kRNKYyLW/uysOtIMI7QEomHHpB
 OsabUD/9Zdp72G9fhdEI66cSJuF/ny31oVYwiloQTrMpJoE9a7KlDaPxkrVk=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 4 Nov 2019, Jeff King wrote:

> On Sun, Nov 03, 2019 at 12:21:55AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > The git fetch command recently learned to extend the --jobs=3D<n> opti=
on to
> > cover the --multiple mode: it will run multiple fetches in parallel.
> >
> > Together with the recent support to write commit-graphs automatically =
after
> > each fetch by setting fetch.writeCommitGraph, this led to frequent iss=
ues
> > where the commit-graph-chain.lock file could not be created because a
> > parallel job had already created it.
> >
> > This pair of patches first introduces the command-line option
> > --write-commit-graph (together with the --no-* variant) and then uses =
it to
> > avoid writing the commit-graph until all fetch jobs are complete.
>
> Thanks, the whole thing looks clearly explained and the patches
> themselves look good. And having "--[no-]write-commit-graph" is a good
> thing even independent of the problem you're fixing.
>
> I wondered if it was worth having a test in the second patch, but I
> think it would be inherently racy. So it's probably not worth the
> trouble.

Yes, I gave testing a great deal of thought, and I failed at coming up
with any way to automate it.

Thanks,
Dscho
