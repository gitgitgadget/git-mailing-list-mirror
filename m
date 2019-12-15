Return-Path: <SRS0=YD5J=2F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2258EC43603
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 21:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAECA24676
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 21:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Du1Pc9sZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfLOVKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Dec 2019 16:10:11 -0500
Received: from mout.gmx.net ([212.227.15.18]:53145 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfLOVKL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Dec 2019 16:10:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576444210;
        bh=n3+6i+mJuzcv34YUiwGvj/p8aMY5UsoPpbBrcFmg1OA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Du1Pc9sZQT1vz2SfhmrEGxO5+IW9rAnEX3nllW1qHEzuNsCMDfNhbktv2+OHWK8Ut
         YeXKkKhVgF9Kry0diM50KIXYKLIx3/uVL7vWjH8wKCaPz3gGgEvzi0tRIapTxklEJd
         0ZAR64syrRJRxIpTxB0g3WvQNABpi8NcQ5wc6VoY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdefD-1i7XNo3RoH-00ZiJx; Sun, 15
 Dec 2019 22:10:09 +0100
Date:   Sun, 15 Dec 2019 22:09:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Mikael Simonsson <m@mikaelsimonsson.com>
cc:     git@vger.kernel.org
Subject: Re: Bug? git commit fileA tries to delete fileB and other oddities
In-Reply-To: <CA+PLxnUR2skor9CGfDKfEEm8XTmoHwM2cDf5Kpgt-ppo=4zhbQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1912152209020.46@tvgsbejvaqbjf.bet>
References: <CA+PLxnUR2skor9CGfDKfEEm8XTmoHwM2cDf5Kpgt-ppo=4zhbQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GgqTJULi8emUFA/Q5dkVq85kyt31UVpd9l9278F2IT1L8R9n4pw
 1g9ga/XPzFsA0Xu6B/T3DCRU4TV/LvwcDeVTKLJRn2Fs+Ntwz6AoOMJjWRAFLyRElv2h8Jl
 KylEF8JQQ8fFB+tA6KmWGq4Lon3/dosEKhhwkU70bUwuT0w2bVFsGZdtsjcLrfZT+aPiYEk
 1KdwUlpCqG6Pmk8N1c0nQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xhgm2Jrt0dc=:8jvJI7pgrnoOxy0Gmh5hLh
 tXtaaoj3Qv/oTf+TKZno8PMz9FEAL7pXDPw7k/Mx0LyuW0a3zqHd8fZoTGQcCsW1D5RO0fHk6
 SNGWfmmCu5M03fO+ol4/+V4iL9WoxwCs0WlbbXMXt223ixT6idKZQskF2BR2nmBxmqMDsPAkB
 nJS06GOzV+7W+uVagsW6dxQRMhlaWxIPwfIkIZ0AbwkrUeQ/ty/+45bpFJABfnWoZMFjYcPfS
 n8JILvKEWov0AbjmkMLGgeHZiAvCJS/DgDZios9+UwQT3kf3gfiB6+bLOvCHiWgWUw0l1Ssoi
 N5S5FRHjC1m8O+4DnYuE3ajtyD4vra85Hia8Crk4AqOsfTOecIPcHZbrAr5nDLr7sKU4gH/em
 K1k2vK0Mo/wDpb0MPTIIqFIH02aNw5mYJf91pA5adZBEsRv5HMbUU0bVDLYsWSOXzn9ZQ3fp0
 IvJutaibx/7KvpzGplXRhz7Y3REY6JsoYmDZL2iNNi9IxIOM5kVk2T2U8Yjt3aT80nwDNJO54
 3VdFNpG+C5PpDTLwJCXUaBhGijngubahg49qbdQoXs81KRC0+5KD48Q4FwM/1F6KtyDnDiyu1
 zWx0zhJCEYyJ6KvuROF0EtG/ubnO9s+STSgprH7N1y4cn2M/0Ftyspw+wGtFgWX2SRLi7GWxw
 /JS4wRM+re91aLGBWi344N8Ae/yQBjJ408h9m7I/8xrDLSgt3wguxKV1GW3O5qb8Mwr6jpGdJ
 IplB0P12Ou+ANecE2afgLMTUc/+17SwovtoMpawfd4JBZn6fuCbpycm5TxvZMIvDT3+WChTLA
 XCrjyoVsiXKFEowLW1vMs8Q9UMwPX4BCo0amrxxfQ+6H6JvYlKk7xWBunfqUezNRayPdwJr0Z
 RxyHNyfyel7uRY2l9+UumIHSyRybFtcPYbf0sHX8J9AnBYVfQaFf/9jvZ0CHjhOl8wnUdI/j4
 LDN3hcJck5s1mBrsd4s92FMONhcucnuhXnuK6/rsbO07ws1/aOhxRfw7H84Qe+eAIppGS8v6D
 lFttIUhNMBjhRKHWsGTSHmcfiomcUp2SuUfOEx5UUjcXFoCjFwTd6q/b5rx4pWVK5KOoXYWqS
 I0/Odz3XCyNJINfKub725ZXYFScKd0329tvvI0LhALQMUCWmgMVcV539UfHwXX2Ry4pYNfgmK
 yvGGbD0gZA70dbOlicVLfJkF1BNS7fHvh4ZKpzKk/vlNqL8UWZb65EC4xERx4NlICBr4ZIhTU
 ofpPa0b2fVOg8ytR5uItwtBjPl0GR6pyL3/5gN69xqrGGNLusqth4qLkOhdA=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mikael,

On Sat, 14 Dec 2019, Mikael Simonsson wrote:

> I have the following problems with a local repository:
>
> * git commit fileA tries to delete fileX (fileX still exists).
>
> * git restore --staged fileX doesn't work, the file remains staged.
>
> * A commit from a few days back deleted 2 random files that I haven't
> touched or staged in months and pulled in staged changes I didn't ask
> for.
>
> git version: 2.24.0 and 2.24.1 (OS: FreeBSD 12)
>
> How can this happen? The repository has a local remote (on the same
> filesystem) that is pushed to only. I tarred the project and copied it
> to a Mac with git 2.23.0 and the problem persists.

It would be good if you could come up with a minimal list of commands to
recreate that problem. That way, we can turn it into a regression test and
fix the problem.

Ciao,
Johannes

>
> For example (I've only changed the filenames):
>
> % git status
> On branch master
> Your branch is up to date with 'origin/master'.
>
> Changes to be committed:
>   (use "git restore --staged <file>..." to unstage)
>         modified:   fileA
>         modified:   fileB
>         modified:   fileC
>
> Changes not staged for commit:
>   (use "git add/rm <file>..." to update what will be committed)
>   (use "git restore <file>..." to discard changes in working directory)
>         ...
>
>
> % git commit fileA
>
> # Please enter the commit message for your changes. Lines starting
> # with '#' will be ignored, and an empty message aborts the commit.
> #
> # On branch master
> # Your branch is up to date with 'origin/master'.
> #
> # Changes to be committed:
> #       deleted:    fileX
> #       modified:   fileA
> #
> # Changes not staged for commit:
>
>
> % git stash
> Saved working directory and index state WIP on master: 488e7081 ...
>
>
> % git status
> On branch master
> Your branch is up to date with 'origin/master'.
>
> Changes to be committed:
>   (use "git restore --staged <file>..." to unstage)
>         deleted:    fileX
>
> Untracked files:
>
>
> % git restore --staged fileX
>
>
> % git status
> On branch master
> Your branch is up to date with 'origin/master'.
>
> Changes to be committed:
>   (use "git restore --staged <file>..." to unstage)
>         deleted:    fileX
>
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>
>
> Thanks,
> Mikael
>
