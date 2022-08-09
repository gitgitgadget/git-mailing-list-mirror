Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC94DC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 09:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbiHIJDI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 05:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbiHIJDH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 05:03:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415802124E
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 02:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660035783;
        bh=ZvYNfMNjj6Xu3UGOXEIYOe6q3Hzm9tpGFp6YfSKwlm4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AF3QZa93RO+YiH53zpBuAZ/reMPaqHk8P7XOea1G6XErFaV+ogWtJ9PsNOLq+N75I
         45gUyN2ZVpFi4j5y4QM/sRk964pTAPelG/v9JovhPROoXqUegbWTXUB5Rt23c97G09
         ccS/id10+nWHMOhn8I5L4ZT6mZEr3O8RFWxBVogI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.31.241.252] ([89.1.214.151]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2wKq-1oOeWg3OaC-003Kui; Tue, 09
 Aug 2022 11:03:02 +0200
Date:   Tue, 9 Aug 2022 11:03:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v5 3/6] pack-bitmap-write: learn pack.writeBitmapLookupTable
 and add tests
In-Reply-To: <CAPOJW5zYndyqwyN8xOcRQnwebqXciY-25hNL3fU=V5ac8fCpNA@mail.gmail.com>
Message-ID: <s714sq49-o13q-5417-0o21-6397s3646q9o@tzk.qr>
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com> <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com> <59b465e5a7817c145172f25e73ad807c7ba67e84.1658342304.git.gitgitgadget@gmail.com> <p3r70610-8n52-s8q0-n641-onp4ps01330n@tzk.qr>
 <CAPOJW5xBUaAJtOvrefwbXv_WDTLa=6PTL5kEoOpRQfqqFAx3oA@mail.gmail.com> <6s4n3600-q5p7-92sr-4206-non3s8rr3n46@tzk.qr> <CAPOJW5yUi471cfAXuXaM4BCzVsfZ15J1Era4NuEpxEnmY6md9Q@mail.gmail.com> <p69r38sn-1ppn-q66q-9089-59394pq78772@tzk.qr>
 <CAPOJW5zYndyqwyN8xOcRQnwebqXciY-25hNL3fU=V5ac8fCpNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:88EYWKZ4bS9hGSinzrgE6MN8KesVKQ6FIV/o91Vdo0Z6FbsK2jW
 6uq5hATvwptM0ht5kI1cLVY1C/gpxa8nqhgb1iepndvPtYY/QndjwjYPPaxwWy8Enz9yhRG
 pNdYiyTgeSjpS5fcnTVA3Rkr/rN+PMNMkSV959VsTYtwv7bpI7YAy0+cIBusmnLCjsjZeF6
 vckTXN+DepwpLG6J6Y2+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QStOT18/Qu4=:Q2Bv8ZjXWWtB6rOV7Z+HQB
 MGA3YngkPACqrxcvYB4AYfCb2oBG6n6MlSCyn+d+zuPpZDeyXt0DpwAXd7Gyni4q7Ma75YHAP
 7YnY1XHTnFbMXwaMQinTTj54LcDxr80koG0YIBMJt0GlbVgEjnv5NwJN98UkajZuumcnysjhP
 YI9LU3oXFxsrjJxi3EDF9nsN9iDEO9U2FfZRsjlXQBaq9t9y+5ouhlhMPPHLxrcbyHYqvviIM
 X4IISyY1a88ffQgUF5RQYT81b1+kK3rxPBsGKEPIpSOVJG5kh4aXAGDHJpyIUDEBEYcYa/3jF
 piXTeEV8C1ktawZSyOovnOjFaYvKVzj973eITeAPj1EK2LFJenqKyxvDP1jOLUX9i6byCE1QB
 MUs8ahiVefLJ3e+a6V8CWtPQrJXob3425kTPTS5/jnGoOfFwNqspC6Ngg2dzOgJKH/lrKnFWB
 gA5poOR2OjixkkPpAbOS1xUTjWmNMZ4R1+R4Ri3/0VHZ04kbrJCNX/EqZqn3T3KfwJJG8iqSI
 v3Vdkchy8+TpI4Ejczg95L80n7f43jVcXj4kbcNVB3FUainLm1LN3DOxS+rf0KwiyulbdZnGY
 Z7j5U7JbfSie5SEDS92qAsCeHyf/Ws5EdrLMwwV3zzUiO2mBQeg++nTT3oDqRNqBsP9qRuCVe
 4HmazX2blnZP6U4MpVbT3/kkQwIt50XQIgVZaaT3mt72DrWJEjZVHPkwpY0pVQCyUM47ZyggB
 Hs3DOl7kmUG2z/MIQJQ5peGDz/uIuu1D3DA0MMVscYubqnEoLrtifWH3Cuek21BT3Qd6eE8XF
 4iOAjJG4LFltPs7GuRL1zWhne2f2ZBptw5qnFHifYBlPyC8a/H4j4U3Quvo1d1OB3rIut/exp
 i05lX7lRTy/lSnf95QKqS2E3Whzt/+GkhMALvTAsCx5/6iGyHNTUIzA1gGozImtjvrM4zy0dU
 eqTyjtF09cWw8OI+QG6uiEDH7Azv7YHnQDr0sxYEQwst6VggvnJfrFr5NfVx7bJuAqDuKLePg
 BuaCTdd93UZKS5a2RydX9dm5lwE4qVUlL5O4by0H+ZzwWXOJE48Ilmj082qpSPpq2O3nStwGz
 vZHQJmgkhHSsWEYmlKMLtrHKN+uhusfeQWbWEqX21ROvWsHOAJz/eSyfA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhradeep,

On Mon, 8 Aug 2022, Abhradeep Chakraborty wrote:

> On Mon, Aug 8, 2022 at 6:36 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 2 Aug 2022, Abhradeep Chakraborty wrote:
> >
> > > On Tue, Aug 2, 2022 at 9:05 PM Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > > Since you are very familiar with the details of bitmaps now, I wou=
ld
> > > > like to encourage you to work on some kind of validator/inspector,
> > > > e.g. something along the lines of a `test-tool midx-bitmap dump` (=
and
> > > > later `... verify`) that would help future you (and future me)
> > > > investigate similar breakages. Ideally, that tool will not only pa=
rse
> > > > the `.bitmap` file but immediately print out everything in a
> > > > human-readable form.
> >
> > Have you made progress on this? I am interested mostly because I am tr=
ying
> > very hard to maintain passing CI runs of Git for Windows' `shears/seen=
`
> > branch (which essentially tries to rebase all of Git for Windows' patc=
hes
> > on top of `seen`), and this failure is consistently causing said CI ru=
ns
> > to fail for a while already.
>
> Hey Dscho, I am trying hard to solve the issue but unfortunately I
> haven't found the key yet.

The tool I proposed could potentially help, in particular with
distributing the burden of the investigation on more shoulders than just
yours.

> I investigated the bitmap code-base and used debug lines but didn't
> find a way to fix it.

Have you investigated whether the `.bitmap` file was produced for the
latest set of pack files? It should be relatively quick to investigate
that, and if it turns out not to be the case, the fix should be quick,
too.

Thanks,
Dscho
