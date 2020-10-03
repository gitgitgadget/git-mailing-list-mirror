Return-Path: <SRS0=BObu=DK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF1CC41604
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 13:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F231206CD
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 13:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GUMAckZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgJCN2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Oct 2020 09:28:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:46439 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgJCN2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Oct 2020 09:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601731690;
        bh=afhHhMTxjCB2Fw5JH3DUEUGoqjRyPqm5V+lYlLVTvxw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GUMAckZmP1Y2Je9UlPShSkJg4DhY/8TcCixV4v5TQHil3xDBZTsGOyjoKRxjwV62y
         fI3mXG5um4+YvdbU7g6jv0bvmcgVT9CJE43jU0MnBbMz/poKgBSjsTePTnzL5kPXEi
         NZKafC1zN6iJ2T0ngX7XJwGAdPvE53IyH0YjuO/g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.213.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqs4f-1kl3xz1xJp-00mrkN; Sat, 03
 Oct 2020 15:28:10 +0200
Date:   Sat, 3 Oct 2020 15:28:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>,
        Nikita Leonov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nikita Leonov <nykyta.leonov@gmail.com>
Subject: Re: [PATCH v2 1/3] credential.c: fix credential reading with regards
 to CR/LF
In-Reply-To: <xmqqk0w8a8re.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010031527200.50@tvgsbejvaqbjf.bet>
References: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com>        <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com>        <27f6400a21412d762b290a34a78ebe7296d36bf3.1601293224.git.gitgitgadget@gmail.com>        <20200929004220.GC898702@coredump.intra.peff.net>
        <nycvar.QRO.7.76.6.2010021011540.50@tvgsbejvaqbjf.bet> <xmqqk0w8a8re.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:a7LMr45TBkM+KkGfBxEM5F2u4E0rleZKHSL8xeVKYVx2VtXOhVE
 WpaDaOltol55BcLPNOqUH7QOwzeHHC/ZqH+tkpdTZORliofQ5COvHDhlaKpok0ElAvRPCfc
 4bTEBe4meKt8WsVzuvJOl2HULpbFu50tTfwtYZKvuLCA9U/YkEcLxWQZSRxEo+eV1hY/TNt
 Lu24u7Fb9hw7dGqW8U8BA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NY01vZNNZLo=:lhJiViIpau7dTvmn099Q3e
 9kNCMVlb74hNvUoH1PnPTfDOFMSjdR7PqoOEFeY6WM20ffFRvp/E0sbhIHTmucsaglCtA1pFV
 WWZm1/LDsanApRyNmawXmmc1pqsb9Ngj+uTzT2XmkTlssH6nKbOo9AbzeXu6RPDJAtecP71kn
 aF0b3p6aVhfpabq289W69VIvieDyWZkWC0IPhQ5iK++OmB5aA91Kf0H1zLk0jmqAxZBebRx+b
 RalT9+6xVayY0MPr8mALQX4c3gPy4lwN+1wfbqJGYV1gVvjXs7fkHrQJAdZi+rKTMX+9wKXHF
 u0yhETPV2BIqtXa9nV9fIhkWlCjI5PvhB4wHDj1ILdr/BQdY5xucEoGSkG/I36N9dwu5B3Wrc
 KUHby0Gdw/+dDDaDpk3jN2SYuksDDPUq+SVBM8fGhqmSTUlKeqby/Knp8RG2EpXGIyX5wbi2b
 tl+MsJjVShvLyROKTWqOomnRP+drOqwEe6SkxXZBIZTCvElffWrkxCG4714yu/hdnjjK9Xmie
 qOB8KUSM+zNbMOEAcKFsIBrbnjdYW2q7B1FqKhV641cxfNAOgua8EwWKk9Q6BPI4yDEIQ81Ra
 nGRRUCp7U5at7zFE1pvTTq6tYGFn9pKYDckb4FfEWQLfXYivJnNB1IExj+Wc49KFe7LUCZkGf
 ya+hCMder8SrI5NSG67fh7px1uX2DWLONujwr9b1bz0UccZtwoMGhGQ5e8pKyRnW0JaTFhLOH
 zaQRpbMKcZEcKTYQdCpPNEG5Kpwn0dkV/ps7zXdZfWwxPLk7U7kNxDB37Ycb+7aKddcwDXqUV
 1ufNyivu8p+q/vQTCUv/ua6Frl6V3nYEJOZE8Jaas60zq2o1+hOstdpcuInaa6ueTd85nBeFs
 oG429waSZvDDcLifQirDgQMIYOaSm26TLjc8wwyO+AYv6Fq0qX+NK575RD8+AtChhc7G9DsMB
 a/BYVrY9aWXkl0XwdEUVjaLxT2nftAY+0EzyfcMnq1qKeTfLN+FmFwAJ46S2+7DUwEm6mGLsn
 ygNCOthAIp9wIcR3CVf0nSdVzctxBBJZ4RBFIYgzVEKNDsxS6Q9Fr4b+xTHx4SFLz6u+vqhZU
 imn/UymBLM9okCaoGsCTzSu77EMCPDt5ZgD5lUlN5EyIN8mayIqv+JLoZ2mQsuKQ/JOp4gulj
 0jAAny94bfgHvwPsRJ2O59Pc7l37HuCT/ZWq/++NdmN7sVJ4/aKhvYBfpMM2abnd1gQcL/t7P
 R9ZN1JX4AnsEC1Cky4GSkHKYhSjca1m3SKvBJ9g==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 2 Oct 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Therefore, I spent some time pouring over the commit message. This is =
my
> > current version:
> >
> >     credential: treat CR/LF as line endings in the credential protocol
> >
> >     This fix makes using Git credentials more friendly to Windows user=
s: it
> >     allows a credential helper to communicate using CR/LF line endings=
 ("DOS
> >     line endings" commonly found on Windows) instead of LF-only line e=
ndings
> >     ("Unix line endings").
> >
> >     Note that this changes the behavior a bit: if a credential helper
> >     produces, say, a password with a trailing Carriage Return characte=
r,
> >     that will now be culled even when the rest of the lines end only i=
n Line
> >     Feed characters, indicating that the Carriage Return was not meant=
 to be
> >     part of the line ending.
> >
> >     In practice, it seems _very_ unlikely that something like this hap=
pens.
> >     Passwords usually need to consist of non-control characters, URLs =
need
> >     to have special characters URL-encoded, and user names, well, are =
names.
> >
> >     So let's change the credential machinery to accept both CR/LF and =
LF
> >     line endings.
> >
> >     While we do this for the credential helper protocol, we do _not_ d=
o
> >     adjust `git credential-cache--daemon` (which won't work on Windows=
,
> >     anyway, because it requires Unix sockets) nor `git credential-stor=
e`
> >     (which writes the file `~/.git-credentials` which we consider an
> >     implementation detail that should be opaque to the user, read: we =
do
> >     expect users _not_ to edit this file manually).
> >
> > What do you think?
>
> I am not Peff, but I was also drawn into the same confusion by the
> "we never see an empty line" red herring.

:-)

> There are some micronits, but the above made a lot easier to
> understand (I think you could even add "quit\r" bit to make it even
> easier to understand) than the original description.

Okay, I incorporated a comment talking about `quit\r` and will submit
a new iteration right now.

Thanks,
Dscho
