Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C65DC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 16:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8FE20740
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 16:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="A4nfG8Wr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfKYQ33 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:29:29 -0500
Received: from mout.gmx.net ([212.227.15.15]:58687 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728683AbfKYQ32 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 11:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574699363;
        bh=D9Y0FZl6v55xCb2A/ZItVxxhsrDzhRc7g5nuYEoK77A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=A4nfG8WrAPaS0RkbotTazWeDGmLE6NVtafeBQUH/8riyPreV37KgjwXuC7zM4XGOC
         Kx0o4hvv1wcJNRYL4G7Dt58cjWsVH9HGNq2edLL0edgh+JkWxMUP9B5u+itOYQBxJa
         AlH494G+0tMryJ32R+FGByh8RlVmvhJqRqoAQAV8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mulm5-1hjVrd3YcV-00rldC; Mon, 25
 Nov 2019 17:29:22 +0100
Date:   Mon, 25 Nov 2019 17:29:07 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] On Windows, limit which file handles are inherited
 by spawned child processes
In-Reply-To: <xmqqimn8y0k5.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911251727560.31080@tvgsbejvaqbjf.bet>
References: <pull.670.git.git.1574433665.gitgitgadget@gmail.com> <xmqqimn8y0k5.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mikDpeyLjecDWIhyXehvHJQOH0KCdSQJiySOWUFtbVafz0EeCoX
 F9Kc5BdaynmTiHHrR99VYwMi/06pwxaVgHXdOhDDkruZhwsA4bOm44A60CKvdqrzpyQUtlC
 QI5FPNj6IbGCB7wDGLxPAlfZr9b8On9v3iaPTn/sOxtARx7clpf34PzexDpajDbD0fTIilD
 KffiueLOAxfOkDpvK1emA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WUYC4NhJsrg=:EfEdFDXR9GctREpYC7av8w
 qHKS9lH52IcHckPZtNUWFviPeoJ/Juftamt4B/yKuLhjBTW3B4bqxfNK3+Gans9OruskCGNdM
 BG9ENk485HfXXMWuE431KavpB/7n6lnqEgEMpRd1K6kDocEICgBv/WKlwUsFLICj7cSA//dqs
 5ISSqU++3t6r4X56N7c02+anZrJFI+rSiVm7VOz+Cj4CgCAGRGyCLkMu7mGuFs5qgiXNMyVmQ
 d9WBlqlSI6GyVFiMR5iMB0fYOpdVWYm0z+CwVVJvbWS4pmXec4/PYfPcp+o6phDqoe4MOAp3L
 T/3IhcBZPr/tNvLrLowLAZnNBr14MFQQE47UCxww3Xvj1yf3XQcsb39gc6lhWDggnLStwnVdX
 Xb4dHGc0QKfrNzuCRfGCfHl1cQQqMJzhpmc8SFaQVjUR3aRfdijV20ZAVbc+7AkR+nQ9y10AM
 UTb8N6UkFFUEgpVMoZrhRt6wwdZD4jt07RhFWHnVZSviy5MCuKBpEaXvXLalrUghZvEKS8yAh
 jTwtz3G0vyWEvqzJPQNLE9SQgg/RRdt90H75U/FQVrVj2KH9L09UUzmxyIQELHt6ai8hxsC4W
 hU9aoC/0m+JZvcwuwYiWbn48GboW4SQGErtAys3NXGrY47oYNPEp+ISEqQsgspEhTbOaN9i3P
 0nPuGN0ygagcqvP1rHmylkPLrqGyHsYJiGzzc+dcL36fuR5GOejIChV9RgRuULEP+qQX6obY8
 SyNPIsP/i8M+qUKmJWiJEVcYsCWLxl9JwMER2SYt2f4SG3uOf09cCXjTjemyoEiHWsRdV77TG
 rmTEvdS0hyL6U9JirX7yCKAwgZpCSlea8dXCSRO7a53PLH5U7HsXkhLbBm4lj9ndBzSRMyCQn
 OAjjNM2XElZYm+UmWEnkUPgXBMzchEZqB+e8LKbHHdsNRvzfPpcF5/H8L+ceP8iaulxmS8qHy
 K+3NRPBxsOF4B9/zlZNP9J+eEgqYsYQehG95tGrYCfa6qrS0fD6m0JKZGhuWyQ9XTQlMSMLzM
 QVQg3W7ZkO3jXUAcQ7KXgYhmKBv/kVLNwn2HS6UUEovZywmrsHaB0Cu0KiQPUtsdxi4m/iH9P
 uyGV2zLgjUGHLDXFi9l5/zsj9A+mu5tTDEUcv1WJmZzcA6u7uLFyLZXPv2oVxkprl91RkQM49
 gSIoe+++u/P+PQzlg7tLwT0+NtxNkpYdu7Yl2reFKuXXYCRGAD+o69HdBE0NgdRP/aiankgA6
 itYRVXiX01HLjPHHIM3rRBQ2al4MazO+x1iPK86Nbc/hHvL7J0w9/28cBibY=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 25 Nov 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > The problem to be solved: files cannot be deleted on Windows when even=
 one
> > process has an open file handle to it. So when a process opens a tempo=
rary
> > file, then spawns a child process that inherits that file handle by mi=
stake,
> > and then the parent process tries to delete the temporary file while t=
he
> > child process is still running, the deletion will fail. (This descript=
ion is
> > slightly simplified, see the commit message "spawned processes need to
> > inherit only standard handles" for more detail.)
>
> Makes me wonder if we should be marking these fds with FD_CLOEXEC to
> solve the issue in a way that is platform agnostic.

I would like that a lot.

Having said that, it is too easy to miss when a patch forgets to do that
and when the contributor only tests on Linux. So I really also would like
to keep the current patch in addition.

Thanks,
Dscho

> It may turn out that we'd be better off to make it an explicit choice by
> the parent when it leaves a FD open while spawning a child process (and
> by that spawned child when it runs another executable---but I undertand
> that it is a single-step operation, not a two-step one, on Windows).
>
> In any case, synchronizing the differences in compat/ between our
> trees is good.  Queued.
>
>
