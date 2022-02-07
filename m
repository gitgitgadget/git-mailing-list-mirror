Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F96FC433F5
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 06:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242731AbiBGGEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 01:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241714AbiBGDgz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 22:36:55 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A39CC061A73
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 19:36:52 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id u6so3210662lfc.3
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 19:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LfPZZ65oIwdMk5+PcsG9fHW7IXZIFjNUXAWnP2JJxXE=;
        b=Xu4K0pvVZwMlueAXTSw5I4LM05XF7YUbW+M9ZFD5IeOfLwzGqGSUkr3P/vacWcbWWt
         YNfA4F5Gx4UPem5VNTsfWwFEjtcQo6b5sMxfHwXI/H3OD7Ew2iCoQd2Z1O+lB/4tyg6Z
         M0nXjtPjhev7tLe/OGpV5R/jbYlaHBfKh7QBO440X2SrITG0+LlxVuLGajfDDAffMdxS
         IDpQdwOfsTAbNprDhUsLFv9/E4N9K7TbmKQGJXUyAmut4iOO0ivz36iPITlKv0yDbva3
         pWtx9LaUo05uQ5+JyxlbiXC6zfdndJg+2NWDgVueSjwhdqnycTMhHErLLzE1UoRDem1O
         64sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LfPZZ65oIwdMk5+PcsG9fHW7IXZIFjNUXAWnP2JJxXE=;
        b=DkpqAnRCu2xd6WcSRRJ6/rGeyErYzqieuRUcwMDjlm3CeuVsNjmXV3EDER7M9wcl5l
         SR0QYEzgyGobDihnje4BEG5sKmiohPqYTw+MK3VG2PNuik2/7hcIKxFJifwNTV44dE6B
         8RiXr4y7nOzDX0LLI+DFvaVwYPGNCln2Lr4qyFxK6Ml8SMoPPk9qe0Lg3W2DY/AV9Mpp
         D6MINFwqfewt5sb1tGwVZELUSvzgB4RPdsAjntl79tDQIK3b6f4HO8pIOTDzdMn85pC+
         NUay7yonZ6ePmLXb2lxCyfflOkzYuByFrAb56iz6oA64x+kuQca6xMf0cVgl+buh9N/3
         YKsw==
X-Gm-Message-State: AOAM531tXlc3Vg+f2KAOqLnIqdHbE2j7wsG06+fh8Ap0AagVGv9gsrYA
        lq0lplcY1GKraBDaos61VWsrSrgi0lieYYksgEuNy2SYJVQ=
X-Google-Smtp-Source: ABdhPJx9oxtjDuqfJ4ex6QIhG/WqjpY5ngzb3n308CF/Q7R9BsRvdeUoKJnQ86T97gMABRH6L5s6Mmv9YRx1XGxrqSQ=
X-Received: by 2002:a05:6512:686:: with SMTP id t6mr6960524lfe.567.1644205010804;
 Sun, 06 Feb 2022 19:36:50 -0800 (PST)
MIME-Version: 1.0
References: <pull.1124.git.1642987616372.gitgitgadget@gmail.com>
 <20220129063538.24038-1-bojun.cbj@gmail.com> <xmqqczk6b3pt.fsf@gitster.g> <CADuS7AoAbtbC3RKrXR=SGvfs7C-n57Y9zkaGne_XrfyJh46zXg@mail.gmail.com>
In-Reply-To: <CADuS7AoAbtbC3RKrXR=SGvfs7C-n57Y9zkaGne_XrfyJh46zXg@mail.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 7 Feb 2022 11:36:39 +0800
Message-ID: <CANYiYbHbFmjbMOCKc=UTDEwcL1bpGRrKRafFCUuYxvuHYVkhTg@mail.gmail.com>
Subject: Re: [PATCH v2] receive-pack: purge temporary data if no command is
 ready to run
To:     Bojun Chen <bojun.cbj@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Chen Bojun <bojun.cbj@alibaba-inc.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Teng Long <dyroneteng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 5, 2022 at 4:15 PM Bojun Chen <bojun.cbj@gmail.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> =E4=BA=8E2022=E5=B9=B42=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=B8=89 06:51=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Chen BoJun <bojun.cbj@gmail.com> writes:
> >
> > > From: Chen Bojun <bojun.cbj@alibaba-inc.com>
> > >
> > > When pushing a hidden ref, e.g.:
> > >
> > >     $ git push origin HEAD:refs/hidden/foo
> > >
> > > "receive-pack" will reject our request with an error message like thi=
s:
> > >
> > >     ! [remote rejected] HEAD -> refs/hidden/foo (deny updating a hidd=
en ref)
> > >
> > > The remote side ("git-receive-pack") will not create the hidden ref a=
s
> > > expected, but the pack file sent by "git-send-pack" is left inside th=
e
> > > remote repository. I.e. the quarantine directory is not purged as it
> > > should be.
> >
> > I was puzzled by the reference to "pushing a hidden ref" at the
> > beginning of the proposed log message, as it wasn't quite clear that
> > it was merely an easy-to-reproduce recipe to fall into such a
> > situation where all ref updates are rejected.
> >
>
> Thanks for the suggestion. Do I have to rewrite this commit message on th=
e v3?

You can start your commit message like this:

    receive-pack: purge temporary data if no command is ready to run

    When pushing to "receive-pack", commands may have already been
    marked with error_string or skip_update before being fed to the
    "pre-receive" hook. E.g.:

     * inconsistent push options for signed push.
     * not permited shallow updates.
     * encounter connectivity issues.
     * push to hidden references.

    Take pushing to hidden references as an example.

    In order to reduce the size of reference advertisement for git-push
    from a client which does not support protocol v2 and push negotiation,
    the administrator may set certain config variables to hide some
    references like:

        $ git config --system --add receive.hideRefs refs/merge-requests

    Then, if a user made a push like this:

        $ git push origin HEAD:refs/merge-requests/123/head

    ...

--
Jiang Xin
