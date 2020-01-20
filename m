Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05941C32771
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 21:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C860F24653
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 21:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NzyeEWmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgATVMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 16:12:03 -0500
Received: from mout.gmx.net ([212.227.15.18]:41943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgATVMD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 16:12:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579554711;
        bh=j3sZtWXD99ZhMiGN6zWSQ7vFGE99598Vitab87JCBzk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NzyeEWmrl1NPJ5NGYC90MF+EwfrYrZ24GrYigx9Zrlm9bIY4P2LLeNqFW03pEHzx6
         QXQ2UDIYga58+E89TUZrpxZ9tEYgTk+ozY0/aWIz84zR35ZcN6xO5/aMflBw7rz2+B
         F9+KlDg5VyDGfY0NnRZpTir+dfjJ9ndm3QFmfFkg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mplc7-1jPyos01iH-00qAfE; Mon, 20
 Jan 2020 22:11:51 +0100
Date:   Mon, 20 Jan 2020 22:11:49 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Ben Curtis <nospam@nowsci.com>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>,
        Ben Curtis via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] commit: replace rebase/sequence booleans with single
 pick_state enum
In-Reply-To: <bfe569ea-93c7-382f-18fe-d81d8f9cbf4f@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001202210520.46@tvgsbejvaqbjf.bet>
References: <pull.531.git.1579268705473.gitgitgadget@gmail.com> <17b57e7f-7f3c-abab-1da6-d2e5c9ff893d@gmail.com> <bb0e232924305697596743d3fa93d5bf3b0e8d4d.camel@nowsci.com> <bfe569ea-93c7-382f-18fe-d81d8f9cbf4f@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LWAZ5F0eQWM2JMAqWFjKrXUuza2X3iSu5Td70NVHhUxrA10V/DU
 8grLyAooXXCkZEGpNaXOok0mLvOKbaY7XtrzFpSsAECAUOpxWbsFAZqn12pOPW2Ku6Feod5
 CjcdWUAhAONSzeALuIGb2HGzBMCl9Z0Ek3IgNzfZgmTXh3j8AFn/V/AOpBQPiM/TlfhTBoo
 keN/PuexRycJjqUdw5HGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/lbMBpc2xF8=:VJgYiVomAOVM9dL6m/oSjW
 Ds2twx9GBgpnik19vH/Hx0OoAaLjI37xHR9fOfYUCNlk9UMOqT9LjEX0V1fyBzwnq56FPY6h9
 5VZm7QWUI5pqseDvurL1PkbdB42pmyRRmkYGrCZEbQn52mgeqWeEqa/MiirHlI0mScFf/fYNH
 fJvEXcqvND60IzP2zojSj1rZwGaEtXzpdyiflTZ7FJMWeiOfBBjfwMfx3K5EjwMvuWHb8Sr2u
 Pp56GZjsVFiLwErtFFE4h+GWxjvLoxNtqUwNp+a5BOmJQuhhjL4JuhSYv9IwDckExHW7D8yl5
 IlWZQ/JE+1eI0DyX+ubOlg7qT96FkG5ouReeDFyOYJ+IBjibk5wNbMHDKf/rtbMxEN3rCNoth
 I3ssLajmDW51SlpejCUEVp3dhRErzvCXpTRj1r+5hSM1UvqAROEEhDnOYpuXuXbpptXzxCoIS
 on4wvbOjfoXZVqipJcDNEo6AgpioN7goJFlr+YYaebxuyylKw6p3R8nMJ3JF0JwkfJ+OtLUvW
 giTzzV9EIIux4oqh+MtaD1yimy8ZFmuhgJEbGvP+oi1jwZROpxjlwTfZR5uAJNj68zN3ahBLp
 4k6dNnXHctE48RusQBxasYetMYW6f3Rmjno8zD6kx0PDXcBfMnn8SCbqcM5/4x0dBPnnPba2j
 vKBaszSCcYjsaCrAlQ7v9R7kus6XdIrU7kY9U1sQxzTbXmYHjru0vHAWUtdQenKjSH8vDi+Zl
 26VXP5MF92geN/heBRkL3h0+nl4oAC1cXtRikFr45KUzIq7dUsBNyJ2rZDsnejcvOpDVYtr10
 gEccSlk4lfhPdMCFf0uVKP2bO7h8B7Cd9DEPV3+ZpWY9AlgXukoeKZJ3pA5n0SBU/extDEgk8
 yfPYHiNCjnVcS6iGO8TFiJDU1o98UCe1n4rM0CgUSPoXtKHCQ/DIoGCKCyXST5qkxJxCG9mQA
 HFjAD6cy4CvkSgjZdWkipee2tHsyFZEU3r7n4O2F41NYtdbYvE5InLG56htaN3JxRrAmjFIHl
 lOnUrtIbXcxT7uaKpBoQZFkW/U6tSeZ0SO31SVH4aK4Heckkrdo8lXnYirPf/zf9yhEXXQw5p
 0xTs1LPOLJ21+fzDbiq7FIwF9kIYU+uIrk0zVLIoVFs3WsarMGBdznCiAS7eHCGfXhZkAX8o1
 6qFI0Isr04FL3/3UINEzdbrbUKF25zgMoXdpNtf6PFe+zKnNfpguplpwZJQOs3bUErtAgSoZj
 msfPwmwmPMT/NxtBKkaBHuBdarbvl6QjO0OxtXVWluOLXLQ2xDjUuHEjNcLs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 20 Jan 2020, Phillip Wood wrote:

> [Cc'ing dscho as it relates to issue management on gitgitgadget]

Duplicating efforts is sadly a thing we cannot prevent, not even should we
agree on a single issue tracker (we won't).

Ciao,
Dscho
