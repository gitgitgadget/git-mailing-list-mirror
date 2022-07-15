Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA674C43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 12:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiGOMLW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 08:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiGOMLU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 08:11:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FE37AC35
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 05:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657887071;
        bh=wZjD3l3Wace/wRmWP+7OFUusTjlOcV21UV1kSY/Flig=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CrnhcppCZroMZL2GEdhU1BAZOayZMGpN1v3BLQO8uAAFmyk6ZlrFTDBD3KAt0p6en
         7b6+BrBdQWMFVv2PuKF3GCuRJ1vrmyYAtnykwOljyTbEqPdiXUZTtRVPOg+h9oh4zu
         zlpIQdPZL2iggjCpSXrin2EUXIDbwb3tcuZRJ43c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.21.23.67] ([89.1.215.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MY68T-1o25o22rBF-00YOTH; Fri, 15
 Jul 2022 14:11:11 +0200
Date:   Fri, 15 Jul 2022 14:11:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Pierre Garnier <pgarnier@mega.com>
Subject: Re: [PATCH] refs: work around network caching on Windows
In-Reply-To: <CAPig+cT17vZcsf2pGQh-S6UjZib3=4Am7RVf=gQq_sDZzKD08w@mail.gmail.com>
Message-ID: <8o57s19q-r69s-660n-1202-7o05182s00p0@tzk.qr>
References: <pull.1291.git.1657872416216.gitgitgadget@gmail.com> <CAPig+cT17vZcsf2pGQh-S6UjZib3=4Am7RVf=gQq_sDZzKD08w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SdE28tDtkmFEZ2E3igevH5oyTNGcxJV37wg+RD2vVRj+qmrJmp7
 hqClVQyBBkkzCfGajA0Zynae87QKzzxSIj9m5qYHYvLr57UizUvyMA/jBHLcMFnB2x2iKdV
 ZdrzA7uhc0dgrcK28LJAjsQW5G/gg1JaJu0tJQvrjLxUi9wFbB5hu6djeDESw1NncqNaDP8
 wyk3JS1UE/B6gC/1iVDaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ORXJ9iCy788=:C3e1WqEHbrh7+pFIgy3TNB
 5/1Q01BXl+ji01/ionUJoCws2ghzZVKorNnyiIMehDVG+knsH8zhidOu36PDf5yTV71kvlXgt
 EFOzT2uvGIuhG26GMLMRlPeslZ+pe46ZHyFwno2mIyEwhT0zj671YSMhPXgcwlnSJnvAaYS7r
 b+L1ffVDZivkd7teR+1LzVoEaWMuyJbHTD6ZL304OxS22xYK8WdzuDXoQWiuZVZhdJ/WFiPtt
 a2xY2PH1TznRxGBKPMQSNMOccd5GGZQWb3Gp9dzxFUpW6W4O2WKa6wwtGtvMDc1ihiyrj0pGO
 MEFC4VvRszEPhg1slB2yVI0BeINqdtDE2fqQuz1mwJQ87izE4SXnMlV7entOyn+6l8cuMNTke
 vKNXUrHALly2/08qREtlu0NpIT6gd2n3vrZrNbuf8EL8vtnno7uy15iAzutouQMNpZDJIXhhF
 ua4Xg5LUBtzo6gQk4a1/X3eDnQzYqSw06tFJrfuBxQlXGly/MkyWWUWe+8HHQv3Sl+fFdkYzj
 H2EdFaEQeT91TaUf4KwM74pwfiEPH/cUdZfGKVobSfOLUChr0cPsC1GWsHTQJnAxB1/Q2pCzp
 dO/p+vxI7KKr47i67cp7Lk5RKvKKUHvq8LRanVfRo6XP0NG8Ga5HRSIyhlch+H3bh9aoUbmXc
 2PGAezYt2croTLifMsJ0CQRvP772x+X0vnjX+Mmd//cXYtx9EDb2uQaTtLE1zz1FIueCnP8TD
 pYtxPChpYk7krvSSTaapYfZL5QtK/js8wWL4N9VHobJHGZIxIday/DBfOISzXDvwjyI6QC8dk
 wyNVS1cz4VBxlbAVumT3FmYwLNoOFMCaQ8YjOtRSRNtldxvrzPW57jcsZj2RPU0Bs6k58tKoQ
 mvPcQDAoHPKB+UUsrm15Yw2g78qrd8gzDVaDB9Ij7w+oIZMuFs5sE4cpGafJ/H+EEwu/f+epK
 XW9CQ0nqr6RDtm8Dqa/vlKmu6d7ywGz4ujU8PhFL22FtMXiw6p+oRD9x4+sqs19AXCzGDOl07
 ShR0IJCyLfZ1RsuWIbjdnRoMzGvtiRjJxAkCaQUMwG70nAzpY/P2Nty72I5uBpSnm8iA9zYW+
 ELB6O+MXC3asBs6qhF69Qg3/s/QCVtdV9Sml4IrAyEgltnc/56nZQRpdw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Fri, 15 Jul 2022, Eric Sunshine wrote:

> On Fri, Jul 15, 2022 at 4:18 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Network shares sometimes use aggressive caching, in which case a
> > just-created directory might not be immediately visible to Git.
> >
> > One symptom of this scenario is the following error:
> >
> >         $ git tag -a -m "automatic tag creation"  test_dir/test_tag
> >         fatal: cannot lock ref 'refs/tags/test_dir/test_tag': unable t=
o resolve reference 'refs/tags/test_dir/test_tag': Not a directory
> >
> > Note: This does not necessarily happen in all Windows setups. One setu=
p
> > where it _did_ happen is a Windows Server 2019 VM, and as hinted in
> >
> >         http://woshub.com/slow-network-shared-folder-refresh-windows-s=
erver/
> >
> > the following commands worked around it:
> >
> >         Set-SmbClientConfiguration -DirectoryCacheLifetime 0
> >         Set-SmbClientConfiguration -FileInfoCacheLifetime 0
> >         Set-SmbClientConfiguration -FileNotFoundCacheLifetime 0
> >
> > This would impact performance negatively, though, as it essentially
> > turns off all caching, therefore we do not want to require users to do
> > that just to be able to use Git on Windows.
> >
> > The underlying culprit is that `GetFileAttributesExW()` that is called=
 from
> > `mingw_lstat()` can raise an error `ERROR_PATH_NOT_FOUND`, which is
> > translated to `ENOTDIR`, as opposed to `ENOENT` as expected on Linux.
> >
> > Therefore, when trying to read a ref, let's allow `ENOTDIR` in additio=
n
> > to `ENOENT` to indicate that said ref is missing.
> >
> > This fixes https://github.com/git-for-windows/git/issues/3727
> >
> > Signed-off-by: Pierre Garnier <pgarnier@mega.com>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > @@ -381,7 +381,7 @@ stat_ref:
> > -               if (myerr !=3D ENOENT || skip_packed_refs)
> > +               if ((myerr !=3D ENOENT && myerr !=3D ENOTDIR) || skip_=
packed_refs)
> > diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> > @@ -480,7 +480,7 @@ static int load_contents(struct snapshot *snapshot=
)
> > -               if (errno =3D=3D ENOENT) {
> > +               if (errno =3D=3D ENOENT || errno =3D=3D ENOTDIR) {
>
> The first question which popped into my mind upon reading the patch
> was why these changes need to be made to files-backend.c and
> packed-backend.c rather than "fixing" mingw_lstat() to return ENOENT
> instead of ENOTDIR.

I already had started crafting a mail to explain that I do not want to
take the risk of changing the code to map `ERROR_PATH_NOT_FOUND` to
`ENOENT` instead of `ENOTDIR`, as we only have one central function to map
Windows' error codes to POSIX `errno` values. It would therefore affect
many more code paths than just `mingw_lstat()`.

Can you imagine my surprise when I looked up the link to that mapping
function so that I could paste it in my reply to make my point, only to
see that that error is _already_ mapped to `ENOENT`? Look here for
yourself: https://github.com/git/git/blob/v2.37.1/compat/mingw.c#L121

So where is the bug? It is somewhere completely different:
https://github.com/git/git/blob/v2.37.1/compat/mingw.c#L847-L851

Essentially, Windows does not give us the equivalent of POSIX' `ENOTDIR`:
For something like `C:\a\b\c` we only get `ERROR_PATH_NOT_FOUND`, no
matter whether `C:\a` is missing or whether it is a file (POSIX would want
an `ENOENT` in the former and `ENOTDIR` in the latter case, and
unfortunately Git fully relies on these POSIX semantics).

In 4b0abd5c695 (mingw: let lstat() fail with errno =3D=3D ENOTDIR when
appropriate, 2016-01-26), we introduced code to emulate POSIX semantics:
we laboriously look through the path components to see whether there is
anything in the way that would prevent us from creating the parent
directory.

It must be somewhere in that emulation where things go wrong, still. I
asked Pierre to debug a bit more to get to the bottom of the problem.

So: thank you for your "silly" question, it did point to the need for more
investigation.

Ciao,
Dscho
