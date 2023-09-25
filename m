Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41152CE7A81
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 11:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjIYLxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 07:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjIYLxC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 07:53:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FB7FE
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695642769; x=1696247569; i=johannes.schindelin@gmx.de;
 bh=7EIrglJzrfg4Xx9hj36WbLbO5keRYCT0fb4ouDMN0mE=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=id+QKE7GsVnuAv/rhK4Ku7pvTA2/g5M5YBpe1YzYEtsiQaB/gzNz2hZjnj8Qm52oAs4h7Js12gX
 A6ycqUFqidEvmQA4nfK9Pg7jVTeeaBRRZnd6mdiYgbfLGqxQi/QEA9pUJ/OV7s8vM3il39vIqteWx
 ebxAIpd+EuGl4SHslqHUFEOdY2LJ5RmARd3o3Pg4prWPEThJfsf3wjsB9lIIOUh7JKlUkEzY3ZE4o
 WfJsSyyTJXi9ZzADkYPAcciSp4jvVAfoCKpgK2Kgx3YmG8dJ7rWy3VTu3uI5kLBgF2h8SyUBW5wzp
 qZVxI/0S6z9dHpNoS8WBCGAGZmQjrAoPneiA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.206]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTiPl-1rE4LN3tNN-00TyKw; Mon, 25
 Sep 2023 13:52:48 +0200
Date:   Mon, 25 Sep 2023 13:52:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/6] coverity: allow overriding the Coverity project
In-Reply-To: <20230923070019.GD1469941@coredump.intra.peff.net>
Message-ID: <a839daf1-9e32-96f8-4eab-7c845e128488@gmx.de>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com> <6c1c82862814f40a408231cb249fb4b653276b52.1695379323.git.gitgitgadget@gmail.com> <20230923070019.GD1469941@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rO1GW0nmS/7QVQftlVSrUVnV0r+QZU54akrNsl8o5ayv3bBqe3I
 44mtL6IDNMXz93z4wqDS/e0SjbRm1kHjqRKEhw6lzJHkPNde8ny0u77tb3CQ/rJYktP9v5w
 dr0Y+41J8ITgggnVsNT2/Hh0TP9j1xeUefDHf8OrwnJP+EUHZGtIwBjRk0JJfv8UOPX41YI
 B+mUPxi+0tk6hYtc1FbgQ==
UI-OutboundReport: notjunk:1;M01:P0:X9z/2cypuok=;nQ1k4ZKzQp/r61L4/dQkOKE++8L
 kmD+hMsP50ojRCW8OtitBKIOWG6wtbJmL29x6lsdzXYIaOD+Jgu0ol8HikGJFHRsstoHyYAi5
 gjeYRr0vIXuIhe3L6rAeLteYNWE08hCpp0rsfXYAKgFSCvsGkoQJ+Ge0TGOiEKRT75T+dF1GQ
 vyNwsTkwBGYuhDcHPjMqXJ4cn91Ae28lUFsgu6/M7ZvF6apadqb4lCTl6XA1qldgfx3kkMmxl
 uL2uQmcBZnQKxRHm4oQ2IlXwSh43EtH6E2IVRD2JyVmJMYHi8jMnk+98mhLwNKdWdKblzPmBm
 wj75h2Z5BAJWG6TDyurG5Cpww+vT9xabe60kUk0FM53LA5YauqMhYwcQQQWeLasL3FXTiK0eL
 x7YW+1IaPOiiDVbdgNZdWddN3AYdgYrzygWPAOGQhDYitU6zzPDDwTHu5ykpk97GMfILtydmR
 ZE1bCXnuian7mqDDnqYamLZZPONUq7FwkPXDOz0N1q45lT3EDm/HvzeK0edIDElgC0BRNwi/n
 r9kE3RAvtGpmwjynp7SYU8tPwXkKDiO6QT1pSkQ1GE8blk6Tk/KGwfXLDmMoevd4lKqxOm2yj
 OOLEB7nG1etKoQZHSKPps/LD4m1zJxrA54tTAN1nKVE+/A4mBqN25KytCWChOEG27e+yxlLay
 y2egIK3hg526hKowXccP9qb/1gt6Pf82/U5Dw04zm/l3hFkvBq2vbNYc1TR5Mdc6UTvczSJBT
 2boQE3CljdtS/OR2wb+e4KA2eNNIQjSJ/om71Z3F2xB4TUDTayH/DErwYfslzRglBIk3rBLrl
 GtJOYjoRHWUNuBJICeenw2g74JBV5DyFQuDvrVL47v0YnpM2isALEr0NFEe7hLXYZbkNyiV2w
 GDCAknVeQVuxycGClDT5Jvd+sfxRO1IPAb25zBNzYklOnIDmh6tilYnakqYW2uNVV6iqwIAfZ
 u9flyQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sat, 23 Sep 2023, Jeff King wrote:

> On Fri, Sep 22, 2023 at 10:42:00AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > +# By default, the builds are submitted to the Coverity project `git`.=
 To override this,
> > +# set the repository variable `COVERITY_PROJECT`.
>
> This may not matter all that much, because I don't expect most people to
> set this up for their forks

Except, of course, Git for Windows. And that has been the entire
motivation for me to work on this here patch series in the first place, so
it would be rather pointless if I could not override this in the
git-for-windows/git fork.

Of course, I could address this differently. I could add a commit on top
and rebase that all the time. I'd just as well avoid that though. There is
already too much stuff in the Git for Windows fork that I have to rebase
so often.

Based on your response, I was on my way to enhance the commit message
accordingly, but then I saw this already being there:

	The Git for Windows project would like to use this workflow, too,
	though, and needs the builds to be submitted to the
	`git-for-windows` Coverity project.

Would you have any suggestion how that could make the motivation and
intention of this patch clearer?

Ciao,
Johannes
